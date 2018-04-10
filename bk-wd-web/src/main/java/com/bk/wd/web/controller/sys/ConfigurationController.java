package com.bk.wd.web.controller.sys;

import java.util.Date;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysConfiguration;
import com.bk.sys.model.SysDict;
import com.bk.sys.model.SysOffice;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysConfigurationService;
import com.bk.sys.service.SysOfficeService;
import com.bk.sys.utils.DictUtils;
import com.bk.wd.web.base.BaseController;

@RequestMapping({ "/wd/configuration" })
@Controller
public class ConfigurationController extends BaseController {

    @Autowired
    private SysConfigurationService configurationService;

    @Autowired
    private SysOfficeService officeService;

    @RequiresPermissions("wd:configuration:edit")
    @RequestMapping(value = { "/list" })
    public String list(Model model) {
        SysUser currentUser = UserUtils.getUser();
        SysOffice company = officeService.selectByPrimaryKey(currentUser.getCompanyId());

        List<SysConfiguration> configList = configurationService.selectByOffice(currentUser.getCompanyId());
        List<SysDict> dictList = DictUtils.getDictList("系统启禁用可控模块");

        for (SysDict sysDict : dictList) {
            boolean hasSetted = false;
            for (SysConfiguration config : configList) {
                if (config.getKey().equals(sysDict.getValue())) {
                    hasSetted = true;
                    config.setDescription(sysDict.getDescription());
                    break;
                }
            }
            if (!hasSetted) {
                SysConfiguration configuration = new SysConfiguration();
                configuration.setId(UidUtil.uuid());
                configuration.setOfficeId(currentUser.getCompanyId());
                if (null != company) 
                    configuration.setOfficeName(company.getName());
                configuration.setKey(sysDict.getValue());
                configuration.setValue("disable");
                configuration.setRemarks(sysDict.getLabel());
                configuration.setCreateBy(currentUser.getId());
                configuration.setCreateDate(new Date());
                configuration.setUpdateBy(currentUser.getId());
                configuration.setUpdateDate(new Date());
                configuration.setDescription(sysDict.getDescription());
                
                configurationService.insertSelective(configuration);

                configList.add(configuration);
            }
        }

        model.addAttribute("Configurations", configList);
        return "modules/sys/configuration/list";
    }

    @RequiresPermissions("wd:configuration:edit")
    @RequestMapping(value = { "/enable" })
    @ResponseBody
    public JsonResult enable(String id, String enable) {
        SysConfiguration configuration = configurationService.selectByPrimaryKey(id);
        if (null == configuration) {
            return new JsonResult(false, "找不到对应的配置项");
        }

        configuration.setValue(enable);
        configuration.setUpdateBy(UserUtils.getUser().getId());
        configuration.setUpdateDate(new Date());
        configurationService.updateByPrimaryKeySelective(configuration);

        return new JsonResult(configurationService);
    }
}
