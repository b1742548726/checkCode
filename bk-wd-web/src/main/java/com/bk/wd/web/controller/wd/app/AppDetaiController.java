package com.bk.wd.web.controller.wd.app;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bk.wd.pl.service.WdApplicationFamilyProfitLossService;
import com.bk.wd.web.utils.HexUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.GeneralException;
import com.bk.common.entity.JsonResult;
import com.bk.common.utils.EntityUtils;
import com.bk.common.utils.FileUtil;
import com.bk.common.utils.UidUtil;
import com.bk.common.utils.ZipUtil;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysUserService;
import com.bk.wd.model.*;
import com.bk.wd.pl.util.InitCardInfo;
import com.bk.wd.pl.util.InitCardInfo4Manual;
import com.bk.wd.service.*;
import com.bk.wd.util.BusinessConsts;
import com.bk.wd.util.BusinessConsts.Action;
import com.bk.wd.util.ProcessHandle;
import com.bk.wd.util.process.EngineHandler;

@Controller
@RequestMapping(value = "/wd/application/detail")
public class AppDetaiController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppDetaiController.class);

    // 客户关系
    private static final String customer_relation = "客户关系人";

    // 车产
    private static final String customer_car = "家庭主要资产（车辆）";

    // 房产
    private static final String customer_building = "家庭主要资产（房产）";

    @Autowired
    private WdApplicationService wdApplicationService;

    @Autowired
    private WdCustomerService wdCustomerService;

    @Autowired
    private WdApplicationPersonService wdApplicationPersonService;

    @Autowired
    private WdPersonService wdPersonService;

    @Autowired
    private WdApplicationCreditInvestigationService wdApplicationCreditInvestigationService;

    @Autowired
    private WdPersonAssetsCarService wdPersonAssetsCarService;

    @Autowired
    private WdApplicationAssetsCarService wdApplicationAssetsCarService;

    @Autowired
    private WdPersonAssetsBuildingService wdPersonAssetsBuildingService;

    @Autowired
    private WdApplicationAssetsBuildingService wdApplicationAssetsBuildingService;

    @Autowired
    private WdApplicationBuildingMortgageService wdApplicationBuildingMortgageService;

    @Autowired
    private WdApplicationRecognizorService wdApplicationRecognizorService;

    @Autowired
    private WdApplicationExtendInfoService wdApplicationExtendInfoService;

    @Autowired
    private WdApplicationMonthlyIncomeStatementService wdApplicationMonthlyIncomeStatementService;

    @Autowired
    private WdApplicationYearlyIncomeStatementService wdApplicationYearlyIncomeStatementService;

    @Autowired
    private WdApplicationBalanceSheetService wdApplicationBalanceSheetService;

    @Autowired
    private WdApplicationPhotoService wdApplicationPhotoService;

    @Autowired
    private WdApplicationBusinessService wdApplicationBusinessService;

    @Autowired
    private WdProductService wdProductService;

    @Autowired
    private WdProductSimpleModuleService wdProductSimpleModuleService;

    @Autowired
    private WdProductComplexModuleService wdProductComplexModuleService;

    @Autowired
    private WdProductSimpleModuleSettingService wdProductSimpleModuleSettingService;

    @Autowired
    private WdCustomerTypeService wdCustomerTypeService;

    @Autowired
    private WdCustomerTypeSettingService wdCustomerTypeSettingService;

    @Autowired
    private WdCommonSimpleModuleService wdCommonSimpleModuleService;

    @Autowired
    private WdCommonSimpleModuleSettingService wdCommonSimpleModuleSettingService;

    @Autowired
    private WdApplicationPersonRelationService wdApplicationPersonRelationService;

    @Autowired
    private WdApplicationInfoDeviationAnalysisService wdApplicationInfoDeviationAnalysisService;

    @Autowired
    private WdApplicationOperatingBalanceSheetService wdApplicationOperatingBalanceSheetService;

    @Autowired
    private WdApplicationOperatingBalanceSheetCheckService wdApplicationOperatingBalanceSheetCheckService;

    @Autowired
    private WdApplicationOperatingBalanceSheetDetailService wdApplicationOperatingBalanceSheetDetailService;

    @Autowired
    private WdApplicationOperatingBalanceSheetAdditionalService wdApplicationOperatingBalanceSheetAdditionalService;

    @Autowired
    private WdApplicationCreditHistoryService wdApplicationCreditHistoryService;

    @Autowired
    private WdApplicationCreditHistoryDetailService wdApplicationCreditHistoryDetailService;

    @Autowired
    private WdApplicationFixAssetsService wdApplicationFixAssetsService;

    @Autowired
    private WdApplicationGoodsService wdApplicationGoodsService;

    @Autowired
    private WdApplicationIndirectInvestigationService wdApplicationIndirectInvestigationService;

    @Autowired
    private WdApplicationOutstandingAccountService wdApplicationOutstandingAccountService;

    @Autowired
    private WdApplicationOutstandingAccountDetailService wdApplicationOutstandingAccountDetailService;

    @Autowired
    private WdApplicationProfitService wdApplicationProfitService;

    @Autowired
    private WdApplicationProfitLogicService wdApplicationProfitLogicService;

    @Autowired
    private WdApplicationRefundPlanService wdApplicationRefundPlanService;

    @Autowired
    private WdApplicationBusinessIncomeStatementService wdApplicationBusinessIncomeStatementService;

    @Autowired
    private WdApplicationBusinessIncomeStatementDetailsService wdApplicationBusinessIncomeStatementDetailsService;

    @Autowired
    private WdApplicationTaskService wdApplicationTaskService;

    @Autowired
    private WdApplicationCarLoanMortgageService wdApplicationCarLoanMortgageService;

    @Autowired
    private WdBusinessElementService wdBusinessElementService;

    @Autowired
    private ProcessHandle processHandle;

    @Autowired
    private WdProductProcessService wdProductProcessService;

    @Autowired
    private WdApplicationCoborrowerService wdApplicationCoborrowerService;

    @Autowired
    private WdDefaultSimpleModuleSettingService wdDefaultSimpleModuleSettingService;

    @Autowired
    private WdCustomerTrackService wdCustomerTrackService;

    @Autowired
    private WdApplicationSurveySiteService wdApplicationSurveySiteService;

    @Autowired
    private WdCourtQueryService wdCourtQueryService;

    @Autowired
    private WdRwZmCreditAntifraudVerifyService wdRwZmCreditAntifraudVerifyService;

    @Autowired
    private WdCustomerBacklistService wdCustomerBacklistService;

    @Autowired
    private WdPersonRelationService wdPersonRelationService;

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private WdApplicationDualNoteService wdApplicationDualNoteService;

    @Autowired
    private WdRwTxCreditAntifraudVerifyService wdRwTxCreditAntifraudVerifyService;

    @Autowired
    private EngineHandler processEngine;
    
    @Autowired
    private WdApplicationCreditCardInfoService wdApplicationCreditCardInfoService;
    
    @Autowired
    private WdApplicationNetProfitLogicService wdApplicationNetProfitLogicService;
    
    @Autowired
    private WdRwEmaySinowayCreditService wdRwEmaySinowayCreditService;

    @Autowired
    private WdApplicationFamilyProfitLossService wdApplicationFamilyProfitLossService;
    
    @RequestMapping(value = { "" })
    public String index(Model model, HttpServletRequest request, String applicationId, String taskId) {
        String referer = request.getHeader("Referer");
        request.getSession().setAttribute("app_detail_back_url", referer);
        request.getSession().setAttribute("appTaskId", taskId);
        model.addAttribute("applicationId", applicationId);
        return "redirect:/wd/application/detail/index";
    }

    /**
     * 根据状态控制按钮show/hide
     * @param status
     * @return
     */
    private Map<String, Boolean> btnStatus(Integer status){
//      目前的状态，1（待分配），2（调查），4（征信），8（线下资料），16（表格审核），32（风控），64（线下贷审会），128（线上贷审会），256（超额审批），
//      512（放款审批），1024（放贷中），2048（还款），4096（贷款完结），8192（终止申请）等等。当调查处于线下资料和表格审核时，值为8+16=24
        Map<String, Boolean> map = new HashMap<>();
        map.put("pass", HexUtils.checkHexIntegerEqArr(status, new Integer[]{8,16,32,64,256}));
        map.put("overrule", HexUtils.checkHexIntegerEqArr(status, new Integer[]{8,16,32,64,256,512}));
        map.put("reject", HexUtils.checkHexIntegerEqArr(status, new Integer[]{32,256}));
        map.put("cancel", HexUtils.checkHexIntegerEqArr(status, new Integer[]{512}));
        map.put("submit", HexUtils.checkHexIntegerEqArr(status, new Integer[]{512}));
        return map;
    }

    /**
     * 贷款详情 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequestMapping(value = { "index" })
    public String detail(HttpServletRequest request, Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        SysUser currentUser = sysUserService.selectByPrimaryKey(wdApplication.getOwnerId());
        // 申请信息
        model.addAttribute("wdApplication", wdApplication);
        // 按钮展示状态
        if(request.getSession().getAttribute("appTaskId") != null){
            WdApplicationTask appTask = wdApplicationTaskService.selectByPrimaryKey(request.getSession().getAttribute("appTaskId").toString());
            if(appTask != null)
                model.addAttribute("btnStatus", btnStatus(appTask.getStatus()));
        }
        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProductService.selectByPrimaryKey(wdApplication.getProductId()).getProductVersion();
        }
        Map<String, Object> productConfig = new HashMap<>();
        List<WdProductSimpleModule> wdProductSimpleModuleList = wdProductSimpleModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, null);
        for (WdProductSimpleModule wdProductSimpleModule : wdProductSimpleModuleList) {
            productConfig.put(wdProductSimpleModule.getDefaultSimpleModuleId(), wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
        }
        model.addAttribute("productConfig", productConfig);

        Map<String, Object> complexProductConfig = new HashMap<>();
        List<WdProductComplexModule> wdProductComplexModuleList = wdProductComplexModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, null);
        for (WdProductComplexModule wdProductComplexModule : wdProductComplexModuleList) {
            complexProductConfig.put(wdProductComplexModule.getDefaultComplexModuleId(), wdProductComplexModule);
        }
        if (!complexProductConfig.isEmpty()) { // 经营类配置
            productConfig.put(BusinessConsts.ModuleID.BusinessInfo, wdBusinessElementService.selectByModule(BusinessConsts.ModuleID.BusinessInfo));
        }
        model.addAttribute("complexProductConfig", complexProductConfig);

        // 客户信息
        WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(wdApplication.getCustomerId());
        model.addAttribute("wdCustomer", wdCustomer);
        // 客户配置
        String customerTypeVersion = wdApplication.getCustomerTypeVersion();
        if (StringUtils.isEmpty(customerTypeVersion)) {
            customerTypeVersion = wdCustomerTypeService.selectByPrimaryKey(wdCustomer.getCustomerTypeId()).getSettingVersion();
        }
        List<WdCustomerTypeSetting> wdCustomerTypeSettingList = wdCustomerTypeSettingService.selectByCustomerTypeIdAndCategory(wdCustomer.getCustomerTypeId(), null, customerTypeVersion);
        model.addAttribute("customerTypeConfigList", wdCustomerTypeSettingList);

        // 其他配置
        // 客户关系
        /*WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getRelatedPersonVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("customerRelationConfigList", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }*/
        // 车
        WdCommonSimpleModule wdCommonSimpleModuleCar = wdCommonSimpleModuleService.selectByModuleName(customer_car, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleCar) {
            String assetsCarVersion = wdApplication.getAssetsCarVersion();
            if (StringUtils.isEmpty(assetsCarVersion)) {
                assetsCarVersion = wdCommonSimpleModuleCar.getSettingVersion();
            }
            model.addAttribute("customerCarConfigList", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleCar.getDefaultSimpleModuleId(), assetsCarVersion));
        }
        // 房
        WdCommonSimpleModule wdCommonSimpleModuleBuilding = wdCommonSimpleModuleService.selectByModuleName(customer_building, currentUser.getCompanyId());
        if (null != wdCommonSimpleModuleBuilding) {
            String assetsBuildingVersion = wdApplication.getAssetsBuildingVersion();
            if (StringUtils.isEmpty(assetsBuildingVersion)) {
                assetsBuildingVersion = wdCommonSimpleModuleBuilding.getSettingVersion();
            }
            model.addAttribute("customerBuildingConfigList", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleBuilding.getDefaultSimpleModuleId(), assetsBuildingVersion));
        }

        if (wdApplication.getStatus() < BusinessConsts.Activity.OfflineReview) { // 是否审批前
            WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdCustomer.getPersonId());
            model.addAttribute("wdPerson", wdPerson); // 人员信息
           /* model.addAttribute("customerRelationList", wdPersonService.selectRelationerByPersonId(wdCustomer.getPersonId())); // 客户关系人
*/            model.addAttribute("customerCarList", wdPersonAssetsCarService.selectByPersonId(wdCustomer.getPersonId())); // 家庭主要资产（车辆）
            model.addAttribute("customerBuildingList", wdPersonAssetsBuildingService.selectByPersonId(wdCustomer.getPersonId())); // 家庭主要资产（房产）
        } else {
            model.addAttribute("wdPerson", wdApplicationPersonService.selectByApplicationId(applicationId));
            /*model.addAttribute("customerRelationList", wdApplicationPersonRelationService.selectByApplicationId(applicationId));*/
            model.addAttribute("customerCarList", wdApplicationAssetsCarService.selectByApplicationId(applicationId));
            model.addAttribute("customerBuildingList", wdApplicationAssetsBuildingService.selectByFamilyAssets(applicationId));
        }

        // 经营信息
        model.addAttribute("wdApplicationBusinesList", wdApplicationBusinessService.selectByApplicationId(applicationId));
        // 征信信息
        model.addAttribute("applicationCreditInvestigationList", wdApplicationCreditInvestigationService.selectByApplicationId(applicationId));
        // 侧面调查
        model.addAttribute("wdApplicationIndirectInvestigationList", wdApplicationIndirectInvestigationService.selectByApplicationId(applicationId));

        // 房产抵押
        model.addAttribute("applicationBuildingMortgageList", wdApplicationBuildingMortgageService.selectByApplicationId(applicationId));
        // 车辆抵押
        model.addAttribute("applicationCarLoanMortgageList", wdApplicationCarLoanMortgageService.selectByApplicationId(applicationId));
        
        model.addAttribute("wdApplicationCreditCardInfo", wdApplicationCreditCardInfoService.selectByApplicationId(applicationId));

       /* // 担保人
        model.addAttribute("wdApplicationRecognizorList", wdApplicationRecognizorService.selectByApplicationId(applicationId));
        // 共同借款人
        model.addAttribute("wdApplicationCoborrowerList", wdApplicationCoborrowerService.selectByApplicationId(applicationId));*/
        // 辅助信息
        model.addAttribute("wdApplicationExtendInfo", wdApplicationExtendInfoService.selectByApplicationId(applicationId));
        // 收入损益表
        model.addAttribute("applicationMonthlyIncomeStatement", wdApplicationMonthlyIncomeStatementService.selectByApplicationId(applicationId));
        model.addAttribute("applicationYearlyIncomeStatement", wdApplicationYearlyIncomeStatementService.selectByApplicationId(applicationId));
        // 家庭资产负债表
        model.addAttribute("applicationBalanceSheet", wdApplicationBalanceSheetService.selectByApplicationId(applicationId));
        // 信贷历史
        model.addAttribute("wdApplicationCreditHistoryList", wdApplicationCreditHistoryService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationCreditHistoryDetailList", wdApplicationCreditHistoryDetailService.selectByApplicationId(applicationId));
        // 软信息不对称偏差分析
        model.addAttribute("applicationInfoDeviationAnalysis", wdApplicationInfoDeviationAnalysisService.selectByApplicationId(applicationId));
        model.addAttribute("softInfoSheet", wdApplicationService.selectSoftInfoSheet(applicationId));
        // 资产负债表
        model.addAttribute("wdApplicationOperatingBalanceSheet", wdApplicationOperatingBalanceSheetService.selectByApplicationId(applicationId));
        // 本期
        model.addAttribute("currentPeriod", wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(applicationId, "1"));
        // 上期
        model.addAttribute("priorPeriod", wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(applicationId, "2"));
        // 资产
        model.addAttribute("assetAdditionals", wdApplicationOperatingBalanceSheetAdditionalService.selectByApplicationId(applicationId, "1"));
        // 负债
        model.addAttribute("debtsAdditionals", wdApplicationOperatingBalanceSheetAdditionalService.selectByApplicationId(applicationId, "2"));
        // 对外担保情况
        model.addAttribute("assureAdditionals", wdApplicationOperatingBalanceSheetAdditionalService.selectByApplicationId(applicationId, "3"));
        // 权益检查
        model.addAttribute("wdApplicationOperatingBalanceSheetCheck", wdApplicationOperatingBalanceSheetCheckService.selectByApplicationId(applicationId, null));
        // 贷款任务
        model.addAttribute("wdApplicationTaskList", wdApplicationTaskService.selectByApplicationId(applicationId));
        // 车贷抵押
        model.addAttribute("wdApplicationCarLoanMortgageList", wdApplicationCarLoanMortgageService.selectByApplicationId(applicationId));
        
        // 毛利率和逻辑检验
        model.addAttribute("wdApplicationProfitList", wdApplicationProfitService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationNetProfitLogic", wdApplicationNetProfitLogicService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationProfitLogicList", wdApplicationProfitLogicService.selectByApplicationId(applicationId));
        
        //损益表
        model.addAttribute("wdApplicationBusinessIncomeStatement", wdApplicationBusinessIncomeStatementService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationOperatingBalanceSheet", wdApplicationOperatingBalanceSheetService.selectByApplicationId(applicationId));

        //家庭损益表
        model.addAttribute("familyProfitLoss",wdApplicationFamilyProfitLossService.selectByApplicationId(applicationId));

        List<WdBusinessElement> allElementList = wdBusinessElementService.selectAll();
        Map<String, Object> wdBusinessElementConfig = new HashMap<>();
        for (WdBusinessElement wdBusinessElement : new ArrayList<>(allElementList)) {
            wdBusinessElementConfig.put(wdBusinessElement.getId(), wdBusinessElement);
            allElementList.remove(wdBusinessElement);
        }
        model.addAttribute("wdBusinessElementConfig", wdBusinessElementConfig);

        // 申请基本信息
        model.addAttribute("applyAuditInfoConfig", wdDefaultSimpleModuleSettingService.selectByModuleId(BusinessConsts.ModuleID.ApplyAuditInfo));

        // 关系人列表
        List<WdPersonRelation> personRelationList = new ArrayList<WdPersonRelation>();
        WdPersonRelation wdPersonRelation = new WdPersonRelation();
        WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdCustomer.getPersonId());
        wdPersonRelation.setWdPerson(wdPerson);
        wdPersonRelation.setRelationType("本人");
        personRelationList.add(wdPersonRelation);
        personRelationList.addAll(wdPersonRelationService.selectByApplictionId(applicationId));

        model.addAttribute("personRelationList", personRelationList);
        return "modules/wd/application/detail/index";
    }
    
    @RequestMapping(value = { "selectRecognizorInfo" })
    public String selectRecognizorInfo(Model model, String applicationId, String personId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getRelatedPersonVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("customerRelationConfigList", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }
        
        WdProductSimpleModule wdProductSimpleModule  = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), wdApplication.getProductVersion(), BusinessConsts.ModuleID.Recognizor);
        model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
        model.addAttribute("extendInfo", wdApplicationRecognizorService.selectByApplicationIdAndOriginalId(applicationId, personId));
        model.addAttribute("wdPerson", wdPersonService.selectByPrimaryKey(personId));
        return "modules/wd/application/detail/personInfo";
    }
    
    @RequestMapping(value = { "selectCoborrowerInfo" })
    public String selectCoborrowerInfo(Model model, String applicationId, String personId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getRelatedPersonVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("customerRelationConfigList", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }
        
        WdProductSimpleModule wdProductSimpleModule  = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), wdApplication.getProductVersion(), BusinessConsts.ModuleID.Coborrower);
        model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
        model.addAttribute("extendInfo", wdApplicationCoborrowerService.selectByApplicationIdAndOriginalId(applicationId, personId));
        model.addAttribute("wdPerson", wdPersonService.selectByPrimaryKey(personId));
        return "modules/wd/application/detail/personInfo";
    }

    /**
     * 逻辑检验 date: 2017年4月20日 下午8:27:41 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "logicExamine" })
    public String logicExamine(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("wdApplication", wdApplicationService.selectByPrimaryKey(applicationId));
        model.addAttribute("wdApplicationProfitList", wdApplicationProfitService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationNetProfitLogic", wdApplicationNetProfitLogicService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationProfitLogicList", wdApplicationProfitLogicService.selectByApplicationId(applicationId));
        return "modules/wd/application/detail/logicExamine";
    }

    /**
     * 损益表 date: 2017年4月20日 下午8:33:01 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "profitLoss" })
    public String profitLoss(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("wdApplication", wdApplicationService.selectByPrimaryKey(applicationId));
        model.addAttribute("wdApplicationBusinessIncomeStatement", wdApplicationBusinessIncomeStatementService.selectByApplicationId(applicationId));
        model.addAttribute("detailsList", wdApplicationBusinessIncomeStatementDetailsService.selectByApplicationId(applicationId));
        return "modules/wd/application/detail/profitLoss";
    }

    /**
     * 预付及应收账款 date: 2017年4月20日 下午8:36:39 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "prepayList" })
    public String prepayList(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("wdApplication", wdApplicationService.selectByPrimaryKey(applicationId));
        model.addAttribute("wdApplicationOutstandingAccount", wdApplicationOutstandingAccountService.selectByApplicationId(applicationId));
        model.addAttribute("receivableList", wdApplicationOutstandingAccountDetailService.selectByApplicationIdAndCategory(applicationId, "1"));
        model.addAttribute("paymentList", wdApplicationOutstandingAccountDetailService.selectByApplicationIdAndCategory(applicationId, "2"));
        return "modules/wd/application/detail/prepayList";
    }

    /**
     * 存货 date: 2017年4月20日 下午8:40:03 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "goodsList" })
    public String goodsList(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("wdApplication", wdApplicationService.selectByPrimaryKey(applicationId));
        model.addAttribute("wdApplicationOutstandingAccount", wdApplicationOutstandingAccountService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationGoodsList", wdApplicationGoodsService.selectByApplicationId(applicationId));
        return "modules/wd/application/detail/goodsList";
    }

    /**
     * 固定资产 date: 2017年4月20日 下午8:40:03 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "fixAssetsList" })
    public String fixAssetsList(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("wdApplication", wdApplicationService.selectByPrimaryKey(applicationId));
        model.addAttribute("wdApplicationOutstandingAccount", wdApplicationOutstandingAccountService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationFixAssetsList", wdApplicationFixAssetsService.selectByApplicationId(applicationId));
        return "modules/wd/application/detail/fixAssetsList";
    }

    /**
     * 还款计划表 date: 2017年4月20日 下午8:40:03 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "refundPlanList" })
    public String refundPlanList(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("wdApplication", wdApplicationService.selectByPrimaryKey(applicationId));
        model.addAttribute("wdApplicationRefundPlanList", wdApplicationRefundPlanService.selectByApplicationId(applicationId));
        return "modules/wd/application/detail/refundPlanList";
    }

    /**
     * 调查图片 date: 2017年4月20日 下午8:47:23 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "surveyPhotoList" })
    public String surveyPhotoList(Model model, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProductService.selectByPrimaryKey(wdApplication.getProductId()).getProductVersion();
        }
        Map<String, Object> productConfig = new HashMap<>();
        List<WdProductSimpleModule> wdProductSimpleModuleList = wdProductSimpleModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, "survey");
        for (WdProductSimpleModule wdProductSimpleModule : wdProductSimpleModuleList) {
            productConfig.put(wdProductSimpleModule.getDefaultSimpleModuleId(), wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
        }
        model.addAttribute("productConfig", productConfig);
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("surveyPhotoList", wdApplicationPhotoService.selectByApplicationId(applicationId));
        return "modules/wd/application/detail/surveyPhotoList";
    }

    @RequestMapping(value = { "handleLoan" })
    public String handleLoan(Model model, String applicationId, String taskId) {
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("taskId", taskId);
        return "modules/wd/application/detail/handleLoan";
    }

    /**
     * 审批通过页面 date: 2017年4月20日 下午8:47:23 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:review")
    @RequestMapping(value = { "reviewView" })
    public String reviewView(Model model, String applicationId, String taskId, String action) {
        WdApplicationTask wdApplicationTask = wdApplicationTaskService.selectByPrimaryKey(taskId);
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        model.addAttribute("wdProductProcess", wdProductProcessService.selectByProductIdAndVersion(wdApplication.getProductId(), wdApplication.getProductVersion()));

        String productVersoin = wdApplication.getProductVersion();
        if (BusinessConsts.Action.Pass.equals(action)) {
            switch (wdApplicationTask.getStatus()) {
                case BusinessConsts.Activity.OfflineReview:
                    WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), productVersoin, BusinessConsts.ModuleID.DataConclusion);
                    if (null != wdProductSimpleModule) {
                        model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
                    }
                    break;
                case BusinessConsts.Activity.RiskControl:
                    wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), productVersoin, BusinessConsts.ModuleID.RiskControlConclusion);
                    if (null != wdProductSimpleModule) {
                        model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
                    }
                    break;
                case BusinessConsts.Activity.ExtendReview:
                    wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), productVersoin, BusinessConsts.ModuleID.OverflowConclusion);
                    if (null != wdProductSimpleModule) {
                        model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
                    }
                    break;
                case BusinessConsts.Activity.TableReview:
                    wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), productVersoin, BusinessConsts.ModuleID.TableConclusion);
                    if (null != wdProductSimpleModule) {
                        model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
                    }
                    break;
                case BusinessConsts.Activity.LoanReview:
                    wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), productVersoin, BusinessConsts.ModuleID.LoanConclusion);
                    if (null != wdProductSimpleModule) {
                        model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
                    }
                    break;
                default:
                    break;
            }
        }

        model.addAttribute("applyAuditInfoConfig", wdDefaultSimpleModuleSettingService.selectByModuleId(BusinessConsts.ModuleID.ApplyAuditInfo)); // 申请基本信息
        model.addAttribute("wdApplication", wdApplication);

        model.addAttribute("wdApplicationTask", wdApplicationTaskService.selectByPrimaryKey(taskId));
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("taskId", taskId);
        model.addAttribute("action", action);
        return "modules/wd/application/detail/reviewView";
    }

    @RequestMapping(value = { "riskNotice" })
    public String riskWarning(Model model, String applicationId, String personId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProductService.selectByPrimaryKey(wdApplication.getProductId()).getProductVersion();
        }
        Map<String, Object> productConfig = new HashMap<>();
        List<WdProductSimpleModule> wdProductSimpleModuleList = wdProductSimpleModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, null);
        for (WdProductSimpleModule wdProductSimpleModule : wdProductSimpleModuleList) {
            productConfig.put(wdProductSimpleModule.getDefaultSimpleModuleId(), wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
        }
        model.addAttribute("productConfig", productConfig);

        Map<String, Object> complexProductConfig = new HashMap<>();
        List<WdProductComplexModule> wdProductComplexModuleList = wdProductComplexModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, null);
        for (WdProductComplexModule wdProductComplexModule : wdProductComplexModuleList) {
            complexProductConfig.put(wdProductComplexModule.getDefaultComplexModuleId(), wdProductComplexModule);
        }
        if (!complexProductConfig.isEmpty()) { // 经营类配置
            productConfig.put(BusinessConsts.ModuleID.BusinessInfo, wdBusinessElementService.selectByModule(BusinessConsts.ModuleID.BusinessInfo));
        }
        model.addAttribute("complexProductConfig", complexProductConfig);

        WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(wdApplication.getCustomerId());

        // 关系人列表
        List<WdPersonRelation> personRelationList = new ArrayList<WdPersonRelation>();

        // 添加本人
        WdPersonRelation wdPersonRelation = new WdPersonRelation();
        WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdCustomer.getPersonId());
        wdPersonRelation.setWdPerson(wdPerson);
        wdPersonRelation.setRelationType("本人");
        personRelationList.add(wdPersonRelation);
        personRelationList.addAll(wdPersonRelationService.selectByApplictionId(applicationId));

        model.addAttribute("personRelationList", personRelationList);

        if (StringUtils.isEmpty(personId) || personId.equals(wdCustomer.getPersonId())) {
            personId = wdCustomer.getPersonId();
            model.addAttribute("wdCustomerBacklist", wdCustomerBacklistService.selectByCustomerId(wdApplication.getCustomerId()));
        }

        model.addAttribute("zhixinList", wdCourtQueryService.selectByPersonIdAndSite(personId, "zhixin", null));
        model.addAttribute("shixinList", wdCourtQueryService.selectByPersonIdAndSite(personId, "shixin", null));
        model.addAttribute("wdRwZmCreditAntifraudVerifyList", wdRwZmCreditAntifraudVerifyService.selectByPerson(personId));
        model.addAttribute("wdRwTxCreditAntifraudVerifyList", wdRwTxCreditAntifraudVerifyService.selectByPersonId(personId, null));
        model.addAttribute("wdRwEmaySinowayCreditList", wdRwEmaySinowayCreditService.selectByPersonId(personId, null));
        
        model.addAttribute("personId", personId);
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/detail/riskNotice";
    }

    /**
     * 提交审批数据 date: 2017年4月25日 下午4:22:18 <br/>
     * @author Liam
     * @param applicationId
     * @param taskId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:review")
    @RequestMapping(value = { "submitReview" })
    @ResponseBody
    public JsonResult submitReview(String applicationId, String taskId, String action, String data, String comment, String addBlank, String extContrantCode, String stopCause) {
        WdApplicationTask wdApplicationTask = wdApplicationTaskService.selectByPrimaryKey(taskId);
        if (null == wdApplicationTask) {
            return new JsonResult(false, "没有编号为【" + taskId + "】的任务");
        }

        WdApplication application = wdApplicationService.selectByPrimaryKey(applicationId);
        if (null == application) {
            return new JsonResult(false, "没有编号为【" + applicationId + "】的申请");
        }

        if (StringUtils.isNotEmpty(data)) {
            data = StringEscapeUtils.unescapeHtml4(data);
        }
        wdApplicationTask.setComment(comment);
        wdApplicationTask.setDetailData(data);
        if (StringUtils.isNotEmpty(extContrantCode)) {
            application.setExtContrantCode(extContrantCode);
            application.setUpdateDate(new Date());
            wdApplicationService.updateByPrimaryKeySelective(application);
        }
        if (StringUtils.isNotEmpty(stopCause)) {
            application.setStopCause(stopCause);
            application.setUpdateDate(new Date());
            wdApplicationService.updateByPrimaryKeySelective(application);
        }
        wdApplicationTaskService.updateByPrimaryKeySelective(wdApplicationTask);

        if (wdApplicationTask.getStatus() == BusinessConsts.Activity.Survey) { // 调查时候更新结论
            application.setAuditConclusion(data);
            
        }

        if (wdApplicationTask.getStatus() == BusinessConsts.Activity.RiskControl || wdApplicationTask.getStatus() == BusinessConsts.Activity.ExtendReview) { // 风控或超额的时候更新结论
            if (!data.equals("{}")) { // 调查，风控、超额
                application.setFinalConclusion(data);
                wdApplicationService.updateByPrimaryKeySelective(application);
            }
        }

        // 处理流程流转
        if (StringUtils.isBlank(application.getName())) {
            try {
                processHandle.dealTask(wdApplicationTask.getId(), action, null, comment, data, UserUtils.getUser().getId(), StringUtils.isNotEmpty(addBlank));
            } catch (GeneralException e) {
                LOGGER.error("提交审批数据失败", e);
                return new JsonResult(e.getMessage());
            }
        } else {
            try {
            	if (Action.Cancel.equals(action)) { //当取消申请时
            		processEngine.cancelInstance(application.getName(), UserUtils.getUser().getId());
    				
    				application.setUpdateDate(new Date());
    				application.setStopCause(stopCause);
    				application.setStatus(BusinessConsts.Activity.ApplyCanceled);
    				wdApplicationService.updateByPrimaryKeySelective(application);

    				WdApplicationTask ctask = new WdApplicationTask();
    				ctask.setId(UidUtil.uuid());
    				ctask.setApplicationId(applicationId);
    				ctask.setOwnerId(UserUtils.getUser().getId());
    				ctask.setOwnerName(UserUtils.getUser().getName());
    				ctask.setClose(BusinessConsts.TrueOrFalseAsString.True);
    				ctask.setCloseDate(new Date());
    				ctask.setComment(comment);
    				ctask.setDone(BusinessConsts.TrueOrFalseAsString.True);
    				ctask.setDonerId(UserUtils.getUser().getId());
    				ctask.setDonerName(UserUtils.getUser().getName());
    				ctask.setDoneDate(new Date());
    				ctask.setAction(BusinessConsts.Action.Cancel);
    				ctask.setActionName(BusinessConsts.ACTIONS.get(BusinessConsts.Action.Cancel));
    				ctask.setCreateBy(UserUtils.getUser().getId());
    				ctask.setCreateDate(new Date());
    				ctask.setUpdateBy(UserUtils.getUser().getId());
    				ctask.setUpdateDate(new Date());
    				ctask.setStatus(BusinessConsts.Activity.ApplyCanceled);
    				ctask.setStatusName(BusinessConsts.ACTIVITIES.get(8192).toString());
    				wdApplicationTaskService.insertSelective(ctask);

    				// 添加客户动态
    				WdCustomerTrack wdCustomerTrack = new WdCustomerTrack();
    				wdCustomerTrack.setId(UidUtil.uuid());
    				wdCustomerTrack.setCustomerId(application.getCustomerId());
    				wdCustomerTrack.setTitle("撤销申请");
    				wdCustomerTrack.setContent(application.getProductName());
    				wdCustomerTrack.setCategory("申贷记录");
    				wdCustomerTrack.setCreateBy(UserUtils.getUser().getId());
    				wdCustomerTrack.setCreateDate(new Date());
    				wdCustomerTrack.setUpdateBy(UserUtils.getUser().getId());
    				wdCustomerTrack.setUpdateDate(new Date());
    				wdCustomerTrack.setRelationId(application.getId());

    				wdCustomerTrackService.insertSelective(wdCustomerTrack);
            	} else {
            		processEngine.dealTask(wdApplicationTask.getId(), action, UserUtils.getUser().getId());
            	}
            } catch (GeneralException e) {
                return new JsonResult(false, e.getMessage());
            }
            processHandle.delWithOldProcessAndNewProcess(application);
        }
            
        if (StringUtils.isNotEmpty(addBlank)) { // 添加黑名单
        	WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(application.getCustomerId());
        	wdCustomer.setBlack("1");
        	wdCustomerService.updateByPrimaryKeySelective(wdCustomer);
        	
        	WdCustomerBacklist wdCustomerBacklist = new WdCustomerBacklist();
        	wdCustomerBacklist.setId(UidUtil.uuid());
        	wdCustomerBacklist.setCustomerId(application.getCustomerId());
        	wdCustomerBacklist.setCustomerName(application.getCustomerName());
        	wdCustomerBacklist.setRemarks(comment);
        	wdCustomerBacklist.setCustomerTypeId(application.getCustomerId());
        	wdCustomerBacklist.setCustomerTypeName(application.getCustomerName());
        	wdCustomerBacklist.setCreateBy(UserUtils.getUser().getId());
        	wdCustomerBacklist.setCreateDate(new Date());
        	wdCustomerBacklist.setUpdateBy(UserUtils.getUser().getId());
        	wdCustomerBacklist.setUpdateDate(new Date());
        	wdCustomerBacklistService.insertSelective(wdCustomerBacklist);
        }

        // 放款后完成归档【异步操作】
        if (wdApplicationTask.getStatus() == BusinessConsts.Activity.LoanReview && BusinessConsts.Action.Pass.equals(action)) {
            WdCustomerTrack wdCustomerTrack = new WdCustomerTrack();
            wdCustomerTrack.setId(UidUtil.uuid());
            wdCustomerTrack.setCustomerId(application.getCustomerId());
            wdCustomerTrack.setTitle("贷款审批成功");
            wdCustomerTrack.setContent(application.getProductName());
            wdCustomerTrack.setCategory("申贷记录");
            wdCustomerTrack.setCreateBy(UserUtils.getUser().getId());
            wdCustomerTrack.setCreateDate(new Date());
            wdCustomerTrack.setUpdateBy(UserUtils.getUser().getId());
            wdCustomerTrack.setUpdateDate(new Date());
            wdCustomerTrack.setRelationId(application.getId());
            wdCustomerTrackService.insertSelective(wdCustomerTrack);

            applicationArchiveFile(applicationId);
            
            InitCardInfo initCardInfo = new InitCardInfo4Manual();
            initCardInfo.init(applicationId);
        }
        return new JsonResult();
    }

    /**
     * 归档文件 date: 2017年9月27日 下午3:17:04 <br/>
     * @author Liam
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "applicationArchiveFile" })
    @ResponseBody
    public boolean applicationArchiveFile(String applicationId) {
        Thread t = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    String zipFile = wdApplicationService.applicationArchiveFile(applicationId);
                    WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
                    wdApplication.setArchiveFile(zipFile);
                    wdApplication.setLoanedDate(new Date());
                    wdApplicationService.updateByPrimaryKeySelective(wdApplication);
                } catch (IOException e) {
                    LOGGER.error("贷款信息归档失败", e);
                }
            }
        });
        t.start();
        return true;
    }

    @RequestMapping(value = { "crossManage" })
    public String crossManage(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProductService.selectByPrimaryKey(wdApplication.getProductId()).getProductVersion();
        }
        Map<String, Object> productConfig = new HashMap<>();
        List<WdProductSimpleModule> wdProductSimpleModuleList = wdProductSimpleModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, null);
        for (WdProductSimpleModule wdProductSimpleModule : wdProductSimpleModuleList) {
            productConfig.put(wdProductSimpleModule.getDefaultSimpleModuleId(), wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
        }
        model.addAttribute("productConfig", productConfig);

        Map<String, Object> complexProductConfig = new HashMap<>();
        List<WdProductComplexModule> wdProductComplexModuleList = wdProductComplexModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, null);
        for (WdProductComplexModule wdProductComplexModule : wdProductComplexModuleList) {
            complexProductConfig.put(wdProductComplexModule.getDefaultComplexModuleId(), wdProductComplexModule);
        }
        if (!complexProductConfig.isEmpty()) { // 经营类配置
            productConfig.put(BusinessConsts.ModuleID.BusinessInfo, wdBusinessElementService.selectByModule(BusinessConsts.ModuleID.BusinessInfo));
        }
        model.addAttribute("complexProductConfig", complexProductConfig);

        List<WdCustomerTrack> showTrackList = new ArrayList<>();

        Date beginDate = wdApplication.getCreateDate();
        WdCustomerTrack wdCustomerTrack = new WdCustomerTrack();
        wdCustomerTrack.setTitle("提交申请");
        wdCustomerTrack.setCreateDate(beginDate);
        showTrackList.add(wdCustomerTrack);
        List<WdCustomerTrack> wdCustomerTrackList = wdCustomerTrackService.selectCrossManageByApplicationId(applicationId);
        List<WdApplicationPhoto> wdApplicationPhotoList = wdApplicationPhotoService.selectByApplicationId(applicationId);

        for (WdCustomerTrack wdCustomerTrack2 : wdCustomerTrackList) {
            if (wdCustomerTrack2.getCategory().equals("客户现场")) {
                WdApplicationSurveySite wdApplicationSurveySite = wdApplicationSurveySiteService.selectByPrimaryKey(wdCustomerTrack2.getPositionName());
                WdCustomerTrack wdCustomerTrack_1 = new WdCustomerTrack();
                wdCustomerTrack_1.setTitle("现场签到");
                wdCustomerTrack_1.setTag("1");
                wdCustomerTrack_1.setCreateDate(wdApplicationSurveySite.getStartDate());
                wdCustomerTrack_1.setPositionName(wdApplicationSurveySite.getStartAddress());
                wdCustomerTrack_1.setPositionLatitude(wdApplicationSurveySite.getStartLatitude());
                wdCustomerTrack_1.setPositionLongitude(wdApplicationSurveySite.getStartLongitude());
                if (null != wdApplicationSurveySite.getRecord()) {
                    wdCustomerTrack_1.setRecording((String) wdApplicationSurveySite.getRecord()); // 录音
                }
                wdCustomerTrack_1.setPhoto(getPhotoByDate(beginDate, wdApplicationSurveySite.getStartDate(), wdApplicationPhotoList));
                showTrackList.add(wdCustomerTrack_1);
                beginDate = wdApplicationSurveySite.getStartDate();

                WdCustomerTrack wdCustomerTrack_2 = new WdCustomerTrack();
                wdCustomerTrack_2.setTitle("现场签退");
                wdCustomerTrack_2.setCreateDate(wdApplicationSurveySite.getEndDate());
                wdCustomerTrack_2.setPositionName(wdApplicationSurveySite.getEndAddress());
                wdCustomerTrack_2.setPositionLatitude(wdApplicationSurveySite.getEndLatitude());
                wdCustomerTrack_2.setPositionLongitude(wdApplicationSurveySite.getEndLongitude());
                wdCustomerTrack_2.setContent(wdApplicationSurveySite.getRemarks());
                wdCustomerTrack_2.setPhoto(getPhotoByDate(beginDate, wdApplicationSurveySite.getEndDate(), wdApplicationPhotoList));
                showTrackList.add(wdCustomerTrack_2);
                beginDate = wdApplicationSurveySite.getEndDate();
            } else {
                wdCustomerTrack2.setPhoto(getPhotoByDate(beginDate, wdCustomerTrack2.getCreateDate(), wdApplicationPhotoList));
                wdCustomerTrack2.setTag("1");
                beginDate = wdCustomerTrack2.getCreateDate();
                showTrackList.add(wdCustomerTrack2);
            }

        }

        WdCustomerTrack wdCustomerTrack1 = new WdCustomerTrack();
        wdCustomerTrack1.setPhoto(getPhotoByDate(beginDate, null, wdApplicationPhotoList));
        wdCustomerTrack1.setTag("1");
        showTrackList.add(wdCustomerTrack1);
        model.addAttribute("wdApplication", wdApplication);
        model.addAttribute("wdCustomerTrackList", showTrackList);
        return "modules/wd/application/detail/crossManage";
    }

    @RequestMapping(value = { "crossManageMapModel" })
    public String crossManageMapModel(Model model, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(wdApplication.getCustomerId());
        model.addAttribute("cityName", sysUserService.getCityByUserId(wdApplication.getOwnerId()));
        model.addAttribute("wdPerson", wdPersonService.selectByPrimaryKey(wdCustomer.getPersonId()));
        model.addAttribute("wdApplicationPhotoList", wdApplicationPhotoService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationSurveySiteList", wdApplicationSurveySiteService.selectByApplicationId(applicationId));
        return "modules/wd/application/detail/crossManageMapModel";
    }

    @RequestMapping(value = { "voiceDualNote" })
    public String voiceDualNote(Model model, String applicationId) {
        model.addAttribute("dualNoteList", wdApplicationDualNoteService.selectByApplicationId(applicationId));
        return "modules/wd/application/detail/voiceDualNote";
    }

    private List<WdApplicationPhoto> getPhotoByDate(Date beginDate, Date endDate, List<WdApplicationPhoto> wdApplicationPhotoList) {
        List<WdApplicationPhoto> photoList = new ArrayList<>();
        for (WdApplicationPhoto wdApplicationPhoto : wdApplicationPhotoList) {
            Date photoTime = wdApplicationPhoto.getPhotoTime() != null ? wdApplicationPhoto.getPhotoTime() : wdApplicationPhoto.getCreateDate();
            if ((photoTime.after(beginDate) && (null == endDate || photoTime.before(endDate))) || beginDate.equals(photoTime)) {
                photoList.add(wdApplicationPhoto);
            }
        }
        return photoList;
    }

    /**
     * 打印所有照片信息 date: 2017年9月4日 上午10:18:25 <br/>
     * @author Liam
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "print_all_photo" })
    public String printAllPicForApplication(String applicationId, Model model) {
        List<String> fileList = new ArrayList<>();
        List<List<String>> idcardMapList = new ArrayList<>();

        // 个人信息
        WdApplicationPerson wdApplicationPerson = wdApplicationPersonService.selectByApplicationId(applicationId);
        /* if (null != wdApplicationPerson.getJsonData().get("base_info_shop_photo")) {
            @SuppressWarnings("unchecked")
            List<String> shopPhotoList = (List<String>) wdApplicationPerson.getJsonData().get("base_info_shop_photo");
            fileList.addAll(shopPhotoList);
        }*/
        if (null != wdApplicationPerson.getJsonData().get("base_info_idcard_photo")) {
            @SuppressWarnings("unchecked")
            List<String> idcardPhotoList = (List<String>) wdApplicationPerson.getJsonData().get("base_info_idcard_photo");
            idcardMapList.add(idcardPhotoList);
        }

        /* // 关系人
        List<WdApplicationPersonRelation> personRelationList = wdApplicationPersonRelationService.selectByApplicationId(applicationId);
        for (WdApplicationPersonRelation wdApplicationPersonRelation : personRelationList) {
            if (null != wdApplicationPersonRelation.getJsonData().get("base_info_shop_photo")) {
                @SuppressWarnings("unchecked")
                List<String> shopPhotoList = (List<String>) wdApplicationPersonRelation.getJsonData().get("base_info_shop_photo");
                fileList.addAll(shopPhotoList);
            }
            if (null != wdApplicationPersonRelation.getJsonData().get("base_info_idcard_photo")) {
                @SuppressWarnings("unchecked")
                List<String> idcardPhotoList = (List<String>) wdApplicationPersonRelation.getJsonData().get("base_info_idcard_photo");
                idcardMapList.add(idcardPhotoList);
            }
        }
        
        // 房产
        List<WdApplicationAssetsBuilding> buildingList = wdApplicationAssetsBuildingService.selectByApplicationIdAndPersonId(applicationId, wdApplicationPerson.getOriginalId());
        for (WdApplicationAssetsBuilding wdApplicationAssetsBuilding : buildingList) {
            if (null != wdApplicationAssetsBuilding.getJsonData().get("assets_building_proof_photo")){
                @SuppressWarnings("unchecked")
                List<String> buildingPhotoList = (List<String>) wdApplicationAssetsBuilding.getJsonData().get("assets_building_proof_photo");
                fileList.addAll(buildingPhotoList);
            }
        }
        
        // 车辆
        List<WdApplicationAssetsCar> carList = wdApplicationAssetsCarService.selectByApplicationId(applicationId);
        for (WdApplicationAssetsCar wdApplicationAssetsCar : carList) {
            if (null != wdApplicationAssetsCar.getJsonData().get("assets_car_proof_photo")){
                @SuppressWarnings("unchecked")
                List<String> carPhotoList = (List<String>) wdApplicationAssetsCar.getJsonData().get("assets_car_proof_photo");
                fileList.addAll(carPhotoList);
            }
        }
        
        // 房产抵押
        List<WdApplicationBuildingMortgage> buildingMortgageList = wdApplicationBuildingMortgageService.selectByApplicationId(applicationId);
        for (WdApplicationBuildingMortgage wdApplicationBuildingMortgage : buildingMortgageList) {
            WdApplicationAssetsBuilding wdApplicationAssetsBuilding = wdApplicationAssetsBuildingService.selectByApplicationIdAndOriginalId(applicationId, wdApplicationBuildingMortgage.getOriginalId());
            if (null != wdApplicationAssetsBuilding.getJsonData().get("assets_building_proof_photo")){
                @SuppressWarnings("unchecked")
                List<String> buildingPhotoList = (List<String>) wdApplicationAssetsBuilding.getJsonData().get("assets_building_proof_photo");
                fileList.addAll(buildingPhotoList);
            }
        }*/

        // 调查照片
        List<WdApplicationPhoto> photoList = wdApplicationPhotoService.selectByApplicationId(applicationId);
        fileList.addAll(EntityUtils.convertEntityToString(photoList, "photoUrl"));

        model.addAttribute("application", wdApplicationService.selectByPrimaryKey(applicationId));
        model.addAttribute("fileList", fileList);
        model.addAttribute("idcardMapList", idcardMapList);
        return "modules/wd/application/print/all_photo";
    }

    /**
     * 下载调查照片 date: 2017年9月4日 上午10:22:52 <br/>
     * @author Liam
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "downloadPhotoFile" })
    public void downloadAllArchiveFile(HttpServletResponse response, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        try (ZipOutputStream out = new ZipOutputStream(response.getOutputStream());) {
            response.setContentType("application/x-download");// 设置response内容的类
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(wdApplication.getCustomerName() + "_" + wdApplication.getCode() + ".zip", "UTF-8"));// 设置头部信息

            String path = wdApplicationService.applicationFile(applicationId);
            ZipUtil.doCompress(new File(path + "/照片"), out);
            response.flushBuffer();
            FileUtil.delDir(path);
        } catch (IOException e) {
            LOGGER.error("照片下载失败", e);
        }
    }

}