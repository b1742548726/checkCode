package com.bk.wd.web.controller.wd;

import java.util.Date;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdDefaultSimpleModuleSetting;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdDefaultSimpleModuleSettingService;
import com.bk.wd.web.base.BaseController;

/**
 * 元件管理
 * @Project Name:bk-wd-web 
 * @Date:2017年3月9日下午2:31:22 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/element")
public class BusinessElementController extends BaseController {
    
    @Autowired
    private WdBusinessElementService wdBusinessElementService;
    
    @Autowired
    private WdDefaultSimpleModuleSettingService wdDefaultSimpleModuleSettingService;
    
    @ModelAttribute
    public WdBusinessElement get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return wdBusinessElementService.selectByPrimaryKey(id);
        }else{
            return new WdBusinessElement();
        }
    }
    
    @RequiresPermissions("wd:element:view")
    @RequestMapping(value = {"list", ""})
    public String list(Model model, Pagination pagination, WdBusinessElement wdBusinessElement) {
        wdBusinessElementService.findByPage(pagination, wdBusinessElement);
        model.addAttribute("pagination", pagination);
        return "modules/wd/element/elementList";
    }

    @RequiresPermissions("wd:element:edit")
    @RequestMapping(value = "form")
    public String form(String id, Model model, String defaultSimpleModuleId) {
        model.addAttribute("defaultSimpleModuleId", defaultSimpleModuleId);
        model.addAttribute("wdBusinessElement", wdBusinessElementService.selectByPrimaryKey(id));
        return "modules/wd/element/elementForm";
    }
    
    @RequiresPermissions("wd:element:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(WdBusinessElement wdBusinessElement, String defaultSimpleModuleId, Model model) {
        if (StringUtils.isEmpty(wdBusinessElement.getId())) {
            
            // 根据key去找对应的元素，如果能找到，则不创建新元素
            WdBusinessElement element =  wdBusinessElementService.selectBykey(wdBusinessElement.getKey());
            if (null == element) {
                wdBusinessElement.setId(UidUtil.uuid());
                wdBusinessElement.setCreateBy(UserUtils.getUser().getId());
                wdBusinessElement.setCreateDate(new Date());
                wdBusinessElement.setUpdateBy(UserUtils.getUser().getId());
                wdBusinessElement.setUpdateDate(new Date());
                wdBusinessElementService.insertSelective(wdBusinessElement);
            } else {
                wdBusinessElement.setId(element.getId());
                wdBusinessElement.setUpdateBy(UserUtils.getUser().getId());
                wdBusinessElement.setUpdateDate(new Date());
                wdBusinessElementService.updateByPrimaryKeySelective(wdBusinessElement);
            }
            
            WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting = new WdDefaultSimpleModuleSetting();
            wdDefaultSimpleModuleSetting.setId(UidUtil.uuid());
            wdDefaultSimpleModuleSetting.setBusinessElementId(wdBusinessElement.getId());
            wdDefaultSimpleModuleSetting.setDefaultSimpleModuleId(defaultSimpleModuleId);
            wdDefaultSimpleModuleSetting.setCreateBy(UserUtils.getUser().getId());
            wdDefaultSimpleModuleSetting.setCreateDate(new Date());
            wdDefaultSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
            wdDefaultSimpleModuleSetting.setUpdateDate(new Date());
            wdDefaultSimpleModuleSettingService.insertSelective(wdDefaultSimpleModuleSetting);
        } else {
            wdBusinessElement.setUpdateBy(UserUtils.getUser().getId());
            wdBusinessElement.setUpdateDate(new Date());
            wdBusinessElementService.updateByPrimaryKeySelective(wdBusinessElement);
        }
        
        return new JsonResult();
    }
    
}