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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.sys.dto.SysUserSearchParamsDto;
import com.bk.sys.model.SysOffice;
import com.bk.sys.model.SysRole;
import com.bk.sys.model.SysUser;
import com.bk.sys.model.SysUserOffice;
import com.bk.sys.model.SysUserRole;
import com.bk.sys.security.service.SystemService;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysOfficeService;
import com.bk.sys.service.SysRoleService;
import com.bk.sys.service.SysUserOfficeService;
import com.bk.sys.service.SysUserRoleService;
import com.bk.sys.service.SysUserService;
import com.bk.wd.web.base.BaseController;

/**
 * 用户管理
 * @Project Name:bk-wd-web
 * @Date:2017年3月7日下午2:29:40
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/user")
public class UserController extends BaseController {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private SystemService systemService;

    @Autowired
    private SysUserRoleService sysUserRoleService;

    @Autowired
    private SysUserOfficeService sysUserOfficeService;

    @Autowired
    private SysOfficeService sysOfficeService;

    @Autowired
    private SysRoleService sysRoleService;

    @ModelAttribute()
    public SysUser get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return sysUserService.selectByPrimaryKey(id);
        } else {
            return new SysUser();
        }
    }

    /**
     * 用戶編輯頁面 date: 2017年5月8日 下午8:40:21 <br/>
     * @author Liam
     * @param request
     * @param response
     * @param pagination
     * @param sysUser
     * @param model
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = { "userForm" })
    public String userForm(HttpServletRequest request, HttpServletResponse response, Pagination pagination, SysUser sysUser, Model model) {
        if (StringUtils.isNotEmpty(sysUser.getId())) {
            List<SysOffice> officeList = sysOfficeService.findByUser(sysUser.getId());
            model.addAttribute("officeList", officeList);
            List<SysRole> roleLst = sysRoleService.findByUser(sysUser.getId());
            model.addAttribute("roleLst", roleLst);
        }
        sysUser.setOffice(sysOfficeService.selectByPrimaryKey(sysUser.getOfficeId()));
        model.addAttribute("sysUser", sysUser);
        return "modules/sys/office/userForm";
    }

    /**
     * 用戶保存 date: 2017年5月8日 下午8:40:35 <br/>
     * @author Liam
     * @param user
     * @param newPassword
     * @param roleIds
     * @param officeIds
     * @param request
     * @param model
     * @param autoPhoto
     * @param redirectAttributes
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(SysUser user, String newPassword, String roleIds, String officeIds, HttpServletRequest request, Model model, @RequestParam(value = "autoPhoto", required = false) CommonsMultipartFile autoPhoto,
            RedirectAttributes redirectAttributes) {

        // 如果新密码为空，则不更换密码
        if (StringUtils.isNotBlank(newPassword)) {
            user.setLastPassword(user.getPassword());
            user.setPassword(SystemService.entryptPassword(newPassword));
        }

        // 判断登录名是否重复
        String oldName = null;
        if (StringUtils.isNoneBlank(user.getId())) {
            oldName = sysUserService.selectByPrimaryKey(user.getId()).getLoginName();
        }
        if (!"true".equals(checkLoginName(oldName, user.getLoginName()))) {
            return new JsonResult("保存用户'" + user.getLoginName() + "'失败，登录名已存在");
        }
        if (StringUtils.isEmpty(user.getId()) && StringUtils.isEmpty(user.getPassword())) {
            return new JsonResult("请设置初始化密码！");
        }

        user.setCompanyId(sysOfficeService.getCompanyByOfficeId(user.getOfficeId()).getId());

        // 保存用户信息
        systemService.saveUser(user);

        // 数据范围
        sysUserOfficeService.deleteUserOffice(user.getId(), user.getCompanyId());
        if (StringUtils.isNotEmpty(officeIds)) {
            String[] officeIdArray = officeIds.split(",");
            for (String officeId : officeIdArray) {
                if (StringUtils.isEmpty(officeId))
                    continue;
                SysUserOffice sysUserOffice = new SysUserOffice();
                sysUserOffice.setId(IdGen.uuid());
                sysUserOffice.setCompanyId(user.getCompanyId());
                sysUserOffice.setOfficeId(officeId);
                sysUserOffice.setUserId(user.getId());
                sysUserOfficeService.insertSelective(sysUserOffice);
            }
        }

        // 角色
        sysUserService.deleteUserRole(user);
        if (StringUtils.isNotEmpty(roleIds)) {
            String[] roleIdArray = roleIds.split(",");
            for (String roleId : roleIdArray) {
                if (StringUtils.isEmpty(roleId))
                    continue;
                SysUserRole sysUserRole = new SysUserRole();
                sysUserRole.setId(IdGen.uuid());
                // sysUserRole.setCompanyId(user.getCompanyId());
                sysUserRole.setRoleId(roleId);
                sysUserRole.setUserId(user.getId());
                sysUserRoleService.insertSelective(sysUserRole);
            }
        }
        return new JsonResult();
    }

    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "userOfficeSelect")
    public String userOfficeSelect(Model model, String officeId) {
        model.addAttribute("officeId", officeId);
        model.addAttribute("officeList", sysOfficeService.treeData(systemService.findAllOffice(), SysOffice.HeadCompany));
        return "modules/sys/office/userOfficeSelect";
    }

    /**
     * 用戶刪除 date: 2017年5月8日 下午8:42:13 <br/>
     * @author Liam
     * @param sysUser
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("sys:user:del")
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(SysUser sysUser) {
        sysUser.setUpdateBy(UserUtils.getUser().getId());
        sysUser.setUpdateDate(new Date());
        sysUser.setDelFlag(true);
        sysUserService.updateByPrimaryKeySelective(sysUser);
        return new JsonResult();
    }

    /**
     * 修改密碼頁面 date: 2017年5月8日 下午8:38:19 <br/>
     * @author Liam
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "modifyPwd", method = RequestMethod.GET)
    public String modifyPwd() {
        return "modules/sys/user/modifyPassword";
    }

    /**
     * 修改个人用户密码
     * @param oldPassword
     * @param newPassword
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "modifyPwd", method = RequestMethod.POST)
    public String modifyPwd(String oldPassword, String newPassword, String newPassword2, HttpServletResponse response, Model model) {

        SysUser user = UserUtils.getUser();
        boolean changeSuccess = false;
        if (StringUtils.isBlank(oldPassword) || StringUtils.isBlank(newPassword) || StringUtils.isBlank(newPassword2)) {
            model.addAttribute("message", "缺少必填");
        } else if (newPassword.compareTo(newPassword2) != 0) {
            model.addAttribute("para", "newPassword2");
            model.addAttribute("message", "两次输入的新密码不相同");
        } else if (!SystemService.validatePassword(oldPassword, user.getPassword())) {
            model.addAttribute("para", "oldPassword");
            model.addAttribute("message", "原始密码不正确");
        } else {
            systemService.updatePasswordById(user.getId(), user.getLoginName(), newPassword);
            changeSuccess = true;
            model.addAttribute("message", "修改密码成功");
        }

        model.addAttribute("result", changeSuccess);
        return renderString(response, model);
    }

    /**
     * 用户选择项 date: 2017年5月6日 下午1:07:54 <br/>
     * @author Liam
     * @param model
     * @param pagination
     * @param sysUserSearchParamsDto
     * @return
     * @since JDK 1.8
     */
    @RequestMapping(value = { "userSelect" })
    public String userSelect(Model model, Pagination pagination, SysUserSearchParamsDto sysUserSearchParamsDto) {
        sysUserSearchParamsDto.setDataScope("office");
        sysUserSearchParamsDto.setUserId(UserUtils.getUser().getId());
        model.addAttribute("userList", sysUserService.selectByDataScope(sysUserSearchParamsDto));
        model.addAttribute("params", sysUserSearchParamsDto);
        return "modules/sys/user/userSelect";
    }

    /**
     * 验证登录名是否有效
     * @param oldLoginName
     * @param loginName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "checkLoginName")
    public String checkLoginName(String oldLoginName, String loginName) {
        if (null != oldLoginName && oldLoginName.equals(loginName)) {
            return "true";
        }
        if (systemService.getUserByLoginName(loginName) == null) {
            return "true";
        }
        return "false";
    }
    
    @ResponseBody
    @RequestMapping(value = "callbackpassword")
    public JsonResult callbackpassword(String userId) {
        SysUser user = sysUserService.selectByPrimaryKey(userId);
        if (null != user && StringUtils.isNotEmpty(user.getLastPassword())) {
            user.setPassword(user.getLastPassword());
            user.setUpdateBy(UserUtils.getUser().getId());
            user.setUpdateDate(new Date());
            user.setLastPassword(null);
            sysUserService.updateByPrimaryKey(user);
        }
        return new JsonResult();
    }

    /**
     * 导出用户数据
     * @param user
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
    /*@RequiresPermissions("sys:user:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(User user, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "用户数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<User> page = systemService.findUser(new Page<User>(request, response, -1), user);
            new ExportExcel("用户数据", User.class).setDataList(page.getList()).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
        }
        return "redirect:" + adminPath + "/sys/user/list?repage";
    }*/

    /**
     * 导入用户数据
     * @param file
     * @param redirectAttributes
     * @return
     */
    /* @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
        if(Global.isDemoMode()){
            addMessage(redirectAttributes, "演示模式，不允许操作！");
            return "redirect:" + adminPath + "/sys/user/list?repage";
        }
        try {
            int successNum = 0;
            int failureNum = 0;
            StringBuilder failureMsg = new StringBuilder();
            ImportExcel ei = new ImportExcel(file, 1, 0);
            List<User> list = ei.getDataList(User.class);
            for (User user : list){
                try{
                    String str1 = user.getLoginName();
                    if(StringUtils.isNotBlank(str1) && str1.contains("E")) {
                        String str2 = str1.substring(0, str1.indexOf("E"));
                        str1 = str2.replace(".", "");
                        user.setLoginName(str1);
                    }
                    String strTell1 = user.getPhone();
                    if(StringUtils.isNotBlank(strTell1) && strTell1.contains("E")) {
                        String strTell2 = strTell1.substring(0, strTell1.indexOf("E"));
                        strTell1 = strTell2.replace(".", "");
                        user.setPhone(strTell1);
                    }
                    if ("true".equals(checkLoginName("", user.getLoginName()))){
                        user.setMobile(str1);
                        user.setPassword(SystemService.entryptPassword("123456"));
                        BeanValidators.validateWithException(validator, user);
                        systemService.saveUser(user);
                        successNum++;
                    }else{
                        failureMsg.append("<br/>登录名 "+user.getLoginName()+" 已存在; ");
                        failureNum++;
                    }
                }catch(ConstraintViolationException ex){
                    failureMsg.append("<br/>登录名 "+user.getLoginName()+" 导入失败：");
                    List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
                    for (String message : messageList){
                        failureMsg.append(message+"; ");
                        failureNum++;
                    }
                }catch (Exception ex) {
                    failureMsg.append("<br/>登录名 "+user.getLoginName()+" 导入失败："+ex.getMessage());
                }
            }
            if (failureNum>0){
                failureMsg.insert(0, "，失败 "+failureNum+" 条用户，导入信息如下：");
            }
            addMessage(redirectAttributes, "已成功导入 "+successNum+" 条用户"+failureMsg);
        } catch (Exception e) {
            addMessage(redirectAttributes, "导入用户失败！失败信息："+e.getMessage());
        }
        return "redirect:" + adminPath + "/sys/user/list?repage";
    }*/

    /**
     * 下载导入用户数据模板
     * @param response
     * @param redirectAttributes
     * @return
     */
    /*@RequiresPermissions("sys:user:view")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "用户数据导入模板.xlsx";
            List<User> list = Lists.newArrayList(); list.add(UserUtils.getUser());
            new ExportExcel("用户数据", User.class, 2).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
        }
        return "redirect:" + adminPath + "/sys/user/list?repage";
    }*/
}