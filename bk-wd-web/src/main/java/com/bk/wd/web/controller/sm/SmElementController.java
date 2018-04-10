package com.bk.wd.web.controller.sm;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bk.common.entity.JsonResult;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sm.model.SmElement;
import com.bk.sm.model.SmElementDataConfig;
import com.bk.sm.model.SmElementDataConfigItem;
import com.bk.sm.service.SmElementDataConfigItemService;
import com.bk.sm.service.SmElementDataConfigService;
import com.bk.sm.service.SmElementService;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdDefaultSimpleModule;
import com.bk.wd.model.WdSelectItem;
import com.bk.wd.model.WdSelectList;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdDefaultSimpleModuleService;
import com.bk.wd.service.WdSelectItemService;
import com.bk.wd.service.WdSelectListService;
import com.bk.wd.util.BusinessConsts;
import com.bk.wd.vo.ModuleSettingVo;

/**
 * 评分元素设置
 * @Project Name:bk-wd-web 
 * @Date:2017年11月12日下午5:54:00 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sm/element")
public class SmElementController {
    
    @Autowired
    private SmElementService smElementService;
    
    @Autowired
    private SmElementDataConfigItemService smElementDataConfigItemService;
    
    @Autowired
    private SmElementDataConfigService smElementDataConfigService;
    
    @Autowired
    private WdBusinessElementService wdBusinessElementService;
    
    @Autowired
    private WdSelectListService selectListService;
    
    @Autowired
    private WdSelectItemService wdSelectItemService;
    
    @Autowired
    private WdDefaultSimpleModuleService wdDefaultSimpleModuleService;
    
    @RequestMapping(value = "/form")
    public String form() {
        return "modules/sm/element/elementForm";
    }
    @RequestMapping(value = "dataRange_configPanel")
    public String dataRange_configPanel() {
        return "modules/sm/element/dataRange_configPanel";
    }
    @RequestMapping(value = "/dataRange-add-group")
    public String dataRangeaddgroup() {
        return "modules/sm/element/dataRange-add-group";
    }
    @RequestMapping(value = "/dataRange-add-list")
    public String dataRangeaddlist() {
        return "modules/sm/element/dataRange-add-list";
    }
    @RequestMapping(value = "/dataRange-list")
    public String dataRangelist() {
        return "modules/sm/element/dataRange-list";
    }
    
    @RequestMapping(value = "/list")
    @ResponseBody
    public JsonResult findElementList() {
        List<SmElement> smElementList = smElementService.selectByCondition(null);
        for (SmElement smElement : smElementList) {
            switch (smElement.getElementType()) {
                case 1:
                    List<SmElementDataConfig> smElementDataConfigList = smElementDataConfigService.selectByElementId(smElement.getId());
                    for (SmElementDataConfig smElementDataConfig : smElementDataConfigList) {
                        smElementDataConfig.setItemList(smElementDataConfigItemService.selectByConfigId(smElementDataConfig.getId()));
                    }
                    smElement.setDataConfigList(smElementDataConfigList);
                case 2:
                    WdBusinessElement wdBusinessElement = wdBusinessElementService.selectByPrimaryKey(smElement.getSourceId());
                    List<WdSelectList> selectListList = selectListService.selectByGroupId(wdBusinessElement.getSelectGroupId());
                    for (WdSelectList wdSelectList : selectListList) {
                        wdSelectList.setItemList(wdSelectItemService.selectByListId(wdSelectList.getId()));
                    }
                    smElement.setSelectList(selectListList);
                    break;
                default:
                    break;
            }
        }
        
        return new JsonResult(smElementList);
    }
    
    @RequestMapping(value = "/moduleList")
    @ResponseBody
    public JsonResult findModuleList() {
        String[] moduleIdArray = {
                BusinessConsts.ModuleID.PersonInfo, 
                BusinessConsts.ModuleID.ExtendInfo,
                BusinessConsts.ModuleID.YearlyIncomeStatement,
                BusinessConsts.ModuleID.MonthlyIncomeStatement,
                BusinessConsts.ModuleID.BalanceSheet
            };
        List<Map<String, Object>> moduleList = new ArrayList<>();
        for (String moduleId : moduleIdArray) {
            WdDefaultSimpleModule wdDefaultSimpleModule = wdDefaultSimpleModuleService.selectByPrimaryKey(moduleId);
            Map<String, Object> module = new HashMap<>();
            module.put("moduleId", moduleId);
            module.put("moduleName", wdDefaultSimpleModule.getName());
            List<ModuleSettingVo> elementList = wdBusinessElementService.selectByModule(moduleId);
            for (ModuleSettingVo moduleSettingVo : elementList) {
                if (StringUtils.isNotEmpty(moduleSettingVo.getSelectGroupId())) {
                    List<WdSelectList> selectListList = selectListService.selectByGroupId(moduleSettingVo.getSelectGroupId());
                    for (WdSelectList wdSelectList : selectListList) {
                        wdSelectList.setItemList(wdSelectItemService.selectByListId(wdSelectList.getId()));
                    }
                    moduleSettingVo.setSelectList(selectListList);
                }
            }
            module.put("elementList", elementList);
            moduleList.add(module);
        }
        return new JsonResult(moduleList);
    }
    
    @RequestMapping(value = "/saveSmElement")
    @ResponseBody
    public JsonResult saveSmElement(SmElement smElement, String elementId) {
        Date now = new Date();
        
        WdBusinessElement wdBusinessElement = wdBusinessElementService.selectByPrimaryKey(smElement.getSourceId());
        smElement.setElementKey(wdBusinessElement.getKey());
        smElement.setElementName(wdBusinessElement.getName());
        smElement.setElementType(1);
        if (StringUtils.isNotEmpty(wdBusinessElement.getSelectGroupId())) {
            smElement.setElementType(2);
        }
        
        if (StringUtils.isEmpty(elementId)) {
            smElement.setId(UidUtil.uuid());
            smElement.setCreateBy(UserUtils.getUser().getId());
            smElement.setCreateDate(now);
            smElement.setUpdateDate(now);
            smElement.setUpdateBy(UserUtils.getUser().getId());
            smElementService.insertSelective(smElement);
        } else {
            smElement.setId(elementId);
            smElement.setUpdateDate(now);
            smElement.setUpdateBy(UserUtils.getUser().getId());
            smElementService.updateByPrimaryKeySelective(smElement);
        }
        return new JsonResult(smElement);
    }
    
    @RequestMapping(value = "/deleteSmElement")
    @ResponseBody
    public JsonResult deleteSmElement(String elementId) {
        smElementService.deleteByPrimaryKey(elementId);
        return new JsonResult();
    }
    
    @RequestMapping(value = "/saveDataConfig")
    @ResponseBody
    public JsonResult saveDataConfig(SmElementDataConfig smElementDataConfig, String dataConfigId) {
        Date now = new Date();
        if (StringUtils.isEmpty(dataConfigId)) {
            smElementDataConfig.setId(UidUtil.uuid());
            smElementDataConfig.setCreateBy(UserUtils.getUser().getId());
            smElementDataConfig.setCreateDate(now);
            smElementDataConfig.setUpdateDate(now);
            smElementDataConfig.setUpdateBy(UserUtils.getUser().getId());
            smElementDataConfigService.insertSelective(smElementDataConfig);
        } else {
            smElementDataConfig.setId(dataConfigId);
            smElementDataConfig.setUpdateDate(now);
            smElementDataConfig.setUpdateBy(UserUtils.getUser().getId());
            smElementDataConfigService.updateByPrimaryKeySelective(smElementDataConfig);
        }
        return new JsonResult(smElementDataConfig);
    }
    
    @RequestMapping(value = "/deleteDataConfig")
    @ResponseBody
    public JsonResult deleteDataConfig(String dataConfigId) {
        smElementDataConfigService.deleteByPrimaryKey(dataConfigId);
        return new JsonResult();
    }
    
    @RequestMapping(value = "/saveDataConfigItem")
    @ResponseBody
    public JsonResult saveDataConfigItem(SmElementDataConfigItem smElementDataConfigItem, String dataConfigItemId) {
        Date now = new Date();
        if (StringUtils.isEmpty(dataConfigItemId)) {
            smElementDataConfigItem.setId(UidUtil.uuid());
            smElementDataConfigItem.setCreateBy(UserUtils.getUser().getId());
            smElementDataConfigItem.setCreateDate(now);
            smElementDataConfigItem.setUpdateDate(now);
            smElementDataConfigItem.setUpdateBy(UserUtils.getUser().getId());
            smElementDataConfigItemService.insertSelective(smElementDataConfigItem);
        } else {
            smElementDataConfigItem.setId(dataConfigItemId);
            smElementDataConfigItem.setUpdateDate(now);
            smElementDataConfigItem.setUpdateBy(UserUtils.getUser().getId());
            smElementDataConfigItemService.updateByPrimaryKeySelective(smElementDataConfigItem);
        }
        return new JsonResult(smElementDataConfigItem);
    }
    
    @RequestMapping(value = "/saveDataConfigItems")
    @ResponseBody
    public JsonResult saveDataConfigItems(String itemData, String dataConfigId) {
        Date now = new Date();
        smElementDataConfigItemService.deleteByConfigId(dataConfigId);
        SmElementDataConfigItem[] smElementDataConfigItemArray = JSON.parseObject(itemData, SmElementDataConfigItem[].class);
        for (SmElementDataConfigItem smElementDataConfigItem : smElementDataConfigItemArray) {
            smElementDataConfigItem.setId(UidUtil.uuid());
            smElementDataConfigItem.setDataConfigId(dataConfigId);
            smElementDataConfigItem.setCreateBy(UserUtils.getUser().getId());
            smElementDataConfigItem.setCreateDate(now);
            smElementDataConfigItem.setUpdateDate(now);
            smElementDataConfigItem.setUpdateBy(UserUtils.getUser().getId());
            smElementDataConfigItemService.insertSelective(smElementDataConfigItem);
        }
        return new JsonResult();
    }
    
    @RequestMapping(value = "/saveSelectItems")
    @ResponseBody
    public JsonResult saveSelectItems(String itemData) {
        Date now = new Date();
        WdSelectItem[] selectItemArray = JSON.parseObject(itemData, WdSelectItem[].class);
        for (WdSelectItem wdSelectItem : selectItemArray) {
            wdSelectItem.setUpdateDate(now);
            wdSelectItem.setUpdateBy(UserUtils.getUser().getId());
            wdSelectItemService.updateByPrimaryKeySelective(wdSelectItem);
        }
        return new JsonResult();
    }
    
    @RequestMapping(value = "/deleteDataConfigItem")
    @ResponseBody
    public JsonResult deleteDataConfigItem(String dataConfigItemId) {
        smElementDataConfigItemService.deleteByPrimaryKey(dataConfigItemId);
        return new JsonResult();
    }
    
}