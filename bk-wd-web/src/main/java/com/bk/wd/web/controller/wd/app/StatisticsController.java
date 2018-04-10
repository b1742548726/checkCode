package com.bk.wd.web.controller.wd.app;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.bk.bi.wd.service.BiUserStatisticsService;
import com.bk.bi.wd.utils.StatisticsUtils;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysOffice;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.service.SystemService;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysOfficeService;
import com.bk.sys.service.SysUserService;
import com.bk.wd.model.WdProduct;
import com.bk.wd.service.WdProductService;

@Controller
@RequestMapping(value = "/wd/statistics")
public class StatisticsController {

	@Autowired
	private WdProductService wdProductService;

	@Autowired
	private StatisticsUtils statisticsUtils;

	@Autowired
	private SysOfficeService sysOfficeService;

	@Autowired
	private SysUserService sysUserService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private BiUserStatisticsService biUserStatisticsService;

	@RequiresPermissions("wd:statistics:product:view")
	@RequestMapping(value = { "product" })
	public String productIndex(Model model) {
	    statisticsUtils.count();
	    
	    List<WdProduct> products = wdProductService.selectByRegion(UserUtils.getUser().getCompanyId());
	    
	    // MARK:后期采用字典
	    String[] productArray = {"车贷", "房贷", "消费贷", "经营贷", "信用卡"};
	    
	    List<Map<String, Object>> productList = new ArrayList<>();
	    for (String category : productArray) {
	        Map<String, Object> wdProductCategoryMap = new HashMap<>();
	        List<WdProduct> wdProductList = wdProductService.selectByCategory(products, category);
	        if (!wdProductList.isEmpty()) {
	            wdProductCategoryMap.put("productList", wdProductList);
	            wdProductCategoryMap.put("category", category);
	            productList.add(wdProductCategoryMap);
	        }
        }
	    model.addAttribute("productList", productList);
	    return "modules/wd/statistics/product/index";
	}
	
	@RequestMapping(value = { "product/charts" })
	public String productCharts(Model model, HttpServletRequest request, String productId, String productCategory, String dateType) {
	    
	    productCategory = StringUtils.toUTF8(productCategory);
	    
		Date endDate = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(endDate);
		switch (dateType) {
		case "2":
			calendar.add(Calendar.DATE, -7);
			break;
		case "3":
			calendar.add(Calendar.DATE, -45);
			break;
		case "4":
			calendar.add(Calendar.MONTH, -6);
			calendar.set(Calendar.DATE, 1);
			break;
		case "5":
			calendar.add(Calendar.MONTH, -12);
			calendar.set(Calendar.DATE, 1);
			break;

		default:
			break;
		}

		Date startDate = calendar.getTime();

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String startDateString = formatter.format(startDate);
		String endDateString = formatter.format(endDate);

		model.addAttribute("dateString", startDateString + " ~ " + endDateString);

		List<Map<String, Object>> statisticses = statisticsUtils.getProductStatistics(productId, productCategory, startDate, endDate);

		List<Map<String, String>> statisticsData = new ArrayList<>();
		BigDecimal totalAmount = new BigDecimal(0);
		Integer totalIntention = 0;
		Integer totalPassing = 0;
		Integer totalLoan = 0;

		if (!statisticses.isEmpty()) {
			BigDecimal temp = new BigDecimal("10000");
			if ((int) ((endDate.getTime() - startDate.getTime()) / 86400000) > 60) {

				SimpleDateFormat formatterMonth = new SimpleDateFormat("yyyy-MM");
				BigDecimal amount = new BigDecimal(0);
				Integer intention = 0;
				Integer passing = 0;
				Integer loan = 0;

				while (startDate.before(endDate)) {
					String date = formatterMonth.format(startDate);

					for (Map<String, Object> statistics : statisticses) {
						String date2 = formatterMonth.format(((Date) statistics.get("date_point")));
						if (!date.equals(date2)) {
							continue;
						}

						amount = amount.add(new BigDecimal(statistics.get("credit_amount").toString()));
						intention = intention + Integer.parseInt(statistics.get("intention_num").toString());
						passing = passing + Integer.parseInt(statistics.get("passing_num").toString());
						loan = loan + Integer.parseInt(statistics.get("loan_num").toString());

						totalAmount = totalAmount.add(new BigDecimal(statistics.get("credit_amount").toString()));
						totalIntention = totalIntention + Integer.parseInt(statistics.get("intention_num").toString());
						totalPassing = totalPassing + Integer.parseInt(statistics.get("passing_num").toString());
						totalLoan = totalLoan + Integer.parseInt(statistics.get("loan_num").toString());
					}

					Map<String, String> data = new HashMap<>();
					data.put("date", date);
					data.put("amount", amount.divide(temp, 2).toString());
					data.put("intention", intention.toString());
					data.put("passing", passing.toString());
					data.put("loan", loan.toString());
					statisticsData.add(data);

					amount = new BigDecimal(0);
					intention = 0;
					passing = 0;
					loan = 0;

					calendar.setTime(startDate);
					calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) + 1);
					startDate = calendar.getTime();
				}

			} else {

				while (startDate.before(endDate)) {
					String date = formatter.format(startDate);
					for (Map<String, Object> statistics : statisticses) {
						String date2 = formatter.format(((Date) statistics.get("date_point")));
						if (date.equals(date2)) {

							Map<String, String> data = new HashMap<>();
							data.put("date", date2);
							data.put("amount", new BigDecimal(statistics.get("credit_amount").toString()).divide(temp, 2).toString());
							data.put("intention", statistics.get("intention_num").toString());
							data.put("passing", statistics.get("passing_num").toString());
							data.put("loan", statistics.get("loan_num").toString());
							statisticsData.add(data);

							totalAmount = totalAmount.add(new BigDecimal(statistics.get("credit_amount").toString()));
							totalIntention = totalIntention + Integer.parseInt(statistics.get("intention_num").toString());
							totalPassing = totalPassing + Integer.parseInt(statistics.get("passing_num").toString());
							totalLoan = totalLoan + Integer.parseInt(statistics.get("loan_num").toString());

							break;
						}
					}

					calendar.setTime(startDate);
					calendar.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH) + 1);
					startDate = calendar.getTime();
				}
			}
		}
		model.addAttribute("data", statisticsData);
		model.addAttribute("productId", productId);
		model.addAttribute("productCategory", productCategory);
		model.addAttribute("dateType", dateType);

		model.addAttribute("totalAmount", totalAmount.divide(new BigDecimal("10000"), 2).toString());
		model.addAttribute("totalIntention", totalIntention.toString());
		model.addAttribute("totalPassing", totalPassing.toString());
		model.addAttribute("totalLoan", totalLoan.toString());

		return "modules/wd/statistics/product/charts";
	}

	@RequiresPermissions("wd:statistics:ratio:view")
	@RequestMapping(value = { "ratio" })
	public String retioIndex(Model model) {
	    statisticsUtils.count();
	    return "modules/wd/statistics/ratio/index";
	}
	
	@RequestMapping(value = { "ratio/charts" })
	public String ratioCharts(Model model, HttpServletRequest request, String ratioType, String dateType) {
		Date endDate = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(endDate);
		switch (dateType) {
		case "2":
			calendar.add(Calendar.DATE, -7);
			break;
		case "3":
			calendar.add(Calendar.DATE, -45);
			break;
		case "4":
			calendar.add(Calendar.MONTH, -6);
			calendar.set(Calendar.DATE, 1);
			break;
		case "5":
			calendar.add(Calendar.MONTH, -12);
			calendar.set(Calendar.DATE, 1);
			break;

		default:
			break;
		}

		Date startDate = calendar.getTime();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String startDateString = formatter.format(startDate);
		String endDateString = formatter.format(endDate);

		model.addAttribute("dateString", startDateString + " ~ " + endDateString);

		List<Map<String, Object>> list = new ArrayList<>();
		if (ratioType.equals("customer")) {
			list = statisticsUtils.getCustomerStatistics(startDate, endDate);
		} else if (ratioType.equals("guarantee")) {
			list = statisticsUtils.getGuaranteeStatistics(startDate, endDate);
		}

		List<Map<String, String>> statisticsData = new ArrayList<>();
		BigDecimal temp = new BigDecimal("10000");
		BigDecimal temp2 = new BigDecimal("100");
		for (Map<String, Object> map : list) {
			Map<String, String> data = new HashMap<>();
			data.put("key", map.get("key").toString());
			data.put("name", map.get("name").toString());
			data.put("amount", ((BigDecimal) map.get("amount")).divide(temp, 2).toString());
			data.put("percentage", ((BigDecimal) map.get("percentage")).multiply(temp2).setScale(2, BigDecimal.ROUND_HALF_UP).toString());
			statisticsData.add(data);
		}

		model.addAttribute("data", statisticsData);
		model.addAttribute("ratioType", ratioType);
		model.addAttribute("dateType", dateType);
		return "modules/wd/statistics/ratio/charts";
	}

	@RequiresPermissions("wd:statistics:team:view")
	@RequestMapping(value = { "team" })
	public String team_index(Model model) {
	    statisticsUtils.count();
	    
	    List<SysOffice> officeLsit = sysOfficeService.treeData(systemService.findAllOffice(), SysOffice.HeadCompany);
	    
        model.addAttribute("officeList", officeLsit);
        return "modules/wd/statistics/team/index";
	}
	
	@RequestMapping(value = { "team_charts" })
	public String team_charts(Model model, HttpServletRequest request, String officeId, String dateType) {
        Date endDate = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(endDate);
        switch (dateType) {
        case "2":
            calendar.add(Calendar.DATE, -7);
            break;
        case "3":
            calendar.add(Calendar.DATE, -45);
            break;
        case "4":
            calendar.add(Calendar.MONTH, -6);
            calendar.set(Calendar.DATE, 1);
            break;
        case "5":
            calendar.add(Calendar.MONTH, -12);
            calendar.set(Calendar.DATE, 1);
            break;

        default:
            break;
        }
        
        Date startDate = calendar.getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String startDateString = formatter.format(startDate);
        String endDateString = formatter.format(endDate);

        model.addAttribute("dateString", startDateString + " ~ " + endDateString);

        List<SysOffice> childrenOffice = sysOfficeService.selectChildList(officeId);
        if (childrenOffice.isEmpty()) {
            SysOffice sysOffice = new SysOffice();
            sysOffice.setId(officeId);
            List<SysUser> officeUsers = sysUserService.selectByOffice(sysOffice);
            return userCompare(model, request, officeUsers, dateType, startDate, endDate);
        } else {
            return teamCompare(model, request, childrenOffice, dateType, startDate, endDate);
        }
	}

	public String teamCompare(Model model, HttpServletRequest request, List<SysOffice> teamIds, String dateType, Date startDate, Date endDate) {
		List<Map<String, Object>> list = new ArrayList<>();

		BigDecimal totalAmount = new BigDecimal(0);
		Integer totalVisit = 0;
		Integer totalIntention = 0;
		Integer totalSubmit = 0;
		Integer totalPassing = 0;
		Integer totalLoan = 0;

		for (SysOffice sysOffice : teamIds) {

			String officeId = sysOffice.getId();
			String officeName = sysOffice.getName();

			SysOffice selectOption = new SysOffice();
			selectOption.setId(officeId);

			List<SysUser> officeUsers = sysUserService.selectByOffice(selectOption);
			List<String> userIds = new ArrayList<>();
			for (SysUser sysUser : officeUsers) {
				userIds.add(sysUser.getId());
			}
			List<Map<String, Object>> sumList = biUserStatisticsService.selectSumByDateRange(userIds, startDate, endDate);

			Map<String, Object> sumObject = new HashMap<>();
			if (sumList.isEmpty() || sumList.get(0) == null) {
				sumObject.put("amount", new BigDecimal("0"));
				sumObject.put("visit", 0);
				sumObject.put("intention", 0);
				sumObject.put("submit", 0);
				sumObject.put("passing", 0);
				sumObject.put("loan", 0);
			} else {
				sumObject = sumList.get(0);
				sumObject.replace("amount", (new BigDecimal(sumObject.get("amount").toString())).divide(new BigDecimal("10000"), 2).toString());
			}

			sumObject.put("officeId", officeId);
			sumObject.put("officeName", officeName);
			list.add(sumObject);

			totalAmount = totalAmount.add(new BigDecimal(sumObject.get("amount").toString()));
			totalVisit = totalVisit + Integer.parseInt(sumObject.get("visit").toString());
			totalIntention = totalIntention + Integer.parseInt(sumObject.get("intention").toString());
			totalSubmit = totalSubmit + Integer.parseInt(sumObject.get("submit").toString());
			totalPassing = totalPassing + Integer.parseInt(sumObject.get("passing").toString());
			totalLoan = totalLoan + Integer.parseInt(sumObject.get("loan").toString());
		}

		// model.addAttribute("totalAmount", totalAmount.divide(new BigDecimal("10000"), 2).toString());
		model.addAttribute("totalAmount", totalAmount.divide(new BigDecimal("1"), 2).toString());
		model.addAttribute("totalVisit", totalVisit.toString());
        model.addAttribute("totalIntention", totalIntention.toString());
        model.addAttribute("totalSubmit", totalSubmit.toString());
		model.addAttribute("totalPassing", totalPassing.toString());
		model.addAttribute("totalLoan", totalLoan.toString());

		Integer size = list.size();
		// BigDecimal avgAmount = totalAmount.divide(new BigDecimal(10000 * size), 2);
		BigDecimal avgAmount = totalAmount.divide(new BigDecimal(size), 2);
		model.addAttribute("avgAmount", avgAmount);
		Integer avgVisit = (totalVisit / size);
		model.addAttribute("avgVisit", avgVisit);
        Integer avgIntention = (totalIntention / size);
        model.addAttribute("avgIntention", avgIntention);
        Integer avgSubmit = (totalSubmit / size);
        model.addAttribute("avgSubmit", avgSubmit);
		Integer avgPassing = (totalPassing / size);
		model.addAttribute("avgPassing", avgPassing);
		Integer avgLoan = (totalLoan / size);
		model.addAttribute("avgLoan", avgLoan);

		model.addAttribute("data", list);
		return "modules/wd/statistics/team/team_office_charts";
	}

	public String userCompare(Model model, HttpServletRequest request, List<SysUser> users, String dateType, Date startDate, Date endDate) {
		List<String> userIds = new ArrayList<>();
		for (SysUser sysUser : users) {
			userIds.add(sysUser.getId());
		}
		List<Map<String, Object>> list = biUserStatisticsService.selectUserSumByDateRange(userIds, startDate, endDate);

		BigDecimal totalAmount = new BigDecimal(0);
		Integer totalVisit = 0;
		Integer totalIntention = 0;
        Integer totalSubmit = 0;
		Integer totalPassing = 0;
		Integer totalLoan = 0;

		for (Map<String, Object> sumObject : list) {

			totalAmount = totalAmount.add(new BigDecimal(sumObject.get("amount").toString()));
			totalVisit = totalVisit + Integer.parseInt(sumObject.get("visit").toString());
			totalIntention = totalIntention + Integer.parseInt(sumObject.get("intention").toString());
			totalSubmit = totalSubmit + Integer.parseInt(sumObject.get("submit").toString());
			totalPassing = totalPassing + Integer.parseInt(sumObject.get("passing").toString());
			totalLoan = totalLoan + Integer.parseInt(sumObject.get("loan").toString());

			BigDecimal amount = new BigDecimal(sumObject.get("amount").toString());
			sumObject.replace("amount", amount.divide(new BigDecimal("10000"), 2).toString());

			userIds.remove(sumObject.get("user_id"));
		}

		for (String userId : userIds) {
			Map<String, Object> sumObject = new HashMap<>();
			sumObject.put("amount", new BigDecimal("0"));
			sumObject.put("visit", 0);
			sumObject.put("intention", 0);
			sumObject.put("passing", 0);
            sumObject.put("submit", 0);
			sumObject.put("loan", 0);
			sumObject.put("user_id", userId);
			sumObject.put("user_name", sysUserService.selectByPrimaryKey(userId).getName());

			list.add(sumObject);
		}

		model.addAttribute("totalAmount", totalAmount.divide(new BigDecimal("10000"), 2).toString());
		model.addAttribute("totalVisit", totalVisit.toString());
        model.addAttribute("totalIntention", totalIntention.toString());
        model.addAttribute("totalSubmit", totalSubmit.toString());
		model.addAttribute("totalPassing", totalPassing.toString());
		model.addAttribute("totalLoan", totalLoan.toString());

		Integer size = list.size();
		BigDecimal avgAmount = totalAmount.divide(new BigDecimal(10000 * size), 2);
		model.addAttribute("avgAmount", avgAmount);
		Integer avgVisit = (totalVisit / size);
		model.addAttribute("avgVisit", avgVisit);
		Integer avgIntention = (totalIntention / size);
		model.addAttribute("avgIntention", avgIntention);
        Integer avgSubmit = (totalSubmit / size);
        model.addAttribute("avgSubmit", avgSubmit);
		Integer avgPassing = (totalPassing / size);
		model.addAttribute("avgPassing", avgPassing);
		Integer avgLoan = (totalLoan / size);
		model.addAttribute("avgLoan", avgLoan);

		model.addAttribute("data", list);

		return "modules/wd/statistics/team/team_user_charts";
	}

	@RequestMapping(value = { "team_user_detail" })
	public String team_user_detail(Model model, HttpServletRequest request, String userId, String dateType) {

		if (StringUtils.isBlank(dateType)) {
			dateType = "1";
		}

		Date endDate = new Date();

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(endDate);
		switch (dateType) {
		case "2":
			calendar.add(Calendar.DATE, -7);
			break;
		case "3":
			calendar.add(Calendar.DATE, -45);
			break;
		case "4":
			calendar.add(Calendar.MONTH, -6);
			calendar.set(Calendar.DATE, 1);
			break;
		case "5":
			calendar.add(Calendar.MONTH, -12);
			calendar.set(Calendar.DATE, 1);
			break;

		default:
			break;
		}

		Date startDate = calendar.getTime();

		System.out.println(startDate);
		System.out.println(endDate);

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String startDateString = formatter.format(startDate);
		String endDateString = formatter.format(endDate);
		model.addAttribute("dateString", startDateString + " ~ " + endDateString);

		List<Map<String, Object>> statisticses = statisticsUtils.getUserStatistics(userId, startDate, endDate);

		List<Map<String, String>> statisticsData = new ArrayList<>();

		if (!statisticses.isEmpty()) {
			BigDecimal temp = new BigDecimal("10000");
			if ((int) ((endDate.getTime() - startDate.getTime()) / 86400000) > 60) {

				SimpleDateFormat formatterMonth = new SimpleDateFormat("yyyy-MM");
				while (startDate.before(endDate)) {
					String date = formatterMonth.format(startDate);

					BigDecimal amount = new BigDecimal(0);
					Integer visit = 0;
					Integer intention = 0;
					Integer submit = 0;
					Integer passing = 0;
					Integer loan = 0;

					for (Map<String, Object> statistics : statisticses) {
						String date2 = formatterMonth.format(((Date) statistics.get("date_point")));

						if (!date.equals(date2)) {
							continue;
						}

						amount = amount.add(new BigDecimal(statistics.get("credit_amount").toString()));
						visit = visit + Integer.parseInt(statistics.get("visit_num").toString());
						intention = intention + Integer.parseInt(statistics.get("intention_num").toString());
						submit = submit + Integer.parseInt(statistics.get("submit_num").toString());
						passing = passing + Integer.parseInt(statistics.get("passing_num").toString());
						loan = loan + Integer.parseInt(statistics.get("loan_num").toString());
					}

					Map<String, String> data = new HashMap<>();
					data.put("date", date);
					data.put("amount", amount.divide(temp, 2).toString());
					data.put("visit", visit.toString());
                    data.put("intention", intention.toString());
                    data.put("submit", submit.toString());
					data.put("passing", passing.toString());
					data.put("loan", loan.toString());
					statisticsData.add(data);

					amount = new BigDecimal(0);
					visit = 0;
					intention = 0;
					passing = 0;
					loan = 0;

					calendar.setTime(startDate);
					calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) + 1);
					startDate = calendar.getTime();
				}

			} else {
				while (startDate.before(endDate)) {
					String date = formatter.format(startDate);
					for (Map<String, Object> statistics : statisticses) {
						String date2 = formatter.format(((Date) statistics.get("date_point")));
						if (date.equals(date2)) {
							Map<String, String> data = new HashMap<>();
							data.put("date", date);
							data.put("amount", new BigDecimal(statistics.get("credit_amount").toString()).divide(temp, 2).toString());
							data.put("visit", statistics.get("visit_num").toString());
                            data.put("intention", statistics.get("intention_num").toString());
                            data.put("submit", statistics.get("submit_num").toString());
							data.put("passing", statistics.get("passing_num").toString());
							data.put("loan", statistics.get("loan_num").toString());
							statisticsData.add(data);

							break;
						}
					}
					calendar.setTime(startDate);
					calendar.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH) + 1);
					startDate = calendar.getTime();
				}
			}
		}
		model.addAttribute("data", statisticsData);

		return "modules/wd/statistics/team/team_user_detail_charts";
	}
}
