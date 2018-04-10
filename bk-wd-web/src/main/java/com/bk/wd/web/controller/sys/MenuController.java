package com.bk.wd.web.controller.sys;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bk.common.entity.JsonResult;
import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysMenu;
import com.bk.sys.security.service.SystemService;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysMenuService;
import com.bk.wd.web.base.BaseController;
import com.google.common.collect.Lists;

/**
 * 菜单
 * @Project Name:bk-wd-web 
 * @Date:2017年3月7日下午2:29:51 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/menu")
public class MenuController extends BaseController {
    
	@Autowired
	private SystemService systemService;
	
	@Autowired
	private SysMenuService sysMenuService;

	@RequiresPermissions("sys:menu:view")
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		List<SysMenu> list = Lists.newArrayList();
		List<SysMenu> sourcelist = systemService.findAllMenu();
		try {
			SysMenu.sortList(list, sourcelist, null, true);
		} catch (Exception e) {
			e.printStackTrace();
		}
        model.addAttribute("list", list);
		return "modules/sys/menu/menuList";
	}
	
	@RequiresPermissions("sys:menu:del")
	@RequestMapping(value = "delete")
	@ResponseBody
	public JsonResult delete(String menuId, RedirectAttributes redirectAttributes) {
		systemService.deleteMenu(menuId);
		return new JsonResult(true, "删除菜单成功");
	}
	
	@RequiresPermissions("sys:menu:view")
    @RequestMapping(value = "form")
    public String form(SysMenu sysMenu, Model model) {
	    if (StringUtils.isNotEmpty(sysMenu.getId())) {
	        sysMenu = sysMenuService.selectByPrimaryKey(sysMenu.getId());
	    }
	    if (StringUtils.isNotEmpty(sysMenu.getParentId())) {
	        sysMenu.setParent(sysMenuService.selectByPrimaryKey(sysMenu.getParentId()));
	    }
        // 获取排序号，最末节点排序号+30
        if (null == sysMenu.getSort()){
            sysMenu.setSort(sysMenuService.getMaxSort(sysMenu.getParentId()) + 30);
        }
        model.addAttribute("menu", sysMenu);
        return "modules/sys/menu/menuForm";
    }
    
    @RequiresPermissions("sys:menu:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(SysMenu sysMenu, Model model, RedirectAttributes redirectAttributes) {
        if(!UserUtils.getUser().isAdmin()){
            return new JsonResult("越权操作，只有超级管理员才能添加或修改数据！");
        }
        systemService.saveMenu(sysMenu);
        return new JsonResult();
    }
	
}
