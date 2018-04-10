package com.bk.wd.web.controller.wd;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.common.utils.StringUtils;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdDefaultSimpleModule;
import com.bk.wd.model.WdDefaultSimpleModuleExample;
import com.bk.wd.model.WdDefaultSimpleModuleSetting;
import com.bk.wd.model.WdDefaultSimpleModuleSettingExample;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdDefaultSimpleModuleService;
import com.bk.wd.service.WdDefaultSimpleModuleSettingService;
import com.bk.wd.web.base.BaseController;

/**
 * 模板容器管理
 * @Project Name:bk-wd-web 
 * @Date:2017年3月9日下午2:33:22 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/simlpeModule")
public class SimpleModuleController extends BaseController {
    
    @Autowired
    private WdDefaultSimpleModuleService wdDefaultSimpleModuleService;
    
    @Autowired
    private WdDefaultSimpleModuleSettingService wdDefaultSimpleModuleSettingService;
    
    @Autowired
    private WdBusinessElementService wdBusinessElementService;

    @RequiresPermissions("wd:simlpeModule:view")
    @RequestMapping(value = {"list", ""})
    public String list(Model model, String id) {
        if (StringUtils.isNotEmpty(id)) {
            WdDefaultSimpleModule wdDefaultSimpleModule = wdDefaultSimpleModuleService.selectByPrimaryKey(id);
            model.addAttribute("wdDefaultSimpleModule", wdDefaultSimpleModule);
        }
        WdDefaultSimpleModuleExample defaultSimpleModuleExample = new WdDefaultSimpleModuleExample();
        defaultSimpleModuleExample.createCriteria().andDelFlagEqualTo(false);
        defaultSimpleModuleExample.setOrderByClause("sort");
        model.addAttribute("list", wdDefaultSimpleModuleService.selectByExample(defaultSimpleModuleExample));
        return "modules/wd/simlpeModule/simlpeModuleList";
    }

    @RequiresPermissions("wd:simlpeModule:edit")
    @RequestMapping(value = "form")
    public String form(WdDefaultSimpleModule wdDefaultSimpleModule, Model model) {
        model.addAttribute("wdDefaultsimlpeModule", wdDefaultSimpleModule);
        return "modules/wd/simlpeModule/simlpeModuleForm";
    }
    
    @RequiresPermissions("wd:simlpeModule:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(WdDefaultSimpleModule wdDefaultSimpleModule, Model model) {
        if (StringUtils.isEmpty(wdDefaultSimpleModule.getId())) {
            wdDefaultSimpleModule.setId(IdGen.uuid());
            wdDefaultSimpleModule.setCreateBy(UserUtils.getUser().getId());
            wdDefaultSimpleModule.setCreateDate(new Date());
            wdDefaultSimpleModule.setUpdateBy(UserUtils.getUser().getId());
            wdDefaultSimpleModule.setUpdateDate(new Date());
            wdDefaultSimpleModuleService.insertSelective(wdDefaultSimpleModule);
        } else {
            wdDefaultSimpleModule.setUpdateBy(UserUtils.getUser().getId());
            wdDefaultSimpleModule.setUpdateDate(new Date());
            wdDefaultSimpleModuleService.updateByPrimaryKeySelective(wdDefaultSimpleModule);
        }
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:simlpeModule:edit")
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(WdDefaultSimpleModule wdDefaultSimpleModule) {
        wdDefaultSimpleModule.setUpdateBy(UserUtils.getUser().getId());
        wdDefaultSimpleModule.setUpdateDate(new Date());
        wdDefaultSimpleModule.setDelFlag(true);
        wdDefaultSimpleModuleService.updateByPrimaryKeySelective(wdDefaultSimpleModule);
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:simlpeModule:view")
    @RequestMapping(value = "itemList")
    public String itemList(WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting, String defaultSimpleModuleCode, Model model) {
        if (org.apache.commons.lang3.StringUtils.isNotEmpty(defaultSimpleModuleCode)) {
            WdDefaultSimpleModule wdDefaultSimpleModule = wdDefaultSimpleModuleService.selectByCode(defaultSimpleModuleCode);
            model.addAttribute("wdDefaultSimpleModule", wdDefaultSimpleModule);
            model.addAttribute("dataList", wdBusinessElementService.selectByModule(wdDefaultSimpleModule.getId()));
        }
        return "modules/wd/simlpeModule/simlpeModuleSettingList";
    }
    
    @RequiresPermissions("wd:simlpeModule:edit")
    @RequestMapping(value = "itemForm")
    public String form(WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting, String defaultSimpleModuleCode, Model model) {
        if (null != defaultSimpleModuleCode) {
            WdDefaultSimpleModule wdDefaultSimpleModule = wdDefaultSimpleModuleService.selectByCode(defaultSimpleModuleCode);
            model.addAttribute("wdDefaultSimpleModule", wdDefaultSimpleModule);
            model.addAttribute("elementList", wdBusinessElementService.selectByModule(wdDefaultSimpleModule.getId()));
        }
        return "modules/wd/simlpeModule/simlpeModuleSettingForm";
    }
    
    @RequiresPermissions("wd:simlpeModule:edit")
    @RequestMapping(value = "setItemRequired")
    @ResponseBody
    public JsonResult setRequired(WdDefaultSimpleModuleSetting WdDefaultSimpleModuleSetting, Model model) {
        WdDefaultSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
        WdDefaultSimpleModuleSetting.setUpdateDate(new Date());
        wdDefaultSimpleModuleSettingService.updateByPrimaryKeySelective(WdDefaultSimpleModuleSetting);
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:simlpeModule:edit")
    @RequestMapping(value = "saveItem")
    @ResponseBody
    public JsonResult saveItem(String newBussinessElementIds, String delBussinessElementIds, String simpleModuleId, Model model) {
        if (StringUtils.isNotEmpty(delBussinessElementIds)) {
            List<String> delBussinessElementIdList = Arrays.asList(delBussinessElementIds.split(","));
            WdDefaultSimpleModuleSettingExample wdDefaultSimpleModuleSettingExample = new WdDefaultSimpleModuleSettingExample();
            wdDefaultSimpleModuleSettingExample.createCriteria().andDefaultSimpleModuleIdEqualTo(simpleModuleId).andBusinessElementIdIn(delBussinessElementIdList);
            wdDefaultSimpleModuleSettingService.deleteByExample(wdDefaultSimpleModuleSettingExample);
        }
        
        if (StringUtils.isNotEmpty(newBussinessElementIds)) {
            List<String> newBussinessElementIdList = Arrays.asList(newBussinessElementIds.split(","));
            for (String businessElementId : newBussinessElementIdList) {
                WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting = new WdDefaultSimpleModuleSetting();
                wdDefaultSimpleModuleSetting.setId(IdGen.uuid());
                wdDefaultSimpleModuleSetting.setDefaultSimpleModuleId(simpleModuleId);
                wdDefaultSimpleModuleSetting.setElementName(wdBusinessElementService.selectByPrimaryKey(businessElementId).getName());
                wdDefaultSimpleModuleSetting.setBusinessElementId(businessElementId);
                wdDefaultSimpleModuleSetting.setCreateBy(UserUtils.getUser().getId());
                wdDefaultSimpleModuleSetting.setCreateDate(new Date());
                wdDefaultSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
                wdDefaultSimpleModuleSetting.setUpdateDate(new Date());
                wdDefaultSimpleModuleSettingService.insertSelective(wdDefaultSimpleModuleSetting);
            }
        }
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:simlpeModule:del")
    @RequestMapping(value = "deleteItem")
    @ResponseBody
    public JsonResult deleteItem(String moduleSettingId) {
        WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting = wdDefaultSimpleModuleSettingService.selectByPrimaryKey(moduleSettingId);
        WdBusinessElement wdBusinessElement = new WdBusinessElement();
        wdBusinessElement.setId(wdDefaultSimpleModuleSetting.getBusinessElementId());
        wdBusinessElement.setUpdateBy(UserUtils.getUser().getId());
        wdBusinessElement.setUpdateDate(new Date());
        wdBusinessElementService.updateByPrimaryKeySelective(wdBusinessElement);
        wdDefaultSimpleModuleSettingService.deleteByPrimaryKey(moduleSettingId);
        return new JsonResult();
    }
    
}