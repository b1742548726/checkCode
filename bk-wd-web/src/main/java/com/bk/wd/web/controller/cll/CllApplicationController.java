package com.bk.wd.web.controller.cll;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bk.cll.Constant;
import com.bk.cll.model.CllApplication;
import com.bk.cll.model.CllApplicationTask;
import com.bk.cll.model.CllCustomer;
import com.bk.cll.model.CllCustomerComprehensiveQuality;
import com.bk.cll.service.CllApplicationService;
import com.bk.cll.service.CllApplicationTaskService;
import com.bk.cll.service.CllCustomerComprehensiveQualityService;
import com.bk.cll.service.CllCustomerService;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.sys.service.SysUserService;
import com.bk.wd.model.WdRwBkScore;
import com.bk.wd.model.WdRwZmScore;
import com.bk.wd.service.WdCourtQueryService;
import com.bk.wd.service.WdRwBkScoreService;
import com.bk.wd.service.WdRwEmaySinowayCreditService;
import com.bk.wd.service.WdRwTdBodyguardService;
import com.bk.wd.service.WdRwTxCreditAntifraudVerifyService;
import com.bk.wd.service.WdRwZmCreditAntifraudVerifyService;
import com.bk.wd.service.WdRwZmScoreService;

@RequestMapping(value = "/cll/application")
@Controller
public class CllApplicationController {
	
	@Autowired
	private CllApplicationService cllApplicationService;
	
	@Autowired
	private CllCustomerService customerService;
	
	@Autowired
	private CllCustomerComprehensiveQualityService cllCustomerComprehensiveQualityService;
	
	@Autowired
	private WdCourtQueryService cllCourtQueryService;
	
	@Autowired
	private WdRwZmCreditAntifraudVerifyService cllRwZmCreditAntifraudVerifyService;
	
	@Autowired
	private WdRwTxCreditAntifraudVerifyService cllRwTxCreditAntifraudVerifyService;
	
	@Autowired
	private WdRwEmaySinowayCreditService cllRwEmaySinowayCreditService;
	
	@Autowired
	private SysUserService sysUserService;
	
	@Autowired 
	private CllApplicationTaskService cllApplicationTaskService;
	
	@Autowired
	private WdRwZmScoreService cllRwZmScoreService;
	
	@Autowired
	private WdRwBkScoreService cllRwBkScoreService;
	
	@Autowired
	private WdRwTdBodyguardService tdBodyguardService;
	
	@RequestMapping(value = "list")
	public String loanInfo(CllApplication cllApplication, Model model, Pagination pagination) {
		cllApplicationService.selectByPagination(pagination, cllApplication);
		model.addAttribute("statusCount", count(cllApplication));
		model.addAttribute("pagination", pagination);
		model.addAttribute("cllApplication", cllApplication);
		return "modules/cll/app/managerList";
	}
	
	public Map<String, Long> count(CllApplication application) {
        List<Map<String, Object>> statusList = cllApplicationService.countApplicationStatus(application);
        long all = 0, appling = 0, preview = 0, credit = 0, survey = 0, review = 0, preSign = 0, preLoan = 0, repayments = 0, closeAcount = 0, reject = 0;
        for (Map<String, Object> map : statusList) {
        	if (null != map.get("status") && null != map.get("count")) {
        		int count = Integer.parseInt(String.valueOf(map.get("count")));
	            switch (Integer.parseInt(String.valueOf(map.get("status")))) {
	                case 0:
	                    all = count;
	                    break;
	                case 1:
	                    appling = count;
	                    break;
	                case 2:
	                    preview = count;
	                    break;
	                case 4:
	                    credit = count;
	                    break;
	                case 8:
	                    survey = count;
	                    break;
	                case 16:
	                    review = count;
	                    break;
	                case 32:
	                    preSign = count;
	                    break;
	                case 64:
	                    preLoan = count;
	                    break;
	                case 128:
	                    repayments = count;
	                    break;
	                case 4096:
	                    closeAcount = count;
	                    break;
	                case 8192:
	                    reject = count;
	                    break;
	                default:
	                    break;
	            }
        	}
        }
        Map<String, Long> statusMap = new HashMap<>();
        statusMap.put("all", all);
        statusMap.put("appling", appling);
        statusMap.put("preview", preview);
        statusMap.put("credit", credit);
        statusMap.put("survey", survey);
        statusMap.put("review", review);
        statusMap.put("preSign", preSign);
        statusMap.put("preLoan", preLoan);
        statusMap.put("repayments", repayments);
        statusMap.put("closeAcount", closeAcount);
        statusMap.put("reject", reject);
        return statusMap;
    }
	
	@RequestMapping(value = "detail")
	public String detail(String applicationId, Model model){
		CllApplication cllApplication = cllApplicationService.selectByPrimaryKey(applicationId);
		CllCustomer customer = customerService.selectByPrimaryKey(cllApplication.getCustomerId());
		
        CllCustomerComprehensiveQuality cllCustomerComprehensiveQuality = cllCustomerComprehensiveQualityService.selectByApplicationId(applicationId);
        if (null != cllCustomerComprehensiveQuality && StringUtils.isNotEmpty(cllCustomerComprehensiveQuality.getCreateBy())) {
        	cllCustomerComprehensiveQuality.setCreateByName(sysUserService.selectByPrimaryKey(cllCustomerComprehensiveQuality.getCreateBy()).getName()); 
        }
        cllApplication.setComprehensiveQuality(cllCustomerComprehensiveQuality);
        cllApplication.setCllApplicationTask(cllApplicationTaskService.selectLastTask(applicationId));
        
        List<CllApplicationTask> cllApplicationTaskList = cllApplicationTaskService.selectByApplication(applicationId);
		Map<String, Object> task = new HashMap<>();
		for (CllApplicationTask cllApplicationTask : cllApplicationTaskList) {
			String title = "";
			switch (cllApplicationTask.getTitle()) {
			case Constant.ApplicationTaskSubcategory.Approval:
				title = "approval";
				break;
			case Constant.ApplicationTaskSubcategory.Preapproval:
				title = "preapproval";
				break;
			case Constant.ApplicationTaskSubcategory.GetCreditReport:
				title = "getCreditReport";
				break;
			case Constant.ApplicationTaskSubcategory.Investigation:
				title = "investigation";
				break;
			default:
				break;
			}

			if (StringUtils.isNotBlank(title)) {
				task.put(title, cllApplicationTask);
			}
		}
		cllApplication.setTaskMap(task);
        
        model.addAttribute("cllApplication", cllApplication);
        
        
        WdRwZmScore zmScore = cllRwZmScoreService.selectLastestByPersonId(customer.getWdPersonId(), cllApplication.getId());
		WdRwBkScore bkScore = cllRwBkScoreService.selectLastestByPersonId(customer.getWdPersonId(), cllApplication.getId());
        
        model.addAttribute("bkScore", bkScore);
        model.addAttribute("zmScore", zmScore);
        
        model.addAttribute("zhixinList", cllCourtQueryService.selectByPersonIdAndSite(customer.getWdPersonId(), "zhixin", cllApplication.getId()));
        model.addAttribute("shixinList", cllCourtQueryService.selectByPersonIdAndSite(customer.getWdPersonId(), "shixin", cllApplication.getId()));
        model.addAttribute("cllRwZmCreditAntifraudVerifyList", cllRwZmCreditAntifraudVerifyService.selectByPerson(customer.getWdPersonId()));
        model.addAttribute("cllRwTxCreditAntifraudVerifyList", cllRwTxCreditAntifraudVerifyService.selectByPersonId(customer.getWdPersonId(), cllApplication.getId()));
        model.addAttribute("cllRwEmaySinowayCreditList", cllRwEmaySinowayCreditService.selectByPersonId(customer.getWdPersonId(), cllApplication.getId()));
        model.addAttribute("cllRwTdBodyguardList", tdBodyguardService.selectByPersonId(customer.getWdPersonId(), cllApplication.getId()));
        return "modules/cll/app/detail";
	}

}