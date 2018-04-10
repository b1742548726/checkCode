package com.bk.wd.web.controller.sys;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysArea;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysAreaService;
import com.bk.wd.web.base.BaseController;

/**
 * 区域管理
 * @Project Name:bk-wd-web 
 * @Date:2017年3月7日下午2:30:11 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/area")
public class AreaController extends BaseController {

	@Autowired
	private SysAreaService areaService;
	
	@ModelAttribute("sysArea")
	public SysArea get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return areaService.selectByPrimaryKey(id);
		}else{
			return new SysArea();
		}
	}

	@RequestMapping(value = {"list", ""})
	public String list(SysArea sysArea, Model model) {
		model.addAttribute("list", areaService.queryAll());
		return "modules/sys/area/areaList";
	}

	@RequestMapping(value = "form")
	public String form(SysArea sysArea, Model model) {
		model.addAttribute("areaParent", areaService.selectByPrimaryKey(sysArea.getParentId()));
		model.addAttribute("sysArea", sysArea);
		return "modules/sys/area/areaForm";
	}
	
	@RequestMapping(value = "save")
	@ResponseBody
	public JsonResult save(SysArea sysArea, Model model) {
	    if (StringUtils.isEmpty(sysArea.getId())) {
	        sysArea.setId(IdGen.uuid());
	        sysArea.setCreateBy(UserUtils.getUser().getId());
            sysArea.setCreateDate(new Date());
            sysArea.setUpdateBy(UserUtils.getUser().getId());
            sysArea.setUpdateDate(new Date());
            areaService.insertSelective(sysArea);
        } else {
            sysArea.setUpdateBy(UserUtils.getUser().getId());
            sysArea.setUpdateDate(new Date());
            areaService.updateByPrimaryKeySelective(sysArea);
        }
	    return new JsonResult();
	}
	
	@RequestMapping(value = "delete")
	@ResponseBody
	public JsonResult delete(SysArea sysArea) {
	    sysArea.setUpdateBy(UserUtils.getUser().getId());
        sysArea.setUpdateDate(new Date());
        sysArea.setDelFlag(true);
        areaService.updateByPrimaryKeySelective(sysArea);
		return new JsonResult();
	}
/*
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Area> list = areaService.findAll();
		for (int i=0; i<list.size(); i++){
			Area e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}*/
}
