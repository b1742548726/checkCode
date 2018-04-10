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
import com.bk.sys.model.SysDict;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysDictService;
import com.bk.sys.utils.DictUtils;
import com.bk.wd.web.base.BaseController;

/**
 * 字典管理
 * @Project Name:bk-wd-web 
 * @Date:2017年3月7日下午2:30:18 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/dict")
public class DictController extends BaseController {

	@Autowired
	private SysDictService dictService;
	
	@ModelAttribute
	public SysDict get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return dictService.selectByPrimaryKey(id);
		}else{
			return new SysDict();
		}
	}
	
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysDict sysDict, Pagination pagination, HttpServletRequest request, HttpServletResponse response, Model model) {
        dictService.findByPage(pagination, sysDict);
        model.addAttribute("pagination", pagination);
		return "modules/sys/dict/dictList";
	}
	
	@RequiresPermissions("sys:dict:view")
    @RequestMapping(value = "form")
    public String form(SysDict sysDict, Model model) {
        model.addAttribute("sysDict", sysDict);
        return "modules/sys/dict/dictForm";
    }
	
	@RequiresPermissions("sys:dict:edit")
    @RequestMapping(value = "save")
	@ResponseBody
    public JsonResult save(SysDict sysDict, Model model, RedirectAttributes redirectAttributes) {
	    if (StringUtils.isEmpty(sysDict.getId())) {
	        sysDict.setId(IdGen.uuid());
	        sysDict.setCreateBy(UserUtils.getUser().getId());
	        sysDict.setCreateDate(new Date());
	        sysDict.setUpdateBy(UserUtils.getUser().getId());
	        sysDict.setUpdateDate(new Date());
            dictService.insertSelective(sysDict);
        } else {
            sysDict.setUpdateBy(UserUtils.getUser().getId());
            sysDict.setUpdateDate(new Date());
            dictService.updateByPrimaryKeySelective(sysDict);
        }
	    DictUtils.clearDictCache();
	    return new JsonResult();
    }
	
	@RequiresPermissions("sys:dict:del")
    @RequestMapping(value = "delete")
	@ResponseBody
    public JsonResult delete(SysDict sysDict, RedirectAttributes redirectAttributes) {
	    sysDict.setDelFlag(true);
	    sysDict.setUpdateBy(UserUtils.getUser().getId());
	    sysDict.setUpdateDate(new Date());
	    dictService.updateByPrimaryKeySelective(sysDict);
	    DictUtils.clearDictCache();
        return new JsonResult();
    }

/*	
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String type, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Dict dict = new Dict();
		dict.setType(type);
		List<Dict> list = dictService.findList(dict);
		for (int i=0; i<list.size(); i++){
			Dict e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParentId());
			map.put("name", StringUtils.replace(e.getLabel(), " ", ""));
			mapList.add(map);
		}
		return mapList;
	}
	
	@ResponseBody
	@RequestMapping(value = "listData")
	public List<Dict> listData(@RequestParam(required=false) String type) {
		Dict dict = new Dict();
		dict.setType(type);
		return dictService.findList(dict);
	}
*/
}
