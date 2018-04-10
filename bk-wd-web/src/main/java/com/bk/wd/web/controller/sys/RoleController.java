package com.bk.wd.web.controller.sys;

import java.util.List;

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
import com.bk.common.utils.EntityUtils;
import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysOffice;
import com.bk.sys.model.SysRole;
import com.bk.sys.model.SysRoleExample;
import com.bk.sys.model.SysRoleMenu;
import com.bk.sys.model.SysUserExample;
import com.bk.sys.model.SysUserRole;
import com.bk.sys.model.SysUserRoleExample;
import com.bk.sys.security.service.SystemService;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysMenuService;
import com.bk.sys.service.SysOfficeService;
import com.bk.sys.service.SysRoleMenuService;
import com.bk.sys.service.SysRoleService;
import com.bk.sys.service.SysUserRoleService;
import com.bk.sys.service.SysUserService;
import com.bk.wd.web.base.BaseController;

/**
 * 角色管理
 * @Project Name:bk-wd-web 
 * @Date:2017年3月9日下午4:08:34 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/role")
public class RoleController extends BaseController {

	@Autowired
	private SystemService systemService;
	
	@Autowired
    private SysRoleService sysRoleService;
	
	@Autowired
	private SysRoleMenuService sysRoleMenuService;
	
	@Autowired
	private SysUserRoleService sysUserRoleService;
	
	@Autowired
	private SysUserService sysUserService;
	
	@Autowired
	private SysOfficeService sysOfficeService;
	
	@Autowired
	private SysMenuService sysMenuService;
	
	@ModelAttribute()
	public SysRole get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return sysRoleService.selectByPrimaryKey(id);
		}else{
			return new SysRole();
		}
	}
	
	/**
	 * 角色列表
	 * date: 2017年5月3日 下午9:08:25 <br/> 
	 * @author Liam 
	 * @param model
	 * @return 
	 * @since JDK 1.8
	 */
	@RequiresPermissions("sys:role:view")
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		model.addAttribute("list", systemService.findAllRole());
		return "modules/sys/role/roleList";
	}

	/**
	 * 编辑角色
	 * date: 2017年5月3日 下午9:08:51 <br/> 
	 * @author Liam 
	 * @param sysRole
	 * @param model
	 * @return 
	 * @since JDK 1.8
	 */
	@RequiresPermissions("sys:role:view")
	@RequestMapping(value = "form")
	public String form(SysRole sysRole, Model model) {
	    model.addAttribute("list", systemService.findAllRole());
 	    if (StringUtils.isNotEmpty(sysRole.getId())) {
	        model.addAttribute("roleMenuList", sysRoleMenuService.selectByRole(sysRole.getId()));
	    }
		model.addAttribute("role", sysRole);
		model.addAttribute("menuList", sysMenuService.treeData(systemService.findAllMenu(), null));
		return "modules/sys/role/roleForm";
	}
	
	/**
	 * 角色用户列表
	 * date: 2017年5月3日 下午9:09:26 <br/> 
	 * @author Liam 
	 * @param request
	 * @param response
	 * @param pagination
	 * @param sysRole
	 * @param model
	 * @return 
	 * @since JDK 1.8
	 */
	@RequiresPermissions("sys:role:view")
    @RequestMapping(value = {"userList"})
    public String userList(HttpServletRequest request, HttpServletResponse response, Pagination pagination, SysRole sysRole,
            Model model) {
	    if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
            sysRole.setUserId(UserUtils.getUser().getId());
        }
        sysUserService.selectByRolePagination(pagination, sysRole);
        model.addAttribute("pagination", pagination);
        return "modules/sys/role/userList";
    }
	
	/**
	 * 角色保存
	 * date: 2017年5月3日 下午7:01:29 <br/> 
	 * @author Liam 
	 * @param sysRole
	 * @param menuIds
	 * @param model
	 * @param redirectAttributes
	 * @return 
	 * @since JDK 1.8
	 */
	@RequiresPermissions("sys:role:edit")
	@RequestMapping(value = "save")
	@ResponseBody
	public JsonResult save(SysRole sysRole, String menuIds, Model model, RedirectAttributes redirectAttributes) {
		if (!checkName(sysRole.getId(), sysRole.getName())){
		    return new JsonResult(false, "保存角色'" + sysRole.getName() + "'失败, 角色名已存在");
		}
		systemService.saveRole(sysRole);
		
		sysRoleMenuService.deleteByRole(sysRole.getId());
		if (StringUtils.isNotEmpty(menuIds)) {
            String[] menuIdArray = menuIds.split(",");
            for (String menuId : menuIdArray) {
                SysRoleMenu sysRoleMenu = new SysRoleMenu();
                sysRoleMenu.setId(IdGen.uuid());
                sysRoleMenu.setMenuId(menuId);
                sysRoleMenu.setRoleId(sysRole.getId());
                sysRoleMenuService.insertSelective(sysRoleMenu);
            }
		}
		
		return new JsonResult(true, "保存角色'" + sysRole.getName() + "'成功");
	}
	
	/**
	 * 角色删除
	 * date: 2017年5月3日 下午7:01:41 <br/> 
	 * @author Liam 
	 * @param sysRole
	 * @param redirectAttributes
	 * @return 
	 * @since JDK 1.8
	 */
	@RequiresPermissions("sys:role:del")
	@RequestMapping(value = "delete")
	@ResponseBody
	public JsonResult delete(SysRole sysRole, RedirectAttributes redirectAttributes) {
		systemService.deleteRole(sysRole);
		return new JsonResult(true, "删除角色成功");
	}
	
	/**
     * 删除用户的角色
     * date: 2017年5月3日 下午7:01:41 <br/> 
     * @author Liam 
     * @param sysRole
     * @param redirectAttributes
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:role:assignment")
    @RequestMapping(value = "deleteRoleUser")
    @ResponseBody
    public JsonResult deleteRoleUser(SysRole sysRole, String userId, RedirectAttributes redirectAttributes) {
        sysUserRoleService.deleteByRoleAndUser(sysRole.getId(), userId);
        return new JsonResult(true, "删除角色成功");
    }
	
	/**
	 * 角色分配用户页面
	 * @param role
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:role:assignment")
	@RequestMapping(value = "roleUserForm")
	public String roleUserForm(SysRole sysRole, Model model) {
	    model.addAttribute("sysRole", sysRole);
	    if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
	        sysRole.setUserId(UserUtils.getUser().getId());
	    }
	    model.addAttribute("userList", sysUserService.selectByRole(sysRole));
	    model.addAttribute("officeList", sysOfficeService.treeData(systemService.findAllOffice(), SysOffice.HeadCompany));
		return "modules/sys/role/roleUserForm";
	}
	
	/**
	 * 角色分配
	 * @param role
	 * @param idsArr
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:role:assignment")
	@RequestMapping(value = "saveRoleUser")
	@ResponseBody
	public JsonResult saveRoleUser(SysRole role, String userIds) {
	    if (SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
	        sysUserRoleService.deleteByRole(role.getId());
	    } else {
	        SysUserExample sysUserExample = new SysUserExample();
	        sysUserExample.createCriteria().andCompanyIdEqualTo(UserUtils.getUser().getCompanyId());
	        
	        List<String> userIdList = EntityUtils.convertEntityToString(sysUserService.selectByExample(sysUserExample), "id");
	        if (!userIdList.isEmpty()) {
	            SysUserRoleExample sysUserRoleExample = new SysUserRoleExample();
	            sysUserRoleExample.createCriteria().andRoleIdEqualTo(role.getId()).andUserIdIn(userIdList);
	            sysUserRoleService.deleteByExample(sysUserRoleExample);
	        }
	    }
	    
	    if (StringUtils.isNotEmpty(userIds)) {
            String[] userIdArray = userIds.split(",");
            for (String userId : userIdArray) {
                SysUserRole sysUserRole = new SysUserRole();
                sysUserRole.setId(IdGen.uuid());
                //sysUserRole.setCompanyId(user.getCompanyId());
                sysUserRole.setRoleId(role.getId());
                sysUserRole.setUserId(userId);
                sysUserRoleService.insertSelective(sysUserRole);
            }
        }
	    return new JsonResult();
	}

	/**
	 * 验证角色名是否有效
	 * @param oldName
	 * @param name
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "checkName")
	public boolean checkName(String id, String name) {
	    SysRoleExample sysRoleExample = new SysRoleExample();
	    SysRoleExample.Criteria criteria = sysRoleExample.createCriteria();
	    criteria.andDelFlagEqualTo(false);
	    criteria.andNameEqualTo(name);
	    if (StringUtils.isNotEmpty(id)){
	        criteria.andIdNotEqualTo(id);
	    }
	    List<SysRole> sysRoleList = sysRoleService.selectByExample(sysRoleExample);
	    if (sysRoleList.isEmpty()) {
	        return true;
	    } else {
	        return false;
	    }
	}
}