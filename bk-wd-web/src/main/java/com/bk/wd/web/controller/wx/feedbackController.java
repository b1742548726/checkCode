package com.bk.wd.web.controller.wx;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.wd.model.WdFdComplaint;
import com.bk.wd.model.WdFdScore;
import com.bk.wd.service.WdFdComplaintService;
import com.bk.wd.service.WdFdScoreService;
import com.bk.wd.web.base.BaseController;

@Controller
@RequestMapping(value = "/wx/feedback")
public class feedbackController extends BaseController {

    @Autowired
    private WdFdScoreService wdFdScoreService;

    @Autowired
    private WdFdComplaintService wdFdComplaintService;

    @RequestMapping(value = "/score/list")
    public String scoreList(Model model, HttpServletRequest request, Pagination pagination, String manager) {
        wdFdScoreService.selectByManager(manager, pagination);
        model.addAttribute("pagination", pagination);
        model.addAttribute("manager", manager);

        return "modules/wx/scoreList";
    }

    @RequestMapping(value = "/complaint/list")
    public String complaintList(Model model, Pagination pagination, String manager) {
        wdFdComplaintService.selectByManager(manager, pagination);
        model.addAttribute("pagination", pagination);
        model.addAttribute("manager", manager);

        return "modules/wx/complaintList";
    }

    @RequestMapping(value = "/score/detail")
    public String scoreDetail(Model model, HttpServletRequest request, String current, String manager) {
        model.addAttribute("list", wdFdScoreService.selectAvg(null));
        model.addAttribute("current", current);
        model.addAttribute("manager", manager);

        return "modules/wx/scoreDetail";
    }

    @RequestMapping(value = "/score/user")
    public String userScoreList(Model model, String userId) {
        List<Map<String, String>> result = new ArrayList<>();
        List<WdFdScore> list = wdFdScoreService.selectByUserId(userId);

        if (!list.isEmpty() && list.get(0) != null) {

            model.addAttribute("userName", list.get(0).getUserName());
            
            SimpleDateFormat formatterMonth = new SimpleDateFormat("yyyy-MM");
            DecimalFormat df = new DecimalFormat("0.0");
            String date = formatterMonth.format(list.get(0).getCreateDate());
            float scoreService = 0;
            float scoreEfficiency = 0;
            float scoreProbity = 0;
            float size = 0;

            for (WdFdScore score : list) {
                String date2 = formatterMonth.format(score.getCreateDate());
                if (!date.equals(date2)) {
                    Map<String, String> map = new HashMap<>();
                    map.put("month", date);
                    map.put("scoreService", df.format(scoreService / size));
                    map.put("scoreEfficiency", df.format(scoreEfficiency / size));
                    map.put("scoreProbity", df.format(scoreProbity / size));
                    map.put("scoreAvg", df.format((scoreService + scoreEfficiency + scoreProbity) / size / 3));
                    result.add(map);
                    
                    date = date2;
                    scoreService = 0;
                    scoreEfficiency = 0;
                    scoreProbity = 0;
                    size = 0;
                }

                scoreService += score.getScoreService();
                scoreEfficiency += score.getScoreEfficiency();
                scoreProbity += score.getScoreProbity();
                size += 1;
            }
            Map<String, String> map = new HashMap<>();
            map.put("month", date);
            map.put("scoreService", df.format(scoreService / size));
            map.put("scoreEfficiency", df.format(scoreEfficiency / size));
            map.put("scoreProbity", df.format(scoreProbity / size));
            map.put("scoreAvg", df.format((scoreService + scoreEfficiency + scoreProbity) / size / 3));
            result.add(map);
        }

        model.addAttribute("list", result);
        return "modules/wx/scoreDetailUser";
    }
}
