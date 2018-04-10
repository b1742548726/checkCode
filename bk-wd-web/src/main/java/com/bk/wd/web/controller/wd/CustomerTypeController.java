package com.bk.wd.web.controller.wd;

import java.util.Date;
import java.util.List;

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
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdBusinessElement;
import com.bk.wd.model.WdCustomerType;
import com.bk.wd.model.WdCustomerTypeSetting;
import com.bk.wd.model.WdCustomerTypeSettingExample;
import com.bk.wd.service.WdBusinessElementService;
import com.bk.wd.service.WdCustomerTypeService;
import com.bk.wd.service.WdCustomerTypeSettingService;
import com.bk.wd.service.WdSelectGroupService;
import com.bk.wd.util.BusinessConsts.TrueOrFalseAsInt;
import com.bk.wd.util.BusinessConsts.TrueOrFalseAsString;
import com.bk.wd.web.base.BaseController;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

/**
 * 客戶類型
 * @Project Name:bk-wd-web
 * @Date:2017年3月15日下午4:31:34
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/customerType")
public class CustomerTypeController extends BaseController {

    @Autowired
    private WdCustomerTypeService wdCustomerTypeService;

    @Autowired
    private WdCustomerTypeSettingService wdCustomerTypeSettingService;

    @Autowired
    private WdBusinessElementService wdBusinessElementService;

    @Autowired
    private WdSelectGroupService wdSelectGroupService;

    @ModelAttribute
    public WdCustomerType get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return wdCustomerTypeService.selectByPrimaryKey(id);
        } else {
            return new WdCustomerType();
        }
    }

    @RequiresPermissions("wd:customerType:view")
    @RequestMapping(value = { "list", "" })
    public String list(Model model, Pagination pagination, WdCustomerType wdCustomerType) {
        if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
            wdCustomerType.setRegion(UserUtils.getUser().getCompanyId());
        }
        wdCustomerTypeService.findByPage(pagination, wdCustomerType);
        model.addAttribute("pagination", pagination);
        return "modules/wd/customerType/customerTypeList";
    }

    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = "form")
    public String form(String id, Model model) {
        model.addAttribute("wdCustomerType", wdCustomerTypeService.selectByPrimaryKey(id));
        return "modules/wd/customerType/customerTypeForm";
    }

    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = "save")
    @ResponseBody
    public JsonResult save(WdCustomerType wdCustomerType, Model model) {
        if (null == wdCustomerType) {
            return new JsonResult(false, "未能接收表单数据");
        }

        if (StringUtils.isBlank(wdCustomerType.getNewable())) {
            wdCustomerType.setNewable(TrueOrFalseAsString.False);
        }

        if (StringUtils.isEmpty(wdCustomerType.getId())) {
            wdCustomerType.setId(IdGen.uuid());
            wdCustomerType.setCreateBy(UserUtils.getUser().getId());
            wdCustomerType.setCreateDate(new Date());
            wdCustomerType.setRegion(UserUtils.getUser().getCompanyId());
            wdCustomerType.setUpdateBy(UserUtils.getUser().getId());
            wdCustomerType.setUpdateDate(new Date());
            wdCustomerTypeService.insertSelective(wdCustomerType);
        } else {
            wdCustomerType.setUpdateBy(UserUtils.getUser().getId());
            wdCustomerType.setUpdateDate(new Date());
            wdCustomerTypeService.updateByPrimaryKeySelective(wdCustomerType);
        }
        return new JsonResult();
    }

    @RequiresPermissions("wd:customerType:del")
    @RequestMapping(value = "delete")
    @ResponseBody
    public JsonResult delete(WdCustomerType wdCustomerType) {
        wdCustomerType.setUpdateBy(UserUtils.getUser().getId());
        wdCustomerType.setUpdateDate(new Date());
        wdCustomerType.setDelFlag(true);
        wdCustomerTypeService.updateByPrimaryKeySelective(wdCustomerType);
        return new JsonResult();
    }

    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = { "sorts" })
    @ResponseBody
    public JsonResult sorts(String ids) {
        if (StringUtils.isNoneEmpty(ids)) {
            String[] idArray = ids.split(",");
            for (int i = 0; i < idArray.length; i++) {
                if (StringUtils.isNoneEmpty(idArray[i])) {
                    WdCustomerType wdCustomerType = wdCustomerTypeService.selectByPrimaryKey(idArray[i]);
                    wdCustomerType.setSort(i);
                    wdCustomerType.setUpdateBy(UserUtils.getUser().getId());
                    wdCustomerType.setUpdateDate(new Date());
                    wdCustomerTypeService.updateByPrimaryKeySelective(wdCustomerType);
                }
            }
        }
        return new JsonResult();
    }

    /**
     * 客户类型配置列表 date: 2017年3月17日 下午4:11:58 <br/>
     * @author Liam
     * @param model
     * @param category
     * @param wdCustomerType
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = { "settingForm" })
    public String settingForm(Model model, WdCustomerType wdCustomerType) {
        String newVersion = "temp" + new Date().getTime();
        List<WdCustomerTypeSetting> customerTypeSettingList = wdCustomerTypeSettingService.selectByCustomerTypeIdAndCategory(wdCustomerType.getId(), null, wdCustomerType.getSettingVersion());
        if (!customerTypeSettingList.isEmpty()) {
            for (WdCustomerTypeSetting wdCustomerTypeSetting : customerTypeSettingList) {
                wdCustomerTypeSetting.setId(IdGen.uuid());
                wdCustomerTypeSetting.setCreateBy(UserUtils.getUser().getId());
                wdCustomerTypeSetting.setCreateDate(new Date());
                wdCustomerTypeSetting.setUpdateBy(UserUtils.getUser().getId());
                wdCustomerTypeSetting.setUpdateDate(new Date());
                wdCustomerTypeSetting.setVersion(newVersion);
                wdCustomerTypeSettingService.insertSelective(wdCustomerTypeSetting);
            }
        }

        model.addAttribute("customerTypeSettingList", customerTypeSettingList);
        model.addAttribute("wdCustomerType", wdCustomerType);
        model.addAttribute("newVersion", newVersion);
        model.addAttribute("customerTypeLeftModules", wdBusinessElementService.selectCustomerTypeLeftModule(wdCustomerType.getId(), null));
        return "modules/wd/customerType/customerTypeSettingForm";
    }

    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = { "settingList" })
    public String settingList(Model model, WdCustomerType wdCustomerType, String category) {
        model.addAttribute("customerTypeSettingList", wdCustomerTypeSettingService.selectByCustomerTypeIdAndCategory(wdCustomerType.getId(), category, wdCustomerType.getSettingVersion()));
        return "modules/wd/customerType/customerTypeSettingList";
    }

    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = { "settingSave" })
    @ResponseBody
    public JsonResult settingSave(WdCustomerTypeSetting customerTypeSetting) {
        if (StringUtils.isEmpty(customerTypeSetting.getId())) {
            WdBusinessElement wdBusinessElement = wdBusinessElementService.selectByPrimaryKey(customerTypeSetting.getBusinessElementId());
            customerTypeSetting.setElementHeight(wdBusinessElement.getHeight());
            customerTypeSetting.setElementName(wdBusinessElement.getName());
            customerTypeSetting.setElementPlaceholder(wdBusinessElement.getPlaceholder());
            customerTypeSetting.setElementErrorMessage(wdBusinessElement.getErrorMessage());
            if (StringUtils.isNoneEmpty(wdBusinessElement.getSelectGroupId())) {
                customerTypeSetting.setElementSelectListId(wdSelectGroupService.getSelectGroupDefault(wdBusinessElement.getSelectGroupId()));
            }
            customerTypeSetting.setId(IdGen.uuid());
            customerTypeSetting.setCreateBy(UserUtils.getUser().getId());
            customerTypeSetting.setCreateDate(new Date());
            customerTypeSetting.setUpdateBy(UserUtils.getUser().getId());
            customerTypeSetting.setUpdateDate(new Date());
            customerTypeSetting.setSortMobile(99); // 默认在最后
            wdCustomerTypeSettingService.insertSelective(customerTypeSetting);
        } else {
            customerTypeSetting.setUpdateBy(UserUtils.getUser().getId());
            customerTypeSetting.setUpdateDate(new Date());
            wdCustomerTypeSettingService.updateByPrimaryKeySelective(customerTypeSetting);
        }
        return new JsonResult();
    }

    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = { "settingDelete" })
    @ResponseBody
    public JsonResult settingDelete(WdCustomerTypeSetting customerTypeSetting) {
        if (StringUtils.isEmpty(customerTypeSetting.getId())) {
            WdCustomerTypeSettingExample wdCustomerTypeSettingExample = new WdCustomerTypeSettingExample();
            wdCustomerTypeSettingExample.createCriteria().andBusinessElementIdEqualTo(customerTypeSetting.getBusinessElementId()).andVersionEqualTo(customerTypeSetting.getVersion())
                    .andDefaultSimpleModuleIdEqualTo(customerTypeSetting.getDefaultSimpleModuleId()).andCustomerTypeIdEqualTo(customerTypeSetting.getCustomerTypeId());
            wdCustomerTypeSettingService.deleteByExample(wdCustomerTypeSettingExample);
        } else {
            wdCustomerTypeSettingService.deleteByPrimaryKey(customerTypeSetting.getId());
        }
        return new JsonResult();
    }

    /**
     * 修改客户类型配置列表 date: 2017年3月17日 下午5:34:38 <br/>
     * @author Liam
     * @param category
     * @param customerTypeId
     * @param data
     * @return
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = { "settingIssue" })
    @ResponseBody
    public JsonResult settingIssue(String customerTypeId, String version, String portraitCol, String titleCol, String subtitleCol) {
        WdCustomerType wdCustomerType = wdCustomerTypeService.selectByPrimaryKey(customerTypeId);
        wdCustomerType.setPortraitCol(portraitCol);
        wdCustomerType.setTitleCol(titleCol);
        wdCustomerType.setSubtitleCol(subtitleCol);
        wdCustomerType.setSettingVersion(version);
        wdCustomerType.setUpdateBy(UserUtils.getUser().getId());
        wdCustomerType.setUpdateDate(new Date());
        wdCustomerTypeService.updateByPrimaryKeySelective(wdCustomerType);
        return new JsonResult();
    }

    @RequiresPermissions("wd:customerType:edit")
    @RequestMapping(value = { "settingSorts" })
    @ResponseBody
    public JsonResult settingSorts(String ids) {
        if (StringUtils.isNoneEmpty(ids)) {
            String[] idArray = ids.split(",");
            for (int i = 0; i < idArray.length; i++) {
                if (StringUtils.isNoneEmpty(idArray[i])) {
                    WdCustomerTypeSetting wdCustomerTypeSetting = wdCustomerTypeSettingService.selectByPrimaryKey(idArray[i]);
                    wdCustomerTypeSetting.setSortMobile(i);
                    wdCustomerTypeSetting.setUpdateBy(UserUtils.getUser().getId());
                    wdCustomerTypeSetting.setUpdateDate(new Date());
                    wdCustomerTypeSettingService.updateByPrimaryKeySelective(wdCustomerTypeSetting);
                }
            }
        }
        return new JsonResult();
    }
}