package com.bk.wd.web.controller.sys;

import java.io.IOException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.bk.common.service.DfsService;
import com.bk.sys.security.service.SystemService;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysGlobalSettingService;
import com.bk.sys.model.SysGlobalSetting;
import com.bk.wd.web.base.BaseController;

/**
 * 系统全局设置
 * @Project Name:bk-wd-web 
 * @Date:2017年3月17日下午1:40:16 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/globalSetting")
public class GlobalSettingController extends BaseController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(GlobalSettingController.class);
    
    @Autowired
    private SystemService systemService;
    
    @Autowired
    private SysGlobalSettingService sysGlobalSettingService;
    
    @Autowired
    private DfsService dfsService;
    
    @RequiresPermissions("sys:globalsetting:edit")
    @RequestMapping(value = "form")
    public String form(Model model) {
        model.addAttribute("sysGlobalSetting", sysGlobalSettingService.selectByCompany(UserUtils.getUser().getCompanyId()));
        return "modules/sys/globalsetting/form";
    }
    
    @RequiresPermissions("sys:globalsetting:edit")
    @RequestMapping(value = "save")
    public String save(SysGlobalSetting sysGlobalSetting, Model model, @RequestParam(value = "loginPhotoFile", required = false)CommonsMultipartFile loginPhotoFile,
            @RequestParam(value = "systemLogoFile", required = false)CommonsMultipartFile systemLogoFile,
            @RequestParam(value = "systemIcoFile", required = false)CommonsMultipartFile systemIcoFile) {
        try {
            if (null != loginPhotoFile && !loginPhotoFile.isEmpty() && loginPhotoFile.getSize() > 0) {
                sysGlobalSetting.setLoginPhoto(dfsService.uploadFile(loginPhotoFile.getBytes(), loginPhotoFile.getOriginalFilename()));
            }
            if (null != systemLogoFile && !systemLogoFile.isEmpty() && systemLogoFile.getSize() > 0) {
                sysGlobalSetting.setSystemLogo(dfsService.uploadFile(systemLogoFile.getBytes(), systemLogoFile.getOriginalFilename()));
            }
            if (null != systemIcoFile && !systemIcoFile.isEmpty() && systemIcoFile.getSize() > 0) {
                sysGlobalSetting.setSystemIco(dfsService.uploadFile(systemIcoFile.getBytes(), systemIcoFile.getOriginalFilename()));
            }
        } catch (IOException e) {
            LOGGER.error("上传照片失败", e);
        }
        sysGlobalSetting.setCompanyId(UserUtils.getUser().getCompanyId());
        systemService.saveGlobalSetting(sysGlobalSetting);
        return "redirect:/sys/globalSetting/form";
    }
    
}
