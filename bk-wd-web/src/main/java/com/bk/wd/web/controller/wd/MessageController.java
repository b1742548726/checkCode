package com.bk.wd.web.controller.wd;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.JGMessageUtils;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysOffice;
import com.bk.sys.security.service.SystemService;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdMessage;
import com.bk.wd.model.WdMessageJpush;
import com.bk.wd.model.WdMessageJpushExample;
import com.bk.wd.model.WdMessageReceiver;
import com.bk.wd.service.WdMessageJpushService;
import com.bk.wd.service.WdMessageReceiverService;
import com.bk.wd.service.WdMessageService;

@Controller
@RequestMapping(value = "/wd/message")
public class MessageController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(MessageController.class);

    @Autowired
    private WdMessageService wdMessageService;
    @Autowired
    private SystemService systemService;
    @Autowired
    private WdMessageReceiverService wdMessageReceiverService;
    @Autowired
    private WdMessageJpushService wdMessageJpushService;
    @Autowired
    private JGMessageUtils jgMessageUtils;

    @RequiresPermissions("wd:message:view")
    @RequestMapping(value = "list/mine")
    public String mineList(Model model, Pagination pagination, String userId) {
        WdMessage message = new WdMessage();
        message.setCreateBy(userId);
        message.setCategory("通知");

        wdMessageService.findByPage(pagination, message);

        model.addAttribute("pagination", pagination);
        return "modules/wd/message/list";
    }

    @RequiresPermissions("wd:message:del")
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(String id) {

        WdMessageJpushExample example = new WdMessageJpushExample();
        example.createCriteria().andMessageIdEqualTo(id);
        List<WdMessageJpush> jpushs = wdMessageJpushService.selectByExample(example);
        for (WdMessageJpush jpush : jpushs) {
            if (jgMessageUtils.deleteMessageSchedule(jpush.getScheduleId())) {
                wdMessageJpushService.deleteByPrimaryKey(jpush.getId());
            }
        }
        
        wdMessageService.deleteByPrimaryKey(id);

        return new JsonResult(true, "");
    }

    @RequiresPermissions("wd:message:edit")
    @RequestMapping(value = "edit")
    public String edit(Model model, String id) {
        WdMessage message = wdMessageService.selectByPrimaryKey(id);
        model.addAttribute("message", message);
        return "modules/wd/message/edit";
    }

    @RequiresPermissions("wd:message:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(String id, String title, String messageDate, String content, HttpServletRequest request) {
        if (StringUtils.isBlank(title)) {
            return new JsonResult(false, "标题不能为空");
        }
        if (StringUtils.isBlank(content)) {
            return new JsonResult(false, "内容不能为空");
        }

        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.SECOND, 10);
        Date sendDate = calendar.getTime();

        if (StringUtils.isNotBlank(messageDate)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            try {
                Date date = sdf.parse(messageDate);
                if (date.after(sendDate)) {
                    sendDate = date;
                }
            } catch (ParseException e) {
                LOGGER.error(e.getMessage(), e);
            }
        }

        WdMessage wdMessage = new WdMessage();
        wdMessage.setCategory("通知");
        wdMessage.setTitle(title);
        wdMessage.setContent(content);
        wdMessage.setMessageDate(sendDate);

        Collection<String> schedules = new ArrayList<String>();
        List<String> officeIds = new ArrayList<String>();

        if (StringUtils.isBlank(id)) {
            wdMessage.setId(UidUtil.uuid());
            wdMessage.setCreateBy(UserUtils.getUser().getId());
            wdMessage.setCreateDate(new Date());
            wdMessage.setUpdateBy(UserUtils.getUser().getId());
            wdMessage.setUpdateDate(new Date());
            wdMessageService.insertSelective(wdMessage);

            List<SysOffice> offices = systemService.findAllOffice();
            for (SysOffice office : offices) {
                officeIds.add(office.getId());

                WdMessageReceiver receiver = new WdMessageReceiver();
                receiver.setId(UidUtil.uuid());
                receiver.setMessageDate(sendDate);
                receiver.setMessageId(wdMessage.getId());
                receiver.setReceiverOfficeId(office.getId());
                receiver.setDelFlag(false);

                wdMessageReceiverService.insertSelective(receiver);
            }

        } else {
            wdMessage.setId(id);
            wdMessage.setUpdateBy(UserUtils.getUser().getId());
            wdMessage.setUpdateDate(new Date());
            wdMessageService.updateByPrimaryKeySelective(wdMessage);

            WdMessageJpushExample example = new WdMessageJpushExample();
            example.createCriteria().andMessageIdEqualTo(id);
            List<WdMessageJpush> jpushs = wdMessageJpushService.selectByExample(example);
            for (WdMessageJpush jpush : jpushs) {
                if (jgMessageUtils.deleteMessageSchedule(jpush.getScheduleId())) {
                    wdMessageJpushService.deleteByPrimaryKey(jpush.getId());
                }
            }
        }

        Map<String, String> extraInfo = new HashMap<>();
        extraInfo.put("category", "通知");
        extraInfo.put("messageId", wdMessage.getId());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String[] strings = new String[officeIds.size()];
        schedules = jgMessageUtils.messageScheduleByTags(
                officeIds.toArray(strings), title, content, extraInfo, sdf.format(sendDate)
        );

        for (String scheduleId : schedules) {
            WdMessageJpush jpush = new WdMessageJpush();
            jpush.setId(UidUtil.uuid());
            jpush.setMessageId(wdMessage.getId());
            jpush.setScheduleId(scheduleId);
            wdMessageJpushService.insertSelective(jpush);
        }

        return new JsonResult(true, "");
    }

    @RequiresPermissions("wd:message:view")
    @RequestMapping(value = "show")
    public String show(Model model, String id) {
        WdMessage message = wdMessageService.selectByPrimaryKey(id);
        model.addAttribute("message", message);
        return "modules/wd/message/show";
    }
}
