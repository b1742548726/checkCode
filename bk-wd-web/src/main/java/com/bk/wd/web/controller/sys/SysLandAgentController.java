package com.bk.wd.web.controller.sys;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bk.common.entity.JsonResult;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysLandAgent;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysLandAgentService;

/**
 * 房产开发商
 * @Project Name:bk-wd-web 
 * @Date:2017年12月25日下午3:49:12 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/landagent")
public class SysLandAgentController {
    
    @Autowired
    private SysLandAgentService sysLandAgentService;
    
    @RequestMapping(value = {"index"})
    public String index() {
        return "modules/sys/landAgent/index";
    }
    
    @RequestMapping(value = {"list"})
    @ResponseBody
    public JsonResult list() {
        List<SysLandAgent> sysLandAgentList = sysLandAgentService.selectByCompanyId(UserUtils.getUser().getCompanyId());
        return new JsonResult(treeData(sysLandAgentList, null));
    }
    
    public List<SysLandAgent> treeData(List<SysLandAgent> sysLandAgentList, String parentId) {
        List<SysLandAgent> list = new ArrayList<>();
        if (!sysLandAgentList.isEmpty()) {
            for (SysLandAgent sysLandAgent : sysLandAgentList) {
                if ((null == parentId && StringUtils.isEmpty(sysLandAgent.getParentId())) || (parentId != null && parentId.equals(sysLandAgent.getParentId()))) {
                    sysLandAgent.setItemList(treeData(sysLandAgentList, sysLandAgent.getId()));
                    list.add(sysLandAgent);
                }
            }
        }
        return list;
    }
    
    @RequestMapping(value = {"del"})
    @ResponseBody
    public JsonResult del(String id) {
        sysLandAgentService.deleteByPrimaryKey(id);
        return new JsonResult();
    }
    
    @RequestMapping(value = {"getChild"})
    @ResponseBody
    public JsonResult getChild(String parentId) {
        return new JsonResult(sysLandAgentService.selectByParentId(parentId));
    }
    
    @RequestMapping(value = {"save"})
    @ResponseBody
    public JsonResult save(SysLandAgent sysLandAgent) {
        SysUser user = UserUtils.getUser();
        
        if (StringUtils.isEmpty(sysLandAgent.getId())) {
            sysLandAgent.setId(UidUtil.uuid());
            sysLandAgent.setCompanyId(user.getCompanyId());
            sysLandAgent.setDelFlag(false);
            sysLandAgent.setCreateBy(user.getId());
            sysLandAgent.setCreateDate(new Date());
            sysLandAgent.setUpdateBy(user.getId());
            sysLandAgent.setUpdateDate(new Date());
            sysLandAgent.setSort(sysLandAgentService.countByCompanyId(user.getCompanyId()));
            sysLandAgentService.insertSelective(sysLandAgent);
        } else {
            sysLandAgent.setUpdateBy(user.getId());
            sysLandAgent.setUpdateDate(new Date());
            sysLandAgentService.updateByPrimaryKeySelective(sysLandAgent);
        }
        return new JsonResult(sysLandAgent);
    }
    
    @RequestMapping(value = {"sort"})
    @ResponseBody
    public JsonResult sort(String ids) {
        if (StringUtils.isNotEmpty(ids)) {
            String[] idArray = JSON.parseObject(StringEscapeUtils.unescapeHtml4(ids), String[].class);
            for (int i = 0; i < idArray.length; i++) {
                SysLandAgent sysLandAgent = sysLandAgentService.selectByPrimaryKey(idArray[i]);
                sysLandAgent.setSort(i);
                sysLandAgentService.updateByPrimaryKey(sysLandAgent);
            }
        }
        return new JsonResult();
    }

}
