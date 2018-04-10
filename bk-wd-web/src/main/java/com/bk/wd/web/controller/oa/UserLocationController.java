package com.bk.wd.web.controller.oa;

import java.util.Date;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.bk.common.utils.UidUtil;
import com.bk.oa.model.OaLocationConfig;
import com.bk.oa.model.OaLocationConfigTimeQuantum;
import com.bk.oa.service.OaLocationConfigService;
import com.bk.oa.service.OaLocationConfigTimeQuantumService;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysUserService;

/**
 * 用户实时定位
 * @Project Name:bk-wd-web 
 * @Date:2017年8月29日上午11:02:08 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/oa/location")
public class UserLocationController {
    
    @Autowired
    private OaLocationConfigService oaLocationConfigService;
    
    @Autowired
    private OaLocationConfigTimeQuantumService oaLocationConfigTimeQuantumService;
    
    @Autowired
    private SysUserService sysUserService;

    @RequiresPermissions("oa:location:config:edit")
    @RequestMapping(value = { "/config/form" })
    public String configForm(Model model) {
        SysUser sysUser = sysUserService.selectByPrimaryKey(UserUtils.getUser().getId());
        OaLocationConfig oaLocationConfig = oaLocationConfigService.selectByCompanyId(sysUser.getCompanyId());
        if (null != oaLocationConfig) {
            oaLocationConfig.setConfigTimeQuantumList(oaLocationConfigTimeQuantumService.selectByConfigId(oaLocationConfig.getId()));
            model.addAttribute("oaLocationConfig", oaLocationConfig);
        }
        return "modules/oa/location/configForm";
    }
    
    @RequiresPermissions("oa:location:config:edit")
    @RequestMapping(value = "/config/save")
    public String save(OaLocationConfig oaLocationConfig, String timeQuantums, Model model) {
        oaLocationConfig.setCompanyId(UserUtils.getUser().getCompanyId());
        if (oaLocationConfig.getEnable() == null) {
            oaLocationConfig.setEnable(false);
        }
        if (StringUtils.isEmpty(oaLocationConfig.getId())) {
            oaLocationConfig.setId(UidUtil.uuid());
            oaLocationConfig.setCreateBy(UserUtils.getUser().getId());
            oaLocationConfig.setCreateDate(new Date());
            oaLocationConfig.setUpdateBy(UserUtils.getUser().getId());
            oaLocationConfig.setUpdateDate(new Date());
            oaLocationConfigService.insertSelective(oaLocationConfig);
        } else {
            oaLocationConfigTimeQuantumService.deleteByConfigId(oaLocationConfig.getId());
            oaLocationConfig.setUpdateBy(UserUtils.getUser().getId());
            oaLocationConfig.setUpdateDate(new Date());
            oaLocationConfigService.updateByPrimaryKeySelective(oaLocationConfig);
        }
        if (StringUtils.isNotEmpty(timeQuantums)) {
            OaLocationConfigTimeQuantum[] oaLocationConfigTimeQuantumArrary = JSON.parseObject(StringEscapeUtils.unescapeHtml4(timeQuantums), OaLocationConfigTimeQuantum[].class);
            for (OaLocationConfigTimeQuantum oaLocationConfigTimeQuantum : oaLocationConfigTimeQuantumArrary) {
                oaLocationConfigTimeQuantum.setId(UidUtil.uuid());
                oaLocationConfigTimeQuantum.setConfigId(oaLocationConfig.getId());
                oaLocationConfigTimeQuantum.setCreateBy(UserUtils.getUser().getId());
                oaLocationConfigTimeQuantum.setCreateDate(new Date());
                oaLocationConfigTimeQuantum.setUpdateBy(UserUtils.getUser().getId());
                oaLocationConfigTimeQuantum.setUpdateDate(new Date());
                oaLocationConfigTimeQuantumService.insertSelective(oaLocationConfigTimeQuantum);
            }
        }
        return "redirect:/oa/location/config/form";
    }
    
}