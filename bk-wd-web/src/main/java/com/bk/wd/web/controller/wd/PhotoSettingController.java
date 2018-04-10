package com.bk.wd.web.controller.wd;

import java.util.Date;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdDefaultPhotoSetting;
import com.bk.wd.service.WdDefaultPhotoSettingService;
import com.bk.wd.web.base.BaseController;

/**
 * 调查组照片配置
 * @Project Name:bk-wd-web 
 * @Date:2017年3月9日下午10:31:26 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/photoSetting")
public class PhotoSettingController extends BaseController {
    
    @Autowired
    private WdDefaultPhotoSettingService wdDefaultPhotoSettingService;
    
    @RequiresPermissions("wd:photoSetting:view")
    @RequestMapping(value = {"list", ""})
    public String list(Model model, Pagination pagination, WdDefaultPhotoSetting wdDefaultPhotoSetting) {
        wdDefaultPhotoSettingService.findByPage(pagination, wdDefaultPhotoSetting);
        model.addAttribute("pagination", pagination);
        return "modules/wd/photoSetting/photoSettingList";
    }

    @RequiresPermissions("wd:photoSetting:view")
    @RequestMapping(value = "form")
    public String form(String id, Model model) {
        model.addAttribute("wdDefaultPhotoSetting", wdDefaultPhotoSettingService.selectByPrimaryKey(id));
        return "modules/wd/photoSetting/photoSettingForm";
    }
    
    @RequiresPermissions("wd:photoSetting:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(WdDefaultPhotoSetting wdDefaultPhotoSetting, Model model) {
        if (StringUtils.isEmpty(wdDefaultPhotoSetting.getId())) {
            wdDefaultPhotoSetting.setId(IdGen.uuid());
            wdDefaultPhotoSetting.setCreateBy(UserUtils.getUser().getId());
            wdDefaultPhotoSetting.setCreateDate(new Date());
            wdDefaultPhotoSetting.setUpdateBy(UserUtils.getUser().getId());
            wdDefaultPhotoSetting.setUpdateDate(new Date());
            wdDefaultPhotoSettingService.insertSelective(wdDefaultPhotoSetting);
        } else {
            wdDefaultPhotoSetting.setUpdateBy(UserUtils.getUser().getId());
            wdDefaultPhotoSetting.setUpdateDate(new Date());
            wdDefaultPhotoSettingService.updateByPrimaryKeySelective(wdDefaultPhotoSetting);
        }
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:photoSetting:edit")
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(WdDefaultPhotoSetting wdDefaultPhotoSetting) {
        wdDefaultPhotoSetting.setUpdateBy(UserUtils.getUser().getId());
        wdDefaultPhotoSetting.setUpdateDate(new Date());
        wdDefaultPhotoSetting.setDelFlag(true);
        wdDefaultPhotoSettingService.updateByPrimaryKeySelective(wdDefaultPhotoSetting);
        return new JsonResult();
    }
    
    @RequiresPermissions("wd:photoSetting:edit")
    @RequestMapping(value = {"sorts"})
    @ResponseBody
    public JsonResult sorts(String photoSettingIds) {
        if (StringUtils.isNoneEmpty(photoSettingIds)) {
            String[] photoSettingIdArray = photoSettingIds.split(",");
            for (int i = 0; i < photoSettingIdArray.length; i++) {
                if (StringUtils.isNoneEmpty(photoSettingIdArray[i])) {
                    WdDefaultPhotoSetting wdDefaultPhotoSetting = wdDefaultPhotoSettingService.selectByPrimaryKey(photoSettingIdArray[i]);
                    wdDefaultPhotoSetting.setSort(i);
                    wdDefaultPhotoSetting.setUpdateBy(UserUtils.getUser().getId());
                    wdDefaultPhotoSetting.setUpdateDate(new Date());
                    wdDefaultPhotoSettingService.updateByPrimaryKeySelective(wdDefaultPhotoSetting);
                }
            }
        }
        return new JsonResult();
    }

}