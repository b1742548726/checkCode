package com.bk.wd.web.controller.wd;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.bk.sys.model.SysOffice;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdCommonSimpleModule;
import com.bk.wd.model.WdCommonSimpleModuleSetting;
import com.bk.wd.model.WdCommonSimpleModuleSettingExample;
import com.bk.wd.model.WdDefaultSimpleModuleSetting;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdCommonSimpleModuleService;
import com.bk.wd.service.WdCommonSimpleModuleSettingService;
import com.bk.wd.service.WdDefaultSimpleModuleService;
import com.bk.wd.service.WdDefaultSimpleModuleSettingService;
import com.bk.wd.service.WdSelectGroupService;

/**
 * 公用模块
 * @Project Name:bk-wd-web 
 * @Date:2017年4月4日下午8:33:12 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/commonModule")
public class CommonModuleController {
    
    @Autowired
    private WdCommonSimpleModuleService wdCommonSimpleModuleService;
    
    @Autowired
    private WdCommonSimpleModuleSettingService wdCommonSimpleModuleSettingService;
    
    @Autowired
    private WdSelectGroupService wdSelectGroupService;
    
    @Autowired
    private WdBusinessElementService wdBusinessElementService;
    
    @Autowired
    private WdDefaultSimpleModuleSettingService wdDefaultSimpleModuleSettingService;
    
    @Autowired
    private WdDefaultSimpleModuleService wdDefaultSimpleModuleService;
    
    @ModelAttribute
    public WdCommonSimpleModule get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return wdCommonSimpleModuleService.selectByPrimaryKey(id);
        }else{
            return new WdCommonSimpleModule();
        }
    }
    
    @RequiresPermissions("wd:commonModule:view")
    @RequestMapping(value = {"list", ""})
    public String list(Model model, Pagination pagination, WdCommonSimpleModule wdCommonSimpleModule) {
        if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
            wdCommonSimpleModule.setCompanyId(UserUtils.getUser().getCompanyId());
        }
        wdCommonSimpleModuleService.selectByPagination(pagination, wdCommonSimpleModule);
        model.addAttribute("pagination", pagination);
        return "modules/wd/commonModule/commonModuleList";
    }
    
    @RequiresPermissions("wd:commonModule:edit")
    @RequestMapping(value = "form")
    public String form(WdCommonSimpleModule wdCommonSimpleModule, Model model) {
        model.addAttribute("wdCommonSimpleModule", wdCommonSimpleModule);
        return "modules/wd/commonModule/commonModuleForm";
    }
    
    @RequiresPermissions("wd:commonModule:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(WdCommonSimpleModule wdCommonSimpleModule, Model model) {
        if (StringUtils.isEmpty(wdCommonSimpleModule.getId())) {
            wdCommonSimpleModule.setId(IdGen.uuid());
            wdCommonSimpleModule.setCreateBy(UserUtils.getUser().getId());
            wdCommonSimpleModule.setCreateDate(new Date());
            wdCommonSimpleModule.setCompanyId(UserUtils.getUser().getCompanyId());
            wdCommonSimpleModule.setUpdateBy(UserUtils.getUser().getId());
            wdCommonSimpleModule.setUpdateDate(new Date());
            wdCommonSimpleModule.setSettingVersion("0");
            wdCommonSimpleModuleService.insertSelective(wdCommonSimpleModule);
        } else {
            wdCommonSimpleModule.setUpdateBy(UserUtils.getUser().getId());
            wdCommonSimpleModule.setUpdateDate(new Date());
            wdCommonSimpleModuleService.updateByPrimaryKeySelective(wdCommonSimpleModule);
        }
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:commonModule:del")
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(WdCommonSimpleModule wdCommonSimpleModule) {
        wdCommonSimpleModule.setUpdateBy(UserUtils.getUser().getId());
        wdCommonSimpleModule.setUpdateDate(new Date());
        wdCommonSimpleModule.setDelFlag(true);
        wdCommonSimpleModuleService.updateByPrimaryKeySelective(wdCommonSimpleModule);
        return new JsonResult();
    }
    
    /**
     *配置列表
     * date: 2017年3月17日 下午4:11:58 <br/> 
     * @author Liam 
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:commonModule:edit")
    @RequestMapping(value = {"settingForm"})
    public String settingForm(Model model, WdCommonSimpleModule wdCommonSimpleModule) {
        String newVersion = "temp" + new Date().getTime();
        List<WdCommonSimpleModuleSetting> wdCommonSimpleModuleSettingList = wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModule.getDefaultSimpleModuleId(), wdCommonSimpleModule.getSettingVersion());
        if (!wdCommonSimpleModuleSettingList.isEmpty()) {
            for (WdCommonSimpleModuleSetting wdCommonSimpleModuleSetting : wdCommonSimpleModuleSettingList) {
                wdCommonSimpleModuleSetting.setId(IdGen.uuid());
                wdCommonSimpleModuleSetting.setCreateBy(UserUtils.getUser().getId());
                wdCommonSimpleModuleSetting.setCreateDate(new Date());
                wdCommonSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
                wdCommonSimpleModuleSetting.setUpdateDate(new Date());
                wdCommonSimpleModuleSetting.setVersion(newVersion);
                wdCommonSimpleModuleSettingService.insertSelective(wdCommonSimpleModuleSetting);
            }
        }
        
        // 生成必选项的值
        List<WdDefaultSimpleModuleSetting> wdDefaultSimpleModuleSettingList = wdDefaultSimpleModuleSettingService.selectByModuleId(wdCommonSimpleModule.getDefaultSimpleModuleId());
        for (WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting : wdDefaultSimpleModuleSettingList) {
            if ("1".equals(wdDefaultSimpleModuleSetting.getRequired())) {
                WdCommonSimpleModuleSetting wdCommonSimpleModuleSetting = new WdCommonSimpleModuleSetting();
                wdCommonSimpleModuleSetting.setDefaultSimpleModuleSettingId(wdDefaultSimpleModuleSetting.getId());
                wdCommonSimpleModuleSetting.setRequired("1");
                wdCommonSimpleModuleSetting.setVersion(newVersion);
                settingSave(wdCommonSimpleModuleSetting);
            }
        }
        
        model.addAttribute("wdCommonSimpleModule", wdCommonSimpleModule);
        model.addAttribute("newVersion", newVersion);
        model.addAttribute("defaultModule", wdDefaultSimpleModuleService.selectByPrimaryKey(wdCommonSimpleModule.getDefaultSimpleModuleId()));
        Map<String, Object> params = new HashMap<>();
        params.put("moduleId", wdCommonSimpleModule.getDefaultSimpleModuleId());
        params.put("version", newVersion);
        model.addAttribute("commonModuleSettingList", wdBusinessElementService.selectCommonLeftModule(params));
        return "modules/wd/commonModule/commonModuleSettingForm";
    }
    
    @RequiresPermissions("wd:commonModule:edit")
    @RequestMapping(value = {"settingList"})
    public String settingList(Model model, String version, String moduleId) {
        Map<String, Object> params = new HashMap<>();
        params.put("moduleId", moduleId);
        params.put("version", version);
        model.addAttribute("commonModuleSettingList",
                wdBusinessElementService.selectCommonLeftModule(params));
        return "modules/wd/commonModule/commonModuleSettingList";
    }
    
    @RequiresPermissions("wd:commonModule:edit")
    @RequestMapping(value = {"settingSave"})
    @ResponseBody
    public JsonResult settingSave(WdCommonSimpleModuleSetting wdCommonSimpleModuleSetting) {
        WdCommonSimpleModuleSetting wdCommonSimpleModuleSettingMain = wdCommonSimpleModuleSettingService.selectByModuleSettingVersion(wdCommonSimpleModuleSetting.getDefaultSimpleModuleSettingId(), wdCommonSimpleModuleSetting.getVersion());
        if (null == wdCommonSimpleModuleSettingMain) {
            wdCommonSimpleModuleSetting.getDefaultSimpleModuleSettingId();
            WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting = wdDefaultSimpleModuleSettingService.selectByPrimaryKey(wdCommonSimpleModuleSetting.getDefaultSimpleModuleSettingId());
            wdCommonSimpleModuleSetting.setDefaultSimpleModuleId(wdDefaultSimpleModuleSetting.getDefaultSimpleModuleId());
            WdBusinessElement wdBusinessElement = wdBusinessElementService.selectByPrimaryKey(wdDefaultSimpleModuleSetting.getBusinessElementId());
            wdCommonSimpleModuleSetting.setElementHeight(wdBusinessElement.getHeight());
            wdCommonSimpleModuleSetting.setBusinessElementId(wdBusinessElement.getId());
            wdCommonSimpleModuleSetting.setElementName(wdBusinessElement.getName());
            wdCommonSimpleModuleSetting.setElementPlaceholder(wdBusinessElement.getPlaceholder());
            wdCommonSimpleModuleSetting.setElementErrorMessage(wdBusinessElement.getErrorMessage());
            if (StringUtils.isNoneEmpty(wdBusinessElement.getSelectGroupId())) {
                wdCommonSimpleModuleSetting.setElementSelectListId(wdSelectGroupService.getSelectGroupDefault(wdBusinessElement.getSelectGroupId()));
            }
            wdCommonSimpleModuleSetting.setId(IdGen.uuid());
            wdCommonSimpleModuleSetting.setCreateBy(UserUtils.getUser().getId());
            wdCommonSimpleModuleSetting.setCreateDate(new Date());
            wdCommonSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
            wdCommonSimpleModuleSetting.setUpdateDate(new Date());
            wdCommonSimpleModuleSetting.setSortMobile(99); //默认在最后
            wdCommonSimpleModuleSettingService.insertSelective(wdCommonSimpleModuleSetting);
        } else {
            wdCommonSimpleModuleSetting.setId(wdCommonSimpleModuleSettingMain.getId());
            wdCommonSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
            wdCommonSimpleModuleSetting.setUpdateDate(new Date());
            wdCommonSimpleModuleSettingService.updateByPrimaryKeySelective(wdCommonSimpleModuleSetting);
        }
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:commonModule:edit")
    @RequestMapping(value = {"settingDelete"})
    @ResponseBody
    public JsonResult settingDelete(String version, String defaultSimpleModuleSettingId) {
        WdCommonSimpleModuleSettingExample wdCommonSimpleModuleSettingExample = new WdCommonSimpleModuleSettingExample();
        wdCommonSimpleModuleSettingExample.createCriteria().andDefaultSimpleModuleSettingIdEqualTo(defaultSimpleModuleSettingId).andVersionEqualTo(version);
        wdCommonSimpleModuleSettingService.deleteByExample(wdCommonSimpleModuleSettingExample);
        return new JsonResult();
    }
    
    /**
     * 发布配置
     * date: 2017年3月17日 下午5:34:38 <br/> 
     * @author Liam 
     * @param data
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:commonModule:edit")
    @RequestMapping(value = {"settingIssue"})
    @ResponseBody
    public JsonResult settingIssue( WdCommonSimpleModule wdCommonSimpleModule, String version) {
        wdCommonSimpleModule.setSettingVersion(version);
        wdCommonSimpleModule.setUpdateBy(UserUtils.getUser().getId());
        wdCommonSimpleModule.setUpdateDate(new Date());
        wdCommonSimpleModuleService.updateByPrimaryKeySelective(wdCommonSimpleModule);
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:commonModule:edit")
    @RequestMapping(value = {"settingSorts"})
    @ResponseBody
    public JsonResult settingSorts(String ids) {
        if (StringUtils.isNoneEmpty(ids)) {
            String[] idArray = ids.split(",");
            for (int i = 0; i < idArray.length; i++) {
                if (StringUtils.isNoneEmpty(idArray[i])) {
                    WdCommonSimpleModuleSetting wdCommonSimpleModuleSetting = wdCommonSimpleModuleSettingService.selectByPrimaryKey(idArray[i]);
                    wdCommonSimpleModuleSetting.setSortMobile(i);
                    wdCommonSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
                    wdCommonSimpleModuleSetting.setUpdateDate(new Date());
                    wdCommonSimpleModuleSettingService.updateByPrimaryKeySelective(wdCommonSimpleModuleSetting);
                }
            }
        }
        return new JsonResult();
    }
}