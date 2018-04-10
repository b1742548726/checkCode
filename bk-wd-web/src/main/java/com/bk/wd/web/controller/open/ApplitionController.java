package com.bk.wd.web.controller.open;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bk.sys.model.SysUser;
import com.bk.sys.service.SysUserService;
import com.bk.wd.model.WdApplication;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdCommonSimpleModule;
import com.bk.wd.model.WdCustomer;
import com.bk.wd.model.WdCustomerTypeSetting;
import com.bk.wd.model.WdPerson;
import com.bk.wd.model.WdPersonRelation;
import com.bk.wd.model.WdProductComplexModule;
import com.bk.wd.model.WdProductSimpleModule;
import com.bk.wd.service.WdApplicationAssetsBuildingService;
import com.bk.wd.service.WdApplicationAssetsCarService;
import com.bk.wd.service.WdApplicationBalanceSheetService;
import com.bk.wd.service.WdApplicationBuildingMortgageService;
import com.bk.wd.service.WdApplicationBusinessIncomeStatementDetailsService;
import com.bk.wd.service.WdApplicationBusinessIncomeStatementService;
import com.bk.wd.service.WdApplicationBusinessService;
import com.bk.wd.service.WdApplicationCarLoanMortgageService;
import com.bk.wd.service.WdApplicationCoborrowerService;
import com.bk.wd.service.WdApplicationCreditCardInfoService;
import com.bk.wd.service.WdApplicationCreditHistoryDetailService;
import com.bk.wd.service.WdApplicationCreditHistoryService;
import com.bk.wd.service.WdApplicationCreditInvestigationService;
import com.bk.wd.service.WdApplicationDualNoteService;
import com.bk.wd.service.WdApplicationExtendInfoService;
import com.bk.wd.service.WdApplicationFixAssetsService;
import com.bk.wd.service.WdApplicationGoodsService;
import com.bk.wd.service.WdApplicationIndirectInvestigationService;
import com.bk.wd.service.WdApplicationIndustryDemandFundUseSheetService;
import com.bk.wd.service.WdApplicationInfoDeviationAnalysisService;
import com.bk.wd.service.WdApplicationMonthlyIncomeStatementService;
import com.bk.wd.service.WdApplicationNetProfitLogicService;
import com.bk.wd.service.WdApplicationOperatingBalanceSheetAdditionalService;
import com.bk.wd.service.WdApplicationOperatingBalanceSheetCheckService;
import com.bk.wd.service.WdApplicationOperatingBalanceSheetDetailService;
import com.bk.wd.service.WdApplicationOperatingBalanceSheetService;
import com.bk.wd.service.WdApplicationOutstandingAccountDetailService;
import com.bk.wd.service.WdApplicationOutstandingAccountService;
import com.bk.wd.service.WdApplicationPersonRelationService;
import com.bk.wd.service.WdApplicationPersonService;
import com.bk.wd.service.WdApplicationPhotoService;
import com.bk.wd.service.WdApplicationProfitLogicService;
import com.bk.wd.service.WdApplicationProfitService;
import com.bk.wd.service.WdApplicationRecognizorService;
import com.bk.wd.service.WdApplicationRefundPlanService;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.service.WdApplicationSurveySiteService;
import com.bk.wd.service.WdApplicationTaskService;
import com.bk.wd.service.WdApplicationYearlyIncomeStatementService;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdCommonSimpleModuleService;
import com.bk.wd.service.WdCommonSimpleModuleSettingService;
import com.bk.wd.service.WdCourtQueryService;
import com.bk.wd.service.WdCustomerBacklistService;
import com.bk.wd.service.WdCustomerService;
import com.bk.wd.service.WdCustomerTrackService;
import com.bk.wd.service.WdCustomerTypeService;
import com.bk.wd.service.WdCustomerTypeSettingService;
import com.bk.wd.service.WdDefaultSimpleModuleSettingService;
import com.bk.wd.service.WdPersonAssetsBuildingService;
import com.bk.wd.service.WdPersonAssetsCarService;
import com.bk.wd.service.WdPersonRelationService;
import com.bk.wd.service.WdPersonService;
import com.bk.wd.service.WdProductComplexModuleService;
import com.bk.wd.service.WdProductProcessService;
import com.bk.wd.service.WdProductService;
import com.bk.wd.service.WdProductSimpleModuleService;
import com.bk.wd.service.WdProductSimpleModuleSettingService;
import com.bk.wd.service.WdRwEmaySinowayCreditService;
import com.bk.wd.service.WdRwTxCreditAntifraudVerifyService;
import com.bk.wd.service.WdRwZmCreditAntifraudVerifyService;
import com.bk.wd.util.BusinessConsts;
import com.bk.wd.util.ProcessHandle;
import com.bk.wd.util.process.EngineHandler;

@Controller
@RequestMapping(value = "/open/application/")
public class ApplitionController {
    
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
    private WdApplicationIndustryDemandFundUseSheetService wdApplicationIndustryDemandFundUseSheetService;
    
    @RequestMapping(value = { "index" })
    public String detail(Model model, String applicationId, String token) {
        
        model.addAttribute("applicationId", applicationId);
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        
        SysUser currentUser = sysUserService.selectByPrimaryKey(wdApplication.getOwnerId());
        // 申请信息
        model.addAttribute("wdApplication", wdApplication);
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
        WdCommonSimpleModule wdCommonSimpleModuleCar = wdCommonSimpleModuleService.selectByModuleName(customer_car, currentUser.getCompanyId());
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

        model.addAttribute("wdPerson", wdApplicationPersonService.selectByApplicationId(applicationId));
        /*model.addAttribute("customerRelationList", wdApplicationPersonRelationService.selectByApplicationId(applicationId));*/
        model.addAttribute("customerCarList", wdApplicationAssetsCarService.selectByApplicationId(applicationId));
        model.addAttribute("customerBuildingList", wdApplicationAssetsBuildingService.selectByFamilyAssets(applicationId));

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
        
        // 调查图片
        model.addAttribute("surveyPhotoList", wdApplicationPhotoService.selectByApplicationId(applicationId));
        
        model.addAttribute("wdApplicationBusinessIncomeStatement", wdApplicationBusinessIncomeStatementService.selectByApplicationId(applicationId));
        model.addAttribute("detailsList", wdApplicationBusinessIncomeStatementDetailsService.selectByApplicationId(applicationId));
        
        model.addAttribute("wdApplicationOutstandingAccount", wdApplicationOutstandingAccountService.selectByApplicationId(applicationId));
        model.addAttribute("receivableList", wdApplicationOutstandingAccountDetailService.selectByApplicationIdAndCategory(applicationId, "1"));
        model.addAttribute("paymentList", wdApplicationOutstandingAccountDetailService.selectByApplicationIdAndCategory(applicationId, "2"));
        model.addAttribute("wdApplicationGoodsList", wdApplicationGoodsService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationFixAssetsList", wdApplicationFixAssetsService.selectByApplicationId(applicationId));
        model.addAttribute("wdApplicationRefundPlanList", wdApplicationRefundPlanService.selectByApplicationId(applicationId));
        
        model.addAttribute("industryDemandFundUseSheetInfo", wdApplicationIndustryDemandFundUseSheetService.selectByApplicationId(applicationId));

        return "modules/wd/application/openApi/index";
    }
    
    @RequestMapping(value = { "openIframe" })
    public String getApplicationInfo() {
        return "modules/wd/application/openApi/iframe";
    }
    
}
