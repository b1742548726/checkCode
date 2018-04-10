package com.bk.wd.web.controller.wdpl;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bk.common.entity.JsonResult;
import com.bk.common.utils.StringUtils;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.pl.model.WdPlRiskInquiryPolicy;
import com.bk.wd.pl.model.WdPlRiskInquiryPolicyItem;
import com.bk.wd.pl.service.WdPlRiskInquiryPolicyItemService;
import com.bk.wd.pl.service.WdPlRiskInquiryPolicyService;

@Controller
@RequestMapping(value = "/wdpl/riskInquiry/policy")
public class WdPlRiskInquiryPolicyController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(WdPlRiskInquiryPolicyController.class);
    
    @Autowired
    private WdPlRiskInquiryPolicyService wdPlRiskInquiryPolicyService;
    
    @Autowired
    private WdPlRiskInquiryPolicyItemService wdPlRiskInquiryPolicyItemService;
    
    @ModelAttribute("wdPlRiskInquiryPolicy")
    public WdPlRiskInquiryPolicy get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return wdPlRiskInquiryPolicyService.selectByPrimaryKey(id);
        }else{
            return new WdPlRiskInquiryPolicy();
        }
    }

    @RequestMapping(value = "/form")
    public String form(WdPlRiskInquiryPolicy wdPlRiskInquiryPolicy, Model model) {
        if (null != wdPlRiskInquiryPolicy && StringUtils.isNotEmpty(wdPlRiskInquiryPolicy.getId())) {
            wdPlRiskInquiryPolicy.setPolicyItemList(wdPlRiskInquiryPolicyItemService.selectByRiskInquiryPolicyId(wdPlRiskInquiryPolicy.getId()));
        }
        model.addAttribute("wdPlRiskInquiryPolicy", wdPlRiskInquiryPolicy);
        return "modules/wdpl/riskInquiry/policyForm";
    }
    
    @RequestMapping(value = "/save")
    @ResponseBody
    public JsonResult save(WdPlRiskInquiryPolicy wdPlRiskInquiryPolicy, String policyItems, Model model) {
        if (StringUtils.isEmpty(wdPlRiskInquiryPolicy.getId())) {
            wdPlRiskInquiryPolicy.setId(IdGen.uuid());
            wdPlRiskInquiryPolicy.setCompanyId(UserUtils.getUser().getCompanyId());
            wdPlRiskInquiryPolicy.setCreateBy(UserUtils.getUser().getId());
            wdPlRiskInquiryPolicy.setCreateDate(new Date());
            wdPlRiskInquiryPolicy.setUpdateBy(UserUtils.getUser().getId());
            wdPlRiskInquiryPolicy.setUpdateDate(new Date());
            wdPlRiskInquiryPolicyService.insertSelective(wdPlRiskInquiryPolicy);
        } else {
            wdPlRiskInquiryPolicy.setUpdateBy(UserUtils.getUser().getId());
            wdPlRiskInquiryPolicy.setUpdateDate(new Date());
            wdPlRiskInquiryPolicyService.updateByPrimaryKeySelective(wdPlRiskInquiryPolicy);
            wdPlRiskInquiryPolicyItemService.deleteByRiskInquiryPolicyId(wdPlRiskInquiryPolicy.getId());
        }
        
        WdPlRiskInquiryPolicyItem[] WdPlRiskInquiryPolicyItemArray = JSON.parseObject(policyItems, WdPlRiskInquiryPolicyItem[].class);
        for (WdPlRiskInquiryPolicyItem wdPlRiskInquiryPolicyItem : WdPlRiskInquiryPolicyItemArray) {
            wdPlRiskInquiryPolicyItem.setId(IdGen.uuid());
            wdPlRiskInquiryPolicyItem.setRiskInquiryPolicyId(wdPlRiskInquiryPolicy.getId());
            wdPlRiskInquiryPolicyItemService.insert(wdPlRiskInquiryPolicyItem);
        }
        return new JsonResult();
    }
    
    @RequestMapping(value = "/del")
    @ResponseBody
    public JsonResult del(WdPlRiskInquiryPolicy wdPlRiskInquiryPolicy, Model model) {
        wdPlRiskInquiryPolicy.setDelFlag(true);
        wdPlRiskInquiryPolicy.setUpdateBy(UserUtils.getUser().getId());
        wdPlRiskInquiryPolicy.setUpdateDate(new Date());
        wdPlRiskInquiryPolicyService.updateByPrimaryKeySelective(wdPlRiskInquiryPolicy);
        return new JsonResult();
    }
    
    @RequestMapping(value = "enable")
    @ResponseBody
    public JsonResult disable(WdPlRiskInquiryPolicy wdPlRiskInquiryPolicy) {
        wdPlRiskInquiryPolicy.setUpdateBy(UserUtils.getUser().getId());
        wdPlRiskInquiryPolicy.setUpdateDate(new Date());
        wdPlRiskInquiryPolicyService.updateByPrimaryKeySelective(wdPlRiskInquiryPolicy);
        return new JsonResult();
    }

}