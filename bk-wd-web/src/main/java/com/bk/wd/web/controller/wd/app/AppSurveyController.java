package com.bk.wd.web.controller.wd.app;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.bk.wd.pl.service.WdApplicationFamilyProfitLossService;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.bk.common.entity.GeneralException;
import com.bk.common.entity.JsonResult;
import com.bk.common.service.DfsService;
import com.bk.common.utils.DateUtils;
import com.bk.common.utils.IDCard;
import com.bk.common.utils.UidUtil;
import com.bk.sm.model.SmModel;
import com.bk.sm.service.SmModelService;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysUserService;
import com.bk.wd.model.WdApplication;
import com.bk.wd.model.WdApplicationBalanceSheet;
import com.bk.wd.model.WdApplicationBuildingMortgage;
import com.bk.wd.model.WdApplicationBusiness;
import com.bk.wd.model.WdApplicationBusinessIncomeStatement;
import com.bk.wd.model.WdApplicationBusinessIncomeStatementDetails;
import com.bk.wd.model.WdApplicationCoborrower;
import com.bk.wd.model.WdApplicationCreditHistory;
import com.bk.wd.model.WdApplicationCreditHistoryDetail;
import com.bk.wd.model.WdApplicationCreditInvestigation;
import com.bk.wd.model.WdApplicationExtendInfo;
import com.bk.wd.model.WdApplicationFixAssets;
import com.bk.wd.model.WdApplicationGoods;
import com.bk.wd.model.WdApplicationIndirectInvestigation;
import com.bk.wd.model.WdApplicationIndustryDemandFundUseSheet;
import com.bk.wd.model.WdApplicationInfoDeviationAnalysis;
import com.bk.wd.model.WdApplicationMonthlyIncomeStatement;
import com.bk.wd.model.WdApplicationNetProfitLogic;
import com.bk.wd.model.WdApplicationOperatingBalanceSheet;
import com.bk.wd.model.WdApplicationOperatingBalanceSheetAdditional;
import com.bk.wd.model.WdApplicationOperatingBalanceSheetCheck;
import com.bk.wd.model.WdApplicationOperatingBalanceSheetDetail;
import com.bk.wd.model.WdApplicationOutstandingAccount;
import com.bk.wd.model.WdApplicationOutstandingAccountDetail;
import com.bk.wd.model.WdApplicationProfit;
import com.bk.wd.model.WdApplicationProfitLogic;
import com.bk.wd.model.WdApplicationRecognizor;
import com.bk.wd.model.WdApplicationRefundPlan;
import com.bk.wd.model.WdApplicationScore;
import com.bk.wd.model.WdApplicationTask;
import com.bk.wd.model.WdApplicationYearlyIncomeStatement;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdCommonSimpleModule;
import com.bk.wd.model.WdCustomer;
import com.bk.wd.model.WdCustomerRelation;
import com.bk.wd.model.WdCustomerTrack;
import com.bk.wd.model.WdCustomerType;
import com.bk.wd.model.WdCustomerTypeSetting;
import com.bk.wd.model.WdPerson;
import com.bk.wd.model.WdPersonAssetsBuilding;
import com.bk.wd.model.WdPersonAssetsBuildingRelation;
import com.bk.wd.model.WdPersonAssetsCar;
import com.bk.wd.model.WdPersonRelation;
import com.bk.wd.model.WdProduct;
import com.bk.wd.model.WdProductComplexModule;
import com.bk.wd.model.WdProductSimpleModule;
import com.bk.wd.model.WdProductSmModel;
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
import com.bk.wd.service.WdApplicationPhotoService;
import com.bk.wd.service.WdApplicationProfitLogicService;
import com.bk.wd.service.WdApplicationProfitService;
import com.bk.wd.service.WdApplicationRecognizorService;
import com.bk.wd.service.WdApplicationRefundPlanService;
import com.bk.wd.service.WdApplicationScoreService;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.service.WdApplicationTaskService;
import com.bk.wd.service.WdApplicationYearlyIncomeStatementService;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdCommonSimpleModuleService;
import com.bk.wd.service.WdCommonSimpleModuleSettingService;
import com.bk.wd.service.WdCourtQueryService;
import com.bk.wd.service.WdCustomerRelationService;
import com.bk.wd.service.WdCustomerService;
import com.bk.wd.service.WdCustomerTrackService;
import com.bk.wd.service.WdCustomerTypeService;
import com.bk.wd.service.WdCustomerTypeSettingService;
import com.bk.wd.service.WdDefaultSimpleModuleSettingService;
import com.bk.wd.service.WdPersonAssetsBuildingRelationService;
import com.bk.wd.service.WdPersonAssetsBuildingService;
import com.bk.wd.service.WdPersonAssetsCarService;
import com.bk.wd.service.WdPersonRelationService;
import com.bk.wd.service.WdPersonService;
import com.bk.wd.service.WdProductComplexModuleService;
import com.bk.wd.service.WdProductService;
import com.bk.wd.service.WdProductSimpleModuleService;
import com.bk.wd.service.WdProductSimpleModuleSettingService;
import com.bk.wd.service.WdProductSmModelService;
import com.bk.wd.util.BusinessConsts;
import com.bk.wd.util.BusinessConsts.CustomerInfoRights;
import com.bk.wd.util.BusinessConsts.ModuleID;
import com.bk.wd.util.process.EngineHandler;
import com.bk.wd.util.BusinessElementUtils;
import com.bk.wd.util.DataAssembly;
import com.bk.wd.util.ProcessHandle;
import com.bk.wd.vo.PersonRelationerVo;
import com.bk.wd.vo.SoftInfoSheetVo;
import com.bk.wd.web.base.BaseController;
import com.bk.wd.web.constant.SheetConstant;
import com.bk.wd.web.utils.ExcelUtils;

@Controller
@RequestMapping(value = "/wd/application/survey")
public class AppSurveyController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppSurveyController.class);

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
    private WdCustomerRelationService wdCustomerRelationService;

    @Autowired
    private WdPersonService wdPersonService;

    @Autowired
    private WdApplicationCreditInvestigationService wdApplicationCreditInvestigationService;

    @Autowired
    private WdPersonAssetsCarService wdPersonAssetsCarService;

    @Autowired
    private WdPersonAssetsBuildingService wdPersonAssetsBuildingService;

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
    private WdBusinessElementService wdBusinessElementService;

    @Autowired
    private WdProductService wdProductService;

    @Autowired
    private WdProductSimpleModuleService wdProductSimpleModuleService;

    @Autowired
    private WdProductComplexModuleService wdProductComplexModuleService;

    @Autowired
    private WdProductSimpleModuleSettingService wdProductSimpleModuleSettingService;

    @Autowired
    private DfsService dfsService;

    @Autowired
    private WdCustomerTrackService wdCustomerTrackService;

    @Autowired
    private WdCustomerTypeService wdCustomerTypeService;

    @Autowired
    private WdCustomerTypeSettingService wdCustomerTypeSettingService;

    @Autowired
    private WdCommonSimpleModuleService wdCommonSimpleModuleService;

    @Autowired
    private WdCommonSimpleModuleSettingService wdCommonSimpleModuleSettingService;

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
    private ProcessHandle processHandle;

    @Autowired
    private EngineHandler processEngine;

    @Autowired
    private WdApplicationBusinessService wdApplicationBusinessService;

    @Autowired
    private WdDefaultSimpleModuleSettingService wdDefaultSimpleModuleSettingService;

    @Autowired
    private WdApplicationCoborrowerService wdApplicationCoborrowerService;

    @Autowired
    private WdPersonRelationService wdPersonRelationService;

    @Autowired
    private WdPersonAssetsBuildingRelationService wdPersonAssetsBuildingRelationService;

    @Autowired
    private WdCourtQueryService wdCourtQueryService;

    @Autowired
    private WdApplicationCarLoanMortgageService wdApplicationCarLoanMortgageService;

    @Autowired
    private DataAssembly dataAssembly;
    
    @Autowired
    private WdApplicationScoreService wdApplicationScoreService;
    
    @Autowired
    private WdProductSmModelService wdProductSmModelService;
    
    @Autowired
    private SmModelService smModelService;
    
    @Autowired
    private WdApplicationIndustryDemandFundUseSheetService wdApplicationIndustryDemandFundUseSheetService;
    
    @Autowired
    private WdApplicationCreditCardInfoService wdApplicationCreditCardInfoService;
    
    @Autowired
    private WdApplicationNetProfitLogicService wdApplicationNetProfitLogicService;
    
    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private WdApplicationFamilyProfitLossService wdApplicationFamilyProfitLossService;

    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "" })
    public String index(Model model, HttpServletRequest request, String applicationId) {
        String referer = request.getHeader("Referer");
        request.getSession().setAttribute("survey_back_url", referer);
        model.addAttribute("applicationId", applicationId);
        return "redirect:/wd/application/survey/applicantInfo";
    }
    
    @RequestMapping(value = { "saveApplicationInfo" })
    @ResponseBody
    public JsonResult saveApplicationInfo(String applicationId, String industryDemandFundUseSheetInfo, String indirectInvestigationList) {
        wdApplicationIndirectInvestigationService.delByApplicationId(applicationId);
        wdApplicationIndustryDemandFundUseSheetService.delByApplicationId(applicationId);
        
        if (StringUtils.isNotEmpty(indirectInvestigationList)) {
            WdApplicationIndirectInvestigation[] smModelElementConfigArray = JSON.parseObject(StringEscapeUtils.unescapeHtml4(indirectInvestigationList), WdApplicationIndirectInvestigation[].class);
            
            for (int i = 0; i < smModelElementConfigArray.length; i++) {
                WdApplicationIndirectInvestigation wdApplicationIndirectInvestigation = smModelElementConfigArray[i];
                wdApplicationIndirectInvestigation.setId(UidUtil.uuid());
                wdApplicationIndirectInvestigation.setExcOrder(i);
                wdApplicationIndirectInvestigation.setApplicationId(applicationId);
                wdApplicationIndirectInvestigation.setCreateBy(UserUtils.getUser().getId());
                wdApplicationIndirectInvestigation.setCreateDate(new Date());
                wdApplicationIndirectInvestigation.setUpdateBy(UserUtils.getUser().getId());
                wdApplicationIndirectInvestigation.setUpdateDate(new Date());
                wdApplicationIndirectInvestigation.setDelFlag(false);
                wdApplicationIndirectInvestigationService.insertSelective(wdApplicationIndirectInvestigation);
            }
        }
        
        if (StringUtils.isNotEmpty(industryDemandFundUseSheetInfo)) {
            WdApplicationIndustryDemandFundUseSheet wdApplicationIndustryDemandFundUseSheet = JSON.parseObject(StringEscapeUtils.unescapeHtml4(industryDemandFundUseSheetInfo), WdApplicationIndustryDemandFundUseSheet.class);
            wdApplicationIndustryDemandFundUseSheet.setId(UidUtil.uuid());
            wdApplicationIndustryDemandFundUseSheet.setApplicationId(applicationId);
            wdApplicationIndustryDemandFundUseSheet.setCreateBy(UserUtils.getUser().getId());
            wdApplicationIndustryDemandFundUseSheet.setCreateDate(new Date());
            wdApplicationIndustryDemandFundUseSheet.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationIndustryDemandFundUseSheet.setUpdateDate(new Date());
            wdApplicationIndustryDemandFundUseSheetService.insertSelective(wdApplicationIndustryDemandFundUseSheet);
        }
        
        return new JsonResult();
    }
    
    @RequestMapping(value = { "getApplicationInfo" })
    @ResponseBody
    public JsonResult getApplicationInfo(String applicationId) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("indirectInvestigationList", wdApplicationIndirectInvestigationService.selectByApplicationId(applicationId));
        resultMap.put("industryDemandFundUseSheetInfo", wdApplicationIndustryDemandFundUseSheetService.selectByApplicationId(applicationId));
        return new JsonResult(resultMap);
    }

    /**
     * 申请人信息 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "applicantInfo" })
    public String applicantInfo(Model model, HttpServletRequest request, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        
        SysUser currentUser = sysUserService.selectByPrimaryKey(wdApplication.getOwnerId());
        // 申请信息
        model.addAttribute("wdApplication", wdApplication);
        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        WdProduct wdProduct = wdProductService.selectByPrimaryKey(wdApplication.getProductId());
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProduct.getProductVersion();
        }
        Map<String, Object> productConfig = new HashMap<>();
        List<WdProductSimpleModule> wdProductSimpleModuleList = wdProductSimpleModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, "survey");
        for (WdProductSimpleModule wdProductSimpleModule : wdProductSimpleModuleList) {
            productConfig.put(wdProductSimpleModule.getDefaultSimpleModuleId(), wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
        }

        Map<String, Object> complexProductConfig = new HashMap<>();
        List<WdProductComplexModule> wdProductComplexModuleList = wdProductComplexModuleService.selectByProductVersion(wdApplication.getProductId(), productVersoin, "survey");
        for (WdProductComplexModule wdProductComplexModule : wdProductComplexModuleList) {
            complexProductConfig.put(wdProductComplexModule.getDefaultComplexModuleId(), wdProductComplexModule);
        }
        if (!complexProductConfig.isEmpty()) { // 经营类配置
            productConfig.put(BusinessConsts.ModuleID.BusinessInfo, wdBusinessElementService.selectByModule(BusinessConsts.ModuleID.BusinessInfo));
        }
        model.addAttribute("productConfig", productConfig);
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
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, currentUser.getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getRelatedPersonVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("customerRelationConfigList", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }
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

        // 人员信息
        WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdCustomer.getPersonId());
        model.addAttribute("wdPerson", wdPerson);
        // 客户关系人
        List<PersonRelationerVo> customerRelationList = wdPersonService.selectRelationerByPersonId(wdCustomer.getPersonId(), currentUser.getId());
        model.addAttribute("customerRelationList", customerRelationList);
        Map<String, Integer> customerRelationPermissions = new HashMap<>();
        for (PersonRelationerVo customerRelation : customerRelationList) {
            int permission = wdCustomerRelationService.getPermissionByPersonAndManager(customerRelation.getPersonId(), currentUser.getId());
            customerRelationPermissions.put(customerRelation.getPersonId(), (permission | CustomerInfoRights.read));
        }
        model.addAttribute("customerRelationPermissions", customerRelationPermissions);
        // 家庭主要资产（车辆）
        model.addAttribute("customerCarList", wdPersonAssetsCarService.selectByPersonId(wdCustomer.getPersonId()));
        // 家庭主要资产（房产）
        model.addAttribute("customerBuildingList", wdPersonAssetsBuildingService.selectByPersonId(wdCustomer.getPersonId()));
        // 经营信息
        model.addAttribute("wdApplicationBusinesList", wdApplicationBusinessService.selectByApplicationId(applicationId));

        // 征信信息
        model.addAttribute("applicationCreditInvestigationList", wdApplicationCreditInvestigationService.selectByApplicationId(applicationId));
        // 房产抵押
        model.addAttribute("applicationBuildingMortgageList", wdApplicationBuildingMortgageService.selectByApplicationId(applicationId));
        // 车辆抵押
        model.addAttribute("applicationCarLoanMortgageList", wdApplicationCarLoanMortgageService.selectByApplicationId(applicationId));
        // 担保人
        model.addAttribute("wdApplicationRecognizorList", wdApplicationRecognizorService.selectByApplicationId(applicationId));
        // 共同借款人
        model.addAttribute("wdApplicationCoborrowerList", wdApplicationCoborrowerService.selectByApplicationId(applicationId));
        // 信用卡信息
        model.addAttribute("wdApplicationCreditCardInfo", wdApplicationCreditCardInfoService.selectByApplicationId(applicationId));
        
        // 辅助信息
        model.addAttribute("wdApplicationExtendInfo", wdApplicationExtendInfoService.selectByApplicationId(applicationId));
        // 收入损益表
        model.addAttribute("applicationMonthlyIncomeStatement", wdApplicationMonthlyIncomeStatementService.selectByApplicationId(applicationId));
        model.addAttribute("applicationYearlyIncomeStatement", wdApplicationYearlyIncomeStatementService.selectByApplicationId(applicationId));
        // 家庭资产负债表
        model.addAttribute("applicationBalanceSheet", wdApplicationBalanceSheetService.selectByApplicationId(applicationId));
        // 调查图片
        model.addAttribute("surveyPhotoList", wdApplicationPhotoService.selectByApplicationId(applicationId));

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

        return "modules/wd/application/survey/applicantInfo";
    }

    /**
     * 进入经营编辑页面 date: 2017年4月26日 下午2:41:27 <br/>
     * @author Liam
     * @param request
     * @param businessId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/new_business_view" })
    public String newBusinessView(HttpServletRequest request, Model model, String businessId, String applicationId) {
        model.addAttribute("config", wdDefaultSimpleModuleSettingService.selectByModuleId(ModuleID.BusinessInfo));
        if (StringUtils.isNotEmpty(businessId)) {
            model.addAttribute("wdApplicationBusiness", wdApplicationBusinessService.selectByPrimaryKey(businessId));
        }
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/survey/newBusinessInfo";
    }

    /**
     * 进入经营详情页面 date: 2017年4月26日 下午2:41:27 <br/>
     * @author Liam
     * @param request
     * @param businessId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/business_info_detail" })
    public String business_info_detail(HttpServletRequest request, Model model, String businessId, String applicationId) {
        model.addAttribute("config", wdDefaultSimpleModuleSettingService.selectByModuleId(ModuleID.BusinessInfo));
        if (StringUtils.isNotEmpty(businessId)) {
            model.addAttribute("wdApplicationBusiness", wdApplicationBusinessService.selectByPrimaryKey(businessId));
        }
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/survey/edit/businessInfoDetail";
    }

    /**
     * 修改经营信息 date: 2017年3月27日 下午3:36:00 <br/>
     * @author Liam
     * @param applicationId
     * @param businessId
     * @param data
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/save_business" })
    @ResponseBody
    public JsonResult saveBusiness(String businessId, String applicationId, String data, HttpServletRequest request) {
        data = BusinessElementUtils.dataHandle(request, data, wdBusinessElementService);
        WdApplicationBusiness wdApplicationBusiness = new WdApplicationBusiness();
        if (StringUtils.isNotEmpty(businessId)) {
            wdApplicationBusiness = wdApplicationBusinessService.selectByPrimaryKey(businessId);
            wdApplicationBusiness.setDetailData(data);
            wdApplicationBusiness.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationBusiness.setUpdateDate(new Date());
            wdApplicationBusinessService.updateByPrimaryKey(wdApplicationBusiness);
        } else {
            businessId = UidUtil.uuid();
            wdApplicationBusiness.setApplicationId(applicationId);
            wdApplicationBusiness.setId(businessId);
            wdApplicationBusiness.setCreateBy(UserUtils.getUser().getId());
            wdApplicationBusiness.setCreateDate(new Date());
            wdApplicationBusiness.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationBusiness.setUpdateDate(new Date());
            wdApplicationBusiness.setDetailData(data);
            wdApplicationBusinessService.insertSelective(wdApplicationBusiness);
        }
        return new JsonResult(wdApplicationBusiness);
    }

    /**
     * 删除经营信息 date: 2017年3月28日 下午11:51:20 <br/>
     * @author Liam
     * @param businessId
     * @param data
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/del_business" })
    @ResponseBody
    public JsonResult delBusiness(String businessId, String data, HttpServletRequest request) {
        wdApplicationBusinessService.deleteByPrimaryKey(businessId);
        return new JsonResult();
    }

    /**
     * 进入关系人编辑页面
     * @author Liam
     * @param request
     * @param model
     * @param businessId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/new_person_relation_view" })
    public String newPersonRelationView(HttpServletRequest request, Model model, String relationId, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 客户关系
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getRelatedPersonVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("config", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }

        if (StringUtils.isNotEmpty(relationId)) {
            WdPersonRelation wdPersonRelation = wdPersonRelationService.selectByPrimaryKey(relationId);
            model.addAttribute("wdPersonRelation", wdPersonRelation);
            WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdPersonRelation.getRelatedPersonId());
            model.addAttribute("wdPerson", wdPerson);
        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/personRelation";
    }

    /**
     * 关系人详情 date: 2017年7月24日 下午5:19:29 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/person_relation_detail" })
    public String personRelationerDetail(HttpServletRequest request, Model model, String relationId, String applicationId) {

        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 客户关系
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getRelatedPersonVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("config", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }

        if (StringUtils.isNotEmpty(relationId)) {
            WdPersonRelation wdPersonRelation = wdPersonRelationService.selectByPrimaryKey(relationId);
            WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdPersonRelation.getRelatedPersonId());
            wdPersonRelation.setWdPerson(wdPerson);
            model.addAttribute("wdPersonRelation", wdPersonRelation);
        }

        int permission = wdCustomerRelationService.getPermissionByPersonAndManager(relationId, UserUtils.getUser().getId());
        model.addAttribute("permission", permission | CustomerInfoRights.read);

        return "modules/wd/application/survey/edit/personRelationDetail";
    }

    private WdPersonRelation savePersonRelationship(WdPerson debtor, WdPerson relatedPerson, String relationType, String userId) {
        WdPersonRelation relation = wdPersonRelationService.selectByDebtorPersonIdAndRelatedPersonId(relatedPerson.getId(), debtor.getId());
        if (null == relation) {
            relation = new WdPersonRelation();
        }
        relation.setDebtorPersonId(relatedPerson.getId());
        relation.setDebtorPersonName(relatedPerson.getName());
        relation.setRelatedPersonId(debtor.getId());
        relation.setRelatedPersonName(debtor.getName());
        relation.setRelationType(relationType);
        relation.setUpdateBy(userId);
        relation.setUpdateDate(new Date());
        if (StringUtils.isBlank(relation.getId())) {
            relation.setId(UidUtil.uuid());
            relation.setCreateBy(userId);
            relation.setCreateDate(new Date());
            wdPersonRelationService.insertSelective(relation);
        } else {
            wdPersonRelationService.updateByPrimaryKeySelective(relation);
        }

        relation = wdPersonRelationService.selectByDebtorPersonIdAndRelatedPersonId(debtor.getId(), relatedPerson.getId());
        if (null == relation) {
            relation = new WdPersonRelation();
        }
        relation.setDebtorPersonId(debtor.getId());
        relation.setDebtorPersonName(debtor.getName());
        relation.setRelatedPersonId(relatedPerson.getId());
        relation.setRelatedPersonName(relatedPerson.getName());
        relation.setRelationType(relationType);
        relation.setUpdateBy(userId);
        relation.setUpdateDate(new Date());
        if (StringUtils.isBlank(relation.getId())) {
            relation.setId(UidUtil.uuid());
            relation.setCreateBy(userId);
            relation.setCreateDate(new Date());
            wdPersonRelationService.insertSelective(relation);
        } else {
            wdPersonRelationService.updateByPrimaryKeySelective(relation);
        }

        return relation;
    }

    /**
     * 保存关系人 date: 2017年3月27日 下午3:36:36 <br/>
     * @author Liam
     * @param customerId
     * @param data
     * @param request
     * @param userId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/save_related_person" })
    @ResponseBody
    public JsonResult savePersonRelationer(String relationType, String relationId, String customerId, String data, HttpServletRequest request) {

        WdCustomer customer = wdCustomerService.selectByPrimaryKey(customerId);
        if (null == customer || StringUtils.isBlank(customer.getPersonId())) {
            return new JsonResult(false, "找不到对应的客户");
        }
        WdPerson debtor = wdPersonService.selectByPrimaryKey(customer.getPersonId());
        if (null == debtor) {
            return new JsonResult(false, "客户数据有误，详情信息丢失");
        }
        if (StringUtils.isBlank(relationType)) {
            return new JsonResult(false, "人员与客户的关系必填");
        }

        String userId = UserUtils.getUser().getId();
        WdPerson relatedPerson = null;
        if (StringUtils.isNotBlank(relationId)) {
            relatedPerson = wdPersonService.selectByPrimaryKey(relationId);
            if (null == relatedPerson) {
                return new JsonResult(false, "找不到对应的关系人");
            }

            int permission = wdCustomerRelationService.getPermissionByPersonAndManager(relationId, userId);
            if ((permission & CustomerInfoRights.write) == 0) {
                return new JsonResult(false, "您暂时不能修改该关系人");
            }
        }
        if (null == relatedPerson) {
            relatedPerson = new WdPerson();
            relatedPerson.setId(UidUtil.uuid());
        }

        data = BusinessElementUtils.dataHandle(request, data, wdBusinessElementService);
        Object nameObj = JSON.parseObject(data, HashMap.class).get("base_info_name");
        Object idcardObj = JSON.parseObject(data, HashMap.class).get("base_info_idcard");
        Object telObj = JSON.parseObject(data, HashMap.class).get("base_info_tel");

        if (null != idcardObj) {
            try {
                IDCard.IDCardValidate(idcardObj.toString());
            } catch (ParseException | GeneralException e) {
                LOGGER.error("创建征信任务时报错", e);
                return new JsonResult(false, e.getMessage());
            }
        }

        // 关系人已经被录入
        if (null != idcardObj && wdPersonService.existed(idcardObj.toString(), relatedPerson.getId())) {

            relatedPerson = wdPersonService.selectByIdCard(idcardObj.toString());
            WdPersonRelation relation = savePersonRelationship(debtor, relatedPerson, relationType, userId);

            if (StringUtils.isNotBlank(relationId)) {
                // 如果关系人对应的客户进行过贷款则不删除，否则删除客户信息以及客户与经理的关联关系
                if (wdCustomerService.deleteByPersonId(relationId) != null) {
                    // 如果关系人对应的客户数据删除，同时删除关联的人员信息
                    wdPersonService.deleteByPrimaryKey(relationId);
                } else {
                    // 如果关系人对应的客户数据没有删除，则仅删除该关系人与当前借贷人的关联关系
                    wdPersonRelationService.deleteRelationByDebtorAndRelatedPerson(debtor.getId(), relationId);
                }
            }

            return new JsonResult(true, "该关系人身份证号已被他人录入，已使用原有信息，如需更改请先将该关系人转到你的名下", relation);
        }

        boolean nameChange = true;
        boolean idNoChange = true;
        if (null != nameObj && !nameObj.toString().equals(relatedPerson.getName())) {
            relatedPerson.setName(nameObj.toString());
        } else {
            nameChange = false;
        }

        if (null != idcardObj && !idcardObj.toString().equals(relatedPerson.getIdNumber())) {
            relatedPerson.setIdNumber(idcardObj.toString());
        } else {
            idNoChange = false;
        }

        if (null != telObj) {
            relatedPerson.setPhone(telObj.toString());
        }
        relatedPerson.setBaseInfo(data);
        relatedPerson.setUpdateBy(userId);
        relatedPerson.setUpdateDate(new Date());

        if (StringUtils.isEmpty(relationId)) {
            // 添加客户信息
            List<WdCustomerType> customerTypes = wdCustomerTypeService.selectDisnewable(UserUtils.getUser().getCompanyId());
            if (null == customerTypes || customerTypes.isEmpty() || customerTypes.get(0) == null) {
                return new JsonResult(false, "缺少默认客户类型，请联系管理员");
            }
            WdCustomer relatedCustomer = new WdCustomer();
            relatedCustomer.setId(UidUtil.uuid());
            relatedCustomer.setPersonId(relatedPerson.getId());
            relatedCustomer.setCustomerTypeId(customerTypes.get(0).getId());
            relatedCustomer.setCustomerTypeName(customerTypes.get(0).getName());
            relatedCustomer.setCustomerTypeCode(customerTypes.get(0).getCode());
            relatedCustomer.setCreateBy(userId);
            relatedCustomer.setCreateDate(new Date());
            relatedCustomer.setUpdateBy(userId);
            relatedCustomer.setUpdateDate(new Date());

            Map<String, Object> dataMap = JSON.parseObject(data, Map.class);
            Set<String> keys = dataMap.keySet();
            if (null != keys) {
                for (String key : keys) {
                    WdBusinessElement wdBusinessElement = wdBusinessElementService.selectBykey(key);
                    // 客户可查询信息
                    if (null != customerTypes.get(0).getPortraitCol() && customerTypes.get(0).getPortraitCol().equals(wdBusinessElement.getId())) {
                        relatedCustomer.setPortrait(dataMap.get(key).toString());
                    }
                    if (null != customerTypes.get(0).getSubtitleCol() && customerTypes.get(0).getSubtitleCol().equals(wdBusinessElement.getId())) {
                        relatedCustomer.setSubtitle(dataMap.get(key).toString());
                    }
                    if (null != customerTypes.get(0).getTitleCol() && customerTypes.get(0).getTitleCol().equals(wdBusinessElement.getId())) {
                        relatedCustomer.setTitle(dataMap.get(key).toString());
                    }
                }
            }
            wdCustomerService.insertSelective(relatedCustomer);

            WdCustomerTrack wdCustomerTrack = new WdCustomerTrack();
            wdCustomerTrack.setId(UidUtil.uuid());
            wdCustomerTrack.setCustomerId(relatedCustomer.getId());
            wdCustomerTrack.setTitle("新增客户");
            wdCustomerTrack.setContent("作为" + debtor.getName() + "的关系人被录入");
            wdCustomerTrack.setCategory("营销记录");
            wdCustomerTrack.setCreateBy(userId);
            wdCustomerTrack.setCreateDate(new Date());
            wdCustomerTrack.setUpdateBy(userId);
            wdCustomerTrack.setUpdateDate(new Date());
            wdCustomerTrackService.insertSelective(wdCustomerTrack);

            SysUser user = UserUtils.getUser();
            WdCustomerRelation wdCustomerRelation = new WdCustomerRelation();
            wdCustomerRelation.setId(UidUtil.uuid());
            wdCustomerRelation.setCustomerId(relatedCustomer.getId());
            wdCustomerRelation.setPersonId(relatedCustomer.getId());
            wdCustomerRelation.setUserId(userId);
            wdCustomerRelation.setUserName(user.getName());
            wdCustomerRelation.setRelationType("belong");
            wdCustomerRelation.setPermission(CustomerInfoRights.read | CustomerInfoRights.write | CustomerInfoRights.transfer | CustomerInfoRights.share);
            wdCustomerRelation.setCreateBy(userId);
            wdCustomerRelation.setCreateDate(new Date());
            wdCustomerRelation.setUpdateBy(userId);
            wdCustomerRelation.setUpdateDate(new Date());
            wdCustomerRelationService.insertSelective(wdCustomerRelation);

            relatedPerson.setCreateBy(userId);
            relatedPerson.setCreateDate(new Date());
            wdPersonService.insertSelective(relatedPerson);
        } else {
            wdPersonService.updateByPrimaryKeySelective(relatedPerson);
        }

        WdPersonRelation relation = savePersonRelationship(debtor, relatedPerson, relationType, userId);

        return new JsonResult(relation);
    }

    /**
     * 删除关系 date: 2017年3月27日 下午4:25:16 <br/>
     * @author Liam
     * @param relationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/del_person_relationer" })
    @ResponseBody
    public JsonResult delPersonRelationer(String relationId, HttpServletRequest request) {
        wdPersonRelationService.deleteByPrimaryKey(relationId);
        return new JsonResult();
    }

    /**
     * 进入家庭主要资产（车辆）编辑页面
     * @author Liam
     * @param request
     * @param model
     * @param businessId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/new_person_assets_car_view" })
    public String new_person_assets_car_view(HttpServletRequest request, Model model, String carId, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 车辆
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_car, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getAssetsCarVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("config", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }

        if (StringUtils.isNotEmpty(carId)) {
            model.addAttribute("personAssetsCar", wdPersonAssetsCarService.selectByPrimaryKey(carId));
        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/personAssetsCar";
    }

    /**
     * 家庭主要资产（车辆）详情 date: 2017年7月25日 上午10:51:22 <br/>
     * @author Liam
     * @param request
     * @param model
     * @param carId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/person_assets_car_detail" })
    public String person_assets_car_detail(HttpServletRequest request, Model model, String carId, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 车辆
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_car, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getAssetsCarVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("config", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }

        if (StringUtils.isNotEmpty(carId)) {
            model.addAttribute("personAssetsCar", wdPersonAssetsCarService.selectByPrimaryKey(carId));
        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/personAssetsCarDetail";
    }

    /**
     * 编辑车 date: 2017年3月27日 下午5:05:55 <br/>
     * @author Liam
     * @param customerId
     * @param data
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/add_person_assets_car" })
    @ResponseBody
    public JsonResult addPersonAssetCar(String customerId, String id, String data, HttpServletRequest request) {
        data = BusinessElementUtils.dataHandle(request, data, wdBusinessElementService);
        WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(customerId);
        WdPersonAssetsCar wdPersonAssetsCar = new WdPersonAssetsCar();
        if (StringUtils.isEmpty(id)) {
            wdPersonAssetsCar.setId(UidUtil.uuid());
            wdPersonAssetsCar.setPersonId(wdCustomer.getPersonId());
            wdPersonAssetsCar.setCreateBy(UserUtils.getUser().getId());
            wdPersonAssetsCar.setCreateDate(new Date());
            wdPersonAssetsCar.setUpdateBy(UserUtils.getUser().getId());
            wdPersonAssetsCar.setUpdateDate(new Date());

            wdPersonAssetsCar.setDetailData(data);
            wdPersonAssetsCarService.insertSelective(wdPersonAssetsCar);
        } else {
            wdPersonAssetsCar.setId(id);
            wdPersonAssetsCar.setDetailData(data);
            wdPersonAssetsCar.setUpdateBy(UserUtils.getUser().getId());
            wdPersonAssetsCar.setUpdateDate(new Date());
            wdPersonAssetsCarService.updateByPrimaryKeySelective(wdPersonAssetsCar);
        }
        return new JsonResult(wdPersonAssetsCar);
    }

    /**
     * 删除主要资产[车] date: 2017年3月27日 下午10:54:44 <br/>
     * @author Liam
     * @param carId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/del_person_assets_car" })
    @ResponseBody
    public JsonResult delPersonAssetCar(String carId, HttpServletRequest request) {
        WdPersonAssetsCar wdPersonAssetsCar = wdPersonAssetsCarService.selectByPrimaryKey(carId);
        wdPersonAssetsCar.setUpdateBy(UserUtils.getUser().getId());
        wdPersonAssetsCar.setUpdateDate(new Date());
        wdPersonAssetsCar.setDelFlag(true);
        wdPersonAssetsCarService.updateByPrimaryKeySelective(wdPersonAssetsCar);
        return new JsonResult();
    }

    /**
     * 进入主要资产[房]编辑页面
     * @author Liam
     * @param request
     * @param model
     * @param businessId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/new_person_assets_building_view" })
    public String new_person_assets_building_view(HttpServletRequest request, Model model, String buildingId, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 客户关系
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_building, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getAssetsBuildingVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("config", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }

        if (StringUtils.isNotEmpty(buildingId)) {
            model.addAttribute("personAssetsBuilding", wdPersonAssetsBuildingService.selectByPrimaryKey(buildingId));
        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/personAssetsBuilding";
    }

    @RequestMapping(value = { "/person_assets_building_detail" })
    public String person_assets_building_detail(HttpServletRequest request, Model model, String buildingId, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 客户关系
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_building, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getAssetsBuildingVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("config", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }

        if (StringUtils.isNotEmpty(buildingId)) {
            model.addAttribute("personAssetsBuilding", wdPersonAssetsBuildingService.selectByPrimaryKey(buildingId));
        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/personAssetsBuildingDetail";
    }

    /**
     * 添加房产 date: 2017年3月27日 下午11:40:12 <br/>
     * @author Liam
     * @param customerId
     * @param data
     * @param request
     * @param userId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/add_person_assets_building" })
    @ResponseBody
    public JsonResult addPersonAssetsBuilding(String customerId, String id, String data, HttpServletRequest request) {
        data = BusinessElementUtils.dataHandle(request, data, wdBusinessElementService);

        WdPersonAssetsBuilding wdPersonAssetsBuilding = new WdPersonAssetsBuilding();
        if (StringUtils.isEmpty(id)) {
            String personId = StringUtils.EMPTY;
            WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(customerId);
            if (null != wdCustomer && StringUtils.isNotBlank(wdCustomer.getPersonId())) {
                personId = wdCustomer.getPersonId();
            } else {
                WdPerson wdPerson = wdPersonService.selectByPrimaryKey(customerId);
                if (null != wdPerson && StringUtils.isNotBlank(wdPerson.getId())) {
                    personId = wdPerson.getId();
                }
            }

            if (StringUtils.isBlank(personId)) {
                return new JsonResult(false, "找不到对应的人员");
            }

            wdPersonAssetsBuilding.setId(UidUtil.uuid());
            wdPersonAssetsBuilding.setCreateBy(UserUtils.getUser().getId());
            wdPersonAssetsBuilding.setCreateDate(new Date());
            wdPersonAssetsBuilding.setUpdateBy(UserUtils.getUser().getId());
            wdPersonAssetsBuilding.setUpdateDate(new Date());
            wdPersonAssetsBuilding.setDetailData(data);
            wdPersonAssetsBuildingService.insertSelective(wdPersonAssetsBuilding);

            WdPersonAssetsBuildingRelation wdPersonAssetsBuildingRelation = new WdPersonAssetsBuildingRelation();
            wdPersonAssetsBuildingRelation.setId(UidUtil.uuid());
            wdPersonAssetsBuildingRelation.setBuildingId(wdPersonAssetsBuilding.getId());
            wdPersonAssetsBuildingRelation.setPersonId(personId);
            wdPersonAssetsBuildingRelation.setCreateBy(UserUtils.getUser().getId());
            wdPersonAssetsBuildingRelation.setCreateDate(new Date());
            wdPersonAssetsBuildingRelation.setUpdateBy(UserUtils.getUser().getId());
            wdPersonAssetsBuildingRelation.setUpdateDate(new Date());
            wdPersonAssetsBuildingRelationService.insertSelective(wdPersonAssetsBuildingRelation);
        } else {
            wdPersonAssetsBuilding.setId(id);
            wdPersonAssetsBuilding.setUpdateDate(new Date());
            wdPersonAssetsBuilding.setDetailData(data);
            wdPersonAssetsBuildingService.updateByPrimaryKeySelective(wdPersonAssetsBuilding);
        }

        return new JsonResult(wdPersonAssetsBuilding);
    }

    /**
     * 删除主要资产[房] date: 2017年3月27日 下午11:33:36 <br/>
     * @author Liam
     * @param buildingId
     * @param customerId
     * @param request
     * @param userId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/del_person_assets_building" })
    @ResponseBody
    public JsonResult delPersonAssetBuilding(String buildingId, String customerId, HttpServletRequest request, String userId) {
        WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(customerId);
        WdPersonAssetsBuildingRelation wdPersonAssetsBuildingRelation = wdPersonAssetsBuildingRelationService.selectByPersonIdAndBuildingId(wdCustomer.getPersonId(), buildingId);
        wdPersonAssetsBuildingRelationService.deleteByPrimaryKey(wdPersonAssetsBuildingRelation.getId());
        return new JsonResult();
    }

    /**
     * 进入担保人编辑页面
     * @author Liam
     * @param businessId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/application_recognizor_view" })
    public String application_recognizor_view(HttpServletRequest request, Model model, String recognizorId, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);

        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        WdProduct wdProduct = wdProductService.selectByPrimaryKey(wdApplication.getProductId());
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProduct.getProductVersion();
        }
        WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdProduct.getId(), productVersoin, BusinessConsts.ModuleID.Recognizor);
        model.addAttribute("config", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));

        // 客户关系人
        model.addAttribute("customerRelationList", wdPersonService.selectRelationerByPersonId(wdCustomerService.selectByPrimaryKey(wdApplication.getCustomerId()).getPersonId(), UserUtils.getUser().getId()));

        if (StringUtils.isNotEmpty(recognizorId)) {
            WdApplicationRecognizor wdApplicationRecognizor = wdApplicationRecognizorService.selectByPrimaryKey(recognizorId);
            model.addAttribute("wdApplicationRecognizor", wdApplicationRecognizor);

            WdPersonRelation wdPersonRelation = wdPersonRelationService.selectByPrimaryKey(wdApplicationRecognizor.getApplicationPersonRelationId());
            model.addAttribute("wdPersonRelation", wdPersonRelation);

            WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdPersonRelation.getRelatedPersonId());
            model.addAttribute("wdPerson", wdPerson);

        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/applicationRecognizor";
    }

    /**
     * 进入担保人详情页面
     * @param recognizorId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/application_recognizor_detail" })
    public String application_recognizor_detail(HttpServletRequest request, Model model, String recognizorId, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);

        // 担保人配置
        String productVersoin = wdApplication.getProductVersion();
        WdProduct wdProduct = wdProductService.selectByPrimaryKey(wdApplication.getProductId());
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProduct.getProductVersion();
        }
        WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdProduct.getId(), productVersoin, BusinessConsts.ModuleID.Recognizor);
        model.addAttribute("config", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));

        // 客户关系配置
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getRelatedPersonVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("customerRelationConfigList", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }

        if (StringUtils.isNotEmpty(recognizorId)) {
            WdApplicationRecognizor wdApplicationRecognizor = wdApplicationRecognizorService.selectByPrimaryKey(recognizorId);
            model.addAttribute("wdApplicationRecognizor", wdApplicationRecognizor);

            WdPersonRelation wdPersonRelation = wdPersonRelationService.selectByPrimaryKey(wdApplicationRecognizor.getApplicationPersonRelationId());
            model.addAttribute("wdPersonRelation", wdPersonRelation);

            WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdPersonRelation.getRelatedPersonId());
            model.addAttribute("wdPerson", wdPerson);

        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/applicationRecognizorDetail";
    }

    /**
     * 保存担保人 date: 2017年3月30日 下午1:51:25 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/save_recognizor" })
    @ResponseBody
    public JsonResult saveRecognizor(HttpServletRequest request, WdApplicationRecognizor recognizor, String data) {
        data = BusinessElementUtils.dataHandle(request, data, wdBusinessElementService);
        WdPersonRelation relation = wdPersonRelationService.selectByPrimaryKey(recognizor.getApplicationPersonRelationId());

        recognizor.setOriginalId(relation.getRelatedPersonId());
        recognizor.setRelationType(relation.getRelationType());
        recognizor.setRelationPersonName(relation.getRelatedPersonName());

        WdApplicationRecognizor oldRecognizor = wdApplicationRecognizorService.selectByApplicationIdAndOriginalId(recognizor.getApplicationId(), relation.getRelatedPersonId());
        if (null != oldRecognizor && oldRecognizor.getId().compareTo(recognizor.getId()) != 0) {
            return new JsonResult(false, "该申请已经添加过当前担保人");
        }

        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(recognizor.getApplicationId());
        if (null == wdApplication) {
            return new JsonResult(false, "找不到对应的申请");
        }
        recognizor.setRecognizorInfo(data);

        if (StringUtils.isEmpty(recognizor.getId())) {
            recognizor.setId(UidUtil.uuid());
            recognizor.setCreateBy(UserUtils.getUser().getId());
            recognizor.setCreateDate(new Date());
            recognizor.setUpdateBy(UserUtils.getUser().getId());
            recognizor.setUpdateDate(new Date());
            wdApplicationRecognizorService.insertSelective(recognizor);
        } else {
            recognizor.setUpdateBy(UserUtils.getUser().getId());
            recognizor.setUpdateDate(new Date());
            wdApplicationRecognizorService.updateByPrimaryKeySelective(recognizor);
        }
        return new JsonResult(recognizor);
    }

    /**
     * 删除担保人 date: 2017年3月30日 下午1:51:25 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/del_recognizor" })
    @ResponseBody
    public JsonResult delRecognizor(String id) {
        WdApplicationRecognizor wdApplicationRecognizor = wdApplicationRecognizorService.selectByPrimaryKey(id);
        wdApplicationRecognizor.setDelFlag(true);
        wdApplicationRecognizor.setUpdateBy(UserUtils.getUser().getId());
        wdApplicationRecognizor.setUpdateDate(new Date());
        wdApplicationRecognizorService.updateByPrimaryKeySelective(wdApplicationRecognizor);
        return new JsonResult();
    }

    /**
     * 共同借款人编辑页面
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/edit_coborrower_view" })
    public String edit_coborrower_view(String applicationId, String userId, String coborrowerId, Model model) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);

        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        WdProduct wdProduct = wdProductService.selectByPrimaryKey(wdApplication.getProductId());
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProduct.getProductVersion();
        }
        WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdProduct.getId(), productVersoin, BusinessConsts.ModuleID.Coborrower);
        model.addAttribute("config", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));

        // 客户关系人
        model.addAttribute("customerRelationList", wdPersonService.selectRelationerByPersonId(wdCustomerService.selectByPrimaryKey(wdApplication.getCustomerId()).getPersonId(), UserUtils.getUser().getId()));

        if (StringUtils.isNotEmpty(coborrowerId)) {
            WdApplicationCoborrower wdApplicationCoborrower = wdApplicationCoborrowerService.selectByPrimaryKey(coborrowerId);
            model.addAttribute("wdApplicationCoborrower", wdApplicationCoborrower);

            WdPersonRelation wdPersonRelation = wdPersonRelationService.selectByPrimaryKey(wdApplicationCoborrower.getApplicationPersonRelationId());
            model.addAttribute("wdPersonRelation", wdPersonRelation);

            WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdPersonRelation.getRelatedPersonId());
            model.addAttribute("wdPerson", wdPerson);

        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/applicationCoborrower";
    }

    /**
     * 共同借款人详情页面
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/coborrower_detail" })
    public String coborrower_detail(String applicationId, String userId, String coborrowerId, Model model) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);

        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        WdProduct wdProduct = wdProductService.selectByPrimaryKey(wdApplication.getProductId());
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProduct.getProductVersion();
        }
        WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdProduct.getId(), productVersoin, BusinessConsts.ModuleID.Coborrower);
        model.addAttribute("config", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));

        // 客户关系配置
        WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, UserUtils.getUser().getCompanyId());
        if (null != wdCommonSimpleModuleRelation) {
            String relatedPersonVersion = wdApplication.getRelatedPersonVersion();
            if (StringUtils.isEmpty(relatedPersonVersion)) {
                relatedPersonVersion = wdCommonSimpleModuleRelation.getSettingVersion();
            }
            model.addAttribute("customerRelationConfigList", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), relatedPersonVersion));
        }

        if (StringUtils.isNotEmpty(coborrowerId)) {
            WdApplicationCoborrower wdApplicationCoborrower = wdApplicationCoborrowerService.selectByPrimaryKey(coborrowerId);
            model.addAttribute("wdApplicationCoborrower", wdApplicationCoborrower);

            WdPersonRelation wdPersonRelation = wdPersonRelationService.selectByPrimaryKey(wdApplicationCoborrower.getApplicationPersonRelationId());
            model.addAttribute("wdPersonRelation", wdPersonRelation);

            WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdPersonRelation.getRelatedPersonId());
            model.addAttribute("wdPerson", wdPerson);

        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/applicationCoborrowerDetail";
    }

    /**
     * 保存共同借款人 date: 2017年3月30日 下午1:51:25 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/save_coborrower" })
    @ResponseBody
    public JsonResult saveCoborrower(HttpServletRequest request, WdApplicationCoborrower coborrower, String data) {
        data = BusinessElementUtils.dataHandle(request, data, wdBusinessElementService);

        WdPersonRelation relation = wdPersonRelationService.selectByPrimaryKey(coborrower.getApplicationPersonRelationId());
        if (null == relation) {
            return new JsonResult(false, "此人与客户没有对应关系");
        }
        coborrower.setOriginalId(relation.getRelatedPersonId());
        coborrower.setRelationType(relation.getRelationType());
        coborrower.setRelationPersonName(relation.getRelatedPersonName());

        WdApplicationCoborrower oldCoborrower = wdApplicationCoborrowerService.selectByApplicationIdAndOriginalId(coborrower.getApplicationId(), relation.getRelatedPersonId());
        if (null != oldCoborrower && oldCoborrower.getId().compareTo(coborrower.getId()) != 0) {
            return new JsonResult(false, "该申请已经添加过当前共同借款人");
        }

        WdApplicationRecognizor oldRecognizor = wdApplicationRecognizorService.selectByApplicationIdAndOriginalId(coborrower.getApplicationId(), relation.getRelatedPersonId());
        if (null != oldRecognizor) {
            return new JsonResult(false, "此人已经作为担保人");
        }

        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(coborrower.getApplicationId());
        if (null == wdApplication) {
            return new JsonResult(false, "找不到对应的申请");
        }

        coborrower.setCoborrowerInfo(data);
        coborrower.setApplicationPersonRelationId(relation.getId());
        coborrower.setRelationPersonName(relation.getRelatedPersonName());

        if (StringUtils.isEmpty(coborrower.getId())) {
            coborrower.setId(UidUtil.uuid());
            coborrower.setCreateBy(UserUtils.getUser().getId());
            coborrower.setCreateDate(new Date());
            coborrower.setUpdateBy(UserUtils.getUser().getId());
            coborrower.setUpdateDate(new Date());
            wdApplicationCoborrowerService.insertSelective(coborrower);
        } else {
            coborrower.setUpdateBy(UserUtils.getUser().getId());
            coborrower.setUpdateDate(new Date());
            wdApplicationCoborrowerService.updateByPrimaryKeySelective(coborrower);
        }

        return new JsonResult(coborrower);
    }

    /**
     * 删除共同借款人 date: 2017年3月30日 下午1:51:25 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/del_coborrower" })
    @ResponseBody
    public JsonResult delCoborrower(String id) {
        WdApplicationCoborrower wdApplicationCoborrower = wdApplicationCoborrowerService.selectByPrimaryKey(id);
        if (null == wdApplicationCoborrower) {
            return new JsonResult(false, "编号不存在");
        }
        wdApplicationCoborrower.setDelFlag(true);
        wdApplicationCoborrower.setUpdateBy(UserUtils.getUser().getId());
        wdApplicationCoborrower.setUpdateDate(new Date());
        wdApplicationCoborrowerService.updateByPrimaryKeySelective(wdApplicationCoborrower);
        return new JsonResult();
    }

    /**
     * 进入房贷抵押编辑页面
     * @author Liam
     * @param request
     * @param model
     * @param businessId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/building_mortgage_view" })
    public String building_mortgage_view(HttpServletRequest request, Model model, String id, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);

        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        WdProduct wdProduct = wdProductService.selectByPrimaryKey(wdApplication.getProductId());
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProduct.getProductVersion();
        }
        WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdProduct.getId(), productVersoin, BusinessConsts.ModuleID.MortgageBuilding);
        model.addAttribute("config", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));

        // 家庭主要资产（房产）
        model.addAttribute("customerBuildingList", wdPersonAssetsBuildingService.selectByPersonId(wdCustomerService.selectByPrimaryKey(wdApplication.getCustomerId()).getPersonId()));

        if (StringUtils.isNotEmpty(id)) {
            WdApplicationBuildingMortgage buildingMortgage = wdApplicationBuildingMortgageService.selectByPrimaryKey(id);
            model.addAttribute("wdApplicationBuildingMortgage", buildingMortgage);
        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/buildingMortgage";
    }

    /**
     * 保存房贷抵押 date: 2017年3月30日 下午1:51:25 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/save_building_mortgage" })
    @ResponseBody
    public JsonResult saveBuildingMortgage(HttpServletRequest request, WdApplicationBuildingMortgage buildingMortgage, String data) {
        data = BusinessElementUtils.dataHandle(request, data, wdBusinessElementService);
        List<WdApplicationBuildingMortgage> mortgages = wdApplicationBuildingMortgageService.selectByApplicationIdAndOriginalId(buildingMortgage.getApplicationId(), buildingMortgage.getOriginalId());
        if (mortgages.size() > 1 || (StringUtils.isBlank(buildingMortgage.getId()) && mortgages.size() != 0)) {
            return new JsonResult(false, "该房产已经在本申请中作为抵押了");
        }

        buildingMortgage.setDetailData(data);

        if (StringUtils.isEmpty(buildingMortgage.getId())) {
            buildingMortgage.setId(UidUtil.uuid());
            buildingMortgage.setCreateBy(UserUtils.getUser().getId());
            buildingMortgage.setCreateDate(new Date());
            buildingMortgage.setUpdateBy(UserUtils.getUser().getId());
            buildingMortgage.setUpdateDate(new Date());

            wdApplicationBuildingMortgageService.insertSelective(buildingMortgage);
        } else {
            buildingMortgage.setUpdateBy(UserUtils.getUser().getId());
            buildingMortgage.setUpdateDate(new Date());
            wdApplicationBuildingMortgageService.updateByPrimaryKeySelective(buildingMortgage);
        }
        return new JsonResult();
    }

    /**
     * 删除房贷抵押 date: 2017年3月30日 下午1:51:25 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/del_building_mortgage" })
    @ResponseBody
    public JsonResult delBuildingMortgage(String id) {
        WdApplicationBuildingMortgage wdApplicationBuildingMortgage = wdApplicationBuildingMortgageService.selectByPrimaryKey(id);
        wdApplicationBuildingMortgage.setDelFlag(true);
        wdApplicationBuildingMortgage.setUpdateBy(UserUtils.getUser().getId());
        wdApplicationBuildingMortgage.setUpdateDate(new Date());
        wdApplicationBuildingMortgageService.updateByPrimaryKeySelective(wdApplicationBuildingMortgage);
        return new JsonResult();
    }

    /**
     * 进入辅助信息编辑页面
     * @author Liam
     * @param request
     * @param model
     * @param businessId
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "/application_extend_info_view" })
    public String application_extend_info_view(HttpServletRequest request, Model model, String id, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);

        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        WdProduct wdProduct = wdProductService.selectByPrimaryKey(wdApplication.getProductId());
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProduct.getProductVersion();
        }
        WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdProduct.getId(), productVersoin, BusinessConsts.ModuleID.ExtendInfo);
        model.addAttribute("config", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));

        if (StringUtils.isNotEmpty(id)) {
            model.addAttribute("wdApplicationExtendInfo", wdApplicationExtendInfoService.selectByPrimaryKey(id));
        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/applicationExtendInfo";
    }

    @RequestMapping(value = { "/application_extend_info_detail" })
    public String application_extend_info_detail(HttpServletRequest request, Model model, String id, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);

        // 产品配置
        String productVersoin = wdApplication.getProductVersion();
        WdProduct wdProduct = wdProductService.selectByPrimaryKey(wdApplication.getProductId());
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProduct.getProductVersion();
        }
        WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdProduct.getId(), productVersoin, BusinessConsts.ModuleID.ExtendInfo);
        model.addAttribute("config", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));

        if (StringUtils.isNotEmpty(id)) {
            model.addAttribute("wdApplicationExtendInfo", wdApplicationExtendInfoService.selectByPrimaryKey(id));
        }
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/edit/applicationExtendInfoDetail";
    }

    /**
     * 保存辅助信息 date: 2017年3月30日 下午1:51:25 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "/save_application_extend_info" })
    @ResponseBody
    public JsonResult save_application_extend_info(HttpServletRequest request, WdApplicationExtendInfo wdApplicationExtendInfo, String data) {
        data = BusinessElementUtils.dataHandle(request, data, wdBusinessElementService);
        wdApplicationExtendInfo.setDetailData(data);
        if (StringUtils.isEmpty(wdApplicationExtendInfo.getId())) {
            wdApplicationExtendInfo.setId(UidUtil.uuid());
            wdApplicationExtendInfo.setCreateBy(UserUtils.getUser().getId());
            wdApplicationExtendInfo.setCreateDate(new Date());
            wdApplicationExtendInfo.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationExtendInfo.setUpdateDate(new Date());
            wdApplicationExtendInfoService.insertSelective(wdApplicationExtendInfo);
        } else {
            wdApplicationExtendInfo.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationExtendInfo.setUpdateDate(new Date());
            wdApplicationExtendInfoService.updateByPrimaryKeySelective(wdApplicationExtendInfo);
        }
        return new JsonResult(wdApplicationExtendInfo);
    }

    /**
     * 软信息不对称偏差 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "softInfo" })
    public String softInfo(Model model, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        model.addAttribute("applicationInfoDeviationAnalysis", wdApplicationInfoDeviationAnalysisService.selectByApplicationId(applicationId));
        SoftInfoSheetVo softInfoSheetVo = wdApplicationService.selectSoftInfoSheet(applicationId);
        model.addAttribute("softInfoSheet", softInfoSheetVo);
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/softInfo";
    }

    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "saveSoftInfo" })
    @ResponseBody
    public JsonResult saveSoftInfo(Model model, WdApplicationInfoDeviationAnalysis wdApplicationInfoDeviationAnalysis) {
        if (StringUtils.isEmpty(wdApplicationInfoDeviationAnalysis.getId())) {
            wdApplicationInfoDeviationAnalysis.setId(UidUtil.uuid());
            wdApplicationInfoDeviationAnalysis.setCreateBy(UserUtils.getUser().getId());
            wdApplicationInfoDeviationAnalysis.setCreateDate(new Date());
            wdApplicationInfoDeviationAnalysis.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationInfoDeviationAnalysis.setUpdateDate(new Date());
            wdApplicationInfoDeviationAnalysisService.insertSelective(wdApplicationInfoDeviationAnalysis);
        } else {
            wdApplicationInfoDeviationAnalysis.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationInfoDeviationAnalysis.setUpdateDate(new Date());
            wdApplicationInfoDeviationAnalysisService.updateByPrimaryKeySelective(wdApplicationInfoDeviationAnalysis);
        }
        return new JsonResult();
    }

    /**
     * 导入Excel数据 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:survey")
    @RequestMapping(value = { "implExcel" })
    public String implExcel(Model model, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        model.addAttribute("wdApplication", wdApplication);
        return "modules/wd/application/survey/implExcel";
    }

    @RequestMapping(value = "/implExcelFile", params = "method=uploadAjax")
    @ResponseBody
    @Transactional
    @RequiresPermissions("wd:application:survey")
    public JsonResult excelFile(@RequestParam MultipartFile excelFile, HttpServletRequest request, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);

        String fileName = excelFile.getOriginalFilename();
        String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());

        if (!(fileType.equals(".xlsx") || fileType.equals(".xls"))) {
            return new JsonResult(false, "上传的文件不是Excel文件");
        }

        List<Map<String, Object>> errorList = new ArrayList<Map<String, Object>>();
        Map<String, Object> map;

        Workbook workbook = null;
        try {
            workbook = WorkbookFactory.create(excelFile.getInputStream());
        } catch (EncryptedDocumentException | InvalidFormatException | IOException e) {
            LOGGER.error("上传excel", e);
            return new JsonResult(false, "当前模板不是最新，请下载最新的调查模板");
        }
        Sheet sheetVersion = workbook.getSheet(SheetConstant.SHEET_VERSION);

        if (null == sheetVersion || null == sheetVersion.getRow(0).getCell(0)) {
            LOGGER.info("当前模板不是最新，请下载最新的调查模板");
            return new JsonResult(false, "当前模板不是最新，请下载最新的调查模板");
        }

        // 版本号
        BigDecimal version = ExcelUtils.stringToBig(ExcelUtils.getValue(sheetVersion.getRow(0).getCell(0)));
        if (!BigDecimal.valueOf(3.0).equals(version)) {
            LOGGER.info("当前模板不是最新，请下载最新的调查模板");
            return new JsonResult(false, "当前模板不是最新，请下载最新的调查模板");
        }

        // 4-应收账款
        Sheet sheet4 = workbook.getSheet(SheetConstant.SHEET_5);
        for (int rowNumber = 3; rowNumber <= sheet4.getLastRowNum(); rowNumber++) {
            map = new HashMap<String, Object>();
            try {
                Row row4 = sheet4.getRow(rowNumber);
                if (row4 == null) {
                    continue;
                }
                if (StringUtils.isNotBlank(ExcelUtils.getValue(row4.getCell(0)))) {
                    WdApplicationOutstandingAccountDetail appAccountsReceivable = new WdApplicationOutstandingAccountDetail();
                    appAccountsReceivable.setApplicationId(applicationId);
                    appAccountsReceivable.setSort(rowNumber);
                    appAccountsReceivable.setCategory("1");
                    appAccountsReceivable.setCustomerName(ExcelUtils.getValue(row4.getCell(0)));
                    appAccountsReceivable.setProportion(ExcelUtils.stringToBig(ExcelUtils.getValue(row4.getCell(1))));
                    appAccountsReceivable.setAmount(ExcelUtils.stringToBig(ExcelUtils.getValue(row4.getCell(2))));
                    appAccountsReceivable.setTransactionContent(ExcelUtils.getValue(row4.getCell(3)));
                    appAccountsReceivable.setDiesCedin(ExcelUtils.getValue(row4.getCell(4)));
                    appAccountsReceivable.setDealings(ExcelUtils.getValue(row4.getCell(6)));
                    appAccountsReceivable.setUsualTurnover(ExcelUtils.stringToBig(ExcelUtils.getValue(row4.getCell(7))));
                    appAccountsReceivable.setLastMonthTurnover(ExcelUtils.stringToBig(ExcelUtils.getValue(row4.getCell(8))));
                    appAccountsReceivable.setSettlementPlan(ExcelUtils.getValue(row4.getCell(9)));
                    appAccountsReceivable.setSettlementPredict(ExcelUtils.getValue(row4.getCell(10)));
                    appAccountsReceivable.setRemarks(ExcelUtils.getValue(row4.getCell(11)));
                    appAccountsReceivable.setId(UidUtil.uuid());
                    appAccountsReceivable.setCreateBy(UserUtils.getUser().getId());
                    appAccountsReceivable.setCreateDate(new Date());
                    appAccountsReceivable.setUpdateBy(UserUtils.getUser().getId());
                    appAccountsReceivable.setUpdateDate(new Date());
                    wdApplicationOutstandingAccountDetailService.insertSelective(appAccountsReceivable);
                } else {
                    map.put("sheet", sheet4.getSheetName());
                    map.put("rowNum", rowNumber);
                    map.put("error", "信息不全");
                    errorList.add(map);
                }
            } catch (Exception e) {
                map.put("sheet", sheet4.getSheetName());
                map.put("rowNum", rowNumber);
                map.put("error", e.getMessage());
                errorList.add(map);
            }
        }

        // 5-预付账款
        Sheet sheet5 = workbook.getSheet(SheetConstant.SHEET_6);
        for (int rowNumber = 2; rowNumber <= sheet5.getLastRowNum(); rowNumber++) {
            map = new HashMap<String, Object>();
            try {
                Row row5 = sheet5.getRow(rowNumber);
                if (row5 == null) {
                    continue;
                }
                if (StringUtils.isNotBlank(ExcelUtils.getValue(row5.getCell(0)))) {
                    WdApplicationOutstandingAccountDetail appAccountsReceivable = new WdApplicationOutstandingAccountDetail();
                    appAccountsReceivable.setApplicationId(applicationId);
                    appAccountsReceivable.setSort(rowNumber);
                    appAccountsReceivable.setCategory("2");
                    appAccountsReceivable.setCustomerName(ExcelUtils.getValue(row5.getCell(0)));
                    appAccountsReceivable.setProportion(ExcelUtils.stringToBig(ExcelUtils.getValue(row5.getCell(1))));
                    appAccountsReceivable.setAmount(ExcelUtils.stringToBig(ExcelUtils.getValue(row5.getCell(2))));
                    appAccountsReceivable.setTransactionContent(ExcelUtils.getValue(row5.getCell(3)));
                    appAccountsReceivable.setDiesCedin(ExcelUtils.getValue(row5.getCell(4)));
                    appAccountsReceivable.setDealings(ExcelUtils.getValue(row5.getCell(6)));
                    appAccountsReceivable.setUsualTurnover(ExcelUtils.stringToBig(ExcelUtils.getValue(row5.getCell(7))));
                    appAccountsReceivable.setLastMonthTurnover(ExcelUtils.stringToBig(ExcelUtils.getValue(row5.getCell(8))));
                    appAccountsReceivable.setSettlementPlan(ExcelUtils.getValue(row5.getCell(9)));
                    appAccountsReceivable.setSettlementPredict(ExcelUtils.getValue(row5.getCell(10)));
                    appAccountsReceivable.setRemarks(ExcelUtils.getValue(row5.getCell(11)));
                    appAccountsReceivable.setId(UidUtil.uuid());
                    appAccountsReceivable.setCreateBy(UserUtils.getUser().getId());
                    appAccountsReceivable.setCreateDate(new Date());
                    appAccountsReceivable.setUpdateBy(UserUtils.getUser().getId());
                    appAccountsReceivable.setUpdateDate(new Date());
                    wdApplicationOutstandingAccountDetailService.insertSelective(appAccountsReceivable);
                } else {
                    map.put("sheet", sheet5.getSheetName());
                    map.put("rowNum", rowNumber);
                    map.put("error", "信息不全");
                    errorList.add(map);
                }
            } catch (Exception e) {
                map.put("sheet", sheet5.getSheetName());
                map.put("rowNum", rowNumber);
                map.put("error", e.getMessage());
                errorList.add(map);
            }
        }

        // 6-存货
        Sheet sheet6 = workbook.getSheet(SheetConstant.SHEET_7);
        for (int rowNumber = 3; rowNumber <= sheet6.getLastRowNum(); rowNumber++) {
            map = new HashMap<String, Object>();
            try {
                Row row6 = sheet6.getRow(rowNumber);
                if (row6 == null) {
                    continue;
                }
                WdApplicationGoods wdApplicationGoods = new WdApplicationGoods();
                if (StringUtils.isNotBlank(ExcelUtils.getValue(row6.getCell(0))) || StringUtils.isNotBlank(ExcelUtils.getValue(row6.getCell(1))) || StringUtils.isNotBlank(ExcelUtils.getValue(row6.getCell(5)))) {
                    wdApplicationGoods.setApplicationId(applicationId);
                    wdApplicationGoods.setExcOrder(rowNumber);
                    wdApplicationGoods.setGoodsAddress(ExcelUtils.getValue(row6.getCell(0)));
                    wdApplicationGoods.setType(ExcelUtils.getValue(row6.getCell(1)));
                    wdApplicationGoods.setName(ExcelUtils.getValue(row6.getCell(2)));
                    wdApplicationGoods.setProportion(ExcelUtils.getValue(row6.getCell(3)));
                    wdApplicationGoods.setPrice(ExcelUtils.stringToBig(ExcelUtils.getValue(row6.getCell(4))));
                    wdApplicationGoods.setNumber(ExcelUtils.stringToDouble(ExcelUtils.getValue(row6.getCell(5))).intValue());
                    wdApplicationGoods.setUnits(ExcelUtils.getValue(row6.getCell(6)));
                    wdApplicationGoods.setBuyPrice(ExcelUtils.stringToBig(ExcelUtils.getValue(row6.getCell(7))));
                    wdApplicationGoods.setSellingPrice(ExcelUtils.stringToBig(ExcelUtils.getValue(row6.getCell(8))));
                    wdApplicationGoods.setRate(ExcelUtils.getValue(row6.getCell(9)));
                    wdApplicationGoods.setMemo(ExcelUtils.getValue(row6.getCell(10)));
                    wdApplicationGoods.setId(UidUtil.uuid());
                    wdApplicationGoods.setCreateBy(UserUtils.getUser().getId());
                    wdApplicationGoods.setCreateDate(new Date());
                    wdApplicationGoods.setUpdateBy(UserUtils.getUser().getId());
                    wdApplicationGoods.setUpdateDate(new Date());
                    wdApplicationGoodsService.insertSelective(wdApplicationGoods);
                } else {
                    map.put("sheet", sheet6.getSheetName());
                    map.put("rowNum", rowNumber);
                    map.put("error", "信息不全");
                    errorList.add(map);
                }
            } catch (Exception e) {
                map.put("sheet", sheet6.getSheetName());
                map.put("rowNum", rowNumber);
                map.put("error", e.getMessage());
                errorList.add(map);
            }
        }

        // 7-固定资产
        Sheet sheet7 = workbook.getSheet(SheetConstant.SHEET_8);
        for (int rowNumber = 3; rowNumber <= sheet7.getLastRowNum(); rowNumber++) {
            map = new HashMap<String, Object>();
            try {
                Row row7 = sheet7.getRow(rowNumber);
                if (row7 == null) {
                    continue;
                }
                WdApplicationFixAssets wdApplicationFixAssets = new WdApplicationFixAssets();
                if (StringUtils.isNotBlank(ExcelUtils.getValue(row7.getCell(0)))) {
                    wdApplicationFixAssets.setApplicationId(applicationId);
                    wdApplicationFixAssets.setExcOrder(rowNumber);
                    wdApplicationFixAssets.setAssetsName(ExcelUtils.getValue(row7.getCell(0)));
                    wdApplicationFixAssets.setBuyDate(ExcelUtils.removePoint(ExcelUtils.getValue(row7.getCell(1))));
                    wdApplicationFixAssets.setCost(ExcelUtils.stringToBig(ExcelUtils.getValue(row7.getCell(2))));
                    wdApplicationFixAssets.setNowPrice(ExcelUtils.stringToBig(ExcelUtils.getValue(row7.getCell(3))));
                    wdApplicationFixAssets.setRate(ExcelUtils.stringToBig(ExcelUtils.getValue(row7.getCell(4))));
                    wdApplicationFixAssets.setPoorPrice(ExcelUtils.stringToBig(ExcelUtils.getValue(row7.getCell(5))));
                    wdApplicationFixAssets.setMemo(ExcelUtils.getValue(row7.getCell(6)));
                    wdApplicationFixAssets.setId(UidUtil.uuid());
                    wdApplicationFixAssets.setCreateBy(UserUtils.getUser().getId());
                    wdApplicationFixAssets.setCreateDate(new Date());
                    wdApplicationFixAssets.setUpdateBy(UserUtils.getUser().getId());
                    wdApplicationFixAssets.setUpdateDate(new Date());
                    wdApplicationFixAssetsService.insertSelective(wdApplicationFixAssets);
                }
            } catch (Exception e) {
                map.put("sheet", sheet7.getSheetName());
                map.put("rowNum", rowNumber);
                map.put("error", e.getMessage());
                errorList.add(map);
            }
        }

        // 8-毛利检测
        Sheet sheet8 = workbook.getSheet(SheetConstant.SHEET_9);
        for (int rowNumber = 2; rowNumber <= 4; rowNumber++) {
            map = new HashMap<String, Object>();
            try {
                Row row8 = sheet8.getRow(rowNumber);
                if (row8 == null || null == ExcelUtils.getValue(row8.getCell(0))) {
                    continue;
                } else {
                    if (StringUtils.isNotEmpty(ExcelUtils.getValue(row8.getCell(4)))) {
                        WdApplicationProfit appSurveyProfit = new WdApplicationProfit();
                        appSurveyProfit.setExcOrder(rowNumber);
                        appSurveyProfit.setProduct(ExcelUtils.getValue(row8.getCell(0)));
                        appSurveyProfit.setProfitsRate(ExcelUtils.stringToBig(ExcelUtils.getValue(row8.getCell(1))));
                        appSurveyProfit.setExpectedRate(ExcelUtils.stringToBig(ExcelUtils.getValue(row8.getCell(2))));
                        appSurveyProfit.setDeviationRate(ExcelUtils.stringToBig(ExcelUtils.getValue(row8.getCell(3))));
                        appSurveyProfit.setCautiousRate(ExcelUtils.stringToBig(ExcelUtils.getValue(row8.getCell(4))));
                        appSurveyProfit.setId(UidUtil.uuid());
                        appSurveyProfit.setApplicationId(applicationId);
                        appSurveyProfit.setCreateBy(UserUtils.getUser().getId());
                        appSurveyProfit.setCreateDate(new Date());
                        appSurveyProfit.setUpdateBy(UserUtils.getUser().getId());
                        appSurveyProfit.setUpdateDate(new Date());
                        wdApplicationProfitService.insertSelective(appSurveyProfit);
                    }
                }
            } catch (Exception e) {
                map.put("sheet", sheet8.getSheetName());
                map.put("rowNum", rowNumber);
                map.put("error", e.getMessage());
                errorList.add(map);
            }
        }

        // 9-损益表
        Sheet sheet9 = workbook.getSheet(SheetConstant.SHEET_10);

        WdApplicationBusinessIncomeStatement wdApplicationBusinessIncomeStatement = new WdApplicationBusinessIncomeStatement();
        wdApplicationBusinessIncomeStatement.setApplicationId(applicationId);
        wdApplicationBusinessIncomeStatement.setId(UidUtil.uuid());
        wdApplicationBusinessIncomeStatement.setCreateBy(UserUtils.getUser().getId());
        wdApplicationBusinessIncomeStatement.setCreateDate(new Date());
        wdApplicationBusinessIncomeStatement.setUpdateBy(UserUtils.getUser().getId());
        wdApplicationBusinessIncomeStatement.setUpdateDate(new Date());
        // 收入
        wdApplicationBusinessIncomeStatement.setIncome0Text(ExcelUtils.getValue(sheet9.getRow(2).getCell(4)));
        wdApplicationBusinessIncomeStatement.setIncome1Text(ExcelUtils.getValue(sheet9.getRow(3).getCell(4)));
        wdApplicationBusinessIncomeStatement.setIncome2Text(ExcelUtils.getValue(sheet9.getRow(4).getCell(4)));
        // 可变成本
        wdApplicationBusinessIncomeStatement.setVariableCost0Text(ExcelUtils.getValue(sheet9.getRow(6).getCell(4)));
        wdApplicationBusinessIncomeStatement.setVariableCost1Text(ExcelUtils.getValue(sheet9.getRow(7).getCell(4)));
        wdApplicationBusinessIncomeStatement.setVariableCost2Text(ExcelUtils.getValue(sheet9.getRow(8).getCell(4)));
        // 固定支出
        wdApplicationBusinessIncomeStatement.setFixedCharge0Text(ExcelUtils.getValue(sheet9.getRow(11).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge1Text(ExcelUtils.getValue(sheet9.getRow(12).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge2Text(ExcelUtils.getValue(sheet9.getRow(13).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge3Text(ExcelUtils.getValue(sheet9.getRow(14).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge4Text(ExcelUtils.getValue(sheet9.getRow(15).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge5Text(ExcelUtils.getValue(sheet9.getRow(16).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge6Text(ExcelUtils.getValue(sheet9.getRow(17).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge7Text(ExcelUtils.getValue(sheet9.getRow(18).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge8Text(ExcelUtils.getValue(sheet9.getRow(19).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedCharge9Text(ExcelUtils.getValue(sheet9.getRow(20).getCell(4)));
        wdApplicationBusinessIncomeStatement.setFixedChargeAText(ExcelUtils.getValue(sheet9.getRow(21).getCell(4)));
        // 其他
        wdApplicationBusinessIncomeStatement.setOtherCharge0Text(ExcelUtils.getValue(sheet9.getRow(26).getCell(4)));
        wdApplicationBusinessIncomeStatement.setOtherCharge1Text(ExcelUtils.getValue(sheet9.getRow(27).getCell(4)));
        wdApplicationBusinessIncomeStatement.setOtherCharge2Text(ExcelUtils.getValue(sheet9.getRow(28).getCell(4)));
        wdApplicationBusinessIncomeStatement.setOtherIncome0Text(ExcelUtils.getValue(sheet9.getRow(29).getCell(4)));

        // 收入
        wdApplicationBusinessIncomeStatement.setIncome0Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(2).getCell(17))));
        wdApplicationBusinessIncomeStatement.setIncome1Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(3).getCell(17))));
        wdApplicationBusinessIncomeStatement.setIncome2Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(4).getCell(17))));
        wdApplicationBusinessIncomeStatement.setIncomeTotal(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(5).getCell(17))));
        BigDecimal incomeMonth = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(5).getCell(18)));

        // 可变成本
        wdApplicationBusinessIncomeStatement.setVariableCost0Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(6).getCell(17))));
        wdApplicationBusinessIncomeStatement.setVariableCost1Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(7).getCell(17))));
        wdApplicationBusinessIncomeStatement.setVariableCost2Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(8).getCell(17))));
        wdApplicationBusinessIncomeStatement.setVariableCostTotal(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(9).getCell(17))));
        // 毛利润 (3)=(1)-(2)
        wdApplicationBusinessIncomeStatement.setGrossProfit(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(10).getCell(17))));
        // 固定支出
        wdApplicationBusinessIncomeStatement.setFixedCharge0Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(11).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge1Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(12).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge2Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(13).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge3Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(14).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge4Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(15).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge5Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(16).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge6Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(17).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge7Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(18).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge8Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(19).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedCharge9Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(20).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedChargeATotal(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(21).getCell(17))));
        wdApplicationBusinessIncomeStatement.setFixedChargeTotal(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(22).getCell(17))));
        // 税前利润 (5)=(3)-(4)
        wdApplicationBusinessIncomeStatement.setPretaxProfit(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(23).getCell(17))));
        // 所得税 (6)
        wdApplicationBusinessIncomeStatement.setIncomeTax(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(24).getCell(17))));
        // 净利润 (7)=(5)-(6)
        wdApplicationBusinessIncomeStatement.setNetProfit(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(25).getCell(17))));

        // 其他
        wdApplicationBusinessIncomeStatement.setOtherCharge0Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(26).getCell(17))));
        
        BigDecimal familyChargeMonth = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(26).getCell(18)));
        wdApplicationBusinessIncomeStatement.setOtherCharge1Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(27).getCell(17))));
        wdApplicationBusinessIncomeStatement.setOtherCharge2Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(28).getCell(17))));
        wdApplicationBusinessIncomeStatement.setOtherIncome0Total(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(29).getCell(17))));
        // 月可支配资金
        wdApplicationBusinessIncomeStatement.setSpendableIncome(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(30).getCell(17))));
        BigDecimal spendableIncomeAvg = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(30).getCell(18)));
                
        // 其它影响现金流的因素
        wdApplicationBusinessIncomeStatement.setRemarks(ExcelUtils.getValue(sheet9.getRow(31).getCell(17)));
        // 营页总额
        wdApplicationBusinessIncomeStatement.setTurnoverTotal(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(32).getCell(17))));

        int countMonth = 0; // 统计总月数
        // 前12个月数据
        for (int cellNumber = 5; cellNumber < 20; cellNumber++) {
            WdApplicationBusinessIncomeStatementDetails wdApplicationBusinessIncomeStatementDetails = new WdApplicationBusinessIncomeStatementDetails();
            wdApplicationBusinessIncomeStatementDetails.setApplicationId(applicationId);
            wdApplicationBusinessIncomeStatementDetails.setId(UidUtil.uuid());
            wdApplicationBusinessIncomeStatementDetails.setCreateBy(UserUtils.getUser().getId());
            wdApplicationBusinessIncomeStatementDetails.setCreateDate(new Date());
            wdApplicationBusinessIncomeStatementDetails.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationBusinessIncomeStatementDetails.setUpdateDate(new Date());
            wdApplicationBusinessIncomeStatementDetails.setSort(cellNumber - 1);
            wdApplicationBusinessIncomeStatementDetails.setBusinessIncomeStatementId(wdApplicationBusinessIncomeStatement.getId());
            if (StringUtils.isNotEmpty(ExcelUtils.getValue(sheet9.getRow(1).getCell(cellNumber)))) {
                countMonth += 1;
                wdApplicationBusinessIncomeStatementDetails.setPointMonth(ExcelUtils.getValue(sheet9.getRow(1).getCell(cellNumber)));
            }

            // 收入
            wdApplicationBusinessIncomeStatementDetails.setIncome0Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(2).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setIncome1Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(3).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setIncome2Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(4).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setIncomeSum(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(5).getCell(cellNumber))));
            // 可变成本
            wdApplicationBusinessIncomeStatementDetails.setVariableCost0Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(6).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setVariableCost1Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(7).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setVariableCost2Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(8).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setVariableCostSum(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(9).getCell(cellNumber))));
            // 毛利润 (3)=(1)-(2)
            wdApplicationBusinessIncomeStatementDetails.setGrossProfit(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(10).getCell(cellNumber))));
            // 固定支出
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge0Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(11).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge1Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(12).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge2Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(13).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge3Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(14).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge4Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(15).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge5Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(16).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge6Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(17).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge7Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(18).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge8Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(19).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedCharge9Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(20).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedChargeAAmount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(21).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setFixedChargeSum(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(22).getCell(cellNumber))));
            // 税前利润 (5)=(3)-(4)
            wdApplicationBusinessIncomeStatementDetails.setPretaxProfit(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(23).getCell(cellNumber))));
            // 所得税 (6)
            wdApplicationBusinessIncomeStatementDetails.setIncomeTax(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(24).getCell(cellNumber))));
            // 净利润 (7)=(5)-(6)
            wdApplicationBusinessIncomeStatementDetails.setNetProfit(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(25).getCell(cellNumber))));

            // 其他
            wdApplicationBusinessIncomeStatementDetails.setOtherCharge0Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(26).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setOtherCharge1Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(27).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setOtherCharge2Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(28).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetails.setOtherIncome0Amount(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(29).getCell(cellNumber))));
            // 月可支配资金
            wdApplicationBusinessIncomeStatementDetails.setSpendableIncome(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(30).getCell(cellNumber))));
            // 其它影响现金流的因素
            wdApplicationBusinessIncomeStatementDetails.setRemarks(ExcelUtils.getValue(sheet9.getRow(31).getCell(cellNumber)));
            // 营业额
            wdApplicationBusinessIncomeStatementDetails.setTurnover(ExcelUtils.stringToBig(ExcelUtils.getValue(sheet9.getRow(32).getCell(cellNumber))));
            wdApplicationBusinessIncomeStatementDetailsService.insertSelective(wdApplicationBusinessIncomeStatementDetails);
        }
        wdApplicationBusinessIncomeStatement.setCountMonth(countMonth);
        wdApplicationBusinessIncomeStatementService.insertSelective(wdApplicationBusinessIncomeStatement);

        // 10-逻辑检测
        Sheet sheet10 = workbook.getSheet(SheetConstant.SHEET_11);
        Row row10;
        try {
            // 净利检验
            row10 = sheet10.getRow(2);
            WdApplicationNetProfitLogic wdApplicationNetProfitLogic = new WdApplicationNetProfitLogic();
            wdApplicationNetProfitLogic.setApplicationId(applicationId);
            wdApplicationNetProfitLogic.setNetIncomeValue(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
            wdApplicationNetProfitLogic.setNetIncome(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
            wdApplicationNetProfitLogic.setNetIncomeDeviationRate(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));
            wdApplicationNetProfitLogic.setCreateBy(UserUtils.getUser().getId());
            wdApplicationNetProfitLogic.setCreateDate(new Date());
            wdApplicationNetProfitLogic.setId(UidUtil.uuid());
            wdApplicationNetProfitLogicService.insertSelective(wdApplicationNetProfitLogic);
            
            // 产品检验1
            WdApplicationProfitLogic wdApplicationProfitLogic1 = new WdApplicationProfitLogic();
            row10 = sheet10.getRow(4);
            wdApplicationProfitLogic1.setProductCheckName(ExcelUtils.getValue(row10.getCell(0)));
            row10 = sheet10.getRow(6);
            wdApplicationProfitLogic1.setId(UidUtil.uuid());
            wdApplicationProfitLogic1.setExcOrder(1);
            wdApplicationProfitLogic1.setCreateBy(UserUtils.getUser().getId());
            wdApplicationProfitLogic1.setCreateDate(new Date());
            wdApplicationProfitLogic1.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationProfitLogic1.setUpdateDate(new Date());
            wdApplicationProfitLogic1.setApplicationId(applicationId);
            
            wdApplicationProfitLogic1.setTurnoverCheck1Text(ExcelUtils.getValue(row10.getCell(0)));
            wdApplicationProfitLogic1.setTurnoverCheck1Memo(ExcelUtils.getValue(row10.getCell(1)));
            row10 = sheet10.getRow(7);
            if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                wdApplicationProfitLogic1.setTurnoverCheck1Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
            }
            wdApplicationProfitLogic1.setAnnualTurnover1(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
            wdApplicationProfitLogic1.setTurnover1(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
            wdApplicationProfitLogic1.setDeviationRate1(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));

            row10 = sheet10.getRow(9);
            wdApplicationProfitLogic1.setTurnoverCheck2Text(ExcelUtils.getValue(row10.getCell(0)));
            wdApplicationProfitLogic1.setTurnoverCheck2Memo(ExcelUtils.getValue(row10.getCell(1)));
            row10 = sheet10.getRow(10);
            if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                wdApplicationProfitLogic1.setTurnoverCheck2Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
            }
            wdApplicationProfitLogic1.setAnnualTurnover2(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
            wdApplicationProfitLogic1.setTurnover2(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
            wdApplicationProfitLogic1.setDeviationRate2(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));

            row10 = sheet10.getRow(12);
            wdApplicationProfitLogic1.setTurnoverCheck3Text(ExcelUtils.getValue(row10.getCell(0)));
            wdApplicationProfitLogic1.setTurnoverCheck3Memo(ExcelUtils.getValue(row10.getCell(1)));
            row10 = sheet10.getRow(13);
            if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                wdApplicationProfitLogic1.setTurnoverCheck3Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
            }
            wdApplicationProfitLogic1.setAnnualTurnover3(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
            wdApplicationProfitLogic1.setTurnover3(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
            wdApplicationProfitLogic1.setDeviationRate3(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));
            wdApplicationProfitLogicService.insertSelective(wdApplicationProfitLogic1);
            
            if (StringUtils.isNoneEmpty(ExcelUtils.getValue(sheet10.getRow(17).getCell(0)))) {
             // 产品检验2
                WdApplicationProfitLogic wdApplicationProfitLogic2 = new WdApplicationProfitLogic();
                row10 = sheet10.getRow(15);
                wdApplicationProfitLogic2.setProductCheckName(ExcelUtils.getValue(row10.getCell(0)));
                row10 = sheet10.getRow(17);
                wdApplicationProfitLogic2.setId(UidUtil.uuid());
                wdApplicationProfitLogic1.setExcOrder(2);
                wdApplicationProfitLogic2.setCreateBy(UserUtils.getUser().getId());
                wdApplicationProfitLogic2.setCreateDate(new Date());
                wdApplicationProfitLogic2.setUpdateBy(UserUtils.getUser().getId());
                wdApplicationProfitLogic2.setUpdateDate(new Date());
                wdApplicationProfitLogic2.setApplicationId(applicationId);
                
                wdApplicationProfitLogic2.setTurnoverCheck1Text(ExcelUtils.getValue(row10.getCell(0)));
                wdApplicationProfitLogic2.setTurnoverCheck1Memo(ExcelUtils.getValue(row10.getCell(1)));
                row10 = sheet10.getRow(18);
                if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                    wdApplicationProfitLogic2.setTurnoverCheck1Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
                }
                wdApplicationProfitLogic2.setAnnualTurnover1(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
                wdApplicationProfitLogic2.setTurnover1(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
                wdApplicationProfitLogic2.setDeviationRate1(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));

                row10 = sheet10.getRow(20);
                wdApplicationProfitLogic2.setTurnoverCheck2Text(ExcelUtils.getValue(row10.getCell(0)));
                wdApplicationProfitLogic2.setTurnoverCheck2Memo(ExcelUtils.getValue(row10.getCell(1)));
                row10 = sheet10.getRow(21);
                if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                    wdApplicationProfitLogic2.setTurnoverCheck2Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
                }
                wdApplicationProfitLogic2.setAnnualTurnover2(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
                wdApplicationProfitLogic2.setTurnover2(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
                wdApplicationProfitLogic2.setDeviationRate2(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));

                row10 = sheet10.getRow(23);
                wdApplicationProfitLogic2.setTurnoverCheck3Text(ExcelUtils.getValue(row10.getCell(0)));
                wdApplicationProfitLogic2.setTurnoverCheck3Memo(ExcelUtils.getValue(row10.getCell(1)));
                row10 = sheet10.getRow(24);
                if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                    wdApplicationProfitLogic2.setTurnoverCheck3Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
                }
                wdApplicationProfitLogic2.setAnnualTurnover3(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
                wdApplicationProfitLogic2.setTurnover3(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
                wdApplicationProfitLogic2.setDeviationRate3(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));
                wdApplicationProfitLogicService.insertSelective(wdApplicationProfitLogic2);
            }
            
            if (StringUtils.isNoneEmpty(ExcelUtils.getValue(sheet10.getRow(28).getCell(0)))) {
                // 产品检验3
                WdApplicationProfitLogic wdApplicationProfitLogic3 = new WdApplicationProfitLogic();
                row10 = sheet10.getRow(26);
                wdApplicationProfitLogic3.setProductCheckName(ExcelUtils.getValue(row10.getCell(0)));
                row10 = sheet10.getRow(28);
                wdApplicationProfitLogic3.setId(UidUtil.uuid());
                wdApplicationProfitLogic1.setExcOrder(3);
                wdApplicationProfitLogic3.setCreateBy(UserUtils.getUser().getId());
                wdApplicationProfitLogic3.setCreateDate(new Date());
                wdApplicationProfitLogic3.setUpdateBy(UserUtils.getUser().getId());
                wdApplicationProfitLogic3.setUpdateDate(new Date());
                wdApplicationProfitLogic3.setApplicationId(applicationId);
                
                wdApplicationProfitLogic3.setTurnoverCheck1Text(ExcelUtils.getValue(row10.getCell(0)));
                wdApplicationProfitLogic3.setTurnoverCheck1Memo(ExcelUtils.getValue(row10.getCell(1)));
                row10 = sheet10.getRow(29);
                if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                    wdApplicationProfitLogic3.setTurnoverCheck1Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
                }
                wdApplicationProfitLogic3.setAnnualTurnover1(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
                wdApplicationProfitLogic3.setTurnover1(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
                wdApplicationProfitLogic3.setDeviationRate1(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));
    
                row10 = sheet10.getRow(31);
                wdApplicationProfitLogic3.setTurnoverCheck2Text(ExcelUtils.getValue(row10.getCell(0)));
                wdApplicationProfitLogic3.setTurnoverCheck2Memo(ExcelUtils.getValue(row10.getCell(1)));
                row10 = sheet10.getRow(32);
                if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                    wdApplicationProfitLogic3.setTurnoverCheck2Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
                }
                wdApplicationProfitLogic3.setAnnualTurnover2(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
                wdApplicationProfitLogic3.setTurnover2(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
                wdApplicationProfitLogic3.setDeviationRate2(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));
    
                row10 = sheet10.getRow(34);
                wdApplicationProfitLogic3.setTurnoverCheck3Text(ExcelUtils.getValue(row10.getCell(0)));
                wdApplicationProfitLogic3.setTurnoverCheck3Memo(ExcelUtils.getValue(row10.getCell(1)));
                row10 = sheet10.getRow(35);
                if (StringUtils.isNotEmpty(ExcelUtils.getValue(row10.getCell(0)))) {
                    wdApplicationProfitLogic3.setTurnoverCheck3Value(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(0))));
                }
                wdApplicationProfitLogic3.setAnnualTurnover3(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(1))));
                wdApplicationProfitLogic3.setTurnover3(ExcelUtils.stringToBig(ExcelUtils.getValue(row10.getCell(2))));
                wdApplicationProfitLogic3.setDeviationRate3(ExcelUtils.stringToFourBig(ExcelUtils.getValue(row10.getCell(3))));
                wdApplicationProfitLogicService.insertSelective(wdApplicationProfitLogic3);
            }
        } catch (Exception e) {
            map = new HashMap<String, Object>();
            map.put("sheet", sheet10.getSheetName());
            map.put("error", e.getMessage());
            errorList.add(map);
        }

        // 12-还款计划
        Sheet sheet12 = workbook.getSheet(SheetConstant.SHEET_12);
        Row row12;
        for (int rowNumber = 2; rowNumber <= sheet12.getLastRowNum(); rowNumber++) {
            map = new HashMap<String, Object>();
            try {
                row12 = sheet12.getRow(rowNumber);
                if (row12 == null) {
                    continue;
                }
                WdApplicationRefundPlan wdApplicationRefundPlan = new WdApplicationRefundPlan();
                if (StringUtils.isNotBlank(ExcelUtils.getValue(row12.getCell(0)))) {
                    wdApplicationRefundPlan.setExcOrder(rowNumber);
                    wdApplicationRefundPlan.setApplicationId(applicationId);
                    wdApplicationRefundPlan.setPeriods(ExcelUtils.removePoint(ExcelUtils.getValue(row12.getCell(0))));
                    wdApplicationRefundPlan.setMonthRefund(ExcelUtils.twoPoint(ExcelUtils.getValue(row12.getCell(1))));
                    wdApplicationRefundPlan.setCapital(ExcelUtils.twoPoint(ExcelUtils.getValue(row12.getCell(2))));
                    wdApplicationRefundPlan.setInterests(ExcelUtils.twoPoint(ExcelUtils.getValue(row12.getCell(3))));
                    wdApplicationRefundPlan.setBalance(ExcelUtils.twoPoint(ExcelUtils.getValue(row12.getCell(4))));
                    wdApplicationRefundPlan.setId(UidUtil.uuid());
                    wdApplicationRefundPlan.setCreateBy(UserUtils.getUser().getId());
                    wdApplicationRefundPlan.setCreateDate(new Date());
                    wdApplicationRefundPlan.setUpdateBy(UserUtils.getUser().getId());
                    wdApplicationRefundPlan.setUpdateDate(new Date());
                    wdApplicationRefundPlanService.insertSelective(wdApplicationRefundPlan);
                }
            } catch (Exception e) {
                map.put("sheet", sheet12.getSheetName());
                map.put("rowNum", rowNumber);
                map.put("error", e.getMessage());
                errorList.add(map);
            }
        }

        // 表格中需要取出的数据
        BigDecimal accountsReceivable = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet4.getRow(1).getCell(1))); // 应收帐款总额
        BigDecimal advanceTotal = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet5.getRow(1).getCell(1))); // 预付款总额
        BigDecimal goodsTotal = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet6.getRow(1).getCell(1))); // 存货合计
        BigDecimal goodsSaleTotal = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet6.getRow(1).getCell(3))); // 存货可销售金额
        BigDecimal fixAssetsTotal = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet7.getRow(1).getCell(1))); // 固定资产合计
        BigDecimal fixAssetsDeratingTotal = ExcelUtils.stringToBig(ExcelUtils.getValue(sheet7.getRow(1).getCell(3))); // 折旧总额
        WdApplicationOutstandingAccount wdApplicationOutstandingAccount = new WdApplicationOutstandingAccount();
        wdApplicationOutstandingAccount.setId(UidUtil.uuid());
        wdApplicationOutstandingAccount.setApplicationId(applicationId);
        wdApplicationOutstandingAccount.setCreateBy(UserUtils.getUser().getId());
        wdApplicationOutstandingAccount.setCreateDate(new Date());
        wdApplicationOutstandingAccount.setUpdateBy(UserUtils.getUser().getId());
        wdApplicationOutstandingAccount.setUpdateDate(new Date());
        wdApplicationOutstandingAccount.setAccountsReceivable(accountsReceivable);
        wdApplicationOutstandingAccount.setAdvancePayment(advanceTotal);
        wdApplicationOutstandingAccount.setGoodsTotal(goodsTotal);
        wdApplicationOutstandingAccount.setGoodsSaleTotal(goodsSaleTotal);
        wdApplicationOutstandingAccount.setFixAssetsTotal(fixAssetsTotal);
        wdApplicationOutstandingAccount.setFixAssetsDeratingTotal(fixAssetsDeratingTotal);
        wdApplicationOutstandingAccountService.insert(wdApplicationOutstandingAccount);

        // 重新计算资产负债、权益检查
        // 资产负债表本期信息
        WdApplicationOperatingBalanceSheetDetail wdApplicationOperatingBalanceSheetDetail = wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(applicationId, "1");
        wdApplicationOperatingBalanceSheetDetail.setReceivables(accountsReceivable);
        wdApplicationOperatingBalanceSheetDetail.setPrepayments(advanceTotal);
        wdApplicationOperatingBalanceSheetDetail.setStock(goodsTotal);
        wdApplicationOperatingBalanceSheetDetail.setFixedAsset(fixAssetsTotal);
      //  wdApplicationOperatingBalanceSheetDetail.setCreditCard(appCreditHistoryExt.getLoanedCredit());
      //  wdApplicationOperatingBalanceSheetDetail.setShortTermLoan(appCreditHistoryExt.getOtherLoanAmount());
        reComputeCurrentPeriodBalanceSheet(wdApplicationOperatingBalanceSheetDetail);
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheetDetail.getId())) {
            wdApplicationOperatingBalanceSheetDetail.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheetDetail.setApplicationId(applicationId);
            wdApplicationOperatingBalanceSheetDetail.setCategory("1"); // 本期
            wdApplicationOperatingBalanceSheetDetail.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetDetail.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheetDetail.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetDetail.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetDetailService.insertSelective(wdApplicationOperatingBalanceSheetDetail);
        } else {
            wdApplicationOperatingBalanceSheetDetail.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetDetail.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetDetailService.updateByPrimaryKey(wdApplicationOperatingBalanceSheetDetail);
        }

        // 资产负债信息
        WdApplicationOperatingBalanceSheet wdApplicationOperatingBalanceSheet = wdApplicationOperatingBalanceSheetService.selectByApplicationId(applicationId);
        BigDecimal receivablesVsTurnover = null; // 应收款与月平均营业额对比
        BigDecimal stockVsTurnover = null; // 存货可销售与月平均营业额对比
        BigDecimal equityVsExpense = null; // 借款人权限与借款人家庭开支（月）对比
        if (countMonth > 0) {
            wdApplicationOperatingBalanceSheet.setFamilyChargeMonth(familyChargeMonth == null ? BigDecimal.ZERO : familyChargeMonth);
            wdApplicationOperatingBalanceSheet.setIncomeMonth(incomeMonth == null ? BigDecimal.ZERO : incomeMonth);
            wdApplicationOperatingBalanceSheet.setSpendableIncomeAvg(spendableIncomeAvg == null ? BigDecimal.ZERO : spendableIncomeAvg); //Excel损益表!平均月可支

            accountsReceivable = accountsReceivable != null ? accountsReceivable : BigDecimal.ZERO;
            goodsSaleTotal = goodsSaleTotal != null ? goodsSaleTotal : BigDecimal.ZERO;
            BigDecimal equity = wdApplicationOperatingBalanceSheetDetail.getEquity() != null ? wdApplicationOperatingBalanceSheetDetail.getEquity() : BigDecimal.ZERO;
            try {
                receivablesVsTurnover = accountsReceivable.divide(incomeMonth, 10, BigDecimal.ROUND_HALF_DOWN);
            } catch (Exception e) {
                LOGGER.info("应收款与月平均营业额对比计算失败", e);
            }
            try {
                stockVsTurnover = goodsSaleTotal.divide(incomeMonth, 10, BigDecimal.ROUND_HALF_DOWN);
            } catch (Exception e) {
                LOGGER.info("存货可销售与月平均营业额对比计算失败", e);
            }
            try {
                equityVsExpense = equity.divide(familyChargeMonth, 10, BigDecimal.ROUND_HALF_DOWN);
            } catch (Exception e) {
                LOGGER.info("存货可销售与月平均营业额对比计算失败", e);
            }
        }
        wdApplicationOperatingBalanceSheet.setReceivablesVsTurnover(receivablesVsTurnover);
        wdApplicationOperatingBalanceSheet.setStockVsTurnover(stockVsTurnover);
        wdApplicationOperatingBalanceSheet.setEquityVsExpense(equityVsExpense);
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheet.getId())) {
            wdApplicationOperatingBalanceSheet.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheet.setApplicationId(applicationId);
            wdApplicationOperatingBalanceSheet.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheet.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetService.insertSelective(wdApplicationOperatingBalanceSheet);
        } else {
            wdApplicationOperatingBalanceSheet.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetService.updateByPrimaryKey(wdApplicationOperatingBalanceSheet);
        }

        // 权益检查表
        WdApplicationOperatingBalanceSheetCheck wdApplicationOperatingBalanceSheetCheck = wdApplicationOperatingBalanceSheetCheckService.selectByApplicationId(applicationId, null);
        wdApplicationOperatingBalanceSheetCheck.setApplicationId(applicationId);
        wdApplicationOperatingBalanceSheetCheck.setDeOrAppreciationAmount(fixAssetsDeratingTotal);
        wdApplicationOperatingBalanceSheetCheck.setSpendableIncomeAvg(wdApplicationOperatingBalanceSheet.getSpendableIncomeAvg());
        wdApplicationOperatingBalanceSheetCheck.setCurrentPeriodPointTime(wdApplicationOperatingBalanceSheetDetail.getPointTime());
        reComputeBalanceSheetCheck(wdApplicationOperatingBalanceSheetCheck);
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheetCheck.getId())) {
            wdApplicationOperatingBalanceSheetCheck.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheetCheck.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheetCheck.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetCheckService.insertSelective(wdApplicationOperatingBalanceSheetCheck);
        } else {
            wdApplicationOperatingBalanceSheetCheck.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetCheckService.updateByPrimaryKey(wdApplicationOperatingBalanceSheetCheck);
        }

        try {
            String fileId = dfsService.uploadFile(excelFile.getBytes(), fileName);
            wdApplication.setExcelFile(fileId);
            wdApplication.setUpdateDate(new Date());
            wdApplication.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationService.updateByPrimaryKeySelective(wdApplication);
        } catch (IOException e) {
            LOGGER.error("excel上传失败", e);
        }
        return new JsonResult(true);
    }

    /**
     * 重新计算资产负债本期信息 date: 2017年4月24日 下午2:04:13 <br/>
     * @author Liam
     * @param wdApplicationOperatingBalanceSheet
     * @since JDK 1.8
     */
    private void reComputeCurrentPeriodBalanceSheet(WdApplicationOperatingBalanceSheetDetail wdApplicationOperatingBalanceSheetDetail) {
        BigDecimal cash = wdApplicationOperatingBalanceSheetDetail.getCash() != null ? wdApplicationOperatingBalanceSheetDetail.getCash() : BigDecimal.ZERO; // 现金
        BigDecimal bankDeposit = wdApplicationOperatingBalanceSheetDetail.getBankDeposit() != null ? wdApplicationOperatingBalanceSheetDetail.getBankDeposit() : BigDecimal.ZERO; // 银行存款
        BigDecimal receivables = wdApplicationOperatingBalanceSheetDetail.getReceivables() != null ? wdApplicationOperatingBalanceSheetDetail.getReceivables() : BigDecimal.ZERO; // 应收款项
        BigDecimal prepayments = wdApplicationOperatingBalanceSheetDetail.getPrepayments() != null ? wdApplicationOperatingBalanceSheetDetail.getPrepayments() : BigDecimal.ZERO; // 预付款项
        BigDecimal stock = wdApplicationOperatingBalanceSheetDetail.getStock() != null ? wdApplicationOperatingBalanceSheetDetail.getStock() : BigDecimal.ZERO; // 存货
        BigDecimal totalCurrentAsset = cash.add(bankDeposit).add(receivables).add(prepayments).add(stock); // 流动资产总额
        BigDecimal fixedAsset = wdApplicationOperatingBalanceSheetDetail.getFixedAsset() != null ? wdApplicationOperatingBalanceSheetDetail.getFixedAsset() : BigDecimal.ZERO; // 固定资产
        BigDecimal rentSpread = wdApplicationOperatingBalanceSheetDetail.getRentSpread() != null ? wdApplicationOperatingBalanceSheetDetail.getRentSpread() : BigDecimal.ZERO; // 待摊租金
        BigDecimal otherOperatingAsset = wdApplicationOperatingBalanceSheetDetail.getOtherOperatingAsset() != null ? wdApplicationOperatingBalanceSheetDetail.getOtherOperatingAsset() : BigDecimal.ZERO; // 其它经营资产
        BigDecimal otherNonOperatingAsset = wdApplicationOperatingBalanceSheetDetail.getOtherNonOperatingAsset() != null ? wdApplicationOperatingBalanceSheetDetail.getOtherNonOperatingAsset() : BigDecimal.ZERO; // 其它非经营资产
        BigDecimal totalAssets = totalCurrentAsset.add(fixedAsset).add(rentSpread).add(otherOperatingAsset).add(otherNonOperatingAsset); // 总资产合计
        BigDecimal payables = wdApplicationOperatingBalanceSheetDetail.getPayables() != null ? wdApplicationOperatingBalanceSheetDetail.getPayables() : BigDecimal.ZERO; // 应付账款
        BigDecimal advancepay = wdApplicationOperatingBalanceSheetDetail.getAdvancepay() != null ? wdApplicationOperatingBalanceSheetDetail.getAdvancepay() : BigDecimal.ZERO; // 预收款项
        BigDecimal creditCard = wdApplicationOperatingBalanceSheetDetail.getCreditCard() != null ? wdApplicationOperatingBalanceSheetDetail.getCreditCard() : BigDecimal.ZERO; // 信用卡
        BigDecimal shortTermLoan = wdApplicationOperatingBalanceSheetDetail.getShortTermLoan() != null ? wdApplicationOperatingBalanceSheetDetail.getShortTermLoan() : BigDecimal.ZERO; // 短期贷款
        BigDecimal totalShortTermLiabilities = payables.add(advancepay).add(creditCard).add(shortTermLoan);
        BigDecimal totalLongTermLiabilities = wdApplicationOperatingBalanceSheetDetail.getTotalLongTermLiabilities() != null ? wdApplicationOperatingBalanceSheetDetail.getTotalLongTermLiabilities() : BigDecimal.ZERO; // 长期负债合计
        BigDecimal totalLiabilities = totalShortTermLiabilities.add(totalLongTermLiabilities); // 负债合计
        BigDecimal equity = totalAssets.subtract(totalLiabilities); // 权益
        wdApplicationOperatingBalanceSheetDetail.setTotalCurrentAsset(totalCurrentAsset);
        wdApplicationOperatingBalanceSheetDetail.setTotalAssets(totalAssets);
        wdApplicationOperatingBalanceSheetDetail.setTotalShortTermLiabilities(totalShortTermLiabilities);
        wdApplicationOperatingBalanceSheetDetail.setTotalLiabilities(totalLiabilities);
        wdApplicationOperatingBalanceSheetDetail.setEquity(equity);
    }

    private void reComputeBalanceSheetCheck(WdApplicationOperatingBalanceSheetCheck wdApplicationOperatingBalanceSheetCheck) {
        BigDecimal initialEquityAmount = wdApplicationOperatingBalanceSheetCheck.getInitialEquityAmount() != null ? wdApplicationOperatingBalanceSheetCheck.getInitialEquityAmount() : BigDecimal.ZERO; // 初始权益
        BigDecimal periodProfitAmount = wdApplicationOperatingBalanceSheetCheck.getPeriodProfitAmount() != null ? wdApplicationOperatingBalanceSheetCheck.getPeriodProfitAmount() : BigDecimal.ZERO; // 期间内的利润金额
        BigDecimal periodCapitalAmount = wdApplicationOperatingBalanceSheetCheck.getPeriodCapitalAmount() != null ? wdApplicationOperatingBalanceSheetCheck.getPeriodCapitalAmount() : BigDecimal.ZERO; // 期间内资本注入金额
        BigDecimal periodFundingAmount = wdApplicationOperatingBalanceSheetCheck.getPeriodFundingAmount() != null ? wdApplicationOperatingBalanceSheetCheck.getPeriodFundingAmount() : BigDecimal.ZERO; // 期内提取的资金金额
        BigDecimal deOrAppreciationAmount = wdApplicationOperatingBalanceSheetCheck.getDeOrAppreciationAmount() != null ? wdApplicationOperatingBalanceSheetCheck.getDeOrAppreciationAmount() : BigDecimal.ZERO; // 折旧/升值金额
        BigDecimal entitlement = initialEquityAmount.add(periodProfitAmount).add(periodCapitalAmount).subtract(periodFundingAmount).subtract(deOrAppreciationAmount); // 应有权益

        // 权益(资产负债表)
        WdApplicationOperatingBalanceSheetDetail wdApplicationOperatingBalanceSheetDetail = wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(wdApplicationOperatingBalanceSheetCheck.getApplicationId(), "1");
        BigDecimal equity = wdApplicationOperatingBalanceSheetDetail.getEquity() != null ? wdApplicationOperatingBalanceSheetDetail.getEquity() : BigDecimal.ZERO;
        BigDecimal sumOBSAsset = wdApplicationOperatingBalanceSheetAdditionalService.sumOBSAsset(wdApplicationOperatingBalanceSheetCheck.getApplicationId());
        BigDecimal sumOBSLiabilities = wdApplicationOperatingBalanceSheetAdditionalService.sumOBSLiabilities(wdApplicationOperatingBalanceSheetCheck.getApplicationId());
        sumOBSAsset = sumOBSAsset != null ? sumOBSAsset : BigDecimal.ZERO;
        sumOBSLiabilities = sumOBSLiabilities != null ? sumOBSLiabilities : BigDecimal.ZERO;
        BigDecimal deviationValue = entitlement.add(sumOBSLiabilities).subtract(sumOBSAsset).subtract(equity);
        
        BigDecimal spendableIncomeAvg = wdApplicationOperatingBalanceSheetCheck.getSpendableIncomeAvg() != null ? wdApplicationOperatingBalanceSheetCheck.getSpendableIncomeAvg() : BigDecimal.ZERO; // Excel损益表!平均月可支
        BigDecimal deviationRate = BigDecimal.ZERO; // 偏差率
        try {
            if (StringUtils.isNotEmpty(wdApplicationOperatingBalanceSheetCheck.getCheckPoint()) && StringUtils.isNotEmpty(wdApplicationOperatingBalanceSheetCheck.getCurrentPeriodPointTime())) {
                int months = DateUtils.monthsBetween(wdApplicationOperatingBalanceSheetCheck.getCheckPoint().substring(0, 7), wdApplicationOperatingBalanceSheetCheck.getCurrentPeriodPointTime().substring(0, 7));
                if (spendableIncomeAvg.compareTo(BigDecimal.ZERO) != 0 && months != 0) {
                    deviationRate = deviationValue.divide(spendableIncomeAvg, 10, BigDecimal.ROUND_HALF_DOWN).divide(new BigDecimal(months).abs(), 10, BigDecimal.ROUND_HALF_DOWN).multiply(BigDecimal.valueOf(100l));
                }
            }
        } catch (Exception e) {
            LOGGER.warn("偏差率计算失败", e);
        }
        wdApplicationOperatingBalanceSheetCheck.setEntitlement(entitlement);
        wdApplicationOperatingBalanceSheetCheck.setDeviationValue(deviationValue);
        wdApplicationOperatingBalanceSheetCheck.setDeviationRate(deviationRate);
    }

    @RequestMapping(value = { "delExcelFile" })
    @ResponseBody
    @Transactional
    @RequiresPermissions("wd:application:survey")
    public JsonResult delExcelFile(String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        // 删除征信历史数据
    //    wdApplicationCreditHistoryService.delByApplicationId(applicationId);
        // 删除子项
     //   wdApplicationCreditHistoryDetailService.delByApplicationId(applicationId);
        // 删除侧面调查
      //  wdApplicationIndirectInvestigationService.delByApplicationId(applicationId);
        // 删除所有账款
        wdApplicationOutstandingAccountService.delByApplicationId(applicationId);
        wdApplicationOutstandingAccountDetailService.delByApplicationId(applicationId);
        // 删除存货
        wdApplicationGoodsService.delByApplicationId(applicationId);
        // 删除固定资产
        wdApplicationFixAssetsService.delByApplicationId(applicationId);
        // 删除毛利检验
        wdApplicationProfitService.delByApplicationId(applicationId);
        // 删除损益表
        wdApplicationBusinessIncomeStatementService.delByApplicationId(applicationId);
        wdApplicationBusinessIncomeStatementDetailsService.delByApplicationId(applicationId);
        // 删除逻辑检验
        wdApplicationNetProfitLogicService.delByApplicationId(applicationId);
        wdApplicationProfitLogicService.delByApplicationId(applicationId);
        // 删除还款计划
        wdApplicationRefundPlanService.delByApplicationId(applicationId);

        // 重新计算资产负债、权益检查
        // 资产负债表本期信息
        WdApplicationOperatingBalanceSheetDetail wdApplicationOperatingBalanceSheetDetail = wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(applicationId, "1");
        wdApplicationOperatingBalanceSheetDetail.setReceivables(null);
        wdApplicationOperatingBalanceSheetDetail.setPrepayments(null);
        wdApplicationOperatingBalanceSheetDetail.setStock(null);
        wdApplicationOperatingBalanceSheetDetail.setFixedAsset(null);
        wdApplicationOperatingBalanceSheetDetail.setCreditCard(null);
        wdApplicationOperatingBalanceSheetDetail.setShortTermLoan(null);
        reComputeCurrentPeriodBalanceSheet(wdApplicationOperatingBalanceSheetDetail);
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheetDetail.getId())) {
            wdApplicationOperatingBalanceSheetDetail.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheetDetail.setApplicationId(applicationId);
            wdApplicationOperatingBalanceSheetDetail.setCategory("1");
            wdApplicationOperatingBalanceSheetDetail.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetDetail.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheetDetail.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetDetail.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetDetailService.insertSelective(wdApplicationOperatingBalanceSheetDetail);
        } else {
            wdApplicationOperatingBalanceSheetDetail.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetDetail.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetDetailService.updateByPrimaryKey(wdApplicationOperatingBalanceSheetDetail);
        }

        // 资产负债信息
        WdApplicationOperatingBalanceSheet wdApplicationOperatingBalanceSheet = wdApplicationOperatingBalanceSheetService.selectByApplicationId(applicationId);
        wdApplicationOperatingBalanceSheet.setFamilyChargeMonth(null);
        wdApplicationOperatingBalanceSheet.setIncomeMonth(null);
        wdApplicationOperatingBalanceSheet.setReceivablesVsTurnover(null);
        wdApplicationOperatingBalanceSheet.setStockVsTurnover(null);
        wdApplicationOperatingBalanceSheet.setEquityVsExpense(null);
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheet.getId())) {
            wdApplicationOperatingBalanceSheet.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheet.setApplicationId(applicationId);
            wdApplicationOperatingBalanceSheet.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheet.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetService.insertSelective(wdApplicationOperatingBalanceSheet);
        } else {
            wdApplicationOperatingBalanceSheet.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetService.updateByPrimaryKey(wdApplicationOperatingBalanceSheet);
        }

        // 权益检查表
        WdApplicationOperatingBalanceSheetCheck wdApplicationOperatingBalanceSheetCheck = wdApplicationOperatingBalanceSheetCheckService.selectByApplicationId(applicationId, null);
        wdApplicationOperatingBalanceSheetCheck.setDeOrAppreciationAmount(null);
        wdApplicationOperatingBalanceSheetCheck.setApplicationId(applicationId);
        wdApplicationOperatingBalanceSheetCheck.setSpendableIncomeAvg(wdApplicationOperatingBalanceSheet.getSpendableIncomeAvg());
        wdApplicationOperatingBalanceSheetCheck.setCurrentPeriodPointTime(wdApplicationOperatingBalanceSheetDetail.getPointTime());
        reComputeBalanceSheetCheck(wdApplicationOperatingBalanceSheetCheck);
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheetCheck.getId())) {
            wdApplicationOperatingBalanceSheetCheck.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheetCheck.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheetCheck.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetCheckService.insertSelective(wdApplicationOperatingBalanceSheetCheck);
        } else {
            wdApplicationOperatingBalanceSheetCheck.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetCheckService.updateByPrimaryKey(wdApplicationOperatingBalanceSheetCheck);
        }

        // 删除文件
        wdApplication.setExcelFile(null);
        wdApplication.setUpdateDate(new Date());
        wdApplication.setUpdateBy(UserUtils.getUser().getId());
        wdApplicationService.updateByPrimaryKey(wdApplication);
        return new JsonResult();
    }

    /**
     * 资产负债表 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequestMapping(value = { "assets" })
    @RequiresPermissions("wd:application:survey")
    public String assets(Model model, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        model.addAttribute("wdApplication", wdApplication);

        model.addAttribute("wdApplicationOperatingBalanceSheet", wdApplicationOperatingBalanceSheetService.selectByApplicationId(applicationId));
        // 本期
        model.addAttribute("currentPeriod", wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(applicationId, "1"));
        // 上期
        model.addAttribute("priorPeriod", wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(applicationId, "2"));
        // 资产
        model.addAttribute("assetAdditionals", wdApplicationOperatingBalanceSheetAdditionalService.selectByApplicationId(applicationId, "1"));
        // 负债
        model.addAttribute("debtsAdditionals", wdApplicationOperatingBalanceSheetAdditionalService.selectByApplicationId(applicationId, "2"));
        // 担保情况
        model.addAttribute("assureAdditionals", wdApplicationOperatingBalanceSheetAdditionalService.selectByApplicationId(applicationId, "3"));
        return "modules/wd/application/survey/assets";
    }
    
    @RequestMapping(value = { "getAssetsInfo" })
    @ResponseBody
    public JsonResult getAssetsInfo(String applicationId) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("creditCardUseInfoList", wdApplicationCreditHistoryService.selectByApplicationId(applicationId));
        resultMap.put("creditHistoryList", wdApplicationCreditHistoryDetailService.selectByApplicationId(applicationId));
        return new JsonResult(resultMap);
    }

    @RequestMapping(value = { "saveAssets" })
    @ResponseBody
    @Transactional
    @RequiresPermissions("wd:application:survey")
    public JsonResult saveAssets(String applicationId ,Model model, WdApplicationOperatingBalanceSheet wdApplicationOperatingBalanceSheet, String balanceSheetAdditionalData, String balanceSheetDetailData,
            String creditHistoryListData, String creditCardUseInfoListdata) {
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheet.getId())) {
            wdApplicationOperatingBalanceSheet.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheet.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheet.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetService.insertSelective(wdApplicationOperatingBalanceSheet);
        } else {
            wdApplicationOperatingBalanceSheet.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheet.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetService.updateByPrimaryKeySelective(wdApplicationOperatingBalanceSheet);
        }
        wdApplicationOperatingBalanceSheet = wdApplicationOperatingBalanceSheetService.selectByApplicationId(applicationId);

        wdApplicationOperatingBalanceSheetAdditionalService.delByApplicationId(wdApplicationOperatingBalanceSheet.getApplicationId());
        List<WdApplicationOperatingBalanceSheetAdditional> additionalDataList = JSON.parseArray(StringEscapeUtils.unescapeHtml4(balanceSheetAdditionalData), WdApplicationOperatingBalanceSheetAdditional.class);
        if (null != additionalDataList && !additionalDataList.isEmpty()) {
            for (WdApplicationOperatingBalanceSheetAdditional wdApplicationOperatingBalanceSheetAdditional : additionalDataList) {
                wdApplicationOperatingBalanceSheetAdditional.setId(UidUtil.uuid());
                wdApplicationOperatingBalanceSheetAdditional.setApplicationId(wdApplicationOperatingBalanceSheet.getApplicationId());
                wdApplicationOperatingBalanceSheetAdditional.setOperatingBalanceSheetId(wdApplicationOperatingBalanceSheet.getId());
                wdApplicationOperatingBalanceSheetAdditional.setCreateBy(UserUtils.getUser().getId());
                wdApplicationOperatingBalanceSheetAdditional.setCreateDate(new Date());
                wdApplicationOperatingBalanceSheetAdditional.setUpdateBy(UserUtils.getUser().getId());
                wdApplicationOperatingBalanceSheetAdditional.setUpdateDate(new Date());
                wdApplicationOperatingBalanceSheetAdditionalService.insertSelective(wdApplicationOperatingBalanceSheetAdditional);
            }
        }

        wdApplicationOperatingBalanceSheetDetailService.delByApplicationId(wdApplicationOperatingBalanceSheet.getApplicationId());
        List<WdApplicationOperatingBalanceSheetDetail> balanceSheetDetailDataList = JSON.parseArray(StringEscapeUtils.unescapeHtml4(balanceSheetDetailData), WdApplicationOperatingBalanceSheetDetail.class);
        if (null != balanceSheetDetailDataList && !balanceSheetDetailDataList.isEmpty()) {
            for (WdApplicationOperatingBalanceSheetDetail wdApplicationOperatingBalanceSheetDetail : balanceSheetDetailDataList) {
                wdApplicationOperatingBalanceSheetDetail.setId(UidUtil.uuid());
                wdApplicationOperatingBalanceSheetDetail.setApplicationId(wdApplicationOperatingBalanceSheet.getApplicationId());
                wdApplicationOperatingBalanceSheetDetail.setOperatingBalanceSheetId(wdApplicationOperatingBalanceSheet.getId());
                wdApplicationOperatingBalanceSheetDetail.setCreateBy(UserUtils.getUser().getId());
                wdApplicationOperatingBalanceSheetDetail.setCreateDate(new Date());
                wdApplicationOperatingBalanceSheetDetail.setUpdateBy(UserUtils.getUser().getId());
                wdApplicationOperatingBalanceSheetDetail.setUpdateDate(new Date());
                wdApplicationOperatingBalanceSheetDetailService.insertSelective(wdApplicationOperatingBalanceSheetDetail);
            }
        }
        
        wdApplicationCreditHistoryService.delByApplicationId(applicationId);
        // 信用卡使用情况
        if (StringUtils.isNotEmpty(creditCardUseInfoListdata)) {
            List<WdApplicationCreditHistory> wdApplicationCreditHistoryList = JSON.parseArray(StringEscapeUtils.unescapeHtml4(creditCardUseInfoListdata), WdApplicationCreditHistory.class);
            if (null != wdApplicationCreditHistoryList && !wdApplicationCreditHistoryList.isEmpty()) {
                for (int i = 0; i < wdApplicationCreditHistoryList.size(); i++) {
                    WdApplicationCreditHistory wdApplicationCreditHistory = wdApplicationCreditHistoryList.get(i);
                    wdApplicationCreditHistory.setApplicationId(applicationId);
                    wdApplicationCreditHistory.setId(UidUtil.uuid());
                    wdApplicationCreditHistory.setCreateBy(UserUtils.getUser().getId());
                    wdApplicationCreditHistory.setCreateDate(new Date());
                    wdApplicationCreditHistory.setUpdateBy(UserUtils.getUser().getId());
                    wdApplicationCreditHistory.setUpdateDate(new Date());
                    wdApplicationCreditHistory.setExcOrder(i);
                    wdApplicationCreditHistoryService.insertSelective(wdApplicationCreditHistory);
                }
            }
        }
        
        // 信贷历史记录
        wdApplicationCreditHistoryDetailService.delByApplicationId(applicationId);
        if (StringUtils.isNotEmpty(creditHistoryListData)) {
            List<WdApplicationCreditHistoryDetail> wdApplicationCreditHistoryDetailList = JSON.parseArray(StringEscapeUtils.unescapeHtml4(creditHistoryListData), WdApplicationCreditHistoryDetail.class);
            if (null != wdApplicationCreditHistoryDetailList && !wdApplicationCreditHistoryDetailList.isEmpty()) {
                for (int i = 0; i < wdApplicationCreditHistoryDetailList.size(); i++) {
                    WdApplicationCreditHistoryDetail wdApplicationCreditHistoryDetail = wdApplicationCreditHistoryDetailList.get(i);
                    wdApplicationCreditHistoryDetail.setApplicationId(applicationId);
                    wdApplicationCreditHistoryDetail.setApplicationId(applicationId);
                    wdApplicationCreditHistoryDetail.setId(UidUtil.uuid());
                    wdApplicationCreditHistoryDetail.setCreateBy(UserUtils.getUser().getId());
                    wdApplicationCreditHistoryDetail.setCreateDate(new Date());
                    wdApplicationCreditHistoryDetail.setUpdateBy(UserUtils.getUser().getId());
                    wdApplicationCreditHistoryDetail.setUpdateDate(new Date());
                    wdApplicationCreditHistoryDetail.setExcOrder(i);
                    wdApplicationCreditHistoryDetailService.insertSelective(wdApplicationCreditHistoryDetail);
                }
            }
        }
        
        WdApplicationOperatingBalanceSheetDetail wdApplicationOperatingBalanceSheetDetail = wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(applicationId, "1");

        // 权益检查表
        WdApplicationOperatingBalanceSheetCheck wdApplicationOperatingBalanceSheetCheck = wdApplicationOperatingBalanceSheetCheckService.selectByApplicationId(wdApplicationOperatingBalanceSheet.getApplicationId(), null);
        wdApplicationOperatingBalanceSheetCheck.setApplicationId(wdApplicationOperatingBalanceSheet.getApplicationId());
        wdApplicationOperatingBalanceSheetCheck.setSpendableIncomeAvg(wdApplicationOperatingBalanceSheet.getSpendableIncomeAvg());
        wdApplicationOperatingBalanceSheetCheck.setCurrentPeriodPointTime(wdApplicationOperatingBalanceSheetDetail.getPointTime());
        reComputeBalanceSheetCheck(wdApplicationOperatingBalanceSheetCheck);
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheetCheck.getId())) {
            wdApplicationOperatingBalanceSheetCheck.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheetCheck.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheetCheck.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetCheckService.insertSelective(wdApplicationOperatingBalanceSheetCheck);
        } else {
            wdApplicationOperatingBalanceSheetCheck.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetCheckService.updateByPrimaryKey(wdApplicationOperatingBalanceSheetCheck);
        }
        return new JsonResult();
    }

    /**
     * 权益检查 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequestMapping(value = { "rights" })
    @RequiresPermissions("wd:application:survey")
    public String rights(Model model, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        model.addAttribute("wdApplication", wdApplication);
        WdApplicationOperatingBalanceSheet wdApplicationOperatingBalanceSheet = wdApplicationOperatingBalanceSheetService.selectByApplicationId(applicationId);
        // 权益(资产负债表)
        WdApplicationOperatingBalanceSheetDetail wdApplicationOperatingBalanceSheetDetail = wdApplicationOperatingBalanceSheetDetailService.selectByApplicationIdAndCategory(applicationId, "1");
        BigDecimal equity = wdApplicationOperatingBalanceSheetDetail.getEquity() != null ? wdApplicationOperatingBalanceSheetDetail.getEquity() : BigDecimal.ZERO;
        BigDecimal sumOBSAsset = wdApplicationOperatingBalanceSheetAdditionalService.sumOBSAsset(applicationId);
        BigDecimal sumOBSLiabilities = wdApplicationOperatingBalanceSheetAdditionalService.sumOBSLiabilities(applicationId);
        sumOBSAsset = sumOBSAsset != null ? sumOBSAsset : BigDecimal.ZERO;
        sumOBSLiabilities = sumOBSLiabilities != null ? sumOBSLiabilities : BigDecimal.ZERO;
        model.addAttribute("orgEntitlement", equity.subtract(sumOBSLiabilities).add(sumOBSAsset)); // 权益检验原始值
        
        WdApplicationOperatingBalanceSheetCheck wdApplicationOperatingBalanceSheetCheck = wdApplicationOperatingBalanceSheetCheckService.selectByApplicationId(applicationId, null);
        wdApplicationOperatingBalanceSheetCheck.setSpendableIncomeAvg(wdApplicationOperatingBalanceSheet.getSpendableIncomeAvg());
        wdApplicationOperatingBalanceSheetCheck.setCurrentPeriodPointTime(wdApplicationOperatingBalanceSheetDetail.getPointTime());
        model.addAttribute("wdApplicationOperatingBalanceSheetCheck", wdApplicationOperatingBalanceSheetCheck);
        
        
        return "modules/wd/application/survey/rights";
    }

    /**
     * 保存权益检查 date: 2017年4月13日 下午7:50:01 <br/>
     * @author Liam
     * @param wdApplicationOperatingBalanceSheetCheck
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "saveRights" })
    @ResponseBody
    @Transactional
    @RequiresPermissions("wd:application:survey")
    public JsonResult saveRights(WdApplicationOperatingBalanceSheetCheck wdApplicationOperatingBalanceSheetCheck) {
        if (StringUtils.isEmpty(wdApplicationOperatingBalanceSheetCheck.getId())) {
            wdApplicationOperatingBalanceSheetCheck.setId(UidUtil.uuid());
            wdApplicationOperatingBalanceSheetCheck.setCreateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setCreateDate(new Date());
            wdApplicationOperatingBalanceSheetCheck.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetCheckService.insertSelective(wdApplicationOperatingBalanceSheetCheck);
        } else {
            wdApplicationOperatingBalanceSheetCheck.setUpdateBy(UserUtils.getUser().getId());
            wdApplicationOperatingBalanceSheetCheck.setUpdateDate(new Date());
            wdApplicationOperatingBalanceSheetCheckService.updateByPrimaryKeySelective(wdApplicationOperatingBalanceSheetCheck);
        }
        return new JsonResult();
    }

    /**
     * 提交调查 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequestMapping(value = { "submitSurvey" })
    @RequiresPermissions("wd:application:survey")
    public String submitSurvey(Model model, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        model.addAttribute("wdApplication", wdApplication);
        // 产品配置

        String productVersoin = wdApplication.getProductVersion();
        if (StringUtils.isEmpty(productVersoin)) {
            productVersoin = wdProductService.selectByPrimaryKey(wdApplication.getProductId()).getProductVersion();
        }
        WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), productVersoin, BusinessConsts.ModuleID.SurveyConclusion); // 调查结论
        model.addAttribute("surveySubmitConfig", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));

        model.addAttribute("applyAuditInfoConfig", wdDefaultSimpleModuleSettingService.selectByModuleId(BusinessConsts.ModuleID.ApplyAuditInfo)); // 申请基本信息
        return "modules/wd/application/survey/submitSurvey";
    }

    /**
     * 提交调查结论 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequestMapping(value = { "saveAuditConclusion" })
    @ResponseBody
    @RequiresPermissions("wd:application:survey")
    public JsonResult saveAuditConclusion(Model model, String applicationId, String auditConclusion) {
        try {
            String errorMessage = processHandle.checkInfoCompleteness(applicationId);
            if (StringUtils.isNotBlank(errorMessage)) {
                return new JsonResult(false, errorMessage);
            }

            WdApplicationTask task = wdApplicationTaskService.selectByOwnerAndStatus(applicationId, BusinessConsts.Activity.Survey, UserUtils.getUser().getId());
            if (null == task) {
                return new JsonResult(false, "该笔贷款已提交审核，请勿重新提交！");
            }

            WdApplication application = wdApplicationService.selectByPrimaryKey(applicationId);
            if (null == application) {
                return new JsonResult(false, "没有编号为【" + applicationId + "】的申请");
            }

            List<WdApplicationCreditInvestigation> creditInvestigations = wdApplicationCreditInvestigationService.selectByApplicationId(applicationId);
            for (WdApplicationCreditInvestigation creditInvestigation : creditInvestigations) {
                if (StringUtils.isBlank(creditInvestigation.getResult())) {
                    return new JsonResult(false, "有征信审核未完成");
                }
            }

            // 检查互保
            List<WdPerson> loopbackPerson = wdApplicationService.getLoopbackGuarantee(applicationId);
            if (!loopbackPerson.isEmpty() && loopbackPerson.size() > 1) {
                String loopbackPersonName = "";
                for (WdPerson badPerson : loopbackPerson) {
                    loopbackPersonName += ("，" + badPerson.getName());
                }
                return new JsonResult(false, loopbackPersonName.substring(1) + "等人有互相担保情况");
            }

            String data = StringEscapeUtils.unescapeHtml4(auditConclusion);

            // 更新申请的调查结论
            task.setDetailData(data);
            wdApplicationTaskService.updateByPrimaryKeySelective(task);

            // 更新申请的调查结论
            application.setAuditConclusion(data);
            application.setFinalConclusion(data);
            wdApplicationService.updateByPrimaryKeySelective(application);
            // 归档
            dataAssembly.archiving(application.getId(), UserUtils.getUser().getId());
            // 添加客户动态
            WdCustomerTrack wdCustomerTrack = new WdCustomerTrack();
            wdCustomerTrack.setCustomerId(application.getCustomerId());
            wdCustomerTrack.setTitle("提交审批");
            wdCustomerTrack.setContent(application.getProductName());
            wdCustomerTrack.setCategory("申贷过程");
            wdCustomerTrack.setId(UidUtil.uuid());
            wdCustomerTrack.setCreateBy(UserUtils.getUser().getId());
            wdCustomerTrack.setCreateDate(new Date());
            wdCustomerTrack.setUpdateBy(UserUtils.getUser().getId());
            wdCustomerTrack.setUpdateDate(new Date());
            wdCustomerTrack.setRelationId(application.getId());

            wdCustomerTrackService.insertSelective(wdCustomerTrack);

            // 风险提示查询
            try {
                WdCustomer customer = wdCustomerService.selectByPrimaryKey(application.getCustomerId());

                wdCourtQueryService.searchZhixin(customer.getPersonId(), application.getOwnerId(), application.getCustomerId());
                wdCourtQueryService.searchShixin(customer.getPersonId(), application.getOwnerId(), application.getCustomerId());
            } catch (GeneralException e) {
                LOGGER.info(e.getMessage());
            } catch (ParseException e) {
                LOGGER.error(e.getMessage());
            }

            // 处理流程流转
            if (StringUtils.isBlank(application.getName())) {
                processHandle.dealTask(task.getId(), BusinessConsts.Action.Submit, null, null, data, UserUtils.getUser().getId(), false);
            } else { // 新流程处理
                processEngine.dealTask(task.getId(), BusinessConsts.Action.Submit, UserUtils.getUser().getId());
                processHandle.delWithOldProcessAndNewProcess(application);
            }
            
            // 技算评分
            Thread t = new Thread(new Runnable() {
                @Override
                public void run() {
                //    wdApplicationScoreService.computeScoreByApplicationId(applicationId);
                    computeScoreByApplicationId(applicationId);
                }
            });
            t.start();

        } catch (GeneralException e) {
            LOGGER.info("提交调查结论失败", e);
            return new JsonResult(e.getMessage());
        }
        return new JsonResult();
    }
    
    public void computeScoreByApplicationId(String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        List<WdProductSmModel> wdProductSmModelList = wdProductSmModelService.selectByPorductId(wdApplication.getProductId());
        String productId = wdApplication.getProductId();
        String productVersion = wdApplication.getProductVersion();
        String customerId = wdApplication.getCustomerId();
        String customerTypeVersion = wdApplication.getCustomerTypeVersion();
        WdApplicationExtendInfo wdApplicationExtendInfo = wdApplicationExtendInfoService.selectByApplicationId(applicationId);
        WdApplicationMonthlyIncomeStatement wdApplicationMonthlyIncomeStatement = wdApplicationMonthlyIncomeStatementService.selectByApplicationId(applicationId);
        WdApplicationYearlyIncomeStatement wdApplicationYearlyIncomeStatement = wdApplicationYearlyIncomeStatementService.selectByApplicationId(applicationId);
        WdApplicationBalanceSheet wdApplicationBalanceSheet = wdApplicationBalanceSheetService.selectByApplicationId(applicationId);
        WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(wdApplication.getCustomerId());
        WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdCustomer.getPersonId());
        
        for (WdProductSmModel wdProductSmModel : wdProductSmModelList) {
            SmModel smModel = smModelService.selectByModelKey(wdProductSmModel.getModelKey());
            String modelId = smModel.getId();
            
            BigDecimal productScore = smModelService.computeCurrentProductScoreByModelId(modelId, productId, productVersion);
            BigDecimal customerScore = smModelService.computeCurrentCustomerScoreByModelId(modelId, customerId, customerTypeVersion);
            BigDecimal appliationProductScore = smModelService.computeAppliationProductScoreByModelId(wdApplicationMonthlyIncomeStatement, wdApplicationYearlyIncomeStatement, wdApplicationBalanceSheet, wdApplicationExtendInfo, productId, productVersion, modelId);
            BigDecimal appliationCustomerScore = smModelService.computeAppliationtCustomerScoreByModelId(wdPerson, modelId, customerId, customerTypeVersion);
            WdApplicationScore wdApplicationScore = new WdApplicationScore();
            if (appliationProductScore.add(appliationCustomerScore).equals(BigDecimal.ZERO)) {
                wdApplicationScore.setScore(BigDecimal.ZERO);
            } else {
               BigDecimal score = appliationProductScore.add(appliationCustomerScore).divide(productScore.add(customerScore), 10, BigDecimal.ROUND_HALF_DOWN).multiply(new BigDecimal(100));
               wdApplicationScore.setScore(score);
            }
            wdApplicationScore.setId(UidUtil.uuid());
            wdApplicationScore.setCreateBy("sys");
            wdApplicationScore.setCreateDate(new Date());
            wdApplicationScore.setApplicationId(applicationId);
            wdApplicationScore.setModelKey(wdProductSmModel.getModelKey());
            wdApplicationScore.setModelName(smModel.getName());
            wdApplicationScoreService.insertSelective(wdApplicationScore);
        }
    }
}