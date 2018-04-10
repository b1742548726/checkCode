package com.bk.wd.web.controller.wd;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bk.common.entity.GeneralException;
import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.IDCard;
import com.bk.common.utils.JsonUtils;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysConfiguration;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysConfigurationService;
import com.bk.sys.service.SysUserService;
import com.bk.wd.dto.CustomerSearchParamsDto;
import com.bk.wd.model.WdApplication;
import com.bk.wd.model.WdApplicationCoborrower;
import com.bk.wd.model.WdApplicationCreditInvestigation;
import com.bk.wd.model.WdApplicationPerson;
import com.bk.wd.model.WdApplicationPersonRelation;
import com.bk.wd.model.WdApplicationRecognizor;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdCommonSimpleModule;
import com.bk.wd.model.WdCustomer;
import com.bk.wd.model.WdCustomerBacklist;
import com.bk.wd.model.WdCustomerBackup;
import com.bk.wd.model.WdCustomerLocation;
import com.bk.wd.model.WdCustomerRelation;
import com.bk.wd.model.WdCustomerTrack;
import com.bk.wd.model.WdCustomerType;
import com.bk.wd.model.WdCustomerTypeSetting;
import com.bk.wd.model.WdPerson;
import com.bk.wd.model.WdPersonAssetsBuilding;
import com.bk.wd.model.WdPersonAssetsBuildingRelation;
import com.bk.wd.model.WdPersonAssetsCar;
import com.bk.wd.model.WdPersonBackup;
import com.bk.wd.model.WdPersonBalanceSheet;
import com.bk.wd.model.WdPersonBubbleExample;
import com.bk.wd.model.WdPersonBusiness;
import com.bk.wd.model.WdPersonBusinessIncomeStatementDetails;
import com.bk.wd.model.WdPersonBusinessRelation;
import com.bk.wd.model.WdPersonExtendInfo;
import com.bk.wd.model.WdPersonMonthlyIncomeStatement;
import com.bk.wd.model.WdPersonRelation;
import com.bk.wd.model.WdPersonYearlyIncomeStatement;
import com.bk.wd.model.base.BaseWdCustomer;
import com.bk.wd.model.base.BaseWdPerson;
import com.bk.wd.pl.service.WdPlApplicationCardInfoService;
import com.bk.wd.service.WdApplicationCoborrowerService;
import com.bk.wd.service.WdApplicationCreditInvestigationService;
import com.bk.wd.service.WdApplicationPersonRelationService;
import com.bk.wd.service.WdApplicationPersonService;
import com.bk.wd.service.WdApplicationRecognizorService;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdCommonSimpleModuleService;
import com.bk.wd.service.WdCommonSimpleModuleSettingService;
import com.bk.wd.service.WdCourtQueryService;
import com.bk.wd.service.WdCustomerBacklistService;
import com.bk.wd.service.WdCustomerBackupService;
import com.bk.wd.service.WdCustomerLocationService;
import com.bk.wd.service.WdCustomerRelationService;
import com.bk.wd.service.WdCustomerService;
import com.bk.wd.service.WdCustomerTrackService;
import com.bk.wd.service.WdCustomerTypeService;
import com.bk.wd.service.WdCustomerTypeSettingService;
import com.bk.wd.service.WdPersonAssetsBuildingRelationService;
import com.bk.wd.service.WdPersonAssetsBuildingService;
import com.bk.wd.service.WdPersonAssetsCarService;
import com.bk.wd.service.WdPersonBackupService;
import com.bk.wd.service.WdPersonBalanceSheetService;
import com.bk.wd.service.WdPersonBubbleService;
import com.bk.wd.service.WdPersonBusinessIncomeStatementDetailsService;
import com.bk.wd.service.WdPersonBusinessRelationService;
import com.bk.wd.service.WdPersonBusinessService;
import com.bk.wd.service.WdPersonExtendInfoService;
import com.bk.wd.service.WdPersonMonthlyIncomeStatementService;
import com.bk.wd.service.WdPersonRelationService;
import com.bk.wd.service.WdPersonService;
import com.bk.wd.service.WdPersonYearlyIncomeStatementService;
import com.bk.wd.service.WdRwEmaySinowayCreditService;
import com.bk.wd.service.WdRwTxCreditAntifraudVerifyService;
import com.bk.wd.service.WdRwZmCreditAntifraudVerifyService;
import com.bk.wd.util.ProcessHandle;
import com.bk.wd.web.base.BaseController;

/**
 * 客户
 * 
 * @Project Name:bk-wd-web
 * @Date:2017年4月3日下午11:45:24
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/customer")
public class CustomerController extends BaseController {

	// 客户关系
	private static final String customer_relation = "客户关系人";

	// 车产
	private static final String customer_car = "家庭主要资产（车辆）";

	// 房产
	private static final String customer_building = "家庭主要资产（房产）";

	@Autowired
	private WdCustomerService wdCustomerService;
	@Autowired
	private WdCustomerBacklistService wdCustomerBacklistService;
	@Autowired
	private WdCustomerLocationService wdCustomerlocationService;
	@Autowired
	private WdCustomerRelationService wdCustomerRelationService;
	@Autowired
	private WdCustomerTrackService wdCustomerTrackService;
	@Autowired
	private WdPersonService wdPersonService;
	@Autowired
	private WdPersonRelationService wdPersonRelationService;
	@Autowired
	private WdCustomerTypeSettingService wdCustomerTypeSettingService;
	@Autowired
	private WdCustomerTypeService wdCustomerTypeService;
	@Autowired
	private WdCommonSimpleModuleService wdCommonSimpleModuleService;
	@Autowired
	private WdCommonSimpleModuleSettingService wdCommonSimpleModuleSettingService;
	@Autowired
	private WdPersonAssetsBuildingService wdPersonAssetsBuildingService;
	@Autowired
	private WdBusinessElementService wdBusinessElementService;
	@Autowired
	private WdCourtQueryService wdCourtQueryService;
	@Autowired
	private WdRwZmCreditAntifraudVerifyService wdRwZmCreditAntifraudVerifyService;
	@Autowired
	private WdApplicationService wdApplicationService;
	@Autowired
	private WdPersonAssetsBuildingRelationService personBuildingRelationService;
	@Autowired
	private WdPersonAssetsCarService personCarService;
	@Autowired
	private WdPersonBusinessService businessService;
	@Autowired
	private WdPersonBalanceSheetService personBalanceSheetService;
	@Autowired
	private WdPersonBusinessRelationService personBusinessRelationService;
	@Autowired
	private WdPersonBusinessIncomeStatementDetailsService personIncomeStatementService;
	@Autowired
	private WdPersonExtendInfoService personExtendService;
	@Autowired
	private WdPersonMonthlyIncomeStatementService personMonthlyIncomeStatementService;
	@Autowired
	private WdPersonYearlyIncomeStatementService personYearlyIncomeStatementService;
	@Autowired
	private WdApplicationPersonService applicatonPersonService;
	@Autowired
	private WdApplicationPersonRelationService applicatonRelatedPersonService;
	@Autowired
	private WdApplicationRecognizorService personRecognizorService;
	@Autowired
	private WdApplicationCoborrowerService personCoborrowerService;
	@Autowired
	private WdRwTxCreditAntifraudVerifyService wdRwTxCreditAntifraudVerifyService;
	@Autowired
	private WdPlApplicationCardInfoService cardInfoService;

	@Autowired
	private WdApplicationCreditInvestigationService creditInvestigationService;
	@Autowired
	private SysConfigurationService configService;

	@Autowired
	private WdCustomerBackupService customerBackupService;
	@Autowired
	private WdPersonBackupService personBackupService;
	@Autowired
	private WdPersonBubbleService personBubbleService;

	@Autowired
	private SysUserService sysUserService;

	@Autowired
	private ProcessHandle processHandle;

	@Autowired
	private WdRwEmaySinowayCreditService wdRwEmaySinowayCreditService;

	@ModelAttribute
	public WdCustomer get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return wdCustomerService.selectByPrimaryKey(id);
		} else {
			return new WdCustomer();
		}
	}

	@RequiresPermissions("wd:customer:mine")
	@RequestMapping(value = { "myCustomerList", "" })
	public String myCustomerList(Model model, Pagination pagination, CustomerSearchParamsDto customerSearchParamsDto, HttpServletRequest request) {
		customerSearchParamsDto.setPagination(pagination);
		customerSearchParamsDto.setUserId(UserUtils.getUser().getId());
		wdCustomerService.findByPage(pagination, customerSearchParamsDto);
		model.addAttribute("pagination", pagination);
		model.addAttribute("params", customerSearchParamsDto);
		return "modules/wd/customer/mineList";
	}

	@RequiresPermissions("wd:customer:manager")
	@RequestMapping(value = { "customerManagerList" })
	public String customerManagerList(Model model, Pagination pagination, CustomerSearchParamsDto customerSearchParamsDto, HttpServletRequest request) {
		customerSearchParamsDto.setPagination(pagination);
		customerSearchParamsDto.setUserId(UserUtils.getUser().getId());
		customerSearchParamsDto.setDataScope("office"); // 数据权限
		wdCustomerService.findByPage(pagination, customerSearchParamsDto);
		model.addAttribute("pagination", pagination);
		model.addAttribute("params", customerSearchParamsDto);
		return "modules/wd/customer/managerList";
	}

	@RequiresPermissions("wd:customer:blacklist")
	@RequestMapping(value = { "customerBackList" })
	public String customerBackList(Model model, Pagination pagination, CustomerSearchParamsDto customerSearchParamsDto, HttpServletRequest request) {
		customerSearchParamsDto.setPagination(pagination);
		customerSearchParamsDto.setStatus(6);
		customerSearchParamsDto.setUserId(UserUtils.getUser().getId());
		customerSearchParamsDto.setDataScope("office"); // 数据权限
		wdCustomerService.findByPage(pagination, customerSearchParamsDto);
		model.addAttribute("pagination", pagination);
		model.addAttribute("params", customerSearchParamsDto);
		return "modules/wd/customer/backList";
	}

	@RequestMapping(value = { "detail" })
	public String index(Model model, HttpServletRequest request, String customerId) {
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("customer_detail_back_url", referer);
		model.addAttribute("customerId", customerId);
		return "redirect:/wd/customer/detail/index";
	}

	@RequestMapping(value = { "detail/index" })
	public String detail(Model model, String customerId) {
		WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(customerId);
		SysUser currentUser = sysUserService.selectByPrimaryKey(wdCustomer.getCreateBy());

		model.addAttribute("wdCustomer", wdCustomer);
		// 客户信息
		WdPerson wdPerson = wdPersonService.selectByPrimaryKey(wdCustomer.getPersonId());
		model.addAttribute("wdPerson", wdPerson);

		// 客户配置
		WdCustomerType wdCustomerType = wdCustomerTypeService.selectByPrimaryKey(wdCustomer.getCustomerTypeId());
		List<WdCustomerTypeSetting> wdCustomerTypeSettingList = wdCustomerTypeSettingService.selectByCustomerTypeIdAndCategory(wdCustomer.getCustomerTypeId(), null, wdCustomerType.getSettingVersion());
		model.addAttribute("wdCustomerTypeSettingList", wdCustomerTypeSettingList);

		// 客户贷款
		model.addAttribute("applicationList", wdCustomerService.selectAllApplicationByCustomerId(wdCustomer.getId()));

		Map<String, Object> config = new HashMap<>();

		WdCommonSimpleModule wdCommonSimpleModuleRelation = wdCommonSimpleModuleService.selectByModuleName(customer_relation, currentUser.getCompanyId());
		if (null != wdCommonSimpleModuleRelation) {
			config.put("customerRelation", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleRelation.getDefaultSimpleModuleId(), wdCommonSimpleModuleRelation.getSettingVersion()));
		}
		WdCommonSimpleModule wdCommonSimpleModuleCar = wdCommonSimpleModuleService.selectByModuleName(customer_car, currentUser.getCompanyId());
		if (null != wdCommonSimpleModuleCar) {
			config.put("customerCar", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleCar.getDefaultSimpleModuleId(), wdCommonSimpleModuleCar.getSettingVersion()));
		}
		WdCommonSimpleModule wdCommonSimpleModuleBuilding = wdCommonSimpleModuleService.selectByModuleName(customer_building, currentUser.getCompanyId());
		if (null != wdCommonSimpleModuleBuilding) {
			config.put("customerBuilding", wdCommonSimpleModuleSettingService.selectByModuleVersion(wdCommonSimpleModuleBuilding.getDefaultSimpleModuleId(), wdCommonSimpleModuleBuilding.getSettingVersion()));
		}
		model.addAttribute("config", config);
		model.addAttribute("customerRelationList", wdPersonService.selectRelationerByPersonId(wdCustomer.getPersonId(), currentUser.getCompanyId()));
		model.addAttribute("customerCarList", personCarService.selectByPersonId(wdCustomer.getPersonId()));
		model.addAttribute("customerBuildingList", wdPersonAssetsBuildingService.selectByPersonId(wdCustomer.getPersonId()));

		List<WdBusinessElement> allElementList = wdBusinessElementService.selectAll();
		Map<String, Object> wdBusinessElementConfig = new HashMap<>();
		for (WdBusinessElement wdBusinessElement : new ArrayList<>(allElementList)) {
			wdBusinessElementConfig.put(wdBusinessElement.getId(), wdBusinessElement);
			allElementList.remove(wdBusinessElement);
		}
		model.addAttribute("wdBusinessElementConfig", wdBusinessElementConfig);

		Map<String, Object> params = new HashMap<>();
		params.put("userId", UserUtils.getUser().getId());
		return "modules/wd/customer/detail/detail";
	}

	@RequiresPermissions(value = { "wd:customer:view", "wd:application:view" }, logical = Logical.OR)
	@RequestMapping(value = { "task" })
	public String task(Model model, String customerId) {
		WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(customerId);
		model.addAttribute("wdCustomer", wdCustomer);
		model.addAttribute("wdCustomerTrackList", wdCustomerTrackService.selectByCustomerIdAndCategory(customerId, null));
		return "modules/wd/customer/detail/task";
	}

	@RequestMapping(value = { "riskWarning" })
	public String riskWarning(Model model, String customerId) {
		WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(customerId);
		model.addAttribute("wdCustomer", wdCustomer);
		model.addAttribute("wdCustomerBacklist", wdCustomerBacklistService.selectByCustomerId(customerId));
		model.addAttribute("zhixinList", wdCourtQueryService.selectByPersonIdAndSite(wdCustomer.getPersonId(), "zhixin", null));
		model.addAttribute("shixinList", wdCourtQueryService.selectByPersonIdAndSite(wdCustomer.getPersonId(), "shixin", null));
		model.addAttribute("wdRwZmCreditAntifraudVerifyList", wdRwZmCreditAntifraudVerifyService.selectByPerson(wdCustomer.getPersonId()));
		model.addAttribute("wdRwTxCreditAntifraudVerifyList", wdRwTxCreditAntifraudVerifyService.selectByPersonId(wdCustomer.getPersonId(), null));
		model.addAttribute("wdRwEmaySinowayCreditList", wdRwEmaySinowayCreditService.selectByPersonId(wdCustomer.getPersonId(), null));
		return "modules/wd/customer/detail/riskWarning";
	}

	@RequestMapping(value = { "zhixinDetail" })
	public String zhixinDetail(Model model, String id) {
		model.addAttribute("wdCourtQuery", wdCourtQueryService.selectByPrimaryKey(id));
		return "modules/wd/customer/detail/courtZhixinDetail";
	}

	@RequestMapping(value = { "shixinDetail" })
	public String shixinDetail(Model model, String id) {
		model.addAttribute("wdCourtQuery", wdCourtQueryService.selectByPrimaryKey(id));
		return "modules/wd/customer/detail/courtShixinDetail";
	}

	@RequestMapping(value = { "emaySinowayCreditDetail" })
	public String emaySinowayCreditDetail(Model model, String id) {
		model.addAttribute("wdRwEmaySinowayCredit", wdRwEmaySinowayCreditService.selectByPrimaryKey(id));
		return "modules/wd/customer/detail/emaySinowayCreditDetail";
	}

	@RequestMapping(value = { "positionView" })
	public String positionView(Model model, HttpServletRequest request, String position, String lat, String lng) {
		model.addAttribute("position", position);
		model.addAttribute("lat", lat);
		model.addAttribute("lng", lng);
		return "modules/common/positionView";
	}

	@RequestMapping(value = { "videoPlay" })
	public String videoPlay(Model model, HttpServletRequest request, String videoUrl, String firstUrl) {
		model.addAttribute("videoUrl", videoUrl);
		model.addAttribute("firstUrl", firstUrl);
		return "modules/common/videoPlay";
	}

	/**
	 * 信任黑名单 date: 2017年5月6日 下午1:38:22 <br/>
	 * 
	 * @author Liam
	 * @param model
	 * @param customerId
	 * @return
	 * @since JDK 1.8
	 */
	@RequiresPermissions("wd:customer:trustblacker")
	@RequestMapping(value = { "trustBlacker" })
	@ResponseBody
	public JsonResult trustBlacker(Model model, String blackListId) {
		WdCustomerBacklist wdCustomerBacklist = wdCustomerBacklistService.selectByPrimaryKey(blackListId);
		wdCustomerBacklist.setDelFlag(true);
		wdCustomerBacklist.setUpdateBy(UserUtils.getUser().getId());
		wdCustomerBacklist.setUpdateDate(new Date());
		wdCustomerBacklistService.updateByPrimaryKeySelective(wdCustomerBacklist);

		WdCustomer wdCustomer = wdCustomerService.selectByPrimaryKey(wdCustomerBacklist.getCustomerId());
		wdCustomer.setBlack("0"); // 黑名单信任
		wdCustomer.setUpdateBy(UserUtils.getUser().getId());
		wdCustomer.setUpdateDate(new Date());
		wdCustomerService.updateByPrimaryKeySelective(wdCustomer);
		return new JsonResult();
	}

	/**
	 * 分配 date: 2017年5月6日 下午1:38:08 <br/>
	 * 
	 * @author Liam
	 * @param model
	 * @param customerIds
	 * @return
	 * @since JDK 1.8
	 */
	@RequiresPermissions("wd:customer:transfer")
	@RequestMapping(value = { "customerTransfer" })
	@ResponseBody
	public JsonResult customerTransfer(Model model, String customerRaletions, String userId) {

		SysUser user = UserUtils.get(userId);

		if (StringUtils.isNotEmpty(customerRaletions)) {
			String[] customerRaletionIdArray = customerRaletions.split(",");
			for (String customerRaletionId : customerRaletionIdArray) {
				WdCustomerRelation customerRelation = wdCustomerRelationService.selectByPrimaryKey(customerRaletionId);
				String oldUserId = customerRelation.getUserId();
				String oldUserName = customerRelation.getUserName();

				customerRelation.setDelFlag(true);
				customerRelation.setUpdateBy(UserUtils.getUser().getId());
				customerRelation.setUpdateDate(new Date());
				wdCustomerRelationService.updateByPrimaryKeySelective(customerRelation);

				customerRelation.setCreateBy(UserUtils.getUser().getId());
				customerRelation.setCreateDate(new Date());
				customerRelation.setUserId(user.getId());
				customerRelation.setUserName(user.getName());
				customerRelation.setDelFlag(false);
				customerRelation.setId(UidUtil.uuid());
				wdCustomerRelationService.insertSelective(customerRelation);

				wdApplicationService.transfer(userId, oldUserId, UserUtils.getUser(), customerRelation.getCustomerId());
				// 贷后数据修改
				cardInfoService.transfer(user, oldUserId, UserUtils.getUser(), customerRelation.getCustomerId());

				WdCustomerTrack wdCustomerTrack = new WdCustomerTrack();
				wdCustomerTrack.setId(UidUtil.uuid());
				wdCustomerTrack.setCustomerId(customerRelation.getCustomerId());
				wdCustomerTrack.setTitle("客户移交");
				wdCustomerTrack.setContent("客户" + (StringUtils.isBlank(oldUserName) ? "" : "由" + oldUserName) + "移交给" + user.getName());
				wdCustomerTrack.setCategory("移交记录");
				wdCustomerTrack.setCreateBy(UserUtils.getUser().getId());
				wdCustomerTrack.setCreateDate(new Date());
				wdCustomerTrack.setUpdateBy(UserUtils.getUser().getId());
				wdCustomerTrack.setUpdateDate(new Date());
				wdCustomerTrackService.insertSelective(wdCustomerTrack);
			}
		}
		return new JsonResult();
	}

	@RequiresPermissions(value = { "wd:customer:view", "wd:application:view" }, logical = Logical.OR)
	@RequestMapping(value = { "/merge/list" })
	public String mergeCustomerList(Model model, HttpServletRequest request) {
		List<Map<String, Object>> result = new ArrayList<>();

		List<String> idNos = wdPersonService.selectRepeatedIdNo(null);
		for (String idNo : idNos) {
			Map<String, Object> mapPerson = new HashMap<>();
			mapPerson.put("idNo", idNo);

			List<Map<String, Object>> customers = wdCustomerService.selectByIdNo(idNo);
			mapPerson.put("customers", customers);

			result.add(mapPerson);
		}

		model.addAttribute("result", result);

		return "modules/wd/customer/mergeList";
	}

	@RequestMapping(value = { "/merge" })
	@ResponseBody
	public JsonResult mergeCustomer(String personId, String userId, HttpServletRequest request) {
		WdPerson person = wdPersonService.selectByPrimaryKey(personId);
		Object data = person.getBaseInfo();

		String customerId = "";
		List<Map<String, Object>> customers = wdCustomerService.selectByIdNo(person.getIdNumber());
		for (Map<String, Object> customer : customers) {
			if (customer.get("personId").toString().equals(personId)) {
				customerId = customer.get("customerId").toString();
				break;
			}
		}
		for (Map<String, Object> customer : customers) {
			if (customer.get("personId").toString().equals(personId)) {
				continue;
			}

			String oldPersonId = customer.get("personId").toString();

			List<WdPersonAssetsBuildingRelation> buildings = personBuildingRelationService.selectByPersonId(oldPersonId);
			for (WdPersonAssetsBuildingRelation building : buildings) {
				building.setPersonId(personId);
				personBuildingRelationService.updateByPrimaryKeySelective(building);
			}

			List<WdPersonAssetsCar> cars = personCarService.selectByPersonId(oldPersonId);
			for (WdPersonAssetsCar car : cars) {
				car.setPersonId(personId);
				personCarService.updateByPrimaryKeySelective(car);
			}

			List<WdPersonBalanceSheet> balanceSheets = personBalanceSheetService.selectByPersonId(oldPersonId);
			for (WdPersonBalanceSheet balanceSheet : balanceSheets) {
				balanceSheet.setPersonId(personId);
				personBalanceSheetService.updateByPrimaryKeySelective(balanceSheet);
			}

			List<WdPersonBusinessRelation> businessRelations = personBusinessRelationService.selectByPersonId(oldPersonId);
			for (WdPersonBusinessRelation businessRelation : businessRelations) {
				businessRelation.setPersonId(personId);
				personBusinessRelationService.updateByPrimaryKeySelective(businessRelation);
			}

			List<WdPersonBusinessIncomeStatementDetails> incomeStatementDetails = personIncomeStatementService.selectByPersonId(oldPersonId);
			for (WdPersonBusinessIncomeStatementDetails incomeStatementDetail : incomeStatementDetails) {
				incomeStatementDetail.setPersonId(personId);
				personIncomeStatementService.updateByPrimaryKeySelective(incomeStatementDetail);
			}

			List<WdPersonExtendInfo> extendInfos = personExtendService.selectByPersonId(oldPersonId);
			for (WdPersonExtendInfo extendInfo : extendInfos) {
				extendInfo.setPersonId(personId);
				personExtendService.updateByPrimaryKeySelective(extendInfo);
			}

			List<WdPersonMonthlyIncomeStatement> monthlyIncomeStatements = personMonthlyIncomeStatementService.selectByPersonId(oldPersonId);
			for (WdPersonMonthlyIncomeStatement monthlyIncomeStatement : monthlyIncomeStatements) {
				monthlyIncomeStatement.setPersonId(personId);
				personMonthlyIncomeStatementService.updateByPrimaryKeySelective(monthlyIncomeStatement);
			}

			List<WdPersonYearlyIncomeStatement> yearlyIncomeStatements = personYearlyIncomeStatementService.selectByPersonId(oldPersonId);
			for (WdPersonYearlyIncomeStatement monthlyIncomeStatement : yearlyIncomeStatements) {
				monthlyIncomeStatement.setPersonId(personId);
				personYearlyIncomeStatementService.updateByPrimaryKeySelective(monthlyIncomeStatement);
			}

			List<WdApplicationPerson> borrowers = applicatonPersonService.selectByOriginalId(oldPersonId);
			for (WdApplicationPerson borrower : borrowers) {
				borrower.setOriginalId(personId);
				applicatonPersonService.updateByPrimaryKeySelective(borrower);
			}

			List<WdApplicationPersonRelation> applicationRelations = applicatonRelatedPersonService.selectByOriginalId(oldPersonId);
			for (WdApplicationPersonRelation applicationRelation : applicationRelations) {
				applicationRelation.setOriginalId(personId);
				applicatonRelatedPersonService.updateByPrimaryKeySelective(applicationRelation);
			}

			List<WdApplicationRecognizor> applicationRecognizors = personRecognizorService.selectByOriginalId(oldPersonId);
			for (WdApplicationRecognizor recognizor : applicationRecognizors) {
				recognizor.setOriginalId(personId);
				personRecognizorService.updateByPrimaryKeySelective(recognizor);
			}

			List<WdApplicationCoborrower> applicationCoborrowers = personCoborrowerService.selectByOriginalId(oldPersonId);
			for (WdApplicationCoborrower coborrower : applicationCoborrowers) {
				coborrower.setOriginalId(personId);
				personCoborrowerService.updateByPrimaryKeySelective(coborrower);
			}

			String oldCustomerId = customer.get("customerId").toString();

			List<WdApplication> applications = wdApplicationService.selectByCustomerId(oldCustomerId);
			for (WdApplication application : applications) {
				application.setCustomerId(customerId);
				wdApplicationService.updateByPrimaryKeySelective(application);
			}

			List<WdPersonRelation> relations = wdPersonRelationService.selectByDebtorPersonId(oldPersonId);
			for (WdPersonRelation relation : relations) {
				if (wdPersonRelationService.selectByDebtorPersonIdAndRelatedPersonId(personId, relation.getRelatedPersonId()) == null) {
					relation.setDebtorPersonId(personId);
					relation.setDebtorPersonName(person.getName());

					wdPersonRelationService.updateByPrimaryKeySelective(relation);
				} else {
					wdPersonRelationService.deleteByPrimaryKey(relation.getId());
				}
			}
			relations = wdPersonRelationService.selectByRelatedPersonId(oldPersonId);
			for (WdPersonRelation relation : relations) {
				if (wdPersonRelationService.selectByDebtorPersonIdAndRelatedPersonId(relation.getDebtorPersonId(), personId) == null) {
					relation.setRelatedPersonId(personId);
					relation.setRelatedPersonName(person.getName());

					wdPersonRelationService.updateByPrimaryKeySelective(relation);
				} else {
					wdPersonRelationService.deleteByPrimaryKey(relation.getId());
				}
			}

			wdCustomerService.deleteByPrimaryKey(oldCustomerId);

			String customerRelationId = customer.get("relationId").toString();
			wdCustomerRelationService.deleteByPrimaryKey(customerRelationId);

			WdPerson oldPerson = wdPersonService.selectByPrimaryKey(oldPersonId);
			data = JsonUtils.assembleTwoModel(oldPerson.getBaseInfo(), data);
			wdPersonService.deleteByPrimaryKey(oldPersonId);
		}

		person.setBaseInfo(data);
		wdPersonService.updateByPrimaryKeySelective(person);

		return new JsonResult();
	}

	@RequiresPermissions("wd:customer:showhideinfo")
	@RequestMapping(value = { "/hide_info" })
	@ResponseBody
	public JsonResult getPersonHideInfo(String elementKey, String personId) {
		WdPerson person = wdPersonService.selectByPrimaryKey(personId);
		if (null == person) {
			return new JsonResult(false, "找不到客户信息");
		}

		Map<String, Object> personInfo = person.getJsonData();
		if (!personInfo.containsKey(elementKey)) {
			return new JsonResult(false, "找不到客户相关数据");
		}

		return new JsonResult(true, personInfo.get(elementKey).toString());
	}

	@RequiresPermissions("wd:customer:editspecialinfo")
	@RequestMapping(value = { "/change_name" })
	@ResponseBody
	public JsonResult changePersonName(String name, String personId) {
		if (StringUtils.isBlank(name)) {
			return new JsonResult(false, "客户姓名不能为空");
		}

		WdPerson person = wdPersonService.selectByPrimaryKey(personId);
		if (null == person) {
			return new JsonResult(false, "找不到客户的详细信息");
		}
		WdCustomer customer = wdCustomerService.selectByPersonId(personId);
		if (null == customer) {
			return new JsonResult(false, "找不到客户信息");
		}

		// 检查是否符合修改的条件
		List<WdApplication> applications = wdApplicationService.selectByCustomerId(customer.getId());
		for (WdApplication application : applications) {
			if ((application.getStatus() & 7168) != 0) {
				return new JsonResult(false, "暂时不能修改客户姓名，错误代码EA，请联系管理员");
			}
		}

		List<WdApplicationCoborrower> coborrowers = personCoborrowerService.selectByOriginalId(personId);
		for (WdApplicationCoborrower coborrower : coborrowers) {
			WdApplication application = wdApplicationService.selectByPrimaryKey(coborrower.getApplicationId());
			if (null != application && (application.getStatus() & 7168) != 0) {
				return new JsonResult(false, "暂时不能修改客户姓名，错误代码EC，请联系管理员");
			}
		}

		List<WdApplicationRecognizor> recognizors = personRecognizorService.selectByOriginalId(personId);
		for (WdApplicationRecognizor recognizor : recognizors) {
			WdApplication application = wdApplicationService.selectByPrimaryKey(recognizor.getApplicationId());
			if (null != application && (application.getStatus() & 7168) != 0) {
				return new JsonResult(false, "暂时不能修改客户姓名，错误代码ER，请联系管理员");
			}
		}

		// 修改客户姓名的逻辑
		// 人员信息
		person.setName(name);
		Map<String, Object> personData = person.getJsonData();
		personData.put("base_info_name", name);
		person.setBaseInfo(JSON.toJSONString(personData));

		wdPersonService.updateByPrimaryKeySelective(person);

		// 客户信息
		String customerTypeId = customer.getCustomerTypeId();
		if (StringUtils.isBlank(customerTypeId)) {
			return new JsonResult(false, "缺少客户类型");
		}
		WdCustomerType customerType = wdCustomerTypeService.selectByPrimaryKey(customerTypeId);
		if (null == customerType) {
			return new JsonResult(false, "客户类型有问题");
		}
		String titleCol = customerType.getTitleCol();
		String subtitleCol = customerType.getSubtitleCol();
		String portraitCol = customerType.getPortraitCol();

		if (StringUtils.isBlank(titleCol)) {
			customer.setTitle(name);
		} else {
			WdBusinessElement element = wdBusinessElementService.selectByPrimaryKey(titleCol);
			if (null == element || "base_info_name".equals(element.getKey())) {
				customer.setTitle(name);
			}
		}
		if (StringUtils.isNotBlank(subtitleCol)) {
			WdBusinessElement element = wdBusinessElementService.selectByPrimaryKey(subtitleCol);
			if (null != element && "base_info_name".equals(element.getKey())) {
				customer.setSubtitle(name);
			}
		}
		if (StringUtils.isNotBlank(portraitCol)) {
			WdBusinessElement element = wdBusinessElementService.selectByPrimaryKey(portraitCol);
			if (null != element && "base_info_name".equals(element.getKey())) {
				customer.setPortrait(name);
			}
		}
		wdCustomerService.updateByPrimaryKeySelective(customer);

		// 申请信息
		for (WdApplication application : applications) {
			application.setCustomerName(name);
			wdApplicationService.updateByPrimaryKeySelective(application);
		}

		// 申请归档信息
		List<WdApplicationPerson> applicationPersons = applicatonPersonService.selectByOriginalId(personId);
		for (WdApplicationPerson applicationPerson : applicationPersons) {
			applicationPerson.setBaseInfo(JSON.toJSONString(personData));
			applicatonPersonService.updateByPrimaryKeySelective(applicationPerson);
		}

		// 征信信息
		List<WdApplicationCreditInvestigation> investigations = creditInvestigationService.selectByPerson(personId);
		for (WdApplicationCreditInvestigation investigation : investigations) {
			investigation.setName(name);
			creditInvestigationService.updateByPrimaryKeySelective(investigation);
		}

		// 共同借款人
		for (WdApplicationCoborrower coborrower : coborrowers) {
			coborrower.setRelationPersonName(name);
			personCoborrowerService.updateByPrimaryKeySelective(coborrower);
		}

		// 担保人
		for (WdApplicationRecognizor recognizor : recognizors) {
			recognizor.setRelationPersonName(name);
			personRecognizorService.updateByPrimaryKeySelective(recognizor);
		}

		SysUser user = UserUtils.getUser();
		if (null != user) {
			checkCourtInfo(personId, user.getId(), customer.getId());
		}

		return new JsonResult(true, name);
	}

	@RequiresPermissions("wd:customer:editspecialinfo")
	@RequestMapping(value = { "/change_idno" })
	@ResponseBody
	public JsonResult changePersonIdNo(String idno, String personId) {
		if (StringUtils.isBlank(idno)) {
			return new JsonResult(false, "身份证号不能为空");
		}

		try {
			IDCard.IDCardValidate(idno);
		} catch (ParseException | GeneralException e) {
			return new JsonResult(false, e.getMessage());
		}

		WdPerson person = wdPersonService.selectByPrimaryKey(personId);
		if (null == person) {
			return new JsonResult(false, "找不到客户的详细信息");
		}
		WdCustomer customer = wdCustomerService.selectByPersonId(personId);
		if (null == customer) {
			return new JsonResult(false, "找不到客户信息");
		}

		// 检查是否符合修改的条件
		List<WdApplication> applications = wdApplicationService.selectByCustomerId(customer.getId());
		for (WdApplication application : applications) {
			if ((application.getStatus() & 7168) != 0) {
				return new JsonResult(false, "暂时不能修改客户姓名，错误代码EA，请联系管理员");
			}
		}

		List<WdApplicationCoborrower> coborrowers = personCoborrowerService.selectByOriginalId(personId);
		for (WdApplicationCoborrower coborrower : coborrowers) {
			WdApplication application = wdApplicationService.selectByPrimaryKey(coborrower.getApplicationId());
			if (null != application && (application.getStatus() & 7168) != 0) {
				return new JsonResult(false, "暂时不能修改客户姓名，错误代码EC，请联系管理员");
			}
		}

		List<WdApplicationRecognizor> recognizors = personRecognizorService.selectByOriginalId(personId);
		for (WdApplicationRecognizor recognizor : recognizors) {
			WdApplication application = wdApplicationService.selectByPrimaryKey(recognizor.getApplicationId());
			if (null != application && (application.getStatus() & 7168) != 0) {
				return new JsonResult(false, "暂时不能修改客户姓名，错误代码ER，请联系管理员");
			}
		}

		// 修改客户身份证的逻辑
		// 人员信息
		person.setIdNumber(idno);
		Map<String, Object> personData = person.getJsonData();
		personData.put("base_info_idcard", idno);
		person.setBaseInfo(JSON.toJSONString(personData));

		wdPersonService.updateByPrimaryKeySelective(person);

		// 客户信息
		String customerTypeId = customer.getCustomerTypeId();
		if (StringUtils.isBlank(customerTypeId)) {
			return new JsonResult(false, "缺少客户类型");
		}
		WdCustomerType customerType = wdCustomerTypeService.selectByPrimaryKey(customerTypeId);
		if (null == customerType) {
			return new JsonResult(false, "客户类型有问题");
		}
		String titleCol = customerType.getTitleCol();
		String subtitleCol = customerType.getSubtitleCol();
		String portraitCol = customerType.getPortraitCol();

		if (StringUtils.isNotBlank(titleCol)) {
			WdBusinessElement element = wdBusinessElementService.selectByPrimaryKey(titleCol);
			if (null != element && "base_info_idcard".equals(element.getKey())) {
				customer.setTitle(idno);
			}
		}
		if (StringUtils.isNotBlank(subtitleCol)) {
			WdBusinessElement element = wdBusinessElementService.selectByPrimaryKey(subtitleCol);
			if (null != element && "base_info_idcard".equals(element.getKey())) {
				customer.setSubtitle(idno);
			}
		}
		if (StringUtils.isNotBlank(portraitCol)) {
			WdBusinessElement element = wdBusinessElementService.selectByPrimaryKey(portraitCol);
			if (null != element && "base_info_idcard".equals(element.getKey())) {
				customer.setPortrait(idno);
			}
		}
		wdCustomerService.updateByPrimaryKeySelective(customer);

		// 申请归档信息
		List<WdApplicationPerson> applicationPersons = applicatonPersonService.selectByOriginalId(personId);
		for (WdApplicationPerson applicationPerson : applicationPersons) {
			applicationPerson.setBaseInfo(JSON.toJSONString(personData));
			applicatonPersonService.updateByPrimaryKeySelective(applicationPerson);
		}

		// 征信信息
		List<WdApplicationCreditInvestigation> investigations = creditInvestigationService.selectByPerson(personId);
		for (WdApplicationCreditInvestigation investigation : investigations) {
			investigation.setIdCard(idno);
			creditInvestigationService.updateByPrimaryKeySelective(investigation);
		}

		SysUser user = UserUtils.getUser();
		if (null != user) {
			checkCourtInfo(personId, user.getId(), customer.getId());
		}

		return new JsonResult(true, idno);
	}

	@RequiresPermissions("wd:customer:delete")
	@RequestMapping(value = { "/del" })
	@ResponseBody
	public JsonResult delCustomer(String customerId) {
		if (StringUtils.isBlank(customerId)) {
			return new JsonResult(false, "CustomerID不能为空");
		}

		BaseWdCustomer customer = wdCustomerService.selectByPrimaryKey(customerId);
		if (null == customer) {
			return new JsonResult(false, "找不到客户信息");
		}
		BaseWdPerson person = wdPersonService.selectByPrimaryKey(customer.getPersonId());
		if (null == person) {
			return new JsonResult(false, "找不到客户的详细信息");
		}

		// 检查是否符合修改的条件
		String applicationCodes = "";
		List<WdApplication> cancelApps = new ArrayList<>();
		List<WdApplication> applications = wdApplicationService.selectByCustomerId(customer.getId());
		for (WdApplication application : applications) {
			if (null == application) {
				continue;
			}
			if ((application.getStatus() & 16384) != 0) {
				return new JsonResult(false, "客户的申请已经被拒，不可删除客户");
			}
			if ((application.getStatus() & 4096) != 0) {
				return new JsonResult(false, "客户的申请已经入档，不可删除客户");
			}
			if ((application.getStatus() & 3072) != 0) {
				return new JsonResult(false, "客户的申请已经放款，不可删除客户");
			}

			if ((application.getStatus() & 8192) != 0) { // 撤销
				cancelApps.add(application);
			}

			if ((application.getStatus() & 1023) != 0) {
				applicationCodes += ("," + application.getCode());
			}
		}
		if (StringUtils.isNotBlank(applicationCodes)) {
			applicationCodes = applicationCodes.substring(1);
			return new JsonResult(false, "客户的申请[" + applicationCodes + "]正在进行中，必须先删除申请，再删除客户");
		}

		for (WdApplication application : cancelApps) {
			processHandle.delApplication(application);
		}

		List<WdApplicationCoborrower> coborrowers = personCoborrowerService.selectByOriginalId(customer.getPersonId());
		for (WdApplicationCoborrower coborrower : coborrowers) {
			WdApplication application = wdApplicationService.selectByPrimaryKey(coborrower.getApplicationId());
			if (null != application) {
				return new JsonResult(false, "客户在申请[" + application.getCode() + "]中作为共同借款人，不能删除客户");
			}
		}

		List<WdApplicationRecognizor> recognizors = personRecognizorService.selectByOriginalId(customer.getPersonId());
		for (WdApplicationRecognizor recognizor : recognizors) {
			WdApplication application = wdApplicationService.selectByPrimaryKey(recognizor.getApplicationId());
			if (null != application) {
				return new JsonResult(false, "客户在申请[" + application.getCode() + "]中作为担保人，不能删除客户");
			}
		}

		WdCustomerBackup customerBackup = new WdCustomerBackup();
		customerBackup.setId(customer.getId());
		customerBackup.setPersonId(customer.getPersonId());
		customerBackup.setBusinessId(customer.getBusinessId());
		customerBackup.setCustomerTypeId(customer.getCustomerTypeId());
		customerBackup.setCustomerTypeName(customer.getCustomerTypeName());
		customerBackup.setCustomerTypeCode(customer.getCustomerTypeCode());
		customerBackup.setPortrait(customer.getPortrait());
		customerBackup.setTitle(customer.getTitle());
		customerBackup.setSubtitle(customer.getSubtitle());
		customerBackup.setBlack(customer.getBlack());
		customerBackup.setCreateBy(customer.getCreateBy());
		customerBackup.setCreateDate(customer.getCreateDate());
		customerBackup.setUpdateBy(customer.getUpdateBy());
		customerBackup.setUpdateDate(customer.getUpdateDate());

		customerBackupService.insertSelective(customerBackup);

		WdPersonBackup personBackup = new WdPersonBackup();
		personBackup.setId(person.getId());
		personBackup.setName(person.getName());
		personBackup.setPhone(person.getPhone());
		personBackup.setIdNumber(person.getIdNumber());
		personBackup.setBaseInfo(person.getBaseInfo());
		personBackup.setIdLocked(person.getIdLocked());
		personBackup.setCreateBy(person.getCreateBy());
		personBackup.setCreateDate(person.getCreateDate());
		personBackup.setUpdateBy(person.getUpdateBy());
		personBackup.setUpdateDate(person.getUpdateDate());

		personBackupService.insertSelective(personBackup);

		wdCustomerService.deleteByPrimaryKey(customer.getId());
		wdPersonService.deleteByPrimaryKey(person.getId());

		List<WdCustomerBacklist> backlists = wdCustomerBacklistService.selectByCustomerId(customerId);
		for (WdCustomerBacklist backlist : backlists) {
			backlist.setDelFlag(true);
			wdCustomerBacklistService.updateByPrimaryKeySelective(backlist);
		}
		List<WdCustomerLocation> locations = wdCustomerlocationService.selectByCustomerId(customerId);
		for (WdCustomerLocation location : locations) {
			location.setDelFlag(true);
			wdCustomerlocationService.updateByPrimaryKeySelective(location);
		}
		List<WdCustomerRelation> relations = wdCustomerRelationService.selectByCutomerId(customerId);
		for (WdCustomerRelation relation : relations) {
			relation.setDelFlag(true);
			wdCustomerRelationService.updateByPrimaryKeySelective(relation);
		}
		// MARK:客户动态信息未处理

		List<String> buildingIds = new ArrayList<>();
		List<WdPersonAssetsBuildingRelation> buildingRelations = personBuildingRelationService.selectByPersonId(person.getId());
		for (WdPersonAssetsBuildingRelation buildingRelation : buildingRelations) {
			buildingIds.add(buildingRelation.getBuildingId());
			personBuildingRelationService.deleteByPrimaryKey(buildingRelation.getId());
		}
		for (String buildingId : buildingIds) {
			if (personBuildingRelationService.countByBuilding(buildingId) == 0) {
				WdPersonAssetsBuilding building = wdPersonAssetsBuildingService.selectByPrimaryKey(buildingId);
				building.setDelFlag(true);
				wdPersonAssetsBuildingService.updateByPrimaryKeySelective(building);
			}
		}
		List<WdPersonAssetsCar> cars = personCarService.selectByPersonId(person.getId());
		for (WdPersonAssetsCar car : cars) {
			car.setDelFlag(true);
			personCarService.updateByPrimaryKeySelective(car);
		}
		List<WdPersonBalanceSheet> balanceSheets = personBalanceSheetService.selectByPersonId(person.getId());
		for (WdPersonBalanceSheet balanceSheet : balanceSheets) {
			balanceSheet.setDelFlag(true);
			personBalanceSheetService.updateByPrimaryKeySelective(balanceSheet);
		}
		WdPersonBubbleExample bubbleExample = new WdPersonBubbleExample();
		bubbleExample.createCriteria().andPersonIdEqualTo(person.getId());
		personBubbleService.deleteByExample(bubbleExample);

		List<String> businessIds = new ArrayList<>();
		List<WdPersonBusinessRelation> businessRelations = personBusinessRelationService.selectByPersonId(person.getId());
		for (WdPersonBusinessRelation businessRelation : businessRelations) {
			businessIds.add(businessRelation.getBusinessId());
			personBusinessRelationService.deleteByPrimaryKey(businessRelation.getId());
		}
		for (String businessId : businessIds) {
			WdPersonBusiness business = businessService.selectByPrimaryKey(businessId);
			business.setDelFlag(true);
			businessService.updateByPrimaryKeySelective(business);
		}
		List<WdPersonBusinessIncomeStatementDetails> incomeStatementDetails = personIncomeStatementService.selectByPersonId(person.getId());
		for (WdPersonBusinessIncomeStatementDetails incomeStatementDetail : incomeStatementDetails) {
			incomeStatementDetail.setDelFlag(true);
			personIncomeStatementService.updateByPrimaryKeySelective(incomeStatementDetail);
		}
		List<WdPersonExtendInfo> extendInfos = personExtendService.selectByPersonId(person.getId());
		for (WdPersonExtendInfo extendInfo : extendInfos) {
			extendInfo.setDelFlag(true);
			personExtendService.updateByPrimaryKeySelective(extendInfo);
		}
		List<WdPersonMonthlyIncomeStatement> monthlyIncomeStatements = personMonthlyIncomeStatementService.selectByPersonId(person.getId());
		for (WdPersonMonthlyIncomeStatement monthlyIncomeStatement : monthlyIncomeStatements) {
			monthlyIncomeStatement.setDelFlag(true);
			personMonthlyIncomeStatementService.updateByPrimaryKeySelective(monthlyIncomeStatement);
		}
		List<WdPersonYearlyIncomeStatement> yearlyIncomeStatements = personYearlyIncomeStatementService.selectByPersonId(person.getId());
		for (WdPersonYearlyIncomeStatement yearlyIncomeStatement : yearlyIncomeStatements) {
			yearlyIncomeStatement.setDelFlag(true);
			personYearlyIncomeStatementService.updateByPrimaryKeySelective(yearlyIncomeStatement);
		}
		List<WdPersonRelation> personRelations = wdPersonRelationService.selectByDebtorPersonId(person.getId());
		for (WdPersonRelation personRelation : personRelations) {
			wdPersonRelationService.deleteByPrimaryKey(personRelation.getId());
		}
		personRelations = wdPersonRelationService.selectByRelatedPersonId(person.getId());
		for (WdPersonRelation personRelation : personRelations) {
			wdPersonRelationService.deleteByPrimaryKey(personRelation.getId());
		}

		return new JsonResult(true, customerId);
	}

	private void checkCourtInfo(String personId, String userId, String customerId) {

		try {
			SysConfiguration zhixingConfig = configService.selectByKeyAndUser("court_zhixing", userId);
			if (null != zhixingConfig && zhixingConfig.getValue().equals("enable")) {
				wdCourtQueryService.searchZhixin(personId, userId, customerId, true, null, null, null);
			}
			SysConfiguration shixinConfig = configService.selectByKeyAndUser("court_shixin", userId);
			if (null != shixinConfig && shixinConfig.getValue().equals("enable")) {
				wdCourtQueryService.searchShixin(personId, userId, customerId, true, null, null, null);
			}
		} catch (GeneralException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

}
