package com.bk.wd.web.controller.wd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysUser;
import com.bk.sys.service.SysUserService;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdCommonSimpleModule;
import com.bk.wd.model.WdPerson;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdCommonSimpleModuleService;
import com.bk.wd.service.WdCommonSimpleModuleSettingService;
import com.bk.wd.service.WdCourtQueryService;
import com.bk.wd.service.WdCustomerBacklistService;
import com.bk.wd.service.WdPersonAssetsBuildingService;
import com.bk.wd.service.WdPersonAssetsCarService;
import com.bk.wd.service.WdPersonService;
import com.bk.wd.service.WdRwEmaySinowayCreditService;
import com.bk.wd.service.WdRwTxCreditAntifraudVerifyService;
import com.bk.wd.service.WdRwZmCreditAntifraudVerifyService;

/**
 * 人员
 * @Project Name:bk-wd-web 
 * @Date:2017年7月21日下午1:55:14 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/person")
public class PersonController {
    
    // 客户关系
    private static final String customer_relation = "客户关系人";

    // 车产
    private static final String customer_car = "家庭主要资产（车辆）";

    // 房产
    private static final String customer_building = "家庭主要资产（房产）";
    
    @Autowired
    private WdPersonService wdPersonService;
    
    @Autowired
    private WdCommonSimpleModuleSettingService wdCommonSimpleModuleSettingService;
    
    @Autowired
    private WdCommonSimpleModuleService wdCommonSimpleModuleService;
    
    @Autowired
    private WdPersonAssetsCarService wdPersonAssetsCarService;
    
    @Autowired
    private WdPersonAssetsBuildingService wdPersonAssetsBuildingService;
    
    @Autowired
    private WdBusinessElementService wdBusinessElementService;
    
    @Autowired
    private WdCustomerBacklistService wdCustomerBacklistService;
    
    @Autowired
    private WdCourtQueryService wdCourtQueryService;
    
    @Autowired
    private WdRwZmCreditAntifraudVerifyService wdRwZmCreditAntifraudVerifyService;
    
    @Autowired
    private WdRwTxCreditAntifraudVerifyService wdRwTxCreditAntifraudVerifyService;
    
    @Autowired
    private WdRwEmaySinowayCreditService wdRwEmaySinowayCreditService;
    
    @Autowired
    private SysUserService sysUserService;
    
    /**
     * 人员详情
     * date: 2017年7月21日 下午1:52:38 <br/> 
     * @author Liam 
     * @param model
     * @param request
     * @param personId
     * @param target
     * @return 
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/detail" })
    public String detail(Model model, HttpServletRequest request, String personId, String target, String targetType) {
        String referer = request.getHeader("Referer");
        request.getSession().setAttribute("person_detail_back_url", referer);
        model.addAttribute("personId", personId);
        if (StringUtils.isEmpty(target)) {
            target = "index";
        }
        model.addAttribute("targetType", targetType);
        return "redirect:/wd/person/detail/" + target;
    }
    
    @RequestMapping(value = { "/detail/index" })
    public String detailIndex(Model model, HttpServletRequest request, String personId, String targetType) {
        model.addAttribute("targetType", targetType);
        
        // 客户信息
        WdPerson wdPerson = wdPersonService.selectByPrimaryKey(personId);
        SysUser currentUser = sysUserService.selectByPrimaryKey(wdPerson.getCreateBy());
        
        model.addAttribute("wdPerson", wdPerson);
        
        model.addAttribute("personId", personId);
        
        Map<String, Object> config = new HashMap<>();

        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, currentUser.getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            config.put("customerRelation",
                    wdCommonSimpleModuleSettingService.selectByModuleVersion(
                            wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(),
                            wdCommonSimpleModuleRelation.getSettingVersion()));
        }
        WdCommonSimpleModule wdCommonSimpleModuleCar = wdCommonSimpleModuleService.selectByModuleName(customer_car, currentUser.getCompanyId());
        if (null != wdCommonSimpleModuleCar) {
            config.put("customerCar", wdCommonSimpleModuleSettingService.selectByModuleVersion(
                    wdCommonSimpleModuleCar.getDefaultSimpleModuleId(), wdCommonSimpleModuleCar.getSettingVersion()));
        }
        WdCommonSimpleModule wdCommonSimpleModuleBuilding = wdCommonSimpleModuleService
                .selectByModuleName(customer_building, currentUser.getCompanyId());
        if (null != wdCommonSimpleModuleBuilding) {
            config.put("customerBuilding",
                    wdCommonSimpleModuleSettingService.selectByModuleVersion(
                            wdCommonSimpleModuleBuilding.getDefaultSimpleModuleId(),
                            wdCommonSimpleModuleBuilding.getSettingVersion()));
        }
        model.addAttribute("config", config);
        model.addAttribute("customerRelationList", wdPersonService.selectRelationerByPersonId(personId, currentUser.getId()));
        model.addAttribute("customerCarList", wdPersonAssetsCarService.selectByPersonId(personId));
        model.addAttribute("customerBuildingList", wdPersonAssetsBuildingService.selectByPersonId(personId));

        List<WdBusinessElement> allElementList = wdBusinessElementService.selectAll();
        Map<String, Object> wdBusinessElementConfig = new HashMap<>();
        for (WdBusinessElement wdBusinessElement : new ArrayList<>(allElementList)) {
            wdBusinessElementConfig.put(wdBusinessElement.getId(), wdBusinessElement);
            allElementList.remove(wdBusinessElement);
        }
        model.addAttribute("wdBusinessElementConfig", wdBusinessElementConfig);

        Map<String, Object> params = new HashMap<>();
        params.put("userId", currentUser.getId());
        return "modules/wd/person/detail/index";
    }
    
    @RequestMapping(value = { "/detail/risk" })
    public String risk(Model model, HttpServletRequest request, String personId, String targetType) {
        model.addAttribute("targetType", targetType);
        
        model.addAttribute("wdCustomerBacklist", wdCustomerBacklistService.selectByCustomerId(personId));
        model.addAttribute("zhixinList", wdCourtQueryService.selectByPersonIdAndSite(personId, "zhixin", null));
        model.addAttribute("shixinList", wdCourtQueryService.selectByPersonIdAndSite(personId, "shixin", null));
        model.addAttribute("wdRwZmCreditAntifraudVerifyList", wdRwZmCreditAntifraudVerifyService.selectByPerson(personId));
        model.addAttribute("wdRwTxCreditAntifraudVerifyList", wdRwTxCreditAntifraudVerifyService.selectByPersonId(personId, null));
        model.addAttribute("wdRwEmaySinowayCreditList", wdRwEmaySinowayCreditService.selectByPersonId(personId, null));
        
        model.addAttribute("wdPerson", wdPersonService.selectByPrimaryKey(personId));
        model.addAttribute("personId", personId);
        return "modules/wd/person/detail/riskWarning";
    }

}