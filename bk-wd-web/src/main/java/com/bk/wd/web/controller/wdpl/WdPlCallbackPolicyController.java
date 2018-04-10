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

import com.bk.common.entity.JsonResult;
import com.bk.common.utils.StringUtils;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.pl.model.WdPlCallbackPolicy;
import com.bk.wd.pl.service.WdPlCallbackPolicyService;

@Controller
@RequestMapping(value = "/wdpl/callback/policy")
public class WdPlCallbackPolicyController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(WdPlCallbackPolicyController.class);

    @Autowired
    private WdPlCallbackPolicyService wdPlCallbackPolicyService;
    
    @ModelAttribute("wdPlCallbackPolicy")
    public WdPlCallbackPolicy get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return wdPlCallbackPolicyService.selectByPrimaryKey(id);
        }else{
            return new WdPlCallbackPolicy();
        }
    }

    @RequestMapping(value = "/form")
    public String form(WdPlCallbackPolicy wdPlCallbackPolicy, Model model) {
        if (null != wdPlCallbackPolicy && null == wdPlCallbackPolicy.getCallbackType()) {
            wdPlCallbackPolicy.setCallbackType(1); //首次回访
        }
        model.addAttribute("wdPlCallbackPolicy", wdPlCallbackPolicy);
        return "modules/wdpl/callback/policyForm";
    }
    
    @RequestMapping(value = "/save")
    @ResponseBody
    public JsonResult save(WdPlCallbackPolicy wdPlCallbackPolicy, Model model) {
        if (StringUtils.isEmpty(wdPlCallbackPolicy.getId())) {
            wdPlCallbackPolicy.setId(IdGen.uuid());
            wdPlCallbackPolicy.setCompanyId(UserUtils.getUser().getCompanyId());
            wdPlCallbackPolicy.setCreateBy(UserUtils.getUser().getId());
            wdPlCallbackPolicy.setCreateDate(new Date());
            wdPlCallbackPolicy.setUpdateBy(UserUtils.getUser().getId());
            wdPlCallbackPolicy.setUpdateDate(new Date());
            wdPlCallbackPolicyService.insertSelective(wdPlCallbackPolicy);
        } else {
            wdPlCallbackPolicy.setUpdateBy(UserUtils.getUser().getId());
            wdPlCallbackPolicy.setUpdateDate(new Date());
            wdPlCallbackPolicyService.updateByPrimaryKeySelective(wdPlCallbackPolicy);
        }
        return new JsonResult();
    }
    
    @RequestMapping(value = "/del")
    @ResponseBody
    public JsonResult del(WdPlCallbackPolicy wdPlCallbackPolicy, Model model) {
        wdPlCallbackPolicy.setDelFlag(true);
        wdPlCallbackPolicy.setUpdateBy(UserUtils.getUser().getId());
        wdPlCallbackPolicy.setUpdateDate(new Date());
        wdPlCallbackPolicyService.updateByPrimaryKeySelective(wdPlCallbackPolicy);
        return new JsonResult();
    }
    
    @RequestMapping(value = "enable")
    @ResponseBody
    public JsonResult disable(WdPlCallbackPolicy wdPlCallbackPolicy) {
        wdPlCallbackPolicy.setUpdateBy(UserUtils.getUser().getId());
        wdPlCallbackPolicy.setUpdateDate(new Date());
        wdPlCallbackPolicyService.updateByPrimaryKeySelective(wdPlCallbackPolicy);
        return new JsonResult();
    }
}
