package com.bk.wd.web.controller.wd;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bk.common.entity.GeneralException;
import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sm.model.SmModel;
import com.bk.sm.service.SmModelService;
import com.bk.sys.model.SysOffice;
import com.bk.sys.security.utils.IdGen;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.*;
import com.bk.wd.service.*;
import com.bk.wd.util.process.TemplateAnalysis;
import com.bk.wd.web.base.BaseController;

/**
 * 产品管理
 * @Project Name:bk-wd-web
 * @Date:2017年3月15日下午9:24:06
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/product")
public class ProductController extends BaseController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(ProductController.class);

	public static final String product_simple_module_survey = "survey";
	public static final String product_simple_module_audit = "audit";
	public static final String product_simple_module_loan = "loan";

	public final static String module_photo_id = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";

	@Autowired
	private WdProductService wdProductService;

	@Autowired
	private WdProductProcessService wdProductProcessService;

	@Autowired
	private WdProductSimpleModuleSettingService wdProductSimpleModuleSettingService;

	@Autowired
	private WdProductSimpleModuleService wdProductSimpleModuleService;

	@Autowired
	private WdBusinessElementService wdBusinessElementService;

	@Autowired
	private WdProductComplexModuleService wdProductComplexModuleService;

	@Autowired
	private WdDefaultSimpleModuleSettingService wdDefaultSimpleModuleSettingService;

	@Autowired
	private TemplateAnalysis templateAnalysis;
	
	@Autowired
	private WdProductSmModelService wdProductSmModelService;
	
	@Autowired
	private SmModelService smModelService;
	
	@Autowired
	private WdProductCreditInvestigationService wdProductCreditInvestigationService;

	@ModelAttribute
	public WdProduct get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return wdProductService.selectByPrimaryKey(id);
		} else {
			return new WdProduct();
		}
	}

	@RequiresPermissions("wd:product:view")
	@RequestMapping(value = { "list", "" })
	public String list(Model model, Pagination pagination, WdProduct wdProduct) {
	    pagination.setBegin(0);
	    if (!SysOffice.HeadCompany.equals(UserUtils.getUser().getCompanyId())) {
	        wdProduct.setRegion(UserUtils.getUser().getCompanyId());
        }
		wdProductService.findByPage(pagination, wdProduct);
		model.addAttribute("pagination", pagination);
		return "modules/wd/product/productList";
	}

	@RequiresPermissions("wd:product:edit")
	@RequestMapping(value = "form")
	public String form(WdProduct wdProduct, Model model) {
		model.addAttribute("newVersion", "temp" + new Date().getTime());
		model.addAttribute("wdProduct", wdProduct);
		return "modules/wd/product/productForm";
	}

	@RequiresPermissions("wd:product:edit")
	@RequestMapping(value = "form_info")
	public String form_info(String productId, Model model) {
		model.addAttribute("wdProduct", wdProductService.selectByPrimaryKey(productId));
		return "modules/wd/product/productInfoForm";
	}

	@RequiresPermissions("wd:product:edit")
	@RequestMapping(value = "form_process")
	public String form_process(String productId, Model model) {
	    WdProduct wdProduct = wdProductService.selectByPrimaryKey(productId);
        String version = wdProduct != null ? wdProduct.getProductVersion() : "";
        WdProductProcess wdProductProcess = wdProductProcessService.selectByProductIdAndVersion(productId, version);
        if (null != wdProductProcess) {
            model.addAttribute("processXml", templateAnalysis.getProcessXml(wdProductProcess.getProcessTemplate()));
        }
        model.addAttribute("productId", productId);
		return "modules/wd/product/productProcessForm";
	}
	
	@RequiresPermissions("wd:product:edit")
	@RequestMapping(value = "form_survey")
	public String form_survey(String productId, Model model) {
	    WdProduct wdProduct = wdProductService.selectByPrimaryKey(productId);
	    String version = wdProduct != null ? wdProduct.getProductVersion() : "";
		model.addAttribute("simpleModuleList",
				wdProductSimpleModuleService.selectByProductVersion(productId, version, product_simple_module_survey));
		model.addAttribute("complexModuleList",
				wdProductComplexModuleService.selectByProductVersion(productId, version, product_simple_module_survey));
		model.addAttribute("wdProductCreditInvestigation",
		        wdProductCreditInvestigationService.selectByProductId(productId, version));
		model.addAttribute("productId", productId);
		return "modules/wd/product/productSurveyForm";
	}

	@RequiresPermissions("wd:product:edit")
	@RequestMapping(value = "form_alternative")
	public String form_alternative(String productId, String moduleId, Model model) {
	    WdProduct wdProduct = wdProductService.selectByPrimaryKey(productId);
        String version = wdProduct != null ? wdProduct.getProductVersion() : "";
		Map<String, Object> params = new HashMap<>();
		params.put("moduleId", moduleId);
        params.put("version", version);
        params.put("productId", productId);
		model.addAttribute("elementList", wdBusinessElementService.selectProductLeftModule(params));
		model.addAttribute("productId", productId);
		return "modules/wd/product/productSurveyAlternative";
	}

	@RequiresPermissions("wd:product:edit") 
	@RequestMapping(value = "form_setting")
	public String form_setting(String productId, String moduleId, Model model) {
	    WdProduct wdProduct = wdProductService.selectByPrimaryKey(productId);
        String version = wdProduct != null ? wdProduct.getProductVersion() : "";
        Map<String, Object> params = new HashMap<>();
        params.put("moduleId", moduleId);
        params.put("version", version);
        params.put("productId", productId);
		model.addAttribute("elementList", wdBusinessElementService.selectProductLeftModule(params));
		model.addAttribute("productId", productId);
		if (module_photo_id.equals(moduleId)) {
			return "modules/wd/product/productSurveySettingPhoto";
		}
		return "modules/wd/product/productSurveySetting";
	}
	
	@RequiresPermissions("wd:product:edit")
    @RequestMapping(value = "form_audit")
    public String form_audit(String productId, Model model) {
	    WdProduct wdProduct = wdProductService.selectByPrimaryKey(productId);
        String version = wdProduct != null ? wdProduct.getProductVersion() : "";
        model.addAttribute("simpleModuleList",
                wdProductSimpleModuleService.selectByProductVersion(productId, version, product_simple_module_audit));
        model.addAttribute("productId", productId);
        return "modules/wd/product/productAuditForm";
    }
	
	
	@RequiresPermissions("wd:product:edit")
	@RequestMapping(value = "save_product")
    @ResponseBody
	public JsonResult save_product(WdProduct wdProduct, String newVersion, String productId, Model model,
	        String surveySimpleModules, String surveyComplexModules, String auditSimpleModules, String productProcessXml, String wdProductCreditInvestigation) {
	    // 默认设置为当前公司
        if (StringUtils.isBlank(wdProduct.getRegion())) {
            wdProduct.setRegion(UserUtils.getUser().getCompanyId());
        }
        
        WdProductProcess wdProductProcess = new WdProductProcess();
        try {
            if (StringUtils.isNotEmpty(productProcessXml)) {
                productProcessXml = StringEscapeUtils.unescapeHtml4(StringEscapeUtils.unescapeXml(productProcessXml)).replaceAll(" ", " ");
            }
            String remplateId = templateAnalysis.readProcessTemplate( productProcessXml, UserUtils.getUser().getId());
            wdProductProcess.setId(UidUtil.uuid());
            wdProductProcess.setProcessTemplate(remplateId);
            wdProductProcess.setVersion(newVersion);
            wdProductProcess.setCreateBy(UserUtils.getUser().getId());
            wdProductProcess.setCreateDate(new Date());
            wdProductProcess.setUpdateBy(UserUtils.getUser().getId());
            wdProductProcess.setUpdateDate(new Date());
        } catch (GeneralException e) {
            LOGGER.error(e.getMessage(), e);
            return new JsonResult(e.getMessage());
        }
        
        // 设置为最新版本号
        wdProduct.setProductVersion(newVersion);
        if (StringUtils.isEmpty(productId)) {
            productId = UidUtil.uuid();
            wdProduct.setId(productId);
            wdProduct.setCreateBy(UserUtils.getUser().getId());
            wdProduct.setCreateDate(new Date());
            wdProduct.setUpdateBy(UserUtils.getUser().getId());
            wdProduct.setUpdateDate(new Date());
            wdProductService.insertSelective(wdProduct);
        } else {
            wdProduct.setId(productId);
            wdProduct.setUpdateBy(UserUtils.getUser().getId());
            wdProduct.setUpdateDate(new Date());
            wdProductService.updateByPrimaryKeySelective(wdProduct);
        }
        
        if (StringUtils.isNotEmpty(auditSimpleModules)) { // 审批流程配置
            JSONArray jsonArray = JSON.parseArray(StringEscapeUtils.unescapeHtml4(auditSimpleModules));
            for (Object object : jsonArray) {
                JSONObject json = (JSONObject) object;
                WdProductSimpleModule wdProductSimpleModule = new WdProductSimpleModule();
                wdProductSimpleModule.setId(UidUtil.uuid());
                wdProductSimpleModule.setVersion(newVersion);
                wdProductSimpleModule.setProductId(productId);
                wdProductSimpleModule.setCreateBy(UserUtils.getUser().getId());
                wdProductSimpleModule.setCreateDate(new Date());
                wdProductSimpleModule.setUpdateBy(UserUtils.getUser().getId());
                wdProductSimpleModule.setUpdateDate(new Date());
                wdProductSimpleModule.setBelongTo(product_simple_module_audit);
                wdProductSimpleModule.setDefaultSimpleModuleId(json.getString("default_simple_module_id"));
                wdProductSimpleModule.setModuleName(json.getString("module_name"));
                wdProductSimpleModuleService.insertSelective(wdProductSimpleModule);

                JSONArray moduleSettingArray = json.getJSONArray("product_simple_module_setting");
                for (int i = 0; i < moduleSettingArray.size(); i++) {
                    JSONObject json2 = (JSONObject) moduleSettingArray.get(i);
                    WdProductSimpleModuleSetting wdProductSimpleModuleSetting = new WdProductSimpleModuleSetting();
                    wdProductSimpleModuleSetting.setId(IdGen.uuid());
                    wdProductSimpleModuleSetting.setProductSimpleModuleId(wdProductSimpleModule.getId());
                    wdProductSimpleModuleSetting.setSortMobile(i);
                    String required = (json2.getBoolean("required") != null && json2.getBoolean("required")) ? "1"
                            : "0";
                    wdProductSimpleModuleSetting.setRequired(required);
                    WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting = wdDefaultSimpleModuleSettingService
                            .selectByPrimaryKey(json2.getString("default_simple_module_setting_id"));
                    wdProductSimpleModuleSetting.setDefaultSimpleModuleSettingId(wdDefaultSimpleModuleSetting.getId());
                    wdProductSimpleModuleSetting
                            .setBusinessElementId(wdDefaultSimpleModuleSetting.getBusinessElementId());
                    WdBusinessElement wdBusinessElement = wdBusinessElementService
                            .selectByPrimaryKey(wdDefaultSimpleModuleSetting.getBusinessElementId());
                    wdProductSimpleModuleSetting.setElementName(wdBusinessElement.getName());
                    wdProductSimpleModuleSetting.setElementSelectListId(json2.getString("element_select_list_id"));
                    wdProductSimpleModuleSetting.setCreateBy(UserUtils.getUser().getId());
                    wdProductSimpleModuleSetting.setCreateDate(new Date());
                    wdProductSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
                    wdProductSimpleModuleSetting.setUpdateDate(new Date());
                    wdProductSimpleModuleSettingService.insertSelective(wdProductSimpleModuleSetting);
                }
            }
        }
        
        if (StringUtils.isNotEmpty(surveySimpleModules)) { // 简单组件
            JSONArray jsonArray = JSON.parseArray(StringEscapeUtils.unescapeHtml4(surveySimpleModules));
            for (Object object : jsonArray) {
                JSONObject json = (JSONObject) object;
                WdProductSimpleModule wdProductSimpleModule = new WdProductSimpleModule();
                wdProductSimpleModule.setId(IdGen.uuid());
                wdProductSimpleModule.setVersion(newVersion);
                wdProductSimpleModule.setProductId(productId);
                wdProductSimpleModule.setCreateBy(UserUtils.getUser().getId());
                wdProductSimpleModule.setCreateDate(new Date());
                wdProductSimpleModule.setUpdateBy(UserUtils.getUser().getId());
                wdProductSimpleModule.setUpdateDate(new Date());
                wdProductSimpleModule.setBelongTo(product_simple_module_survey);
                wdProductSimpleModule.setDefaultSimpleModuleId(json.getString("default_simple_module_id"));
                wdProductSimpleModule.setModuleName(json.getString("module_name"));
                wdProductSimpleModuleService.insertSelective(wdProductSimpleModule);

                JSONArray moduleSettingArray = json.getJSONArray("product_simple_module_setting");
                for (int i = 0; i < moduleSettingArray.size(); i++) {
                    JSONObject json2 = (JSONObject) moduleSettingArray.get(i);
                    WdProductSimpleModuleSetting wdProductSimpleModuleSetting = new WdProductSimpleModuleSetting();
                    wdProductSimpleModuleSetting.setId(IdGen.uuid());
                    wdProductSimpleModuleSetting.setProductSimpleModuleId(wdProductSimpleModule.getId());
                    wdProductSimpleModuleSetting.setSortMobile(i);
                    String required = (json2.getBoolean("required") != null && json2.getBoolean("required")) ? "1" : "0";
                    wdProductSimpleModuleSetting.setRequired(required);
                    WdDefaultSimpleModuleSetting wdDefaultSimpleModuleSetting = wdDefaultSimpleModuleSettingService .selectByPrimaryKey(json2.getString("default_simple_module_setting_id"));
                    wdProductSimpleModuleSetting.setDefaultSimpleModuleSettingId(wdDefaultSimpleModuleSetting.getId());
                    wdProductSimpleModuleSetting .setBusinessElementId(wdDefaultSimpleModuleSetting.getBusinessElementId());
                    WdBusinessElement wdBusinessElement = wdBusinessElementService.selectByPrimaryKey(wdDefaultSimpleModuleSetting.getBusinessElementId());
                    wdProductSimpleModuleSetting.setElementName(wdBusinessElement.getName());
                    wdProductSimpleModuleSetting.setElementSelectListId(json2.getString("element_select_list_id"));
                    wdProductSimpleModuleSetting.setCreateBy(UserUtils.getUser().getId());
                    wdProductSimpleModuleSetting.setCreateDate(new Date());
                    wdProductSimpleModuleSetting.setUpdateBy(UserUtils.getUser().getId());
                    wdProductSimpleModuleSetting.setUpdateDate(new Date());
                    String album = (json2.getBoolean("album") != null && json2.getBoolean("album")) ? "1" : "0";
                    wdProductSimpleModuleSetting.setAlbum(album);
                    if (null != json2.get("max_length")) {
                        wdProductSimpleModuleSetting
                                .setMaxLength(Integer.valueOf(json2.getString("max_length").trim()));
                    }
                    wdProductSimpleModuleSettingService.insertSelective(wdProductSimpleModuleSetting);
                }
            }
        }

        if (StringUtils.isNotEmpty(surveyComplexModules)) { // 复杂组件
            JSONArray jsonArray = JSON.parseArray(StringEscapeUtils.unescapeHtml4(surveyComplexModules));
            for (Object object : jsonArray) {
                JSONObject json = (JSONObject) object;
                WdProductComplexModule wdProductComplexModule = new WdProductComplexModule();
                wdProductComplexModule.setId(IdGen.uuid());
                wdProductComplexModule.setProductId(productId);
                wdProductComplexModule.setVersion(newVersion);
                wdProductComplexModule.setCreateBy(UserUtils.getUser().getId());
                wdProductComplexModule.setCreateDate(new Date());
                wdProductComplexModule.setUpdateBy(UserUtils.getUser().getId());
                wdProductComplexModule.setUpdateDate(new Date());
                wdProductComplexModule.setBelongTo(product_simple_module_survey);
                wdProductComplexModule.setDefaultComplexModuleId(json.getString("default_complex_module_id"));
                wdProductComplexModule.setModuleName(json.getString("module_name"));
                wdProductComplexModuleService.insertSelective(wdProductComplexModule);
            }
        }
        
        if (StringUtils.isNotEmpty(wdProductCreditInvestigation)) {
            WdProductCreditInvestigation productCreditInvestigation = JSON.parseObject(StringEscapeUtils.unescapeHtml4(wdProductCreditInvestigation), WdProductCreditInvestigation.class);
            productCreditInvestigation.setId(IdGen.uuid());
            productCreditInvestigation.setProductId(productId);
            productCreditInvestigation.setVersion(newVersion);
            productCreditInvestigation.setCreateBy(UserUtils.getUser().getId());
            productCreditInvestigation.setCreateDate(new Date());
            productCreditInvestigation.setUpdateBy(UserUtils.getUser().getId());
            productCreditInvestigation.setUpdateDate(new Date());
            wdProductCreditInvestigationService.insertSelective(productCreditInvestigation);
        }
        wdProductProcess.setProductId(wdProduct.getId());
        wdProductProcessService.insertSelective(wdProductProcess);
	    return new JsonResult();
	}
	
	@RequiresPermissions("wd:product:del")
	@RequestMapping(value = "delete")
	@ResponseBody
	public JsonResult delete(WdProduct wdProduct) {
		wdProduct.setUpdateBy(UserUtils.getUser().getId());
		wdProduct.setUpdateDate(new Date());
		wdProduct.setDelFlag(true);
		wdProductService.updateByPrimaryKeySelective(wdProduct);
		return new JsonResult();
	}

	@RequiresPermissions("wd:product:edit")
	@RequestMapping(value = "disable")
	@ResponseBody
	public JsonResult disable(WdProduct wdProduct) {
		wdProduct.setUpdateBy(UserUtils.getUser().getId());
		wdProduct.setUpdateDate(new Date());
		wdProductService.updateByPrimaryKeySelective(wdProduct);
		return new JsonResult();
	}
	
	@RequestMapping(value = "smList")
	public String scoreModel(Pagination pagination) {
	    SmModel smModel = new SmModel();
	    smModel.setEnable("1"); //启用
	    smModelService.selectByPagination(pagination, smModel);
	    return "modules/wd/product/scoreModelConfig";
	}
	
	/**
	 * 使用评分模型
	 * date: 2017年11月13日 上午10:34:46 <br/> 
	 * @author Liam 
	 * @return 
	 * @since JDK 1.8
	 */
    @RequestMapping(value = "useSmModel")
    @ResponseBody
    public JsonResult useSmModel(String modelKey, String productIds) {
        if (StringUtils.isEmpty(modelKey)) {
            return new JsonResult("请选择评分模型");
        }
        wdProductSmModelService.deleteByModelKey(modelKey);
        
        if (StringUtils.isNotEmpty(productIds)) {
            String[] productIdArray = JSON.parseObject(StringEscapeUtils.unescapeHtml4(productIds), String[].class);
            for (String productId : productIdArray) {
                WdProductSmModel wdProductSmModel = new WdProductSmModel();
                wdProductSmModel.setId(UidUtil.uuid());
                wdProductSmModel.setModelKey(modelKey);
                wdProductSmModel.setProductId(productId);
                WdProduct wdProduct = wdProductService.selectByPrimaryKey(productId);
                wdProductSmModel.setProductName(wdProduct.getName());
                wdProductSmModel.setCreateBy(UserUtils.getUser().getId());
                wdProductSmModel.setCreateDate(new Date());
                wdProductSmModel.setUpdateBy(UserUtils.getUser().getId());
                wdProductSmModel.setUpdateDate(new Date());
                wdProductSmModelService.insertSelective(wdProductSmModel);
            }
        }
        return new JsonResult();
    }
}