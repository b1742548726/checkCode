package com.bk.wd.web.controller.sys;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysVersion;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysVersionService;
import com.bk.wd.web.base.BaseController;

/**
 * 版本管理
 * 
 * @Project Name:bk-wd-web
 * @Date:2017年3月9日下午1:50:29
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/version")
public class VersionController extends BaseController {

	@Autowired
	private SysVersionService sysVersionService;

	@ModelAttribute()
	public SysVersion get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return sysVersionService.selectByPrimaryKey(id);
		} else {
			return new SysVersion();
		}
	}

	@RequiresPermissions("sys:sysVersion:view")
	@RequestMapping(value = "")
	public String index(SysVersion sysVersion, Pagination pagination, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		
		if (sysVersion.getPlatform() == null) { // 设置默认页面
			sysVersion.setPlatform("iOS");
		}
		sysVersion.setCompanyId(UserUtils.getUser().getCompanyId());
		sysVersionService.findByPage(pagination, sysVersion);
		model.addAttribute("page", pagination);
		model.addAttribute("sysVersion", sysVersion);
		
		return "modules/sys/version/versionList";
	}

	@RequiresPermissions("sys:sysVersion:edit") 
	@RequestMapping(value = "/form")
	public String form(SysVersion sysVersion, Model model) {
		model.addAttribute("sysVersion", sysVersion);
		return "modules/sys/version/versionForm";
	}

	@RequiresPermissions("sys:sysVersion:edit") 
	@RequestMapping(value = "/save")
	@ResponseBody
	public JsonResult save(SysVersion sysVersion, Model model) {
		if (StringUtils.isEmpty(sysVersion.getId())) {

//			SysVersion lastestVersion = sysVersionService.selectLastestVersion(sysVersion.getPlatform());
//			short versionCode = 1;
//			if (null != lastestVersion && lastestVersion.getVersionCode() > 0) {
//				versionCode = lastestVersion.getVersionCode();
//				versionCode += 1;
//			}

			sysVersion.setId(IdGen.uuid());
//			sysVersion.setVersionCode(versionCode);
			sysVersion.setCompanyId(UserUtils.getUser().getCompanyId());
			sysVersion.setCreateBy(UserUtils.getUser().getId());
			sysVersion.setCreateDate(new Date());
			sysVersion.setUpdateBy(UserUtils.getUser().getId());
			sysVersion.setUpdateDate(new Date());
			sysVersionService.insertSelective(sysVersion);
		} else {
		    sysVersion.setCompanyId(UserUtils.getUser().getCompanyId());
			sysVersion.setUpdateBy(UserUtils.getUser().getId());
			sysVersion.setUpdateDate(new Date());
			sysVersionService.updateByPrimaryKeySelective(sysVersion);
		}
		return new JsonResult(true, "保存成功");
	}

	@RequiresPermissions("sys:sysVersion:edit") 
	@RequestMapping(value = "delete")
	@ResponseBody
	public JsonResult delete(SysVersion sysVersion, RedirectAttributes redirectAttributes) {
		sysVersion.setDelFlag(true);
		sysVersion.setUpdateBy(UserUtils.getUser().getId());
		sysVersion.setUpdateDate(new Date());
		sysVersionService.updateByPrimaryKeySelective(sysVersion);
		return new JsonResult(true, "删除成功");
	}
}
