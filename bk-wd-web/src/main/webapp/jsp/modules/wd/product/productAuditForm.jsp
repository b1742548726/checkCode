<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="layui-layer-title"><span class="layui-layer-setwin"><a class="layui-layer-ico layui-layer-close layui-layer-close1" href="javascript:void(0);" onclick="$('#step-4').hide();" ></a></div>
<!--加个banner by jyshen-->
<div class="layui-layer-title" style="cursor: move;">
    <span class="layui-layer-setwin" style="top:65px;"><a class="layui-layer-ico layui-layer-close layui-layer-close1" href="javascript:$('#step-4').hide();"></a></span>
</div>

<div id="productauditdive">
    <div class="col-md-3 col-sm-3 col-xs-12 wd-nonmargin" style="border-right:1px solid rgb(204,204,204); padding:10px 15px; min-height:640px;">
        <div class="block-title">审核流程</div>
        <ul class="to_do wd_select_list" id="audit-setting">
            <li href=".data_conclusion" selected="selected" moduleid="BBBBBBBB-BBBB-BBBB-BBBB-CCCCCCCCCCCC">
                <span> 资料审查 </span>
            </li>
            <li href=".risk_control_conclusion" moduleid="CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC">
                <span> 风控审批 </span>
            </li>
            <li href=".table_conclusion" moduleid="BBBBBBBB-BBBB-BBBB-BBBB-DDDDDDDDDDDD">
                <span> 表格审批 </span>
            </li>
            <li href=".overflow_conclusion" moduleid="DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD">
                <span> 超额审批 </span>
            </li>
            <li href=".risk_investigation" moduleid="CCCCCCCC-CCCC-CCCC-CCCC-EEEEEEEEEEEE">
                <span> 风险核实 </span>
            </li>
        </ul>
    </div>

    <div id="productauditdiveAlternative" class="col-md-3 col-sm-3 col-xs-12 wd-nonmargin" style="border-right:1px solid rgb(204,204,204); border-left:1px solid rgb(204,204,204); margin-left:-1px; padding:10px 15px; min-height:640px;">
        <div class="block-title">备选项</div>

        <!-- href属性需要替换成真实地址，传递的参数可能包含module_id -->
        <ul class="to_do wd_select_list data_conclusion" name="audit_alternative" style="display:none;"></ul>
        <ul class="to_do wd_select_list risk_control_conclusion" name="audit_alternative" style="display:none;"></ul>
        <ul class="to_do wd_select_list table_conclusion" name="audit_alternative" style="display:none;"></ul>
        <ul class="to_do wd_select_list overflow_conclusion" name="audit_alternative" style="display:none;"></ul>
        <ul class="to_do wd_select_list risk_investigation" name="audit_alternative" style="display:none;"></ul>
        
    </div>

    <div class="col-md-6 col-sm-6 col-xs-12 wd-nonmargin" style="border-left:1px solid rgb(204,204,204); margin-left:-1px; padding:10px 15px; min-height:640px;">
        <div class="block-title">配置结果</div>

        <!-- href属性需要替换成真实地址，传递的参数可能包含module_id、product_id、product_version -->
        <div class="data_conclusion" name="audit_setting" style="display:none;" moduleid="BBBBBBBB-BBBB-BBBB-BBBB-CCCCCCCCCCCC"></div>
        <div class="risk_control_conclusion" name="audit_setting" style="display:none;" moduleid="CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC"></div>
        <div class="table_conclusion" name="audit_setting" style="display:none;" moduleid="BBBBBBBB-BBBB-BBBB-BBBB-DDDDDDDDDDDD"></div>
        <div class="overflow_conclusion" name="audit_setting" style="display:none;" moduleid="DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD"></div>
        <div class="risk_investigation" name="audit_setting" style="display:none;" moduleid="CCCCCCCC-CCCC-CCCC-CCCC-EEEEEEEEEEEE"></div>

    </div>
</div>
<script type="text/javascript">

    function GetAuditData() {

        var simpleModules = new Array();
        $("div[name=audit_setting][checked=checked][moduleid]").each(function () {
            var items = new Array();

            var moduleId = $(this).attr("moduleid");
            $(this).find("tbody tr").each(function () {
                var item = {
                    "default_simple_module_setting_id": $(this).attr("elementid"),
                    "required": $(this).find("input[type=checkbox]").is(":checked"),
                    "element_select_list_id": $(this).find("select:first").val(),
                    "sort": $(this).attr("itemsort"),
                }

                items.push(item);
            });

            var module = {
                "default_simple_module_id": $(this).attr("moduleid"),
                "product_simple_module_setting": items
            };

            simpleModules.push(module);
        });

        var info = {
            "simpleModules": JSON.stringify(simpleModules)
        };

        return info;
    }

    function InitAuditSettingPage() {
        $("#audit-setting li").each(function () {
            var moduleClass = $(this).attr("href");

            var alternative = $(moduleClass + "[name=audit_alternative]");
            var setting = $(moduleClass + "[name=audit_setting]");

            var moduleId = setting.attr("moduleid");
            var productId = $("#product-id").val();
            var productVersion = $("#product-version").val();

            $.ajax({
                url: "${ctx}/wd/product/form_alternative?moduleId=" + moduleId + "&productId=${productId}&version=" + newVersion,
                type: "GET",
                async: false,
                cache: false,
                success: function (result) {
                    alternative.html(result);
                }
            });

            $.ajax({
                url: "${ctx}/wd/product/form_setting?moduleId=" + moduleId + "&productId=${productId}&version=" + newVersion,
                type: "GET",
                async: false,
                cache: false,
                success: function (result) {
                    setting.html(result);
                }
            });
        });
    }

    // 切换模块
    function AuditModuleSwitch() {
        var currentModuleLi = $("#audit-setting li[selected]");
        if (currentModuleLi.length == 0)
            return;

        var currentModuleClass = currentModuleLi.attr("href");

        $("[name=audit_alternative]").hide();
        $("[name=audit_setting]").hide();

        $(currentModuleClass).show();
    }

    $(function () {
        InitAuditSettingPage();
        
    	var simpleModuleList = ${fns:toJsonString(simpleModuleList)};
		if (simpleModuleList && simpleModuleList.length > 0) {
    	    for (var i = 0; i < simpleModuleList.length; i++) {
    	        var simpleModule = simpleModuleList[i];
    	        $("#audit-setting li[moduleid="+ simpleModule.defaultSimpleModuleId +"]").find(":input[type=checkbox]").attr("checked", "checked");
    	        $("div[name=audit_setting][moduleid="+ simpleModule.defaultSimpleModuleId +"]").attr("checked", "checked");
    	    }
    	}
		
        AuditModuleSwitch();

        $("#productauditdive input[type=checkbox].flat").each(function () {
            $(this).iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
            });
        });

        if ($("#productauditdive .js-switch:not([data-switchery])")[0]) {
            var elems = Array.prototype.slice.call(document.querySelectorAll('#productauditdive .js-switch:not([data-switchery])'));

            elems.forEach(function (html) {
                var switchery = new Switchery(html, {
                    color: 'rgb(93, 102, 125)'
                });
            });
        }

        // 所属类别点击
        $("#audit-setting li").click(function () {
           //added by jyshen
        	//流程内没选中的这里也不能选中
        	var key_selected = $(this).find("span").text().trim();
        	
        	var obj_node = getNodeByKey(key_selected);
        	
        	if (!obj_node)  {
        		new PNotify({
					type: "warning",
					title: "",
					text: "流程配置中未启用本节点！",
					styling: 'bootstrap3',
				});
        		
        		return;
        	}
        	
        	obj_node = obj_node.obj;
        	
        	if (!obj_node.issel) {
        		new PNotify({
					type: "warning",
					title: "",
					text: "流程配置中未启用本节点！",
					styling: 'bootstrap3',
				});
        		
        		return;
        	}
        	
        	//end jyshen
            if ($(this).attr("selected") == "selected")
                return;

            $("#audit-setting li[selected]").removeAttr("selected");
            $(this).attr("selected", "selected");
            
            //added by jyshen
            var moduleClass = $(this).attr("href");
            var setting = $(moduleClass + "[name=audit_setting]");
			setting.attr("checked", "checked");
			//end jyshen

            AuditModuleSwitch();
        });
        
        $("#productauditdiveAlternative ul.wd_select_list li").click(function() {
			$(this).find("ins.iCheck-helper").click();
        });

        // 所属类别选中或取消
        $("#audit-setting li ins.iCheck-helper").click(function () {
            if ($(this).prev("input[type=checkbox].flat").is(":checked")) {
                $(this).parents("li").click();
            } else if ($(this).parents("li").attr("selected") == "selected") {
                $("#audit-setting li:first").click();
            }

            var moduleClass = $(this).parents("li").attr("href");
            var setting = $(moduleClass + "[name=audit_setting]");

            if ($(this).prev("input[type=checkbox].flat").is(":checked")) {
                setting.attr("checked", "checked");
            } else {
                setting.removeAttr("checked");
            }
        });

        // 备选项选中或取消
        $("ul[name=audit_alternative] li ins.iCheck-helper").click(function () {
        	if ($(this).siblings("input[type=checkbox]").is(":disabled")) {
        		return;
        	}
        	
            var moduleClass = $(this).parents("ul").attr("class").replace(/to_do wd_select_list/g, "").trim();
            var settingBody = $("div." + moduleClass + "[name=audit_setting] table tbody");

            var elementLi = $(this).parents("li[elementid]");
            var elementId = elementLi.attr("elementid");
            
            if ($(this).prev("input[type=checkbox].flat").is(":checked")) {
                var lastSort = settingBody.children("tr:last").attr("itemsort");;
                if (!isNaN(lastSort))
                    lastSort = Number(lastSort) + 1;

                var elementName = elementLi.children("span").html().trim();
                var trHtml = '<tr elementid="' + elementId + '">'
                if ($("#audit-setting li[selected]").attr("href") != ".auditphoto") {
                    trHtml += '<td>' + elementName + '</td><td><input type="checkbox" class="js-switch" /></td><td></td></tr>'
                } else {
                    trHtml += '<td>' + elementName + '</td><td><input type="text" class="form-control" value="9" /></td><td><input type="checkbox" class="js-switch" /></td></tr>'
                }
                settingBody.append(trHtml);

                var newTr = settingBody.children("tr:last");
                newTr.attr("itemsort", lastSort);

                if ($("#audit-setting li[selected]").attr("href") != ".auditphoto") {

                    var selectListDiv = elementLi.children("div.div-element-select-list");
                    if (selectListDiv.length == 1) {
                        var selectListTd = newTr.children("td:eq(2)");
                        selectListDiv.children("select").clone(true).appendTo(selectListTd);
                    }
                }

                if ($("#productauditdive .js-switch:not([data-switchery])")[0]) {
                    var elems = Array.prototype.slice.call(document.querySelectorAll('#productauditdive .js-switch:not([data-switchery])'));

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

        $("div[name=audit_setting]").each(function () {
            $(this).find("table.sortable tbody").sortable({
                helper: fixHelperModified,
                stop: updateIndex
            }).disableSelection();
        });
    })
    
    //流程配置中选中的这里也要选中
   function audit_reload (obj) {
   		var spans = document.querySelectorAll("#audit-setting li span");	
    	var keys = [], arrs = div_contentObjs.arrs, obj_node = null;
    	var moduleClass, setting;
    	$(spans).parent().removeAttr("selected");
    
    	spans.forEach(function(item, index) {
    		obj_node = getNodeByKey($.trim(item.innerText));
			moduleClass = $(item).parent().attr("href");
            setting = $(moduleClass + "[name=audit_setting]");
	    	if (obj_node) {
    			obj_node = obj_node.obj;
    			
					
    			if (obj_node.issel && obj.innerHTML === obj_node.innerHTML) {
    				$(item).parent().attr("selected", "selected").attr("issel", "");
    				setting.attr("checked", "checked");
    				AuditModuleSwitch();
    				
    			} else if (obj_node.issel) {
    				$(item).parent().removeAttr("selected").attr("issel", "");
    				setting.attr("checked", "checked");
    			} else {
    				$(item).parent().removeAttr("selected").removeAttr("issel");
    				setting.removeAttr("checked");
    			}
    		} else {
    			$(item).parent().removeAttr("selected").removeAttr("issel");
    			setting.removeAttr("checked");
    		}
    	});
   }

</script>