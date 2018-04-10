package com.bk.wd.web.controller.wd.app;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.bk.common.utils.StringUtils;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.util.BusinessConsts.Action;
import com.bk.wd.util.process.EngineHandler;
import com.bk.wd.model.WdApplication;
import com.bk.wd.model.WdApplicationTask;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.service.WdApplicationTaskService;
import com.bk.wd.util.ProcessHandle;

@Controller
@RequestMapping(value = "/wd/application/review")
public class AppReviewController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppReviewController.class);

    @Autowired
    private WdApplicationService wdApplicationService;

    @Autowired
    private WdApplicationTaskService taskService;

    @Autowired
    private ProcessHandle processHandle;

    @Autowired
    private EngineHandler processEngine;

    /**
     * 申請單分配 date: 2017年5月8日 下午7:53:35 <br/>
     * @author Liam
     * @param model
     * @param request
     * @param taskId
     * @param userId
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:assignment")
    @RequestMapping(value = { "assignment" })
    @ResponseBody
    public JsonResult assignment(Model model, HttpServletRequest request, String taskId, String userId) {

        WdApplicationTask task = taskService.selectByPrimaryKey(taskId);
        WdApplication application = wdApplicationService.selectByPrimaryKey(task.getApplicationId());

        if (StringUtils.isBlank(application.getName())) {
            try {
                processHandle.dealTask(taskId, Action.Submit, userId, null, null, UserUtils.getUser().getId(), false);
            } catch (GeneralException e) {
                LOGGER.error("分配错误", e);
                return new JsonResult(e.getMessage());
            }
        } else {
            Map<String, Object> variables = new HashMap<>();
            variables.put("owner", userId);

            try {
                processEngine.setInstanceVariable(application.getName(), variables, UserUtils.getUser().getId());
                processEngine.dealTask(taskId, Action.Submit, UserUtils.getUser().getId());

            } catch (GeneralException e) {
                LOGGER.error("分配错误", e);
                return new JsonResult(e.getMessage());
            }
        }
        return new JsonResult();
    }

}
