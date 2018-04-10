package com.bk.wd.web.controller.wd.app;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSON;
import com.bk.common.entity.GeneralException;
import com.bk.common.entity.JsonResult;
import com.bk.common.service.DfsService;
import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysUserService;
import com.bk.wd.model.WdApplication;
import com.bk.wd.model.WdApplicationCreditInvestigation;
import com.bk.wd.model.WdProductCreditInvestigation;
import com.bk.wd.model.WdProductSimpleModule;
import com.bk.wd.service.WdApplicationCreditInvestigationCommentService;
import com.bk.wd.service.WdApplicationCreditInvestigationPhotoService;
import com.bk.wd.service.WdApplicationCreditInvestigationService;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.service.WdProductCreditInvestigationService;
import com.bk.wd.service.WdProductSimpleModuleService;
import com.bk.wd.service.WdProductSimpleModuleSettingService;
import com.bk.wd.util.BusinessConsts;
import com.bk.wd.util.ProcessHandle4CreditInvestigation;

@Controller
@RequestMapping(value = "/wd/application/credit")
public class AppCreditController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AppCreditController.class);

	@Autowired
	private WdApplicationCreditInvestigationService wdApplicationCreditInvestigationService;

	@Autowired
	private WdApplicationCreditInvestigationPhotoService wdApplicationCreditInvestigationPhotoService;

	@Autowired
	private WdApplicationCreditInvestigationCommentService wdApplicationCreditInvestigationCommentService;

	@Autowired
	private SysUserService userService;

	@Autowired
	private DfsService dfsService;

	@Autowired
	private WdApplicationService wdApplicationService;

	@Autowired
	private WdProductCreditInvestigationService wdProductCreditInvestigationService;

	@Autowired
	private WdProductSimpleModuleService wdProductSimpleModuleService;

	@Autowired
	private WdProductSimpleModuleSettingService wdProductSimpleModuleSettingService;

	@Autowired
	private ProcessHandle4CreditInvestigation processHandle4CreditInvestigation;

	@RequestMapping(value = { "detail" })
	@RequiresPermissions("wd:application:view")
	public String detail(String creditId, Model model, String errorMess) {
		WdApplicationCreditInvestigation wdApplicationCreditInvestigation = wdApplicationCreditInvestigationService.selectByPrimaryKey(creditId);
		model.addAttribute("wdApplicationCreditInvestigation", wdApplicationCreditInvestigation);
		model.addAttribute("lastestComment", wdApplicationCreditInvestigationCommentService.selectLastestComment(creditId));
		if (StringUtils.isNotEmpty(wdApplicationCreditInvestigation.getPersonId())) {
			model.addAttribute("currentDateResult", wdApplicationCreditInvestigationService.selectCurrentDateResultByPerson(wdApplicationCreditInvestigation.getPersonId()));
		}

		WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(wdApplicationCreditInvestigation.getApplicationId());
		WdProductCreditInvestigation wdProductCreditInvestigation = wdProductCreditInvestigationService.selectByProductId(wdApplication.getProductId(), wdApplication.getProductVersion());
		model.addAttribute("wdProductCreditInvestigation", wdProductCreditInvestigation);

		WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), wdApplication.getProductVersion(), BusinessConsts.ModuleID.CreditInvestigationResult);
		if (null != wdProductSimpleModule) {
			model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
		}
		model.addAttribute("wdApplicationCreditInvestigationPhotoList", wdApplicationCreditInvestigationPhotoService.selectByCreditId(creditId));

		model.addAttribute("errorMess", errorMess);
		return "modules/wd/application/credit/creditDetail";
	}

	@RequestMapping(value = { "form" })
	@RequiresPermissions("wd:application:credit")
	public String form(String creditId, String taskId, Model model, String errorMess) {
		WdApplicationCreditInvestigation wdApplicationCreditInvestigation = wdApplicationCreditInvestigationService.selectByPrimaryKey(creditId);
		model.addAttribute("wdApplicationCreditInvestigation", wdApplicationCreditInvestigation);
		model.addAttribute("taskId", taskId);
		model.addAttribute("lastestComment", wdApplicationCreditInvestigationCommentService.selectLastestComment(creditId));
		if (StringUtils.isNotEmpty(wdApplicationCreditInvestigation.getPersonId())) {
			model.addAttribute("currentDateResult", wdApplicationCreditInvestigationService.selectCurrentDateResultByPerson(wdApplicationCreditInvestigation.getPersonId()));
		}

		WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(wdApplicationCreditInvestigation.getApplicationId());

		WdProductCreditInvestigation wdProductCreditInvestigation = wdProductCreditInvestigationService.selectByProductId(wdApplication.getProductId(), wdApplication.getProductVersion());
		model.addAttribute("wdProductCreditInvestigation", wdProductCreditInvestigation);

		WdProductSimpleModule wdProductSimpleModule = wdProductSimpleModuleService.selectByVersionAndModuleId(wdApplication.getProductId(), wdApplication.getProductVersion(), BusinessConsts.ModuleID.CreditInvestigationResult);
		if (null != wdProductSimpleModule) {
			model.addAttribute("configList", wdProductSimpleModuleSettingService.selectByProductSimpleModuleId(wdProductSimpleModule.getId()));
		}

		model.addAttribute("wdApplicationCreditInvestigationPhotoList", wdApplicationCreditInvestigationPhotoService.selectByCreditId(creditId));

		model.addAttribute("errorMess", errorMess);
		return "modules/wd/application/credit/creditForm";
	}

	@RequestMapping(value = { "returnForm" })
	public String reject(String creditId, String taskId, Model model) {
		model.addAttribute("creditId", creditId);
		model.addAttribute("taskId", taskId);
		return "modules/wd/application/credit/returnForm";
	}

	@RequestMapping(value = { "cancelForm" })
	public String cancel(String creditId, String taskId, Model model) {
		model.addAttribute("creditId", creditId);
		model.addAttribute("taskId", taskId);
		return "modules/wd/application/credit/cancelForm";
	}

	@RequestMapping(value = { "/return" })
	@ResponseBody
	public JsonResult taskReturn(String creditId, String reason, String remarks, HttpServletRequest request) {
		WdApplicationCreditInvestigation creditInvestigation = wdApplicationCreditInvestigationService.selectByPrimaryKey(creditId);
		if (null == creditInvestigation) {
			return new JsonResult(false, "请求失败，该征信任务被删除");
		}
		if (!"征信查询中".equals(creditInvestigation.getRemarks())) {
			return new JsonResult(false, "请求失败，该征信任务取消");
		}

		try {
			processHandle4CreditInvestigation.back(creditInvestigation, UserUtils.getUser().getId(), reason, remarks);
		} catch (GeneralException e) {
			LOGGER.error(e.getMessage(), e);
		}

		return new JsonResult(creditInvestigation);

	}

	@RequestMapping(value = { "/cancel" })
	@ResponseBody
	public JsonResult cancel(String creditId, String reason, String remarks, HttpServletRequest request) {
		WdApplicationCreditInvestigation creditInvestigation = wdApplicationCreditInvestigationService.selectByPrimaryKey(creditId);
		if (null == creditInvestigation) {
			return new JsonResult(false, "请求失败，该征信任务被删除");
		}
		if (!"征信查询中".equals(creditInvestigation.getRemarks())) {
			return new JsonResult(false, "请求失败，该征信任务取消");
		}

		try {
			processHandle4CreditInvestigation.cancel(creditInvestigation, UserUtils.getUser().getId(), reason, remarks);
		} catch (GeneralException e) {
			LOGGER.error(e.getMessage(), e);
		}

		return new JsonResult(creditInvestigation);

	}

	@RequiresPermissions("wd:application:credit")
	@RequestMapping(value = "save")
	@Transactional
	public String save(@RequestParam("otherPhotos") CommonsMultipartFile[] otherPhotos, @RequestParam(value = "autoPhoto", required = false) CommonsMultipartFile autoPhoto, WdApplicationCreditInvestigation wdApplicationCreditInvestigation, String taskId, Model model) {

		WdApplicationCreditInvestigation orgCredit = wdApplicationCreditInvestigationService.selectByPrimaryKey(wdApplicationCreditInvestigation.getId());

		String errorMess = "";
		if (null == orgCredit) {
			errorMess = "请求失败，该征信任务被删除";
			try {
				errorMess = URLEncoder.encode(errorMess, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return "redirect:/wd/application/credit/detail?errorMess=" + errorMess + "&creditId=" + wdApplicationCreditInvestigation.getId();

			// return new JsonResult(false, "请求失败，该征信任务被删除");
		}
		if (!"征信查询中".equals(orgCredit.getRemarks())) {
			errorMess = "请求失败，该征信任务取消";
			try {
				errorMess = URLEncoder.encode(errorMess, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return "redirect:/wd/application/credit/detail?errorMess=" + errorMess + "&creditId=" + wdApplicationCreditInvestigation.getId();
			// return new JsonResult(false, "请求失败，该征信任务取消");
		}

		try {
			List<String> resultFile = new ArrayList<>();
			if (otherPhotos != null && otherPhotos.length > 0) {
				for (int i = 0; i < otherPhotos.length; i++) {
					CommonsMultipartFile file = otherPhotos[i];
					if (StringUtils.isNoneBlank(file.getOriginalFilename())) {
						String fileId = dfsService.uploadFile(file.getBytes(), file.getOriginalFilename());
						resultFile.add(fileId);
					}
				}
			}
			orgCredit.setResultFile(JSON.toJSONString(resultFile));
		} catch (IOException e) {
			LOGGER.error("图片上传失败", e);
			errorMess = "征信报告提交失败";
		}

		orgCredit.setCreditCardRecord(wdApplicationCreditInvestigation.getCreditCardRecord());
		orgCredit.setLoanRecord(wdApplicationCreditInvestigation.getLoanRecord());
		orgCredit.setPersonalCreditSystem(wdApplicationCreditInvestigation.getPersonalCreditSystem());
		orgCredit.setCreditRecord(wdApplicationCreditInvestigation.getCreditRecord());
		orgCredit.setCreditRecordOurBank(wdApplicationCreditInvestigation.getCreditRecordOurBank());
		orgCredit.setResult(wdApplicationCreditInvestigation.getResult());
		if (null != wdApplicationCreditInvestigation.getCreditDetail() && StringUtils.isNotEmpty(wdApplicationCreditInvestigation.getCreditDetail().toString())) {
			orgCredit.setCreditDetail(wdApplicationCreditInvestigation.getCreditDetail().toString());
		}
		orgCredit.setCreditDate(new Date());
		SysUser creditUser = userService.selectByPrimaryKey(UserUtils.getUser().getId());
		orgCredit.setCreditBy(creditUser.getId());
		orgCredit.setCreditByName(creditUser.getName());

		wdApplicationCreditInvestigationService.updateByPrimaryKey(orgCredit);

		// 流程处理
		try {
			processHandle4CreditInvestigation.pass(orgCredit, UserUtils.getUser().getId());
		} catch (GeneralException e) {
			LOGGER.error(e.getMessage(), e);
			errorMess = e.getMessage();
		}

		if (StringUtils.isBlank(errorMess)) {
			return "redirect:/wd/application/creditList?repage=1";
		} else {
			try {
				errorMess = URLEncoder.encode(errorMess, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return "redirect:/wd/application/credit/form?errorMess=" + errorMess + "&creditId=" + wdApplicationCreditInvestigation.getId();
		}
	}

}
