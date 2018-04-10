package com.bk.wd.web.controller.sys;

import java.util.Arrays;
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

import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.sys.model.SysOffice;
import com.bk.sys.security.service.SystemService;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysOfficeService;
import com.bk.sys.service.SysUserService;
import com.bk.wd.web.base.BaseController;

/**
 * 机构管理
 * @Project Name:智微云
 * @Date:2017年3月7日上午9:50:08 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/office")
public class OfficeController extends BaseController {

    @Autowired
    private SysOfficeService officeService;
    
    @Autowired
    private SysUserService sysUserService;
    
    @Autowired
    private SystemService systemService;

    @ModelAttribute()
    public SysOffice get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return officeService.selectByPrimaryKey(id);
        } else {
            return new SysOffice();
        }
    }

    /**
     * 组织机构页面
     * date: 2017年5月1日 下午3:23:02 <br/> 
     * @author Liam 
     * @param office
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:office:view")
    @RequestMapping(value = {"", "list"})
    public String list(SysOffice office, Model model) {
        model.addAttribute("officeList", officeService.treeData(systemService.findAllOffice(), SysOffice.HeadCompany));
        return "modules/sys/office/officeList";
    }
    
    /**
     * 用户列表
     * date: 2017年5月1日 下午3:22:40 <br/> 
     * @author Liam 
     * @param request
     * @param response
     * @param pagination
     * @param sysOffice 
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:office:view")
    @RequestMapping(value = {"userList"})
    public String userList(HttpServletRequest request, HttpServletResponse response, Pagination pagination, SysOffice sysOffice, String searchName, Model model) {
        model.addAttribute("sysOffice", sysOffice);
        model.addAttribute("officeName", sysOffice.getName());
        sysOffice.setName(searchName);
        if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
            sysOffice.setUserId(UserUtils.getUser().getId());
        }
        sysUserService.selectByOfficePagination(pagination, sysOffice);
        model.addAttribute("pagination", pagination);
        model.addAttribute("searchName", searchName);
        return "modules/sys/office/userList";
    }
    
    /**
     * 根据机构获取用户列表
     * date: 2017年5月4日 下午3:26:43 <br/> 
     * @author Liam 
     * @param sysOffice
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:office:view")
    @RequestMapping(value = {"queryUserList"})
    @ResponseBody
    public JsonResult userList(SysOffice sysOffice) {
        return new JsonResult(sysUserService.selectByOffice(sysOffice));
    }
    
    /**
     * 编辑机构页面
     * date: 2017年5月1日 下午3:23:19 <br/> 
     * @author Liam 
     * @param office
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:office:edit")
    @RequestMapping(value = "form")
    public String form(SysOffice office, Model model) {
        if (StringUtils.isEmpty(office.getParentId())) { //默认选择本人的所在部门
            office.setParentId(UserUtils.getUser().getOffice().getId());
        }
        model.addAttribute("officeParent", officeService.selectByPrimaryKey(office.getParentId()));
        model.addAttribute("office", office);
        return "modules/sys/office/officeForm";
    }
    
    /**
     * 编辑机构页面
     * date: 2017年5月4日 下午2:21:11 <br/> 
     * @author Liam 
     * @param office
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:office:edit")
    @RequestMapping(value = "editForm")
    public String editForm(SysOffice office, Model model) {
        model.addAttribute("sysOffice", office);
        model.addAttribute("officeList", officeService.treeData(systemService.findAllOffice(), SysOffice.HeadCompany));
        return "modules/sys/office/officeEditForm";
    }

    /**
     * 保存机构页面
     * date: 2017年5月1日 下午3:23:55 <br/> 
     * @author Liam 
     * @param office
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:office:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(SysOffice office, Model model, String newParentId) {
        if (StringUtils.isEmpty(office.getName())) {
            return new JsonResult("请输入机构名称");
        }
        boolean modifyParent = false;
        if (!office.getParentId().equals(newParentId) && StringUtils.isNotEmpty(newParentId)) {
            modifyParent = true;
            office.setParentId(newParentId);
            office.setParentIds(officeService.getParentIds(newParentId) + "," + newParentId);
        }
        
        office.setParentIds(officeService.getParentIds(office.getParentId()));
        office.setType(2);
        if (StringUtils.isEmpty(office.getId())) {
            office.setId(IdGen.uuid());
            office.setCreateBy(UserUtils.getUser().getId());
            office.setCreateDate(new Date());
            office.setUpdateBy(UserUtils.getUser().getId());
            office.setUpdateDate(new Date());
            officeService.insertSelective(office);
        } else {
            office.setUpdateBy(UserUtils.getUser().getId());
            office.setUpdateDate(new Date());
            officeService.updateByPrimaryKeySelective(office);
        }
        
        if (modifyParent) {
            if (office.getId().equals(office.getParentId())) {
                return new JsonResult("父级机构不能选择当前机构");
            }
            
            SysOffice parentOffice = officeService.selectByPrimaryKey(office.getParentId());
            if (StringUtils.isNotEmpty(parentOffice.getParentIds())) {
                if (Arrays.asList(parentOffice.getParentIds().split(",")).contains(office.getId())) {
                    return new JsonResult("不能将当前组归属到下级组中");
                }
            }
            // 父级机构迁移后，子级机构也要迁移
            officeService.updateChildOfParentIds(office.getId(), UserUtils.getUser().getId());
        }
        return new JsonResult(office);
    }
    
    /**
     * 机构选择器
     * date: 2017年5月1日 下午8:23:44 <br/> 
     * @author Liam 
     * @param userId
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "selectOffice")
    public String selectOffice(Model model, String officeIds) {
        model.addAttribute("officeIds", officeIds);
        model.addAttribute("officeList", officeService.treeData(systemService.findAllOffice(), SysOffice.HeadCompany));
        return "modules/sys/office/officeSelect";
    }
    
    /**
     * 角色选择器
     * date: 2017年5月1日 下午8:23:56 <br/> 
     * @author Liam 
     * @param userId
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "selectRole")
    public String selectRole(Model model, String roleIds) {
        model.addAttribute("roleIds", roleIds);
        model.addAttribute("roleList", systemService.findAllRole());
        return "modules/sys/office/roleSelect";
    }
    
    /**
     * 删除机构确认页面
     * date: 2017年5月1日 下午3:43:28 <br/> 
     * @author Liam 
     * @param sysUserOffice
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:office:del")
    @RequestMapping(value = "removeView")
    public String removeView(SysOffice office, Model model) {
        model.addAttribute("office", office);
        return "modules/sys/office/officeRemove";
    }
    
    /**
     * 机构删除
     * date: 2017年5月4日 上午9:50:51 <br/> 
     * @author Liam 
     * @param office
     * @param password
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:office:del")
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(SysOffice office, String password) {
        if (StringUtils.isEmpty(password)) {
            return new JsonResult("请输入密码");
        }
        if (!SystemService.validatePassword(password, UserUtils.getUser().getPassword())) {
            return new JsonResult("密码不正确");
        }
        office.setUpdateBy(UserUtils.getUser().getId());
        office.setUpdateDate(new Date());
        office.setDelFlag(true);
        officeService.updateByPrimaryKeySelective(office);
        return new JsonResult();
    }
    
    @RequestMapping(value = "companyList")
    public String companyList(Model model) {
        model.addAttribute("companyList", officeService.selectChildList(SysOffice.HeadCompany));
        return "modules/sys/office/companyList";
    }
    
    /**
     * 编辑公司页面
     * date: 2017年5月4日 下午2:21:11 <br/> 
     * @author Liam 
     * @param office
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequestMapping(value = "companyForm")
    public String companyForm(SysOffice office, Model model) {
        model.addAttribute("sysOffice", office);
        return "modules/sys/office/companyForm";
    }

}
