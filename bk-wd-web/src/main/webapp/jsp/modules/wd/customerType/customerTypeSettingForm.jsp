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

<title>Gentelella Alela! |</title>

<!-- Bootstrap -->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- iCheck -->
<link href="${imgStatic }/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<!-- Switchery -->
<link href="${imgStatic }/vendors/switchery/dist/switchery.min.css"
	rel="stylesheet">
<!-- Custom Theme Style -->
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<!-- 重要！样式重写! -->
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<style type="text/css">
table#select-group>tbody>tr {
	cursor: pointer;
}

table#select-group>tbody>tr[selected=selected] {
	background-color: #efe8e1;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th,
	.table>thead>tr>td, .table>thead>tr>th {
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
				<h2>${wdCustomerType.name }</h2>
				<input id="customer-type-id" name="customer-type-id" type="hidden"
					value="${wdCustomerType.id }" /> <input id="customer-type-version"
					name="customer-type-version" type="hidden" value="" />
				<ul class="nav navbar-right panel_toolbox">
					<!--  <li style="margin-right: 10px;">
                        <div class="btn-group">
                            <button data-toggle="dropdown" class="btn btn-default dropdown-toggle wd-btn-normal" type="button" aria-expanded="false">
                                选择已有配置进行复制 <span class="caret"></span>
                            </button>
                            <ul role="menu" class="dropdown-menu" id="btn-customer-type-setting">
                                <li>
                                    <a href="#"> 读取 蓝领 类的配置 </a>
                                </li>
                                <li>
                                    <a href="#"> 读取 白领 类的配置 </a>
                                </li>
                                <li>
                                    <a href="#"> 读取 商户 类的配置 </a>
                                </li>
                            </ul>
                        </div>
                    </li> -->
					<li>
						<button type="button"
							class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle"
							id="btn-add-group">保存配置</button>
					</li>
				</ul>
				<div class="clearfix"></div>
			</div>
			<div class="col-md-3 col-sm-3 col-xs-12 wd-nonmargin"
				style="border-right: 1px solid rgb(204, 204, 204); padding: 10px 15px;">
				<div class="block-title">所属类别</div>
				<ul class="to_do wd_select_list" id="setting-category">
					<li category="new_customer"><span> 新增客户设置 </span></li>
					<li category="base_info"><span> 编辑客户设置 </span></li>
				</ul>
			</div>

			<div class="col-md-3 col-sm-3 col-xs-12 wd-nonmargin"
				style="border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); margin-left: -1px; padding: 10px 15px;">
				<div class="block-title">备选项</div>
				<ul class="to_do wd_select_list" id="setting-item">
					<c:forEach items="${customerTypeLeftModules}" var="element">
						<c:set var="category"></c:set>
						<c:forEach items="${customerTypeSettingList}"
							var="customerTypeSetting">
							<c:if
								test="${customerTypeSetting.businessElementId eq element.id and customerTypeSetting.defaultSimpleModuleId eq element.moduleId }">
								<c:set var="category" value="${customerTypeSetting.category }"></c:set>
							</c:if>
						</c:forEach>
						<li moduleid="${element.moduleId}" elementid="${element.id}"
							category="${category }"><span> ${element.name} </span>
							<div style="float: right !important;">
								<input type="checkbox" class="flat"
									${not empty category ? 'checked': ''} />
							</div></li>
					</c:forEach>
				</ul>
			</div>
			<div class="col-md-6 col-sm-6 col-xs-12 wd-nonmargin"
				style="border-left: 1px solid rgb(204, 204, 204); margin-left: -1px; padding: 10px 15px;">
				<div class="block-title">配置结果</div>
				<div id="setting-item-list"></div>
				<div id="mobile-col-setting" style="display: none;">
					<div class="x_panel">
						<div class="x_title">客户列表展示设置</div>
						<div class="x_content">
							<div
								style="position: relative; border: 1px solid #808080; height: 180px; border-radius: 8px;">
								<div
									style="position: absolute; top: 10px; left: 30px; height: 160px; width: 160px; border-radius: 80px; border: 1px solid #000000">

								</div>

								<select class="form-control" id="customer-portrait-col"
									style="position: absolute; top: 75px; left: 40px; width: 140px;">
									<option value="">选择头像列</option>
								</select> <select class="form-control" id="customer-title-col"
									style="position: absolute; top: 40px; left: 200px; width: 180px;">
									<option value="">选择标题</option>
								</select> <select class="form-control" id="customer-subtitle-col"
									style="position: absolute; top: 100px; left: 200px; width: 180px;">
									<option value="">选择子标题</option>
								</select>
							</div>
						</div>
					</div>
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
			$(tbodyObj).children("tr").each(function(dom, index) {
				ids += $(this).attr("settingid") + ",";
			})

			$.ajax({
				url : "${ctx }/wd/customerType/settingSorts",
				data : {
					ids : ids
				},
				type : "post",
				success : function(data) {
				}
			});
		}

		// Hi, boy! look at here! this function need you override!
		// 注意！注意！这个方法要你处理的
		function AddCustomerSetting(category, moduleId, elementId) {
			var submitObj = {
				"customerTypeId" : $("#customer-type-id").val(),
				"version" : newVersion,
				"category" : category,
				"defaultSimpleModuleId" : moduleId,
				"businessElementId" : elementId,
			}

			$.ajax({
				url : "${ctx }/wd/customerType/settingSave",
				data : submitObj,
				type : "post",
				success : function(data) {
					ReloadSettingPage();
				}
			});
		}

		// Hi, boy! look at here! this function need you override!
		// 注意！注意！这个方法要你处理的
		function RemoveCustomerSetting(category, moduleId, elementId) {
			var submitObj = {
				"customerTypeId" : $("#customer-type-id").val(),
				"version" : newVersion,
				"defaultSimpleModuleId" : moduleId,
				"businessElementId" : elementId,
			}

			$.ajax({
				url : "${ctx }/wd/customerType/settingDelete",
				data : submitObj,
				type : "post",
				success : function(data) {
					ReloadSettingPage();
				}
			});
		}

		// Hi, boy! look at here! this function need you override!
		// 注意！注意！这个方法要你处理的
		function UpdateSettingName(settingId, name) {
			$.ajax({
				url : "${ctx }/wd/customerType/settingSave",
				data : {
					id : settingId,
					elementName : name
				},
				type : "post",
				success : function(data) {
					ReloadSettingPage();
				}
			});
		}

		// Hi, boy! look at here! this function need you override!
		// 注意！注意！这个方法要你处理的
		function UpdateSettingRequired(settingId, isRequired) {
			$.ajax({
				url : "${ctx }/wd/customerType/settingSave",
				data : {
					"id" : settingId,
					"required" : (isRequired ? '1' : '0')
				},
				type : "post",
				success : function(data) {
					ReloadSettingPage();
				}
			});
		}

		// Hi, boy! look at here! this function need you override!
		// 注意！注意！这个方法要你处理的
		//选择项改变
		function UpdateSettingSelected(settingId, listId) {
			$.ajax({
				url : "${ctx }/wd/customerType/settingSave",
				data : {
					"id" : settingId,
					"elementSelectListId" : listId
				},
				type : "post",
				success : function(data) {
					ReloadSettingPage();
				}
			});
		}

		function InitSettingItem(category) {
			$("#setting-item li").each(
					function() {
						if ($(this).attr("category")
								&& category != $(this).attr("category")) {
							$(this).iCheck('disable');
						} else {
							$(this).iCheck('enable');
						}
					});
		}

		function ReloadSettingPage() {
			var fixHelperModified = function(e, tr) {
				var $originals = tr.children();
				var $helper = tr.clone();
				$helper.children().each(function(index) {
					$(this).width($originals.eq(index).width())
					$(this).css("background-color", "#CCCFD6");
				});
				return $helper;
			};

			//排序完成后的事件
			var updateIndex = function(e, ui) {
				ui.item.parent("tbody").children("tr").each(function(i) {
					$(this).attr("itemsort", i);
				});

				UpdateItemSort(ui.item.parent("tbody"));
			};

			var category = $("#setting-category > li[selected]").attr(
					"category");
			var customerTypeId = $("#customer-type-id").val();
			var version = $("#customer-type-version").val();

			$("#setting-item-list")
					.load(
							"${ctx}/wd/customerType/settingList?id="
									+ customerTypeId + "&category=" + category
									+ "&settingVersion=" + newVersion + "&r="
									+ Math.random(),
							null,
							function() {

								if ($(".js-switch:not([data-switchery])")[0]) {
									var elems = Array.prototype.slice
											.call(document
													.querySelectorAll('.js-switch:not([data-switchery])'));

									elems.forEach(function(html) {
										var switchery = new Switchery(html, {
											color : 'rgb(93, 102, 125)'
										});
									});
								}

								$("#customer-type-setting tbody").sortable({
									helper : fixHelperModified,
									stop : updateIndex
								}).disableSelection();

							});
		}

		function loadShowList(customerTypeSettingList) {
			var customerPortraitCol = $("#customer-portrait-col").empty()
					.append('<option value="">选择头像列</option>');
			var customerTitleCol = $("#customer-title-col").empty().append(
					'<option value="">选择标题</option>');
			var customerSubtitleCol = $("#customer-subtitle-col").empty()
					.append('<option value="">选择子标题</option>');
			if (customerTypeSettingList && customerTypeSettingList.length > 0) {
				for (var i = 0; i < customerTypeSettingList.length; i++) {
					var customerTypeSetting = customerTypeSettingList[i];
					var options = '<option value="'+ customerTypeSetting.businessElementId +'">'
							+ customerTypeSetting.elementName + '</option>';
					customerPortraitCol.append(options);
					customerTitleCol.append(options);
					customerSubtitleCol.append(options);
				}
			}
			if ("${wdCustomerType.portraitCol }") {
				customerPortraitCol.find(
						"option[value=${wdCustomerType.portraitCol }]").attr(
						"selected", true);
			}
			if ("${wdCustomerType.titleCol }") {
				customerTitleCol.find(
						"option[value=${wdCustomerType.titleCol }]").attr(
						"selected", true);
			}
			if ("${wdCustomerType.subtitleCol }") {
				customerSubtitleCol.find(
						"option[value=${wdCustomerType.subtitleCol }]").attr(
						"selected", true);
			}
		}

		$(function() {
			$("#customer-type-version").val("temp-" + Math.random());

			//待选项样式
			if ($("ul#setting-item li input.flat")[0]) {
				$("ul#setting-item li input.flat").iCheck({
					checkboxClass : 'icheckbox_flat-green',
					radioClass : 'iradio_flat-green'
				});
			}

			// 读取已有的配置
			$("#btn-customer-type-setting").on("click", "li a", function() {
				alert($(this).html());
			});

			$("#setting-category").on("click", "li", function() {
				if ($(this).attr("selected") == "selected")
					return;

				$("ul#setting-category > li[selected]").removeAttr("selected");
				$(this).attr("selected", "selected");

				var category = $(this).attr("category");
				InitSettingItem(category);
				//   ReloadSettingPage();

				if ($(this).attr("category") == "new_customer") {
					$("#mobile-col-setting").show();
				} else {
					$("#mobile-col-setting").hide();
				}
				ReloadSettingPage();
			});

			$("#setting-category li[category=new_customer]").trigger("click");

			//备选项选中事件
			$("#setting-item").on("click", "li", function() {
				var settingItem = $(this).find("input.flat");
				if ($(settingItem).is(':disabled'))
					return;
				if ($(settingItem).is(':checked')) {
					$(settingItem).iCheck('uncheck');
				} else {
					$(settingItem).iCheck('check');
				}
			});

			$("#setting-item")
					.on(
							"ifChecked",
							"li input.flat",
							function() {
								var category = $(
										"#setting-category > li[selected]")
										.attr("category");
								$(this).parents("li")
										.attr("category", category);

								var moduleId = $(this).parents("li").attr(
										"moduleid");
								var elementId = $(this).parents("li").attr(
										"elementid");

								AddCustomerSetting(category, moduleId,
										elementId);
								//  ReloadSettingPage();
							});

			$("#setting-item")
					.on(
							"ifUnchecked",
							"li input.flat",
							function() {
								$(this).parents("li").removeAttr("category");

								var category = $(
										"#setting-category > li[selected]")
										.attr("category");
								var moduleId = $(this).parents("li").attr(
										"moduleid");
								var elementId = $(this).parents("li").attr(
										"elementid");

								RemoveCustomerSetting(category, moduleId,
										elementId);
								//  ReloadSettingPage();
							});

			$("#setting-item-list").on("change", "select", function() {
				var listId = $(this).val();
				var settingId = $(this).closest("tr").attr("settingid");

				UpdateSettingSelected(settingId, listId);
			});

			$("#setting-item-list")
					.on(
							"change",
							"input[type='checkbox']",
							function() {
								var isRequired = $(this).is(":checked");
								var settingId = $(this).closest("tr").attr(
										"settingid");

								UpdateSettingRequired(settingId, isRequired);
							});

			$("#setting-item-list")
					.on(
							"click",
							"button.btn-del-item",
							function() {
								var settingId = $(this).closest("tr").attr(
										"settingid");
								var moduleId = $(this).closest("tr").attr(
										"moduleId");
								var elementid = $(this).closest("tr").attr(
										"elementid");
								$("#setting-item li[moduleId=" + moduleId + "][elementid=" + elementid + "]").click();

								/*  $.ajax({
								     url : "${ctx }/wd/customerType/settingDelete",
								     data : {id: settingId},
								     type: "post",
								     success : function (data) {
								     	ReloadSettingPage();
								     }
								}); */
							});

			$("#btn-add-group").on("click", function() {
				var customerPortraitCol = $("#customer-portrait-col").val();
				var customerTitleCol = $("#customer-title-col").val();
				var customerSubtitleCol = $("#customer-subtitle-col").val();

				var postData = {
					customerTypeId : $("#customer-type-id").val(),
					version : newVersion,
				};
				if($("#setting-category li[selected]").attr("category")=="new_customer") {
					postData["portraitCol"] = customerPortraitCol;
					postData["titleCol"] = customerTitleCol;
					postData["subtitleCol"] = customerSubtitleCol;
				}
				
				$.ajax({
					url : "${ctx }/wd/customerType/settingIssue",
					data : postData,
					type : "post",
					success : function(data) {
						CloseIFrame();
					}
				});
			});
		});
	</script>
</body>
</html>