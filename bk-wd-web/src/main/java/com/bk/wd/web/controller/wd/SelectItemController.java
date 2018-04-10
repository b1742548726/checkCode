package com.bk.wd.web.controller.wd;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdSelectGroup;
import com.bk.wd.model.WdSelectGroupExample;
import com.bk.wd.model.WdSelectItem;
import com.bk.wd.model.WdSelectItemExample;
import com.bk.wd.model.WdSelectList;
import com.bk.wd.model.WdSelectListExample;
import com.bk.wd.service.WdSelectGroupService;
import com.bk.wd.service.WdSelectItemService;
import com.bk.wd.service.WdSelectListService;
import com.bk.wd.web.base.BaseController;

/**
 * 选择项Controller
 * @Project Name:智微云
 * @Date:2017年3月7日下午2:29:23 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/selectItem")
public class SelectItemController extends BaseController {
    
    @Autowired
    private WdSelectItemService wdSelectItemService;
    
    @Autowired
    private WdSelectListService wdSelectListService;
    
    @Autowired
    private WdSelectGroupService wdSelectGroupService;
    
    @RequiresPermissions("wd:selectitem:view")
    @RequestMapping(value = {"", "index"})
    public String index(Model model, Pagination pagination){
    	List<WdSelectGroup> data =  wdSelectGroupService.selectAll();
        model.addAttribute("dataList", data);
        return "modules/wd/selectItem/selectGroupList";
    }
    
    @RequiresPermissions("wd:selectitem:view")
    @RequestMapping(value = {"selectGroupForm"})
    public String newSelectGroup(Model model, String groupId){
        model.addAttribute("wdSelectGroup", wdSelectGroupService.selectByPrimaryKey(groupId));
        return "modules/wd/selectItem/selectGroupForm";
    }
    
    @RequiresPermissions("wd:selectitem:edit")
    @RequestMapping(value = {"editSelectGroup"})
    @ResponseBody
    public JsonResult editSelectGroup(WdSelectGroup wdSelectGroup) {
        // 判断是否重复
        WdSelectGroupExample wdSelectGroupExample = new WdSelectGroupExample();
        WdSelectGroupExample.Criteria criteria = wdSelectGroupExample.createCriteria();
        criteria.andCodeEqualTo(wdSelectGroup.getCode());
        if (StringUtils.isNotEmpty(wdSelectGroup.getId())) {
            criteria.andIdNotEqualTo(wdSelectGroup.getId());
        }
        List<WdSelectGroup> wdSelectGroupList = wdSelectGroupService.selectByExample(wdSelectGroupExample);
        if (!wdSelectGroupList.isEmpty()) {
            return new JsonResult(false, "选项组的键重复");
        }
        
        if (StringUtils.isEmpty(wdSelectGroup.getId())) {
            wdSelectGroup.setId(IdGen.uuid());
            wdSelectGroup.setCreateBy(UserUtils.getUser().getId());
            wdSelectGroup.setCreateDate(new Date());
            wdSelectGroup.setUpdateBy(UserUtils.getUser().getId());
            wdSelectGroup.setUpdateDate(new Date());
            wdSelectGroupService.insertSelective(wdSelectGroup);
        } else {
            wdSelectGroup.setUpdateBy(UserUtils.getUser().getId());
            wdSelectGroup.setUpdateDate(new Date());
            wdSelectGroupService.updateByPrimaryKeySelective(wdSelectGroup);
        }
        return new JsonResult(wdSelectGroup);
    }
    
    @RequiresPermissions("wd:selectitem:edit")
    @RequestMapping(value = {"delSelectGroup"})
    @ResponseBody
    public JsonResult delSelectGroup(String groupId) {
        WdSelectGroup wdSelectGroup = wdSelectGroupService.selectByPrimaryKey(groupId);
        wdSelectGroup.setDelFlag(true);
        wdSelectGroup.setUpdateBy(UserUtils.getUser().getId());
        wdSelectGroup.setUpdateDate(new Date());
        wdSelectGroupService.updateByPrimaryKeySelective(wdSelectGroup);
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:selectitem:view")
    @RequestMapping(value = {"selectListForm"})
    public String selectListForm(Model model, String listId, String selectGroupId){
        WdSelectList wdSelectList = new WdSelectList();
        if (StringUtils.isEmpty(listId)) {
            wdSelectList.setSelectGroupId(selectGroupId);
        } else {
            wdSelectList = wdSelectListService.selectByPrimaryKey(listId);
        }
        model.addAttribute("wdSelectList", wdSelectList);
        return "modules/wd/selectItem/selectListForm";
    }
    
    @RequiresPermissions("wd:selectitem:view")
    @RequestMapping(value = {"showSelectList"})
    public String showSelectList(String groupId, Model model) {
        List<WdSelectList> wdSelectLists = wdSelectListService.selectByGroupId(groupId);
        if (!wdSelectLists.isEmpty()) {
            for (WdSelectList wdSelectList : wdSelectLists) {
                wdSelectList.setItemList(wdSelectItemService.selectByListId(wdSelectList.getId()));
            }
        }
        model.addAttribute("selectGroupId", groupId);
        model.addAttribute("wdSelectLists", wdSelectLists);
        return "modules/wd/selectItem/selectListList";
    }
    
    @RequiresPermissions("wd:selectitem:edit")
    @RequestMapping(value = {"editSelectList"})
    @ResponseBody
    public JsonResult editSelectList(WdSelectList wdSelectList) {
        // 判断是否重复
        WdSelectListExample wdSelectListExample = new WdSelectListExample();
        WdSelectListExample.Criteria criteria = wdSelectListExample.createCriteria();
        criteria.andCodeEqualTo(wdSelectList.getCode());
        criteria.andSelectGroupIdEqualTo(wdSelectList.getSelectGroupId());
        criteria.andDefaultFlagEqualTo("0");
        if (StringUtils.isNotEmpty(wdSelectList.getId())) {
            criteria.andIdNotEqualTo(wdSelectList.getId());
        }
        List<WdSelectList> wdSelectListList = wdSelectListService.selectByExample(wdSelectListExample);
        if (!wdSelectListList.isEmpty()) {
            return new JsonResult(false, "选择项的键重复");
        }
        
        //设置默认选项小组
        if (StringUtils.isEmpty(wdSelectList.getId())) {
            wdSelectList.setId(IdGen.uuid());
            wdSelectList.setCreateBy(UserUtils.getUser().getId());
            wdSelectList.setCreateDate(new Date());
            wdSelectList.setDelFlag(false);
            wdSelectList.setUpdateBy(UserUtils.getUser().getId());
            wdSelectList.setUpdateDate(new Date());
            wdSelectListService.insertSelective(wdSelectList);
        } else {
            wdSelectList.setUpdateBy(UserUtils.getUser().getId());
            wdSelectList.setUpdateDate(new Date());
            wdSelectListService.updateByPrimaryKeySelective(wdSelectList);
        }
        return new JsonResult(wdSelectList);
    }
    
    @RequiresPermissions("wd:selectitem:edit")
    @RequestMapping(value = {"delSelectList"})
    @ResponseBody
    public JsonResult delSelectList(String listId) {
        WdSelectList wdSelectList = wdSelectListService.selectByPrimaryKey(listId);
        wdSelectList.setDelFlag(true);
        wdSelectList.setUpdateBy(UserUtils.getUser().getId());
        wdSelectList.setUpdateDate(new Date());
        wdSelectListService.updateByPrimaryKeySelective(wdSelectList);
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:selectitem:edit")
    @RequestMapping(value = {"selectItemForm"})
    public String selectItemForm(Model model, String listId, String itemId, Integer sort){
        WdSelectItem wdSelectItem = new WdSelectItem();
        if (StringUtils.isEmpty(itemId)) {
            wdSelectItem.setSelectListId(listId);
            wdSelectItem.setSort(sort);
        } else {
            wdSelectItem = wdSelectItemService.selectByPrimaryKey(itemId);
        }
        model.addAttribute("wdSelectItem", wdSelectItem);
        return "modules/wd/selectItem/selectItemForm";
    }
    
    @RequiresPermissions("wd:selectitem:edit")
    @RequestMapping(value = {"editSelectItem"})
    @ResponseBody
    public JsonResult editSelectItem(WdSelectItem wdSelectItem) {
        // 判断是否重复
        WdSelectItemExample wdSelectItemExample = new WdSelectItemExample();
        WdSelectItemExample.Criteria criteria = wdSelectItemExample.createCriteria();
        criteria.andCodeEqualTo(wdSelectItem.getCode());
        criteria.andSelectListIdEqualTo(wdSelectItem.getSelectListId());
        criteria.andDelFlagEqualTo(false);
        if (StringUtils.isNotEmpty(wdSelectItem.getId())) {
            criteria.andIdNotEqualTo(wdSelectItem.getId());
        }
        List<WdSelectItem> wdSelectItemList = wdSelectItemService.selectByExample(wdSelectItemExample);
        if (!wdSelectItemList.isEmpty()) {
            return new JsonResult(false, "选择项的键重复");
        }
        
        if (StringUtils.isEmpty(wdSelectItem.getId())) {
            wdSelectItem.setId(IdGen.uuid());
            wdSelectItem.setCreateBy(UserUtils.getUser().getId());
            wdSelectItem.setCreateDate(new Date());
            wdSelectItem.setDelFlag(false);
            wdSelectItem.setUpdateBy(UserUtils.getUser().getId());
            wdSelectItem.setUpdateDate(new Date());
            wdSelectItemService.insertSelective(wdSelectItem);
        } else {
            wdSelectItem.setUpdateBy(UserUtils.getUser().getId());
            wdSelectItem.setUpdateDate(new Date());
            wdSelectItemService.updateByPrimaryKeySelective(wdSelectItem);
        }
        return new JsonResult(wdSelectItem);
    }
    
    @RequiresPermissions("wd:selectitem:edit")
    @RequestMapping(value = {"delSelectItem"})
    @ResponseBody
    public JsonResult delSelectItem(String itemId) {
        WdSelectItem wdSelectItem = wdSelectItemService.selectByPrimaryKey(itemId);
        wdSelectItem.setDelFlag(true);
        wdSelectItem.setUpdateBy(UserUtils.getUser().getId());
        wdSelectItem.setUpdateDate(new Date());
        wdSelectItemService.updateByPrimaryKey(wdSelectItem);
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:selectitem:edit")
    @ResponseBody
    @RequestMapping(value = {"itemSort"})
    public JsonResult itemSort(String itemData) {
        if (StringUtils.isNoneEmpty(itemData)) {
            JSONArray dataList = JSON.parseArray(StringEscapeUtils.unescapeHtml4(itemData));
            Iterator<Object> iterator = dataList.iterator();
            while(iterator.hasNext())  {
                JSONObject object = JSON.parseObject(iterator.next().toString());
                WdSelectItem wdSelectItem = wdSelectItemService.selectByPrimaryKey(object.get("id").toString());
                wdSelectItem.setSort(Integer.valueOf(object.get("sort").toString()));
                wdSelectItem.setUpdateBy(UserUtils.getUser().getId());
                wdSelectItem.setUpdateDate(new Date());
                wdSelectItemService.updateByPrimaryKey(wdSelectItem);
            }
        }
        return new JsonResult();
    }
}