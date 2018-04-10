package com.bk.wd.web.controller.wd.app;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bk.common.entity.GeneralException;
import com.bk.common.utils.IDCard;
import com.bk.sys.model.SysOffice;
import com.bk.sys.model.SysUser;
import com.bk.sys.service.SysOfficeService;
import com.bk.sys.service.SysUserService;
import com.bk.wd.model.WdApplication;
import com.bk.wd.model.WdApplicationAssetsBuilding;
import com.bk.wd.model.WdApplicationBuildingMortgage;
import com.bk.wd.model.WdApplicationCoborrower;
import com.bk.wd.model.WdApplicationPerson;
import com.bk.wd.model.WdApplicationPersonRelation;
import com.bk.wd.model.WdApplicationRecognizor;
import com.bk.wd.model.WdApplicationTask;
import com.bk.wd.model.view.ViewMeeting;
import com.bk.wd.model.view.ViewMortgage;
import com.bk.wd.model.view.ViewPerson;
import com.bk.wd.model.view.ViewResolution;
import com.bk.wd.model.view.ViewReviewReport;
import com.bk.wd.service.WdApplicationAssetsBuildingService;
import com.bk.wd.service.WdApplicationBuildingMortgageService;
import com.bk.wd.service.WdApplicationCoborrowerService;
import com.bk.wd.service.WdApplicationPersonRelationService;
import com.bk.wd.service.WdApplicationPersonService;
import com.bk.wd.service.WdApplicationRecognizorService;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.service.WdApplicationTaskService;
import com.bk.wd.util.BusinessConsts;
import com.bk.wd.util.DataUtils;
import com.bk.wd.web.utils.WordGenerator;

@Controller
@RequestMapping(value = "/wd/application/print")
public class AppPrintController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppCreditController.class);

    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysOfficeService sysOfficeService;
    @Autowired
    private WdApplicationTaskService wdApplicationTaskService;
    @Autowired
    private WdApplicationService wdApplicationService;
    @Autowired
    private WdApplicationPersonService wdApplicationPersonService;
    @Autowired
    private WdApplicationCoborrowerService wdApplicationCoborrowerService;
    @Autowired
    private WdApplicationPersonRelationService wdApplicationPersonRelationService;
    @Autowired
    private WdApplicationAssetsBuildingService wdApplicationAssetsBuildingService;
    @Autowired
    private WdApplicationBuildingMortgageService wdApplicationBuildingMortgageService;
    @Autowired
    private WdApplicationRecognizorService wdApplicationRecognizorService;

    /**
     * 打印预览
     * @param applicationId
     * @return
     */
    @RequestMapping(value = { "printPreview" })
    public String printPreview(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/print/print_preview";
    }

    /**
     * 决议表 - 镇江
     * @param applicationId 申请id
     * @return
     */
    @RequestMapping(value = { "resolution" })
    public String resolution(Model model, String applicationId) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);
        model.addAttribute("resolution", resultMaps.get("resolution"));
        model.addAttribute("approvedInfoRowSpan", resultMaps.get("approvedInfoRowSpan"));
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/print/resolution_zhenjiang";
    }

    @RequestMapping(value = { "resolutionWordExport" })
    public void resolutionWordExport(Model model, String applicationId, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/msword");

        // 否则Freemarker的模板殷勤在处理时可能会因为找不到值而报错 这里暂时忽略这个步骤了
        File file = WordGenerator.createDoc("resolution_zhenjiang", resultMaps);
        try (ServletOutputStream outputStream = response.getOutputStream(); InputStream fin = new FileInputStream(file);) {
            response.addHeader("Content-Disposition", "attachment;filename=" + new String("贷审会决议表".getBytes(), "iso-8859-1") + ".doc");
            byte[] buffer = new byte[512]; // 缓冲区
            int bytesToRead = -1;
            // 通过循环将读入的Word文件的内容输出到浏览器中
            while ((bytesToRead = fin.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesToRead);
            }
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
        } finally {
            if (file != null)
                file.delete(); // 删除临时文件
        }
    }

    /**
     * 大石桥决议表
     * @param applicationId 申请id
     * @return
     */
    @RequestMapping(value = { "resolutionDashiqiao" })
    public String resolutionDashiqiao(Model model, String applicationId) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);
        model.addAttribute("resolution", resultMaps.get("resolution"));
        model.addAttribute("approvedInfoRowSpan", resultMaps.get("approvedInfoRowSpan"));
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/print/resolution_dashiqiao";
    }
    
    /**
     * 决议表 - 洛阳
     * @param applicationId 申请id
     * @return
     */
    @RequestMapping(value = { "resolutionLuoyang" })
    public String resolutionLuoyang(Model model, String applicationId) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);
        model.addAttribute("resolution", resultMaps.get("resolution"));
        model.addAttribute("approvedInfoRowSpan", resultMaps.get("approvedInfoRowSpan"));
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/print/resolution_luoyang";
    }

    /**
     * 决议表-- 罗山
     * @param applicationId
     * @return
     */
    @RequestMapping(value = { "resolutionLuosan" })
    public String resolutionLuosan(Model model, String applicationId) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);
        model.addAttribute("resolution", resultMaps.get("resolution"));
        model.addAttribute("approvedInfoRowSpan", resultMaps.get("approvedInfoRowSpan"));
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/print/resolution_luoshan";
    }

    @RequestMapping(value = { "resolutionLuosanWordExport" })
    public void resolutionLuosanWordExport(Model model, String applicationId, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/msword");

        // 否则Freemarker的模板殷勤在处理时可能会因为找不到值而报错 这里暂时忽略这个步骤了
        File file = WordGenerator.createDoc("resolution_luoshan", resultMaps);
        try (ServletOutputStream outputStream = response.getOutputStream(); InputStream fin = new FileInputStream(file);) {
            response.addHeader("Content-Disposition", "attachment;filename=" + new String("贷审会决议表".getBytes(), "iso-8859-1") + ".doc");
            byte[] buffer = new byte[512]; // 缓冲区
            int bytesToRead = -1;
            // 通过循环将读入的Word文件的内容输出到浏览器中
            while ((bytesToRead = fin.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesToRead);
            }
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
        } finally {
            if (file != null)
                file.delete(); // 删除临时文件
        }
    }

    /**
     * 决议表-- 宣化
     * @param applicationId
     * @return
     */
    @RequestMapping(value = { "resolutionXuanhua" })
    public String resolutionXuanhua(Model model, String applicationId) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);
        model.addAttribute("resolution", resultMaps.get("resolution"));
        model.addAttribute("approvedInfoRowSpan", resultMaps.get("approvedInfoRowSpan"));
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/print/resolution_xuanhua";
    }

    @RequestMapping(value = { "resolutionXuanhuaWordExport" })
    public void resolutionXuanhuaWordExport(Model model, String applicationId, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/msword");

        // 否则Freemarker的模板殷勤在处理时可能会因为找不到值而报错 这里暂时忽略这个步骤了
        File file = WordGenerator.createDoc("resolution_xuanhua", resultMaps);
        try (ServletOutputStream outputStream = response.getOutputStream(); InputStream fin = new FileInputStream(file);) {
            response.addHeader("Content-Disposition", "attachment;filename=" + new String("贷审会决议表".getBytes(), "iso-8859-1") + ".doc");
            byte[] buffer = new byte[512]; // 缓冲区
            int bytesToRead = -1;
            // 通过循环将读入的Word文件的内容输出到浏览器中
            while ((bytesToRead = fin.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesToRead);
            }
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
        } finally {
            if (file != null)
                file.delete(); // 删除临时文件
        }
    }

    /**
     * 决议表-- 清远
     * @param applicationId
     * @return
     */
    @RequestMapping(value = { "resolutionQingyuan" })
    public String resolutionQingyuan(Model model, String applicationId) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);
        model.addAttribute("resolution", resultMaps.get("resolution"));
        model.addAttribute("approvedInfoRowSpan", resultMaps.get("approvedInfoRowSpan"));
        model.addAttribute("customerManagerCommentRowSpan", resultMaps.get("customerManagerCommentRowSpan"));
        model.addAttribute("applicationId", applicationId);

        return "modules/wd/application/print/resolution_qingyuan";
    }

    @RequestMapping(value = { "resolutionQingyuanWordExport" })
    public void resolutionQingyuanWordExport(Model model, String applicationId, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMaps = getResolutionInfo(applicationId);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/msword");

        // 否则Freemarker的模板殷勤在处理时可能会因为找不到值而报错 这里暂时忽略这个步骤了
        File file = WordGenerator.createDoc("resolution_qingyuan", resultMaps);
        try (ServletOutputStream outputStream = response.getOutputStream(); InputStream fin = new FileInputStream(file);) {
            response.addHeader("Content-Disposition", "attachment;filename=" + new String("贷审会决议表".getBytes(), "iso-8859-1") + ".doc");
            byte[] buffer = new byte[512]; // 缓冲区
            int bytesToRead = -1;
            // 通过循环将读入的Word文件的内容输出到浏览器中
            while ((bytesToRead = fin.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesToRead);
            }
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
        } finally {
            if (file != null)
                file.delete(); // 删除临时文件
        }
    }

    private Map<String, Object> getResolutionInfo(String applicationId) {
        ViewResolution resolution = new ViewResolution();

        WdApplication application = wdApplicationService.selectByPrimaryKey(applicationId);
        WdApplicationPerson person = wdApplicationPersonService.selectByApplicationId(applicationId);

        SysUser loanOfficer = sysUserService.selectByPrimaryKey(application.getCreateBy());
        SysOffice loanOfficerOffice = sysOfficeService.selectByPrimaryKey(loanOfficer.getOfficeId());

        resolution.setPost(loanOfficerOffice.getName());
        resolution.setLoanOfficer(loanOfficer.getName());
        resolution.setContractNo(application.getContractCode());
        resolution.setApplicationNo(application.getCode());
        resolution.setBorrower(DataUtils.getValueAsString(person.getJsonData(), "base_info_name"));
        resolution.setBorrowerIdCardNo(DataUtils.getValueAsString(person.getJsonData(), "base_info_idcard"));
        resolution.setAccountantSubject(DataUtils.getValueAsString(person.getJsonData(), "base_info_accountant_subject"));

        resolution.setProduct(application.getProductName());
        String amount = DataUtils.getValueAsString(application.getApplyInfoJson(), "loan_check_fund");
        if (StringUtils.isNotBlank(amount)) {
            resolution.setApplyAmount(new BigDecimal(amount));
        }
        resolution.setApplyLimit(DataUtils.getValueAsString(application.getApplyInfoJson(), "apply_limit"));

        amount = DataUtils.getValueAsString(application.getAuditConclusionJson(), "loan_check_fund");
        if (StringUtils.isNotBlank(amount)) {
            resolution.setLoanOfficerAmount(new BigDecimal(amount));
        }
        resolution.setLoanOfficerLimit(DataUtils.getValueAsString(application.getAuditConclusionJson(), "survey_limit"));
        resolution.setLoanOfficerRate(DataUtils.getValueAsString(application.getAuditConclusionJson(), "loan_check_interest_rate"));
        resolution.setLoanOfficerRepayment(DataUtils.getValueAsString(application.getAuditConclusionJson(), "loan_check_repayment_category"));
        resolution.setLoanOfficerGuaranteeCategory(DataUtils.getValueAsString(application.getAuditConclusionJson(), "loan_check_guarantee_category"));

        List<ViewPerson> borrowers = new ArrayList<>();
        ViewPerson borrower = new ViewPerson();
        borrower.setName(DataUtils.getValueAsString(person.getJsonData(), "base_info_name"));
        borrower.setIdCardNo(DataUtils.getValueAsString(person.getJsonData(), "base_info_idcard"));
        borrowers.add(borrower);
        resolution.setBorrowers(borrowers);

        List<ViewPerson> coborrowers = new ArrayList<>();
        List<WdApplicationCoborrower> applicationCoborrowers = wdApplicationCoborrowerService.selectByApplicationId(applicationId);
        for (WdApplicationCoborrower wdApplicationCoborrower : applicationCoborrowers) {
            WdApplicationPersonRelation coborrowerInfo = wdApplicationPersonRelationService.selectByApplicationIdAndOriginalId(applicationId, wdApplicationCoborrower.getOriginalId());
            ViewPerson coborrower = new ViewPerson();
            coborrower.setName(DataUtils.getValueAsString(coborrowerInfo.getJsonData(), "base_info_name"));
            coborrower.setIdCardNo(DataUtils.getValueAsString(coborrowerInfo.getJsonData(), "base_info_idcard"));
            coborrowers.add(coborrower);
        }
        resolution.setCoborrowers(coborrowers);

        List<ViewPerson> recognizors = new ArrayList<>();
        List<WdApplicationRecognizor> applicationRecognizors = wdApplicationRecognizorService.selectByApplicationId(applicationId);
        for (WdApplicationRecognizor wdApplicationRecognizor : applicationRecognizors) {
            WdApplicationPersonRelation recognizorInfo = wdApplicationPersonRelationService.selectByApplicationIdAndOriginalId(applicationId, wdApplicationRecognizor.getOriginalId());
            ViewPerson recognizor = new ViewPerson();
            recognizor.setName(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_name"));
            recognizor.setIdCardNo(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_idcard"));
            recognizors.add(recognizor);
        }
        resolution.setRecognizors(recognizors);

        amount = DataUtils.getValueAsString(application.getFinalConclusionJson(), "loan_check_fund");
        if (StringUtils.isNotBlank(amount)) {
            resolution.setFinalAmount(new BigDecimal(amount));
        }
        String finalLimit = DataUtils.getValueAsString(application.getFinalConclusionJson(), "overlimit_limit");
        if (StringUtils.isBlank(finalLimit)) {
            finalLimit = DataUtils.getValueAsString(application.getFinalConclusionJson(), "risk_limit");
        }
        resolution.setFinalLimit(finalLimit);
        resolution.setFinalRate(DataUtils.getValueAsString(application.getFinalConclusionJson(), "loan_check_interest_rate"));
        resolution.setFinalRepayment(DataUtils.getValueAsString(application.getFinalConclusionJson(), "loan_check_repayment_category"));

        BigDecimal totalMortgages = new BigDecimal(0);
        List<ViewMortgage> mortgages = new ArrayList<>();
        List<WdApplicationBuildingMortgage> applicationBuildingMortgages = wdApplicationBuildingMortgageService.selectByApplicationId(applicationId);
        for (WdApplicationBuildingMortgage wdApplicationBuildingMortgage : applicationBuildingMortgages) {
            WdApplicationAssetsBuilding mortgageInfo = wdApplicationAssetsBuildingService.selectByApplicationIdAndOriginalId(applicationId, wdApplicationBuildingMortgage.getOriginalId());
            ViewMortgage mortgage = new ViewMortgage();
            mortgage.setCategory("房产");
            String buildingOwners = "";
            for (Map<String, Object> ownerData : mortgageInfo.getOwnerData()) {
                buildingOwners += ("，" + ownerData.get("name").toString());
            }
            while (buildingOwners.startsWith("，")) {
                buildingOwners = buildingOwners.substring(1);
            }
            mortgage.setOwner(buildingOwners == "" ? wdApplicationBuildingMortgage.getPersonName() : buildingOwners);
            mortgage.setAddress(DataUtils.getValueAsString(mortgageInfo.getJsonData(), "assets_building_street"));
            mortgage.setValuation(DataUtils.getValueAsString(mortgageInfo.getJsonData(), "assets_building_worth"));
            mortgage.setAppraisalAgency(DataUtils.getValueAsString(mortgageInfo.getJsonData(), "assets_building_appraisal_agency"));
            mortgage.setLicense(DataUtils.getValueAsString(mortgageInfo.getJsonData(), "assets_building_license"));

            BigDecimal worthDecimal = new BigDecimal(0);
            amount = DataUtils.getValueAsString(mortgageInfo.getJsonData(), "assets_building_worth");
            if (StringUtils.isNotBlank(amount)) {
                worthDecimal = new BigDecimal(amount);
            }
            totalMortgages = totalMortgages.add(worthDecimal);

            if (worthDecimal.compareTo(new BigDecimal(0)) > 0) {
                mortgage.setDiyalv1(resolution.getApplyAmount().multiply(new BigDecimal(100)).divide(worthDecimal, 2, BigDecimal.ROUND_HALF_UP));
                mortgage.setDiyalv2(resolution.getFinalAmount().multiply(new BigDecimal(100)).divide(worthDecimal, 2, BigDecimal.ROUND_HALF_UP));
            }
            mortgages.add(mortgage);
        }
        resolution.setMortgages(mortgages);

        resolution.setTotalMortgages(totalMortgages);
        if (totalMortgages.compareTo(new BigDecimal(0)) > 0) {
            resolution.setDiyalv1(resolution.getApplyAmount().multiply(new BigDecimal(100)).divide(totalMortgages, 2, BigDecimal.ROUND_HALF_UP));
            resolution.setDiyalv2(resolution.getFinalAmount().multiply(new BigDecimal(100)).divide(totalMortgages, 2, BigDecimal.ROUND_HALF_UP));
        }

        resolution.setUse(DataUtils.getValueAsString(application.getApplyInfoJson(), "apply_use"));

        String loanCondition = DataUtils.getValueAsString(application.getFinalConclusionJson(), "overlimit_terms_of_loan");
        if (StringUtils.isBlank(loanCondition)) {
            loanCondition = DataUtils.getValueAsString(application.getFinalConclusionJson(), "risk_terms_of_loan");
        }
        resolution.setLoanCondition(loanCondition);

        String monitoringCondition = DataUtils.getValueAsString(application.getFinalConclusionJson(), "overlimit_monitoring");
        if (StringUtils.isBlank(monitoringCondition)) {
            monitoringCondition = DataUtils.getValueAsString(application.getFinalConclusionJson(), "risk_monitoring");
        }
        resolution.setMonitoringCondition(monitoringCondition);

        // 备注，审批人，审批结果日期
        Date lastestApprovedDate = application.getCreateDate();
        String lastestApprovedRemark = "";
        String approvedMangers = "";
        WdApplicationTask task = wdApplicationTaskService.selectLastestDoneTaskByApplicationIdAndStatus(applicationId, BusinessConsts.Activity.TableReview);
        if (null != task) {
            approvedMangers += ("，" + task.getDonerName());

            lastestApprovedDate = task.getDoneDate();
            lastestApprovedRemark = task.getComment();
        }
        task = wdApplicationTaskService.selectLastestDoneTaskByApplicationIdAndStatus(applicationId, BusinessConsts.Activity.OfflineReview);
        if (null != task) {
            approvedMangers += ("，" + task.getDonerName());
            if (task.getDoneDate().after(lastestApprovedDate)) {
                lastestApprovedDate = task.getDoneDate();
                lastestApprovedRemark = task.getComment();
            }

            resolution.setZhiliaoComment(task.getComment());
        }
        task = wdApplicationTaskService.selectLastestDoneTaskByApplicationIdAndStatus(applicationId, BusinessConsts.Activity.RiskControl);
        if (null != task) {
            approvedMangers += ("，" + task.getDonerName());
            if (task.getDoneDate().after(lastestApprovedDate)) {
                lastestApprovedDate = task.getDoneDate();
                lastestApprovedRemark = task.getComment();
            }
        }
        task = wdApplicationTaskService.selectLastestDoneTaskByApplicationIdAndStatus(applicationId, BusinessConsts.Activity.ExtendReview);
        if (null != task) {
            approvedMangers += ("，" + task.getDonerName());
            if (task.getDoneDate().after(lastestApprovedDate)) {
                lastestApprovedDate = task.getDoneDate();
                lastestApprovedRemark = task.getComment();
            }
        }

        if (approvedMangers.length() > 0) {
            approvedMangers = approvedMangers.substring(1);
        }

        resolution.setRemark(lastestApprovedRemark);
        resolution.setApprovedDate(lastestApprovedDate);
        resolution.setManagers(approvedMangers);

        int approvedInfoRowSpan = 0;
        approvedInfoRowSpan += (resolution.getBorrowers().size() == 0 ? 2 : (resolution.getBorrowers().size() + 1));
        approvedInfoRowSpan += (resolution.getCoborrowers().size() == 0 ? 1 : resolution.getCoborrowers().size());
        approvedInfoRowSpan += (resolution.getRecognizors().size() == 0 ? 1 : resolution.getRecognizors().size());
        approvedInfoRowSpan += (resolution.getMortgages().size() == 0 ? 2 : (resolution.getMortgages().size() + 1));

        int customerManagerCommentRowSpan = 0;
        customerManagerCommentRowSpan += (resolution.getMortgages().size() == 0 ? 2 : (resolution.getMortgages().size() + 1));

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("resolution", resolution);
        resultMap.put("applicationId", applicationId);
        resultMap.put("approvedInfoRowSpan", approvedInfoRowSpan);
        resultMap.put("customerManagerCommentRowSpan", customerManagerCommentRowSpan);
        return resultMap;
    }

    @RequestMapping(value = { "review_report" })
    public String reviewReport(Model model, String applicationId) {
        model.addAttribute("reviewReport", getReviewReportInfo(applicationId));
        model.addAttribute("applicationId", applicationId);
        return "modules/wd/application/print/review_report_luoshan";
    }

    @RequestMapping(value = { "review_report_excel_export" })
    public void reviewReportExcelExport(Model model, String applicationId, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMaps = new HashMap<>();
        resultMaps.put("reviewReport", getReviewReportInfo(applicationId));

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/msword");

        // 否则Freemarker的模板殷勤在处理时可能会因为找不到值而报错 这里暂时忽略这个步骤了
        File file = WordGenerator.createDoc("review_report_luoshan", resultMaps);
        try (ServletOutputStream outputStream = response.getOutputStream(); InputStream fin = new FileInputStream(file);) {
            response.addHeader("Content-Disposition", "attachment;filename=" + new String("罗山农商银行小微贷中心贷款审查报告".getBytes(), "iso-8859-1") + ".doc");
            byte[] buffer = new byte[512]; // 缓冲区
            int bytesToRead = -1;
            // 通过循环将读入的Word文件的内容输出到浏览器中
            while ((bytesToRead = fin.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesToRead);
            }
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
        } finally {
            if (file != null)
                file.delete(); // 删除临时文件
        }
    }

    private ViewReviewReport getReviewReportInfo(String applicationId) {
        ViewReviewReport report = new ViewReviewReport();

        WdApplication application = wdApplicationService.selectByPrimaryKey(applicationId);
        WdApplicationPerson person = wdApplicationPersonService.selectByApplicationId(applicationId);

        report.setApplyAmount(new BigDecimal(DataUtils.getValueAsString(application.getApplyInfoJson(), "loan_check_fund")));
        report.setApplyLimit(DataUtils.getValueAsString(application.getApplyInfoJson(), "apply_limit"));
        report.setApplyRate(DataUtils.getValueAsString(application.getApplyInfoJson(), "loan_check_interest_rate"));
        report.setApplyRepayment(DataUtils.getValueAsString(application.getApplyInfoJson(), "loan_check_repayment_category"));
        report.setGuaranteeMode(DataUtils.getValueAsString(application.getApplyInfoJson(), "loan_check_guarantee_category"));

        report.setUse(DataUtils.getValueAsString(application.getApplyInfoJson(), "apply_use"));

        List<ViewPerson> recognizors = new ArrayList<>();
        List<WdApplicationRecognizor> applicationRecognizors = wdApplicationRecognizorService.selectByApplicationId(applicationId);
        for (WdApplicationRecognizor wdApplicationRecognizor : applicationRecognizors) {
            WdApplicationPersonRelation recognizorInfo = wdApplicationPersonRelationService.selectByApplicationIdAndOriginalId(applicationId, wdApplicationRecognizor.getOriginalId());
            ViewPerson recognizor = new ViewPerson();
            recognizor.setName(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_name"));
            recognizor.setIdCardNo(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_idcard"));
            recognizor.setGender(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_gender"));
            try {
                IDCard.IDCardValidate(recognizor.getIdCardNo());
                recognizor.setAge(IDCard.IdNOToAge(recognizor.getIdCardNo()));
            } catch (ParseException | GeneralException e) {
                recognizor.setAge(null);
            }
            recognizor.setPost(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_position"));
            recognizor.setMarriage(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_marriage"));
            recognizor.setCensus(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_native_place"));
            recognizor.setAddress(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_home_addr"));

            recognizors.add(recognizor);
        }
        report.setRecognizors(recognizors);

        ViewPerson borrower = new ViewPerson();
        borrower.setName(DataUtils.getValueAsString(person.getJsonData(), "base_info_name"));
        borrower.setIdCardNo(DataUtils.getValueAsString(person.getJsonData(), "base_info_idcard"));
        borrower.setGender(DataUtils.getValueAsString(person.getJsonData(), "base_info_gender"));
        try {
            IDCard.IDCardValidate(borrower.getIdCardNo());
            borrower.setAge(IDCard.IdNOToAge(borrower.getIdCardNo()));
        } catch (ParseException | GeneralException e) {
            borrower.setAge(null);
        }
        borrower.setPost(DataUtils.getValueAsString(person.getJsonData(), "base_info_position"));
        borrower.setMarriage(DataUtils.getValueAsString(person.getJsonData(), "base_info_marriage"));
        borrower.setCensus(DataUtils.getValueAsString(person.getJsonData(), "base_info_native_place"));
        borrower.setAddress(DataUtils.getValueAsString(person.getJsonData(), "base_info_home_addr"));
        report.setBorrower(borrower);
        return report;
    }

    /**
     * 会议记录-罗山 date: 2017年8月7日 下午4:30:19 <br/>
     * @author Liam
     * @param model
     * @param applicationId
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "meeting" })
    public String meeting(Model model, String applicationId) {
        model.addAttribute("applicationId", applicationId);
        model.addAttribute("meeting", getMettingInfo(applicationId));
        return "modules/wd/application/print/meeting_luoshan";
    }

    @RequestMapping(value = { "meetingLuoshanExport" })
    public void meetingLuoshanExport(Model model, String applicationId, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMaps = new HashMap<>();
        resultMaps.put("meeting", getMettingInfo(applicationId));

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/msword");

        // 否则Freemarker的模板殷勤在处理时可能会因为找不到值而报错 这里暂时忽略这个步骤了
        File file = WordGenerator.createDoc("meeting_luoshan", resultMaps);
        try (ServletOutputStream outputStream = response.getOutputStream(); InputStream fin = new FileInputStream(file);) {
            response.addHeader("Content-Disposition", "attachment;filename=" + new String("罗山农商银行小微贷中心会议记录".getBytes(), "iso-8859-1") + ".doc");
            byte[] buffer = new byte[512]; // 缓冲区
            int bytesToRead = -1;
            // 通过循环将读入的Word文件的内容输出到浏览器中
            while ((bytesToRead = fin.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesToRead);
            }
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
        } finally {
            if (file != null)
                file.delete(); // 删除临时文件
        }
    }

    private ViewMeeting getMettingInfo(String applicationId) {
        ViewMeeting meeting = new ViewMeeting();

        WdApplication application = wdApplicationService.selectByPrimaryKey(applicationId);
        WdApplicationPerson person = wdApplicationPersonService.selectByApplicationId(applicationId);

        SysUser loanOfficer = sysUserService.selectByPrimaryKey(application.getCreateBy());

        meeting.setLoanOfficer(loanOfficer.getName());

        meeting.setApplyAmount(new BigDecimal(DataUtils.getValueAsString(application.getApplyInfoJson(), "loan_check_fund")));
        meeting.setApplyLimit(DataUtils.getValueAsString(application.getApplyInfoJson(), "apply_limit"));
        meeting.setApplyRate(DataUtils.getValueAsString(application.getApplyInfoJson(), "loan_check_interest_rate"));
        meeting.setApplyRepayment(DataUtils.getValueAsString(application.getApplyInfoJson(), "loan_check_repayment_category"));

        meeting.setUse(DataUtils.getValueAsString(application.getApplyInfoJson(), "apply_use"));

        meeting.setFamilyNum(DataUtils.getValueAsString(application.getApplyInfoJson(), "extend_family_members"));
        meeting.setFosterNum(DataUtils.getValueAsString(application.getApplyInfoJson(), "extend_foster_count"));

        List<ViewPerson> recognizors = new ArrayList<>();
        List<WdApplicationRecognizor> applicationRecognizors = wdApplicationRecognizorService.selectByApplicationId(applicationId);
        for (WdApplicationRecognizor wdApplicationRecognizor : applicationRecognizors) {
            WdApplicationPersonRelation recognizorInfo = wdApplicationPersonRelationService.selectByApplicationIdAndOriginalId(applicationId, wdApplicationRecognizor.getOriginalId());
            ViewPerson recognizor = new ViewPerson();
            recognizor.setName(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_name"));
            recognizor.setIdCardNo(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_idcard"));
            recognizor.setGender(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_gender"));
            try {
                IDCard.IDCardValidate(recognizor.getIdCardNo());
                recognizor.setAge(IDCard.IdNOToAge(recognizor.getIdCardNo()));
            } catch (ParseException | GeneralException e) {
                recognizor.setAge(null);
            }
            recognizor.setPost(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_position"));
            recognizor.setMarriage(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_marriage"));
            recognizor.setCensus(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_native_place"));
            recognizor.setAddress(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_home_addr"));

            recognizor.setShopAddr(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_shop_addr"));
            recognizor.setShopName(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_shop_name"));
            recognizor.setCompanyName(DataUtils.getValueAsString(recognizorInfo.getJsonData(), "base_info_company_name"));

            recognizors.add(recognizor);
        }
        meeting.setRecognizors(recognizors);

        ViewPerson borrower = new ViewPerson();
        borrower.setName(DataUtils.getValueAsString(person.getJsonData(), "base_info_name"));
        borrower.setIdCardNo(DataUtils.getValueAsString(person.getJsonData(), "base_info_idcard"));
        borrower.setGender(DataUtils.getValueAsString(person.getJsonData(), "base_info_gender"));
        try {
            IDCard.IDCardValidate(borrower.getIdCardNo());
            borrower.setAge(IDCard.IdNOToAge(borrower.getIdCardNo()));
        } catch (ParseException | GeneralException e) {
            borrower.setAge(null);
        }
        borrower.setPost(DataUtils.getValueAsString(person.getJsonData(), "base_info_position"));
        borrower.setMarriage(DataUtils.getValueAsString(person.getJsonData(), "base_info_marriage"));
        borrower.setCensus(DataUtils.getValueAsString(person.getJsonData(), "base_info_native_place"));
        borrower.setAddress(DataUtils.getValueAsString(person.getJsonData(), "base_info_home_addr"));
        borrower.setShopAddr(DataUtils.getValueAsString(person.getJsonData(), "base_info_shop_addr"));
        borrower.setShopName(DataUtils.getValueAsString(person.getJsonData(), "base_info_shop_name"));
        borrower.setCompanyName(DataUtils.getValueAsString(person.getJsonData(), "base_info_company_name"));

        meeting.setBorrower(borrower);

        List<WdApplicationPersonRelation> spouses = wdApplicationPersonRelationService.selectByApplicationIdAndType(applicationId, "配偶");
        if (spouses.isEmpty()) {
            meeting.setSpouse(null);
        } else {
            ViewPerson spouse = new ViewPerson();
            spouse.setName(DataUtils.getValueAsString(spouses.get(0).getJsonData(), "base_info_name"));
            spouse.setIdCardNo(DataUtils.getValueAsString(spouses.get(0).getJsonData(), "base_info_idcard"));
            meeting.setSpouse(spouse);
        }
        return meeting;
    }
    
    @RequestMapping(value = { "printIdcard" })
    public String printIdcard(Model model, String idcard1, String idcard2) {
        model.addAttribute("idcard1", idcard1);
        model.addAttribute("idcard2", idcard2);
        return "modules/wd/application/print/print_idcard";
    }

}