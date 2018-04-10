<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gentelella Alela! | </title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

    <style type="text/css">
        table#select-group > tbody > tr {
            cursor: pointer;
        }

        table#select-group > tbody > tr[selected=selected] {
            background-color: #efe8e1;
        }

        .table > tbody > tr > td,
        .table > tbody > tr > th,
        .table > tfoot > tr > td,
        .table > tfoot > tr > th,
        .table > thead > tr > td,
        .table > thead > tr > th {
            vertical-align: middle;
        }

        .cursor-default {
            cursor: default;
        }
    </style>
</head>
<body>
    <!-- page content -->
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2> ${wdCommonSimpleModule.moduleName } </h2>
                <input id="wdCommonSimpleModuleId" name="id" type="hidden" value="${wdCommonSimpleModule.id }" />
                <input id="defaultSimpleModuleId" name="defaultSimpleModuleId" type="hidden" value="${wdCommonSimpleModule.defaultSimpleModuleId }" />
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-group"> 保存配置 </button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="col-md-3 col-sm-3 col-xs-12 wd-nonmargin" style="border-right:1px solid rgb(204,204,204); padding:10px 15px;">
                <div class="block-title">所属类别</div>
                <ul class="to_do wd_select_list" id="setting-category">
                
                    <li category="new_customer">
                        <span> ${defaultModule.name } </span>
                    </li>
                </ul>
            </div>

            <div class="col-md-3 col-sm-3 col-xs-12 wd-nonmargin" style="border-right:1px solid rgb(204,204,204); border-left:1px solid rgb(204,204,204); margin-left:-1px; padding:10px 15px;">
                <div class="block-title">备选项</div>
                <ul class="to_do wd_select_list" id="setting-item">
                    <c:forEach items="${commonModuleSettingList }" var="element">
                        <li elementid="${element.id}">
                            <span> ${element.name} </span>
                            <div style="float:right!important;">
                                <input type="checkbox" ${element.required eq '1' ? 'disabled' : ''} ${(element.required eq '1' || not empty element.settingId)  ? 'checked' : ''} class="flat" />
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 wd-nonmargin" style="border-left:1px solid rgb(204,204,204); margin-left:-1px; padding:10px 15px;">
                <div class="block-title">配置结果</div>
                <div id="setting-item-list">

                </div>
            </div>
        </div>
    </div>
    <!-- /page content -->
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    
    <!-- 弹出层 -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    
    <!-- Switchery -->
    <script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
    <!-- iCheck -->
    <script src="${imgStatic }/vendors/iCheck/icheck.min.js"></script>
    <!-- jquery ui -->
    <script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>

    <script type="text/javascript">
    	var newVersion = "${newVersion}";
    
        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        function UpdateItemSort(tbodyObj) {
            var ids = "";
            $(tbodyObj).children("tr").each(function(dom, index){
                ids += $(this).attr("settingid") + ",";
            })
            
            $.ajax({
                url : "${ctx }/wd/commonModule/settingSorts",
                data : {ids: ids},
                type: "post",
                success : function (data) {
                }
            });
        }

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        function AddCustomerSetting(elementId) {
            var submitObj = {
                "version": newVersion,
                "defaultSimpleModuleSettingId": elementId,
            }
            
            $.ajax({
                url : "${ctx }/wd/commonModule/settingSave",
                data : submitObj,
                type: "post",
                success : function (data) {
                	ReloadSettingPage();
                }
        	});
        }

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        function RemoveCustomerSetting(elementId) {
        	var submitObj = {
                "version": newVersion,
                "defaultSimpleModuleSettingId": elementId,
            }
            
            $.ajax({
                url : "${ctx }/wd/commonModule/settingDelete",
                data : submitObj,
                type: "post",
                success : function (data) {
                	ReloadSettingPage();
                }
        	});
        }

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        function UpdateSettingName(settingId, name) {
        	$.ajax({
                url : "${ctx }/wd/commonModule/settingSave",
                data : {id : settingId, elementName : name},
                type: "post",
                success : function (data) {
                	ReloadSettingPage();
                }
        	});
        }

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        function UpdateSettingRequired(elementId, isRequired) {
        	$.ajax({
                url : "${ctx }/wd/commonModule/settingSave",
                data : {"defaultSimpleModuleSettingId": elementId, "version": newVersion, "required" : (isRequired ? '1' : '0')},
                type: "post",
                success : function (data) {
                	ReloadSettingPage();
                }
        	});
        }

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        //选择项改变
        function UpdateSettingSelected(elementId, listId) {
        	$.ajax({
                url : "${ctx }/wd/commonModule/settingSave",
                data : {"defaultSimpleModuleSettingId": elementId, "version": newVersion, "elementSelectListId" : listId},
                type: "post",
                success : function (data) {
                	ReloadSettingPage();
                }
        	});
        }

        function ReloadSettingPage() {
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

                 UpdateItemSort(ui.item.parent("tbody"));
             };
        	
            $("#setting-item-list").load("${ctx}/wd/commonModule/settingList?moduleId=${wdCommonSimpleModule.defaultSimpleModuleId}&version=" + newVersion + "&r=" + Math.random(), null, function () {
                if ($(".js-switch:not([data-switchery])")[0]) {
                    var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not([data-switchery])'));

                    elems.forEach(function (html) {
                        var switchery = new Switchery(html, {
                            color: 'rgb(93, 102, 125)'
                        });
                    });
                }
                
				$("#customer-type-setting tbody").sortable({
                    helper: fixHelperModified,
                    stop: updateIndex
                }).disableSelection();

            });
        }
        
        $(function () {
        	ReloadSettingPage();

            //待选项样式
            if ($("ul#setting-item li input.flat")[0]) {
                $("ul#setting-item li input.flat").iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
            }

            //备选项选中事件
            $("#setting-item").on("click", "li", function () {
                var settingItem = $(this).find("input.flat");
                if ($(settingItem).is(':disabled'))
                    return;
                if ($(settingItem).is(':checked')) {
                    $(settingItem).iCheck('uncheck');
                } else {
                    $(settingItem).iCheck('check');
                }
            });

            $("#setting-item").on("ifChecked", "li input.flat", function () {
                var elementId = $(this).parents("li").attr("elementid");
                AddCustomerSetting(elementId);
            });

            $("#setting-item").on("ifUnchecked", "li input.flat", function () {
                var elementId = $(this).parents("li").attr("elementid");
                RemoveCustomerSetting(elementId);
            });

            $("#setting-item-list").on("change", "select", function () {
            	var elementid = $(this).closest("tr").attr("elementid");
            	var listId = $(this).val();
                UpdateSettingSelected(elementid, listId);
            });

            $("#setting-item-list").on("change", "input[type='checkbox']", function () {
                var isRequired = $(this).is(":checked");
                var elementid = $(this).closest("tr").attr("elementid");

                UpdateSettingRequired(elementid, isRequired);
            });
            
            $("#setting-item-list").on("click", "button.btn-del-item", function () {
                var elementid = $(this).closest("tr").attr("elementid");
                $("#setting-item li[elementid="+elementid+"]").click();
                
            });
            
            $("#btn-add-group").on("click", function(){
            	$.ajax({
                    url : "${ctx }/wd/commonModule/settingIssue",
                    data : {
                		id: $("#wdCommonSimpleModuleId").val(),
                		version: newVersion,
                    },
                    type: "post",
                    success : function (data) {
                    	CloseIFrame();
                    }
            	});
            });
        });
    </script>
</body>
</html>