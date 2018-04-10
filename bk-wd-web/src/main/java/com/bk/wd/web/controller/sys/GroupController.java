package com.bk.wd.web.controller.sys;

import java.util.Date;
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
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysDict;
import com.bk.sys.model.SysGroup;
import com.bk.sys.model.SysGroupUser;
import com.bk.sys.model.SysOffice;
import com.bk.sys.security.service.SystemService;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysDictService;
import com.bk.sys.service.SysGroupService;
import com.bk.sys.service.SysGroupUserService;
import com.bk.sys.service.SysOfficeService;
import com.bk.sys.service.SysUserService;
import com.bk.wd.web.base.BaseController;

/**
 * 分组管理
 * @Project Name:bk-wd-web 
 * @Date:2017年4月28日下午4:46:02 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/group")
public class GroupController extends BaseController {
    
    @Autowired
    private SysGroupService sysGroupService;
    
    @Autowired
    private SysUserService sysUserService;
    
    @Autowired
    private SysOfficeService sysOfficeService;
    
    @Autowired
    private SysGroupUserService sysGroupUserService;
    
    @Autowired
    private SystemService systemService;
    
    @Autowired
    private SysDictService sysDictService;

    @ModelAttribute()
    public SysGroup get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return sysGroupService.selectByPrimaryKey(id);
        }else{
            return new SysGroup();
        }
    }
    
    /**
     * 分组列表
     * date: 2017年5月4日 下午7:49:54 <br/> 
     * @author Liam 
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:group:view")
    @RequestMapping(value = {"list", ""})
    public String list(Model model) {
        model.addAttribute("list", sysGroupService.selectBaseGroupByUser(UserUtils.getUser()));
        return "modules/sys/group/groupList";
    }
    
    /**
     * 流程节点列表
     * date: 2017年5月4日 下午7:49:54 <br/> 
     * @author Liam 
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:group:view")
    @RequestMapping(value = {"cllList"})
    public String cllList(Model model) {
        model.addAttribute("list", sysGroupService.selectOnlineGroupByUser(UserUtils.getUser()));
        return "modules/sys/group/cllGroupList";
    }
    
    /**
     * 初始化线上贷款流程节点配置
     * @return
     */
    @RequiresPermissions("sys:group:init:online:config")
    @RequestMapping(value = {"initOnlineUserGroupCategory"})
    @ResponseBody
    public JsonResult initOnlineUserGroupCategory() {
    	List<SysDict> sysDictList = sysDictService.selectByType(SysGroup.ONLINE_GOURP_CATEGORY);
    	for (SysDict sysDict : sysDictList) {
    		List<SysGroup> sysGroupList = sysGroupService.selectByCategory(sysDict.getValue(), UserUtils.getUser());
    		if (sysGroupList.isEmpty()) {
    			SysGroup sysGroup = new SysGroup();
    			sysGroup.setId(UidUtil.uuid());
    			sysGroup.setCompanyId(UserUtils.getUser().getCompanyId());
    			sysGroup.setCreateBy(UserUtils.getUser().getId());
                sysGroup.setCreateDate(new Date());
                sysGroup.setUpdateBy(UserUtils.getUser().getId());
                sysGroup.setUpdateDate(new Date());
                
                sysGroup.setName(sysDict.getLabel());
                sysGroup.setCategory(sysDict.getValue());
                sysGroupService.insertSelective(sysGroup);
    		}
    	}
    	return new JsonResult();
    }

    /**
     * 用户分组列表
     * date: 2017年5月4日 下午7:49:29 <br/> 
     * @author Liam 
     * @param request
     * @param response
     * @param pagination
     * @param sysGroup
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequestMapping(value = {"userList"})
    @RequiresPermissions("sys:group:view")
    public String userList(HttpServletRequest request, HttpServletResponse response, Pagination pagination, SysGroup sysGroup,
            Model model) {
        if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
            sysGroup.setUserId(UserUtils.getUser().getId());
        }
        sysUserService.selectByGroupPagination(pagination, sysGroup);
        model.addAttribute("pagination", pagination);
        return "modules/sys/group/userList";
    }

    /**
     * 编辑分组
     * date: 2017年5月3日 下午9:08:51 <br/> 
     * @author Liam 
     * @param sysRole
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:group:edit")
    @RequestMapping(value = "form")
    public String form(SysGroup sysGroup, Model model) {
        model.addAttribute("sysGroup", sysGroup);
        return "modules/sys/group/groupForm";
    }
    
    /**
     * 保存分组
     * date: 2017年5月4日 下午8:32:59 <br/> 
     * @author Liam 
     * @param sysGroup
     * @param menuIds
     * @param model
     * @param redirectAttributes
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:group:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(SysGroup sysGroup, String menuIds, Model model, RedirectAttributes redirectAttributes) {
        if (StringUtils.isBlank(sysGroup.getId())) {
            sysGroup.setId(IdGen.uuid());
            sysGroup.setCreateBy(UserUtils.getUser().getId());
            sysGroup.setCreateDate(new Date());
            sysGroup.setCompanyId(UserUtils.getUser().getCompanyId());
            sysGroup.setUpdateBy(UserUtils.getUser().getId());
            sysGroup.setUpdateDate(new Date());
            sysGroupService.insertSelective(sysGroup);
        } else {
            sysGroup.setUpdateBy(UserUtils.getUser().getId());
            sysGroup.setUpdateDate(new Date());
            sysGroupService.updateByPrimaryKeySelective(sysGroup);
        }
        return new JsonResult(sysGroup);
    }
    
    /**
     * 分配用户组页面
     * @param role
     * @param model
     * @return
     */
    @RequiresPermissions("sys:group:assignment")
    @RequestMapping(value = "groupUserForm")
    public String groupUserForm(SysGroup sysGroup, Model model) {
        model.addAttribute("sysGroup", sysGroup);
        if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
            sysGroup.setUserId(UserUtils.getUser().getId());
        }
        model.addAttribute("userList", sysUserService.selectByGroup(sysGroup));
        model.addAttribute("officeList", sysOfficeService.treeData(systemService.findAllOffice(), SysOffice.HeadCompany));
        return "modules/sys/group/groupUserForm";
    }
    
    /**
     * 保存用户分配组
     * @param role
     * @param idsArr
     * @return
     */
    @RequiresPermissions("sys:group:assignment")
    @RequestMapping(value = "saveGroupUser")
    @ResponseBody
    public JsonResult saveRoleUser(SysGroup sysGroup, String userIds) {
        sysGroupUserService.deleteByGroupAndUser(null, sysGroup.getId());
        if (StringUtils.isNotEmpty(userIds)) {
            String[] userIdArray = userIds.split(",");
            for (String userId : userIdArray) {
                SysGroupUser sysGroupUser = new SysGroupUser();
                sysGroupUser.setId(IdGen.uuid());
                //sysUserRole.setCompanyId(user.getCompanyId());
                sysGroupUser.setGroupId(sysGroup.getId());
                sysGroupUser.setUserId(userId);
                sysGroupUserService.insertSelective(sysGroupUser);
            }
        }
        return new JsonResult();
    }
    
    /**
     * 角色用户组
     * date: 2017年5月3日 下午7:01:41 <br/> 
     * @author Liam 
     * @param sysRole
     * @param redirectAttributes
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:group:del")
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(SysGroup sysGroup) {
        sysGroup.setUpdateBy(UserUtils.getUser().getId());
        sysGroup.setUpdateDate(new Date());
        sysGroup.setDelFlag(true);
        sysGroupService.updateByPrimaryKeySelective(sysGroup);
        return new JsonResult(true, "删除用户组");
    }
    
    /**
     * 删除用户組的用戶
     * date: 2017年5月3日 下午7:01:41 <br/> 
     * @author Liam 
     * @param sysRole
     * @param redirectAttributes
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:group:assignment")
    @RequestMapping(value = "deleteGroupUser")
    @ResponseBody
    public JsonResult deleteGroupUser(SysGroup sysGroup, String userId) {
        sysGroupUserService.deleteByGroupAndUser(userId, sysGroup.getId());
        return new JsonResult(true, "移除用户组的用戶");
    }
}
