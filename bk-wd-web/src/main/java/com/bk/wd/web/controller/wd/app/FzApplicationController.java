package com.bk.wd.web.controller.wd.app;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.GeneralException;
import com.bk.common.entity.JsonResult;
import com.bk.common.utils.DateUtils;
import com.bk.common.utils.JGMessageUtils;
import com.bk.common.utils.StringUtils;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdApplication;
import com.bk.wd.model.WdApplicationTask;
import com.bk.wd.model.WdProcessSubinstance;
import com.bk.wd.model.WdProcessTask;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.service.WdApplicationTaskService;
import com.bk.wd.service.WdProcessSubinstanceService;
import com.bk.wd.service.WdProcessTaskService;
import com.bk.wd.util.ProcessHandle;
import com.bk.wd.util.process.EngineHandler;

@Controller
@RequestMapping(value = "/wd/application/fz")
public class FzApplicationController {

    @Autowired
    private WdProcessTaskService taskService;

    @Autowired
    private WdProcessSubinstanceService subinstanceService;

    @Autowired
    private WdApplicationService applicationService;

    @Autowired
    private WdApplicationTaskService commentService;

    @Autowired
    private EngineHandler processEngine;

    @Autowired
    private ProcessHandle processHandle;

    @Autowired
    private JGMessageUtils jgMessageUtils;

    private List<WdApplication> getApplications(Integer activiy) {
        List<WdApplication> applications = new ArrayList<>();

        List<WdProcessTask> tasks = taskService.selectUnclosedByActivityAndOwner(activiy, UserUtils.getUser().getId());
        for (WdProcessTask task : tasks) {
            WdProcessSubinstance subinstance = subinstanceService.selectBySubinstance(task.getInstanceId());
            if (subinstance == null) {
                continue;
            }

            WdApplication application = applicationService.selectByName(subinstance.getInstanceId());
            if (null == application) {
                continue;
            }

            WdApplicationTask appTask = new WdApplicationTask();
            appTask.setId(task.getId());
            appTask.setApplicationId(application.getId());
            appTask.setStatus(task.getActivity());
            appTask.setStatusName(task.getActivityName());
            appTask.setOwnerId(task.getOwnerId());
            appTask.setOwnerName(task.getOwnerName());
            appTask.setCreateBy(task.getCreateBy());
            appTask.setCreateDate(task.getCreateDate());
            appTask.setUpdateBy(task.getUpdateBy());
            appTask.setUpdateDate(task.getUpdateDate());

            application.setWdApplicationTask(appTask);
            applications.add(application);
        }

        return applications;
    }

    @RequestMapping(value = { "comment" }, method = { RequestMethod.GET })
    @RequiresPermissions("wd:application:view")
    public String showComment(Model model, HttpServletRequest request, String taskId) {
        model.addAttribute("taskId", taskId);
        return "modules/wd/application/fz/comments";
    }

    @RequestMapping(value = { "deal" }, method = { RequestMethod.POST })
    @RequiresPermissions("wd:application:view")
    @ResponseBody
    public JsonResult dealTask(String taskId, String action, String comment) {
        WdProcessTask task = taskService.selectByPrimaryKey(taskId);
        if (task == null) {
            return new JsonResult(false, "Task ID有误【" + taskId + "】");
        }
        WdProcessSubinstance subinstance = subinstanceService.selectBySubinstance(task.getInstanceId());
        if (subinstance == null) {
            return new JsonResult(false, "Task ID有误【" + taskId + "】");
        }

        WdApplication application = applicationService.selectByName(subinstance.getInstanceId());
        if (null == application) {
            return new JsonResult(false, "Task ID有误【" + taskId + "】");
        }

        String errorMessage = "";
        try {
            errorMessage = processEngine.dealTask(taskId, action, UserUtils.getUser().getId());
        } catch (GeneralException e) {
            return new JsonResult(false, e.getMessage());
        }
        if (StringUtils.isNotBlank(errorMessage)) {
            return new JsonResult(false, errorMessage);
        }

        task = taskService.selectByPrimaryKey(taskId);
        WdApplicationTask taskComment = new WdApplicationTask();
        taskComment.setId(task.getId());
        taskComment.setApplicationId(application.getId());
        taskComment.setStatus(task.getActivity());
        taskComment.setStatusName(task.getActivityName());
        taskComment.setOwnerId(task.getOwnerId());
        taskComment.setOwnerName(task.getOwnerName());
        taskComment.setClose(task.getClose());
        taskComment.setCloseDate(task.getCloseDate());
        taskComment.setDone(task.getDone());
        taskComment.setDonerId(task.getDonerId());
        taskComment.setDonerName(task.getDonerName());
        taskComment.setDoneDate(task.getDoneDate());
        taskComment.setAction(task.getAction());
        taskComment.setActionName(task.getActionName());
        taskComment.setCreateBy(task.getCreateBy());
        taskComment.setCreateDate(task.getCreateDate());
        taskComment.setUpdateBy(task.getUpdateBy());
        taskComment.setUpdateDate(task.getUpdateDate());

        taskComment.setComment(comment);
        commentService.insertSelective(taskComment);

        processHandle.delWithOldProcessAndNewProcess(application);

        // 发送风险核实任务消息
        List<WdProcessTask> unclosedTasks = taskService.selectUnclosedByInstance(task.getInstanceId());
        for (WdProcessTask unclosedTask : unclosedTasks) {
            if (unclosedTask.getActivity().equals(128)) {

                String[] alias = new String[] { task.getOwnerId() };
                String taskTime = DateUtils.formatDateTime(unclosedTask.getCreateDate());
                
                Map<String, String> extraInfo = new HashMap<>();
                extraInfo.put("category", "风险核实");
                extraInfo.put("applicationId", application.getId());
                extraInfo.put("taskId", unclosedTask.getId());
                extraInfo.put("custoemrName", application.getCustomerName());
                extraInfo.put("appliatonCode", application.getCode());
                extraInfo.put("taskTime", taskTime);
                extraInfo.put("product", application.getProductName());

                jgMessageUtils.sendMessageByAlias(alias, "您有一个任务需要处理", "请您尽快对客户【" + application.getCustomerName() +"】先生（女士）进行风险核实", extraInfo);
            }
        }

        return new JsonResult(true, errorMessage);
    }

    @RequestMapping(value = { "ziliaochushen" }, method = { RequestMethod.GET })
    public String ziliaochushen(Model model, HttpServletRequest request) {
        List<WdApplication> applications = getApplications(64);
        model.addAttribute("data", applications);

        return "modules/wd/application/fz/ziliaochushen";
    }

    @RequestMapping(value = { "fenxiandiaocha" }, method = { RequestMethod.GET })
    @RequiresPermissions("wd:application:fenxiandiaocha")
    public String fenxiandaiocha(Model model, HttpServletRequest request) {
        List<WdApplication> applications = getApplications(128);
        model.addAttribute("data", applications);

        return "modules/wd/application/fz/fengxiandiaocha";
    }

}
