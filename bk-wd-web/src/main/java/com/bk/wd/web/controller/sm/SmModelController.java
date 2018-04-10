package com.bk.wd.web.controller.sm;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sm.model.SmModel;
import com.bk.sm.model.SmModelElementConfig;
import com.bk.sm.model.SmModelElementConfigItem;
import com.bk.sm.service.SmModelElementConfigItemService;
import com.bk.sm.service.SmModelElementConfigService;
import com.bk.sm.service.SmModelService;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdSelectItem;
import com.bk.wd.service.WdSelectItemService;

/**
 * 评分模型设置
 * @Project Name:bk-wd-web 
 * @Date:2017年11月12日下午3:34:12 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sm/model")
public class SmModelController {
    
    @Autowired
    private SmModelService smModelService;
    
    @Autowired
    private SmModelElementConfigService smModelElementConfigService;
    
    @Autowired
    private SmModelElementConfigItemService smModelElementConfigItemService;
    
    @Autowired
    private WdSelectItemService wdSelectItemService;
    
    @RequestMapping(value = "/list")
    public String findList(Model model, Pagination pagination) {
        smModelService.selectByPagination(pagination, null);
        model.addAttribute("pagination", pagination);
        return "modules/sm/model/modelList";
    }
    
    @RequestMapping(value = "/form")
    public String form(Model model, String id) {
        model.addAttribute("id", id);
        return "modules/sm/model/modelForm";
    }
    
    @RequestMapping(value = "/detail")
    @ResponseBody
    public JsonResult getModelInfo(String modelId) {
        if (StringUtils.isEmpty(modelId)) {
           return new JsonResult();
        }
        SmModel smModel = smModelService.selectByPrimaryKey(modelId);
        List<SmModelElementConfig> elementConfigList = smModelElementConfigService.selectByModelId(modelId);
        for (SmModelElementConfig smModelElementConfig : elementConfigList) {
            smModelElementConfig.setElementConfigItemList(smModelElementConfigItemService.selectByElementConfigId(smModelElementConfig.getId()));
        }
        smModel.setElementConfigList(elementConfigList);
        return new JsonResult(smModel);
    }
    
    @RequestMapping(value = "/save")
    @ResponseBody
    public JsonResult save(SmModel smModel, String elementConfigs) {
        Date now = new Date();
        if (StringUtils.isEmpty(smModel.getId())) {
            smModel.setId(UidUtil.uuid());
            smModel.setCreateBy(UserUtils.getUser().getId());
            smModel.setCreateDate(now);
            smModel.setUpdateDate(now);
            smModel.setUpdateBy(UserUtils.getUser().getId());
            smModelService.insertSelective(smModel);
        } else {
            smModelElementConfigService.deleteByModelId(smModel.getId());
            
            SmModel smModel1 = smModelService.selectByPrimaryKey(smModel.getId());
            smModel.setCreateBy(smModel1.getCreateBy());
            smModel.setCreateDate(smModel1.getCreateDate());
            smModel.setUpdateDate(now);
            smModel.setUpdateBy(UserUtils.getUser().getId());
            smModelService.updateByPrimaryKey(smModel);
        }
        
        if (StringUtils.isNotEmpty(elementConfigs)) {
            SmModelElementConfig[] smModelElementConfigArray = JSON.parseObject(elementConfigs, SmModelElementConfig[].class);
            for (SmModelElementConfig smModelElementConfig : smModelElementConfigArray) {
                smModelElementConfig.setId(UidUtil.uuid());
                smModelElementConfig.setCreateDate(now);
                smModelElementConfig.setCreateBy(UserUtils.getUser().getId());
                smModelElementConfig.setModelId(smModel.getId());
                if (null != smModelElementConfig.getElementConfigItemList()) {
                    for (SmModelElementConfigItem smModelElementConfigItem : smModelElementConfig.getElementConfigItemList()) {
                        smModelElementConfigItem.setId(UidUtil.uuid());
                        smModelElementConfigItem.setCreateDate(now);
                        smModelElementConfigItem.setCreateBy(UserUtils.getUser().getId());
                        if (StringUtils.isNotEmpty(smModelElementConfigItem.getSelectItemId())) {
                            WdSelectItem wdSelectItem = wdSelectItemService.selectByPrimaryKey(smModelElementConfigItem.getSelectItemId());
                            smModelElementConfigItem.setSelectListId(wdSelectItem.getSelectListId());
                        }
                        smModelElementConfigItem.setUpdateBy(UserUtils.getUser().getId());
                        smModelElementConfigItem.setUpdateDate(now);
                        smModelElementConfigItem.setElementConfigId(smModelElementConfig.getId());
                        smModelElementConfigItemService.insertSelective(smModelElementConfigItem);
                    }
                }
                smModelElementConfigService.insertSelective(smModelElementConfig);
            }
        }
        return new JsonResult(smModel);
    }
    
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(SmModel smModel) {
        smModel.setUpdateBy(UserUtils.getUser().getId());
        smModel.setUpdateDate(new Date());
        smModel.setDelFlag(true);
        smModelService.updateByPrimaryKeySelective(smModel);
        return new JsonResult();
    }
    
    @RequestMapping(value = "enable")
    @ResponseBody
    public JsonResult disable(SmModel smModel) {
        smModel.setUpdateBy(UserUtils.getUser().getId());
        smModel.setUpdateDate(new Date());
        smModelService.updateByPrimaryKeySelective(smModel);
        return new JsonResult();
    }

}