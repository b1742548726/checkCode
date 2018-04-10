package com.bk.wd.web.controller.wd.app;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysOffice;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.dto.AppSearchParamsDto;
import com.bk.wd.model.WdApplication;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.util.ProcessHandle;

@Controller
@RequestMapping(value = "/wd/application")
public class ApplicationController {

    @Autowired
    private WdApplicationService wdApplicationService;

    @Autowired
    private ProcessHandle ProcessHandle;

    /**
     * 我的贷款 date: 2017年4月8日 下午5:46:24 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequestMapping(value = { "mineList" })
    @RequiresPermissions("wd:application:view")
    public String mineList(Model model, AppSearchParamsDto searchParamsDto, HttpServletRequest request) {
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(null);
        model.addAttribute("auditList", selectByStatus(searchParamsDto, 6));
        model.addAttribute("reviewList", selectByStatus(searchParamsDto, 504));
        model.addAttribute("laonList", selectByStatus(searchParamsDto, 512));
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/mineList";
    }

    private List<WdApplication> selectByStatus(AppSearchParamsDto searchParamsDto, int status) {
        searchParamsDto.setStatus(status);
        return wdApplicationService.selectMineList(searchParamsDto);
    }

    @RequestMapping(value = { "allList" })
    @RequiresPermissions("wd:application:view")
    public String mineList(Model model, AppSearchParamsDto searchParamsDto, Pagination pagination, Integer status, HttpServletRequest request) {
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setDataScope("office");
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineList(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineList(searchParamsDto));

        Map<String, Object> analyzeMap = new HashMap<>();
        searchParamsDto.setStatus(null);
        analyzeMap.put("all", wdApplicationService.countMineList(searchParamsDto));
        searchParamsDto.setStatus(1);
        analyzeMap.put("assigned", wdApplicationService.countMineList(searchParamsDto));
        searchParamsDto.setStatus(2);
        analyzeMap.put("survey", wdApplicationService.countMineList(searchParamsDto));
        searchParamsDto.setStatus(8);
        analyzeMap.put("offlineReview", wdApplicationService.countMineList(searchParamsDto));
        searchParamsDto.setStatus(16);
        analyzeMap.put("tableReview", wdApplicationService.countMineList(searchParamsDto));
        searchParamsDto.setStatus(32);
        analyzeMap.put("riskControl", wdApplicationService.countMineList(searchParamsDto));
        searchParamsDto.setStatus(256);
        analyzeMap.put("extendReview", wdApplicationService.countMineList(searchParamsDto));
        searchParamsDto.setStatus(512);
        analyzeMap.put("loanReview", wdApplicationService.countMineList(searchParamsDto));
        model.addAttribute("analyzeData", analyzeMap);

        searchParamsDto.setStatus(status);
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/allList";
    }

    /**
     * 待分配 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:assignment")
    @RequestMapping(value = { "assignmentList" })
    public String assignmentList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setTaskStatus(1);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineListByTast(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/assignmentList";
    }

    /**
     * 待征信 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:credit")
    @RequestMapping(value = { "creditList" })
    public String creditList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        if (null == searchParamsDto.getCreditStatus()) {
            searchParamsDto.setCreditStatus(1);
        }
        searchParamsDto.setPagination(pagination);
        wdApplicationService.selectCreditListByPagination(pagination, searchParamsDto);
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/creditList";
    }

    /**
     * 资料审核 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:offlinereview")
    @RequestMapping(value = { "offlineList" })
    public String offlineList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setTaskStatus(8);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineListByTast(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/offlineList";
    }

    /**
     * 资料初审 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:offlinereview")
    @RequestMapping(value = { "offlineFirstList" })
    public String offlineFirstList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setTaskStatus(64);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineListByTast(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/offlineFirstList";
    }

    /**
     * 风险调查 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequestMapping(value = { "fenxiandaiocha" })
    public String fenxiandaiocha(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setTaskStatus(128);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineListByTast(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/fenxiandaiocha";
    }

    /**
     * 表格审批 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:tablereview")
    @RequestMapping(value = { "tableList" })
    public String tableList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setTaskStatus(16);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineListByTast(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/tableList";
    }

    /**
     * 风控审核 date: 2017年4月8日 下午5:48:41 <br/>
     * @author Liam
     * @param model
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:riskcontrol")
    @RequestMapping(value = { "riskControlList" })
    public String riskControlList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setTaskStatus(32);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineListByTast(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/riskControlList";
    }

    /**
     * 超额待批 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:extendreview")
    @RequestMapping(value = { "extendList" })
    public String extendList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setTaskStatus(256);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineListByTast(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/extendList";
    }

    /**
     * 放款待批 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:loanreview")
    @RequestMapping(value = { "loanReviewList" })
    public String loanReviewList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setTaskStatus(512);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        searchParamsDto.setPagination(pagination);
        pagination.setDataList(wdApplicationService.selectMineListByTast(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/loanReviewList";
    }

    /**
     * 待签约（视频双录） date: 2017年4月8日 下午5:46:24 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequestMapping(value = { "presignedList" })
    @RequiresPermissions("wd:application:presigned")
    public String presignedList(Model model, AppSearchParamsDto searchParamsDto, Pagination pagination, HttpServletRequest request) {
        searchParamsDto.setStatus(512);
        searchParamsDto.setPagination(pagination);
        if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
            searchParamsDto.setCompanyId(UserUtils.getUser().getCompanyId());
        }
        pagination.setTotal(wdApplicationService.countMineList(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineList(searchParamsDto));
        model.addAttribute("params", searchParamsDto);
        model.addAttribute("pagination", pagination);
        return "modules/wd/application/presignedList";
    }

    /**
     * 已终止 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:canceledList")
    @RequestMapping(value = { "canceledList" })
    public String canceledList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setStatus(8192);
        searchParamsDto.setDataScope("office");
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineList(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineList(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/canceledList";
    }

    /**
     * 被拒绝 date: 2017年5月6日 下午9:18:41 <br/>
     * @author Liam
     * @param model
     * @param pagination
     * @param searchParamsDto
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:rejectList")
    @RequestMapping(value = { "rejectList" })
    public String rejectList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setStatus(16384);
        searchParamsDto.setDataScope("office");
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineList(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineList(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/rejectList";
    }

    /**
     * 贷款总控 date: 2017年4月8日 下午5:46:49 <br/>
     * @author Liam
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:manager")
    @RequestMapping(value = { "managerList" })
    public String managerList(Model model, AppSearchParamsDto searchParamsDto, Integer status, Pagination pagination) {
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setDataScope("office");
        searchParamsDto.setPagination(pagination);
        searchParamsDto.setTaskStatus(status);
        pagination.setTotal(wdApplicationService.countMineListByTast(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectManagerListByTast(searchParamsDto));
        searchParamsDto.setTaskStatus(null);

        Map<String, Object> analyzeMap = new HashMap<>();
        searchParamsDto.setStatus(null);
        analyzeMap.put("all", wdApplicationService.countMineListByTast(searchParamsDto));
        searchParamsDto.setStatus(1);
        analyzeMap.put("assigned", wdApplicationService.countMineListByTast(searchParamsDto));
        searchParamsDto.setStatus(2);
        analyzeMap.put("survey", wdApplicationService.countMineListByTast(searchParamsDto));
        searchParamsDto.setStatus(8);
        analyzeMap.put("offlineReview", wdApplicationService.countMineListByTast(searchParamsDto));
        searchParamsDto.setStatus(16);
        analyzeMap.put("tableReview", wdApplicationService.countMineListByTast(searchParamsDto));
        searchParamsDto.setStatus(32);
        analyzeMap.put("riskControl", wdApplicationService.countMineListByTast(searchParamsDto));

        searchParamsDto.setStatus(64);
        analyzeMap.put("offlineFirstReview", wdApplicationService.countMineListByTast(searchParamsDto));
        searchParamsDto.setStatus(128);
        analyzeMap.put("riskHeshi", wdApplicationService.countMineListByTast(searchParamsDto));

        searchParamsDto.setStatus(256);
        analyzeMap.put("extendReview", wdApplicationService.countMineListByTast(searchParamsDto));
        searchParamsDto.setStatus(512);
        analyzeMap.put("loanReview", wdApplicationService.countMineListByTast(searchParamsDto));
        /*searchParamsDto.setStatus(16384);
        analyzeMap.put("rejected", wdApplicationService.countMineList(searchParamsDto));*/
        model.addAttribute("analyzeData", analyzeMap);

        searchParamsDto.setStatus(status);
        model.addAttribute("params", searchParamsDto);
        model.addAttribute("pagination", pagination);
        return "modules/wd/application/managerList";
    }

    @RequiresPermissions("wd:application:delete")
    @RequestMapping(value = { "/del" })
    @ResponseBody
    public JsonResult delApplication(String applicationId) {
        if (StringUtils.isBlank(applicationId)) {
            return new JsonResult(false, "Application ID不能为空");
        }

        // 检查是否符合修改的条件
        WdApplication application = wdApplicationService.selectByPrimaryKey(applicationId);
        if (null == application) {
            return new JsonResult(false, "Application ID有误");
        }

        if ((application.getStatus() & 16384) != 0) {
            return new JsonResult(false, "申请已经被拒，不可删除");
        }
        if ((application.getStatus() & 4096) != 0) {
            return new JsonResult(false, "申请已经入档，不可删除");
        }
        if ((application.getStatus() & 3072) != 0) {
            return new JsonResult(false, "申请已经放款，不可删除");
        }
        
        ProcessHandle.delApplication(application);
        
        return new JsonResult(true, applicationId);
    }
}