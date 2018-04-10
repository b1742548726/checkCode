<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<div id="productsurveydive" class="col-xs-12" >
    <div class="col-md-3 col-sm-3 col-xs-12 wd-nonmargin wd-borderright" >
        <div class="block-title">所属类别</div>
        <ul class="to_do wd_select_list" id="survey-setting">
            <li href=".applyinfo" selected="selected" moduleid="AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA">
                <span>申请信息 </span>
                <div>
                    <input type="checkbox" class="flat" checked="checked" disabled="disabled" />
                </div>
            </li>
            <li href=".extendinfo" moduleid="44444444-4444-4444-4444-444444444444">
                <span>辅助信息 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
            <li href=".yearlyincome" moduleid="55555555-5555-5555-5555-555555555555">
                <span>年收入损益表 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
            <li href=".monthlyincome" moduleid="66666666-6666-6666-6666-666666666666">
                <span>月收入损益表 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
            <li href=".balancesheet" moduleid="77777777-7777-7777-7777-777777777777">
                <span>家庭资产负债表 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
            <li href=".creditcardinfo" moduleid="GGGGGGGG-GGGG-GGGG-GGGG-GGGGGGGGGGGG">
                <span>信用卡信息 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
            <li href=".recognizor" moduleid="99999999-9999-9999-9999-999999999999">
                <span>设置担保人 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
                
            <li href=".coborrower" moduleid="00000000-0000-0000-0000-222222222222">
                <span>设置共同借款人 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
                
            <li href=".buildingmortgage" moduleid="00000000-0000-0000-0000-111111111111">
                <span>设置房产抵押 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
            <li href=".surveyphoto" moduleid="FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF">
                <span>调查照片 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
            <li href=".surveyconclusion" moduleid="BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB">
                <span>调查结论 </span>
                <div>
                    <input type="checkbox" class="flat" checked="checked"  disabled="disabled" />
                </div>
            </li>
            <li href=".mortgagecar" moduleid="EEEEEEEE-EEEE-EEEE-EEEE-FFFFFFFFFFFF">
                <span> 车贷抵押 </span>
                <div>
                    <input type="checkbox" class="flat" />
                </div>
            </li>
            <li href=".creditinvestigation" moduleid="FFFFFFFF-1234-5678-FFFF-FFFFFFFFFFFF">
                <span> 个人征信结果 </span>
                <div>
                    <input type="checkbox" class="flat" checked="checked"  disabled="disabled"/>
                </div>
            </li>
        </ul>
    </div>

    <div id="div_alternative" class="col-md-3 col-sm-3 col-xs-12 wd-nonmargin">
        <div class="block-title">备选项</div>
        <ul class="to_do wd_select_list applyinfo" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list extendinfo" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list yearlyincome" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list monthlyincome" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list balancesheet" name="survey_alternative" style="display: none;"></ul>
        <ul class="to_do wd_select_list creditcardinfo" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list recognizor" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list coborrower" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list buildingmortgage" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list surveyphoto" name="survey_alternative" style="display: none;"></ul>
		<ul class="to_do wd_select_list surveyconclusion" name="survey_alternative" style="display: none;"></ul>
        <ul class="to_do wd_select_list mortgagecar" name="survey_alternative" style="display:none;"></ul>
        <ul class="to_do wd_select_list creditinvestigation" name="survey_alternative" style="display:none;"></ul>
    </div>

    <div id="div_setting" class="col-md-6 col-sm-6 col-xs-12 wd-nonmargin">
        <div class="block-title">配置结果</div>
        
        <div class="applyinfo" name="survey_setting" style="display: none;" moduleid="AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA" checked="checked"></div>
		<div class="extendinfo" name="survey_setting" style="display: none;" moduleid="44444444-4444-4444-4444-444444444444"></div>
		<div class="yearlyincome" name="survey_setting" style="display: none;" moduleid="55555555-5555-5555-5555-555555555555"></div>
		<div class="monthlyincome" name="survey_setting" style="display: none;" moduleid="66666666-6666-6666-6666-666666666666"></div>
		<div class="balancesheet" name="survey_setting" style="display: none;" moduleid="77777777-7777-7777-7777-777777777777"></div>
        <div class="creditcardinfo" name="survey_setting" style="display: none;" moduleid="GGGGGGGG-GGGG-GGGG-GGGG-GGGGGGGGGGGG"></div>
		<div class="recognizor" name="survey_setting" style="display: none;" moduleid="99999999-9999-9999-9999-999999999999"></div>
		<div class="coborrower" name="survey_setting" style="display: none;" moduleid="00000000-0000-0000-0000-222222222222"></div>
		<div class="buildingmortgage" name="survey_setting" style="display: none;" moduleid="00000000-0000-0000-0000-111111111111"></div>
		<div class="surveyphoto" name="survey_setting" style="display: none;" moduleid="FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"></div>
		<div class="surveyconclusion" name="survey_setting" style="display: none;" moduleid="BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB" checked="checked"></div>
        <div class="mortgagecar" name="survey_setting" style="display:none;" moduleid="EEEEEEEE-EEEE-EEEE-EEEE-FFFFFFFFFFFF"></div>
        <div class="creditinvestigation" name="survey_setting" style="display:none;" moduleid="FFFFFFFF-1234-5678-FFFF-FFFFFFFFFFFF" checked="checked"></div>
    </div>

</div>


<div id="productsurveycomplexdiv" class="col-xs-12">

    <div class="col-md-6 col-sm-12"  style="width:100%;">
        <div class="col-md-12" style="width:100%;display: flex;">
			
			<div class="x-title2" >
                <span class="x-alt"> 征信管理模块 </span>
                <ul class="nav" >
                    <li>
                        <input type="checkbox" class="js-switch" id="investigation" />
                    </li>
                </ul>
                <div class="x-content">客户经理可以发起征信，征信人员可以通过提交、驳回、终止征信查询结果</div>
                <div class="clearfix"></div>
            </div>
            
            <div class="x-title2" >
                <span class="x-alt">经营类调查模板 </span>
                <ul class="nav" >
                    <li>
                        <input type="checkbox" class="js-switch" id="business_complex_module" />
                    </li>
                </ul>
                <div class="x-content">如果设置的是经营类产品，需要打开此选项，客户经理将可以在PC端录入软信息不对称偏差，资产负债表，权益检查，经营信息等经营相关信息及经营类Excel文档</div>
                <div class="clearfix"></div>
            </div>
            
             <div class="x-title2" >
                <span class="x-alt"> 抵押房产同时设置担保人 </span>
                <ul class="nav">
                    <li>
                        <input type="checkbox" class="js-switch" id="building_mortgage" />
                    </li>
                </ul>
                <div class="x-content">抵押房产时，同时会将抵押的房产产权人设置成担保人</div>
                <div class="clearfix"></div>
            </div>
		
        </div>
        
         <style>
            .zx_upload > span {
                min-width:90px;
                line-height: 25px;
                border: 1px solid #ddd;
                border-top-left-radius:5px;
                border-bottom-left-radius:5px;
                text-align: center;
                cursor:pointer;
                padding:0 5px;
                display: inline-block;
            }
            
            .zx_upload > span:nth-of-type(2) {
                border-left:none;
                border-top-left-radius:0;
                border-bottom-left-radius:0;
                border-top-right-radius:5px;
                border-bottom-right-radius:5px;
            }
            
            .zx_upload>span.checked {
                background: #97A6CE;
                color: #ffffff;
            }
            
            #dw_surveyTemplate {
                min-width:180px;
                line-height: 25px;
                border: 1px solid #ddd;
                border-radius:5px;
                text-align: center;
                cursor:pointer;
                padding:0 5px;
                display: inline-block;
            }
        </style>
        <!--jyshen-->
        <div class="col-md-12" style="width:100%;display: flex;">
            
            <div class="x-title2" name="creditinvestigationOption" >
                <span> 征信报告 </span>
                <ul class="nav">
                    <li class="zx_upload">
                        <span>客户经理上传</span><span class="checked">征信员上传</span>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            
           <!--  <div class="x-title2">
                <span id="dw_surveyTemplate">点击下载经营类调查模板 </span>
                <div class="clearfix"></div>
            </div> -->
        </div>
         <div class="col-md-12" style="width:100%;display: flex;" >
            <div class="x-title2" name="creditinvestigationOption">
                <span> 征信结果 </span>
                <ul class="nav">
                    <li class="zx_upload">
                        <span class="checked">客户经理填写</span><span>征信员填写</span>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
        </div>
        <!--end jyshen-->
        
    </div>

</div>

<script type="text/javascript">

    function GetSurveyData() {

        var simpleModules = new Array();
        $("div[name=survey_setting][checked=checked][moduleid]").each(function () {
            var items = new Array();

            var moduleId = $(this).attr("moduleid");
        	console.log(moduleId)
            if (moduleId != "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF") {
                $(this).find("tbody tr").each(function () {
                    var item = {
                        "default_simple_module_setting_id": $(this).attr("elementid"),
                        "required": $(this).find("input[type=checkbox]").is(":checked"),
                        "element_select_list_id": $(this).find("select:first").val(),
                        "sort": $(this).attr("itemsort"),
                    }

                    items.push(item);
                });
            } else {
                $(this).find("tbody tr").each(function () {
                    var item = {
                        "default_simple_module_setting_id": $(this).attr("elementid"),
                        "required": $(this).find("input[type=checkbox]:nth-of-type(1)").eq(0).is(":checked"),		//相册新加必填项
                        "album": $(this).find("input[type=checkbox]:nth-of-type(1)").eq(1).is(":checked"),
                        "max_length": $(this).find("input[type=text]:first").val(),
                        "sort": $(this).attr("itemsort"),
                    }

                    items.push(item);
                });
            }

            var module = {
                "default_simple_module_id": $(this).attr("moduleid"),
                "product_simple_module_setting": items
            };

            simpleModules.push(module);
        });

        var complexModules = new Array();
        
        if ($("#business_complex_module").is(":checked")) {
            var complexModule = {
                "default_complex_module_id": "11111111-1111-1111-1111-111111111111",
                "module_name": "经营类调查模板"
            };
            complexModules.push(complexModule);
        }
        
        //加入房产抵押
        if ($("#building_mortgage").is(":checked")) {
            var complexModule = {
                "default_complex_module_id": "00000000-0000-0000-0000-111111111111",
                "module_name": "抵押房产同时设置担保人"
            };
            complexModules.push(complexModule);
        }

        var info = {
            "simpleModules": JSON.stringify(simpleModules),
            "complexModules": JSON.stringify(complexModules)
        };
        
        var wdProductCreditInvestigation = {};
        //加入征信
        if ($("#investigation").is(":checked")) {
        	
        	var report_submitter = "", result_submitter = "";
            var $span = $("[name=creditinvestigationOption]").eq(0).find(".zx_upload > span.checked");
    		
    		if ($span.text().indexOf("客户经理") !== -1) {
    			report_submitter = "客户经理";
    		} else {
    			report_submitter = "征信员";
    		}
    		
    		$span = $("[name=creditinvestigationOption]").eq(1).find(".zx_upload > span.checked");
    		
    		if ($span.text().indexOf("客户经理") !== -1) {
    			result_submitter = "客户经理";
    		} else {
    			result_submitter = "征信员";
    		}
    		wdProductCreditInvestigation.reportSubmitter = report_submitter;
        	wdProductCreditInvestigation.resultSubmitter = result_submitter;
            info.wdProductCreditInvestigation = JSON.stringify(wdProductCreditInvestigation);
        }
        
        return info;
    }

    function InitSurveySettingPage(callback) { //调查模块配置初始化
    	var count = $("#div_alternative ul").size()*2, nn = 0;
    	var r1, r2;
    	StartLoad();
        $("#survey-setting li").each(function (index, item) {
            var moduleClass = $(this).attr("href");

            var alternative = $(moduleClass + "[name=survey_alternative]");
            var setting = $(moduleClass + "[name=survey_setting]");

            var moduleId = setting.attr("moduleid");
            var productVersion = $("#product-version").val();
            r1 = $.ajax({
                url:  "${ctx}/wd/product/form_alternative?moduleId=" + moduleId + "&productId=${productId}&version=" + newVersion,
                type: "GET",
                async: true,
                cache: false,
                success: function (result) {
                    alternative.html(result);
                    nn++;
                    if (nn === count) {
                    	setTimeout(callback, 0);
                    }
                }
            });

            r2 = $.ajax({
                url: "${ctx}/wd/product/form_setting?moduleId=" + moduleId + "&productId=${productId}&version=" + newVersion,
                type: "GET",
                async: true,
                cache: false,
                success: function (result) {
                    setting.html(result);
                    nn++;
                    
                    if (nn === count) {
                    	setTimeout(callback, 0);
                    }
                }
            });
        });
      	//如果R1和R2存在，就用PROMISE，等待2个全部结束调用CALLBACK
        //这里的R1和R2指循环最后一轮的变量
        if (r1 && r2) {
            $.when(r1, r2).done(function() {
            	FinishLoad();
            	setTimeout(callback, 0);
            });
        }

    }

    // 切换模块
    function SurveyModuleSwitch() {

        var currentModuleLi = $("ul#survey-setting li[selected]");
        if (currentModuleLi.length == 0)
            return;
            
        var currentModuleClass = currentModuleLi.attr("href");
        
        $("[name=survey_alternative]").hide();
        $("[name=survey_setting]").hide();

        $(currentModuleClass).show();
    }

    $(function () {
    	$(document).on("click", ".zx_upload > span",  function() {
    		$(this).parent().find("span").removeClass("checked");
    		$(this).addClass("checked");
    		
    		var $txt = $("[name=creditinvestigationOption]").eq(0).find(".zx_upload > span.checked").text();
    		var $objs = $("[name=creditinvestigationOption]").eq(1).find(".zx_upload > span");
    		
    		if ($txt.indexOf("客户经理") !== -1) {
    			$objs.removeClass("checked");
    			$objs.eq(0).addClass("checked");
    		}
    		
    	});
    	
    	$("[name=creditinvestigationOption]").hide();
    	
    	$(document).on("click", "#investigation+.switchery",  function() {
    		if ($(this).prev().is(":checked")) {
    			$("[name=creditinvestigationOption]").show();
    		} else {
    			$("[name=creditinvestigationOption]").hide();
    		}
    	});
    	
    	var simpleModuleList = ${fns:toJsonString(simpleModuleList)};
		if (simpleModuleList && simpleModuleList.length > 0) {
    	    for (var i = 0; i < simpleModuleList.length; i++) {
    	        var simpleModule = simpleModuleList[i];
    	        $("#survey-setting li[moduleid="+ simpleModule.defaultSimpleModuleId +"]").find(":input[type=checkbox]").attr("checked", "checked");
    	        $("div[name=survey_setting][moduleid="+ simpleModule.defaultSimpleModuleId +"]").attr("checked", "checked");
    	    }
    	}
		
		var complexModuleList = ${fns:toJsonString(complexModuleList)};
		if (complexModuleList && complexModuleList.length > 0) {
    	    for (var i = 0; i < complexModuleList.length; i++) {
    	        var simpleModule = complexModuleList[i];
    	        if ("11111111-1111-1111-1111-111111111111" == simpleModule.defaultComplexModuleId) {
	        		$("#business_complex_module").trigger("click");
    	        }
    	        if ("00000000-0000-0000-0000-111111111111" == simpleModule.defaultComplexModuleId) {
    	        	$("#building_mortgage").trigger("click");
    	        }
    	    }
    	}
		
		var wdProductCreditInvestigation = ${fns:toJsonString(wdProductCreditInvestigation)};
		if (wdProductCreditInvestigation) {
			$("#investigation").trigger("click");
			$("[name=creditinvestigationOption]").show();
			
			var report_submitter = wdProductCreditInvestigation.reportSubmitter , result_submitter = wdProductCreditInvestigation.resultSubmitter;
			var $spans = $("[name=creditinvestigationOption]").eq(0).find(".zx_upload > span");
			
			$spans.removeClass("checked");
			$spans.eq(1).addClass("checked");
				
			if (report_submitter) {
				$spans.removeClass("checked");
				
				if (report_submitter.indexOf("客户经理") !== -1) {
					$spans.eq(0).addClass("checked");
				} else {
					$spans.eq(1).addClass("checked");
				}
			}
			
			$spans = $("[name=creditinvestigationOption]").eq(1).find(".zx_upload > span");
			$spans.removeClass("checked");
			$spans.eq(0).addClass("checked");
			
			if (result_submitter) {
				$spans.removeClass("checked");
				
				if (result_submitter.indexOf("客户经理") !== -1) {
					$spans.eq(0).addClass("checked");
				} else {
					$spans.eq(1).addClass("checked");
				}
			}
		}
		
		
		/* 
		if (!"${productId}") {
    		$("#investigation").trigger("click");
    	} */
		
	 	$("#div_alternative ul").on("click" , document, function(e) {
	 		if ($(e.target).is("li")) {
    			$(e.target).find("ins.iCheck-helper").trigger("click")
	 		}
     	});
    	
        var initAllSettingPage = function() {
            SurveyModuleSwitch();
    
            $("#productsurveydive input[type=checkbox].flat").each(function () {
                $(this).iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
            });
    
            if ($("#productsurveydive .js-switch:not([data-switchery])")[0]) {
                var elems = Array.prototype.slice.call(document.querySelectorAll('#productsurveydive .js-switch:not([data-switchery])'));
    
                elems.forEach(function (html) {
                    var switchery = new Switchery(html, {
                        color: 'rgb(93, 102, 125)'
                    });
                });
            }
    
            // 所属类别点击
            $("ul#survey-setting li").click(function () {
                if ($(this).attr("selected") == "selected")
                    return;
    
                $("ul#survey-setting li[selected]").removeAttr("selected");
                $(this).attr("selected", "selected");
    
                SurveyModuleSwitch();
            });
    
            // 所属类别选中或取消
            $("ul#survey-setting li ins.iCheck-helper").click(function () {
                if ($(this).prev("input[type=checkbox].flat").is(":checked")) {
                    $(this).parents("li").click();
                } else if ($(this).parents("li").attr("selected") == "selected") {
                    $("ul#survey-setting li:first").click();
                }
    
                var moduleClass = $(this).parents("li").attr("href");
                var setting = $(moduleClass + "[name=survey_setting]");
    
                if ($(this).prev("input[type=checkbox].flat").is(":checked")) {
                    setting.attr("checked", "checked");
                } else {
                    setting.removeAttr("checked");
                }
            });
    
            // 备选项选中或取消
            $("ul[name=survey_alternative] li ins.iCheck-helper").click(function () {
            	
                if ($(this).siblings("input[type=checkbox]").is(":disabled"))
                    return;
    
    			
                var moduleClass = $(this).parents("ul").attr("class").replace(/to_do wd_select_list/g, "").trim();
                var settingBody = $("div." + moduleClass + "[name=survey_setting] table tbody");
    
                var elementLi = $(this).parents("li[elementid]");
                var elementId = elementLi.attr("elementid");
    
                if ($(this).prev("input[type=checkbox].flat").is(":checked")) {
                    var lastSort = settingBody.children("tr:last").attr("itemsort");;
                    if (!isNaN(lastSort))
                        lastSort = Number(lastSort) + 1;
    
                    var elementName = elementLi.children("span").html().trim();
                    var trHtml = '<tr elementid="' + elementId + '">'
                    if ($("ul#survey-setting li[selected]").attr("href") != ".surveyphoto") {
                        trHtml += '<td>' + elementName + '</td><td><input type="checkbox" class="js-switch" /></td><td></td></tr>'
                    } else {
                        trHtml += '<td>' + elementName + '</td><td><input type="checkbox" class="js-switch" /></td><td><input type="text" class="form-control" value="9" /></td><td><input type="checkbox" class="js-switch" /></td></tr>'
                    }
                    settingBody.append(trHtml);
    
                    var newTr = settingBody.children("tr:last");
                    newTr.attr("itemsort", lastSort);
    
                    if ($("ul#survey-setting li[selected]").attr("href") != ".surveyphoto") {
    
                        var selectListDiv = elementLi.children("div.div-element-select-list");
                        if (selectListDiv.length == 1) {
                            var selectListTd = newTr.children("td:eq(2)");
                            selectListDiv.children("select").clone(true).appendTo(selectListTd);
                        }
                    }
    
                    if ($("#productsurveydive .js-switch:not([data-switchery])")[0]) {
                        var elems = Array.prototype.slice.call(document.querySelectorAll('#productsurveydive .js-switch:not([data-switchery])'));
    
                        elems.forEach(function (html) {
                            var switchery = new Switchery(html, {
                                color: 'rgb(93, 102, 125)'
                            });
                        });
                    }
    
                } else {
                    var elementTr = settingBody.children("tr[elementid=" + elementId + "]");
                    elementTr.fadeOut(512, function () {
                        elementTr.remove();
                    });
                }
    
            });
    
            if ($("#productsurveycomplexdiv .js-switch:not([data-switchery])")[0]) {
                var elems = Array.prototype.slice.call(document.querySelectorAll('#productsurveycomplexdiv .js-switch:not([data-switchery])'));
    
                elems.forEach(function (html) {
                    var switchery = new Switchery(html, {
                        color: 'rgb(93, 102, 125)'
                    });
                });
            }
    
            var fixHelperModified = function (e, tr) {
                var $originals = tr.children();
                var $helper = tr.clone();
                $helper.children().each(function (index) {
                    $(this).width($originals.eq(index).width())
                    $(this).css("background-color", "#CCCFD6");
                });
                return $helper;
            };
    
            //排序完成后的事件
            var updateIndex = function (e, ui) {
                ui.item.parent("tbody").children("tr").each(function (i) {
                    $(this).attr("itemsort", i);
                });
            };
    
            $("div[name=survey_setting]").each(function () {
                $(this).find("table.sortable tbody").sortable({
                    helper: fixHelperModified,
                    stop: updateIndex
                }).disableSelection();
            });
        }
        InitSurveySettingPage(initAllSettingPage);
    })
    
</script>