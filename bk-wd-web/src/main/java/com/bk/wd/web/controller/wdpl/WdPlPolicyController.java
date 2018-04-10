package com.bk.wd.web.controller.wdpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.wd.pl.service.WdPlCallbackPolicyService;
import com.bk.wd.pl.service.WdPlRiskInquiryPolicyService;
import com.bk.wd.pl.util.TimingPolicyHandle;

@Controller
@RequestMapping(value = "/wdpl/policy")
public class WdPlPolicyController {

    private static final Logger LOGGER = LoggerFactory.getLogger(WdPlPolicyController.class);

    @Autowired
    private WdPlCallbackPolicyService wdPlCallbackPolicyService;

    @Autowired
    private WdPlRiskInquiryPolicyService wdPlRiskInquiryPolicyService;

    @Autowired
    private TimingPolicyHandle timingPolicyHandle;

    @RequestMapping(value = "/list")
    public String list(Integer policyType, Model model) {
        if (null == policyType) {
            policyType = 1;
        }

        if (policyType == 4) {
            model.addAttribute("policyList", wdPlRiskInquiryPolicyService.selectByParams(null));
        } else {
            model.addAttribute("policyList", wdPlCallbackPolicyService.selectByType(policyType));
        }
        model.addAttribute("policyType", policyType);
        return "/modules/wdpl/policyList";
    }

    @RequestMapping(value = "/test")
    public String test(Model model) {
        return "/modules/wdpl/policyTest";
    }

    @RequestMapping(value = "/test/review")
    @ResponseBody
    public JsonResult testReview() {
        // try {
        timingPolicyHandle.runCallbackPolicy();
        // } catch (Exception e) {
        // System.out.println(e);
        // return new JsonResult(false, e.getMessage());
        // }
        return new JsonResult(true, "回访策略运行完成");
    }

    @RequestMapping(value = "/test/risk")
    @ResponseBody
    public JsonResult testRisk() {
        // try {
        timingPolicyHandle.runRiskPolicy();
        // } catch (Exception e) {
        // System.out.println(e);
        // return new JsonResult(false, e.getMessage());
        // }

        return new JsonResult(true, "风险策略运行完成");
    }

}