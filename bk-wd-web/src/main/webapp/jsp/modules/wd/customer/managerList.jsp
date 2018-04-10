<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title></title>
<!-- Bootstrap -->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Font Awesome -->
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />
<!-- iCheck -->
<link href="${imgStatic }/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet" />
<!-- PNotify -->
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.css"
	rel="stylesheet" />
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css"
	rel="stylesheet" />
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css"
	rel="stylesheet" />

<!-- Custom Theme Style -->
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet" />

<!-- 重要！样式重写! -->
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet" />

<style type="text/css">
table#customer-list tbody tr td:first-child {
	text-align: center;
}

table#customer-list tbody tr td:nth-child(2) {
	text-align: center;
}

table#customer-list tbody tr td:nth-child(3) {
	text-align: center;
}

table#customer-list tbody tr td:nth-child(6) {
	text-align: center;
}
</style>
</head>

<body>
	<!-- page content -->
	<div class="wd-content">
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<form action="${ctx}/wd/customer/customerManagerList" id="searchForm"
				method="get">
				<input id="current" name="current" type="hidden" value="1" /> <input
					id="length" name="length" type="hidden"
					value="${pagination.length}" />
				<div class="list-page-search-div col-xs-12">
					<!-- 左边搜索条件 -->
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="col-md-10 col-sm-10 col-xs-12">
							<div class="col-xs-3">
								<span class="col-xs-11"> 客户姓名 </span>
								<div class="col-xs-11">
									<div class="auto-clear-input">
										<input type="text" class="form-control" name="name"
											value="${params.name }" />
									</div>
								</div>
							</div>
							<div class="col-xs-3">
								<span class="col-xs-11"> 身份证 </span>
								<div class="col-xs-11">
									<div class="auto-clear-input">
										<input type="text" class="form-control" name="idcard"
											value="${params.idcard }" />
									</div>
								</div>
							</div>
							<div class="col-xs-3">
								<span class="col-xs-11"> 客户经理 </span>
								<div class="col-xs-11">
									<div class="auto-clear-input">
										<input type="text" class="form-control" name="userName"
											value="${params.userName }" />
									</div>
								</div>
							</div>
							<div class="col-xs-3">
								<span class="col-xs-11"> 团队 </span>
								<div class="col-xs-11">
									<div class="auto-clear-input">
										<input type="text" class="form-control" name="officeName"
											value="${params.officeName }" />
									</div>
								</div>
							</div>
						</div>
						<div class="col-xs-2">
							<span class="col-xs-12"> 客户类型 </span>
							<div class="col-xs-12">
								<spring:eval
									expression="@wdCustomerTypeService.selectByRegion(currentUser.companyId)"
									var="customerTypeList" />
								<select class="form-control" name="customerTypeId">
									<option value="">全部</option>
									<c:if test="${not empty customerTypeList}">
										<c:forEach items="${customerTypeList}" var="customerType">
											<option value="${customerType.id }"
												${customerType.id eq params.customerTypeId ? 'selected' : '' }>${customerType.name }</option>
										</c:forEach>
									</c:if>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="x_content">
					<table class="table table-striped table-bordered wd-table"
						id="customer-list">
						<colgroup>
							<shiro:hasPermission name="wd:customer:transfer">
								<col style="width: 50px" />
							</shiro:hasPermission>
							<col style="width: 120px" />
							<col style="width: 100px" />
							<col style="width: 256px" />
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: 100px" />
						</colgroup>
						<thead>
							<tr>
								<shiro:hasPermission name="wd:customer:transfer">
									<th style="width: 50px"><input type="checkbox"
										class="flat checkall" /></th>
								</shiro:hasPermission>
								<th>客户名称</th>
								<th>客户类型</th>
								<th>商户/公司</th>
								<th>性别</th>
								<th>婚姻状况</th>
								<th>录入时间</th>
								<th>客户经理</th>
								<th colspan="7"
									style="display: none; text-align: left; padding-top: 0px; padding-bottom: 0px;">
									<button type="button" class="btn wd-btn-small wd-btn-orange"
										id="btn-tranfer" style="margin-left: 13px;">批量移交</button>
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pagination.dataList}" var="data">
								<tr>
									<shiro:hasPermission name="wd:customer:transfer">
										<td><input type="checkbox" class="flat"
											name="customer-cb" value="${data.wdCustomerRelation.id }" />
										</td>
									</shiro:hasPermission>
									<td><span class="td-span-block" customerid="${data.id }">
											${not empty data.wdPerson.getJsonData().base_info_name ? data.wdPerson.getJsonData().base_info_name : '未知'}
									</span></td>
									<td>${data.customerTypeName}</td>
									<td>${not empty data.wdPerson.getJsonData().base_info_shop_name ? data.wdPerson.getJsonData().base_info_shop_name : data.wdPerson.getJsonData().base_info_company_name}
									</td>
									<td>${data.wdPerson.getJsonData().base_info_gender}</td>
									<td>${data.wdPerson.getJsonData().base_info_marriage}</td>
									<td><fmt:formatDate value="${data.updateDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td>${data.wdCustomerRelation.sysUser.name }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="dataTables_wrapper">${pagination}</div>
				</div>
			</form>
		</div>
	</div>
	<!-- /page content -->
	<!-- jQuery -->
	<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- PNotify -->
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>
	<!-- iCheck -->
	<script src="${imgStatic }/vendors/iCheck/icheck.min.js"></script>

	<script src="${imgStatic }/zwy/js/wd-common.js"></script>
	<script src="${imgStatic }/zwy/js/wd-common-bind.js"></script>

	<script src="${imgStatic }/vendors/layer/layer.js"></script>
	<script src="${imgStatic }/zwy/js/layer-customer.js"></script>

	<script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>

	<script type="text/javascript">
		var currentPageUrl = {
			customer : "${ctx }/wd/customer/detail", // 客户详情页
		};

		function SearchCustomer() {
			$("#searchForm").submit();
		}

		// 重新加载页面
		function ReloadData() {
			$("#current").val("${pagination.current}");
			$("#searchForm").submit();
		}

		function ShowTransfer() {
			if ($("input.flat[type=checkbox][name=customer-cb]:checked").length == 0) {
				$("#customer-list thead tr th:gt(0):lt(8)").show();
				$("#customer-list thead tr th:eq(8)").hide();
			} else {
				$("#customer-list thead tr th:gt(0):lt(8)").hide();
				$("#customer-list thead tr th:eq(8)").show();
			}
		}

		$(function() {
			$("input.flat[type=checkbox]").each(function() {
				$(this).iCheck({
					checkboxClass : 'icheckbox_flat-green',
					radioClass : 'iradio_flat-green'
				});
			});

			// 跳转客户详情
			$("table#customer-list").on(
					"click",
					"span[customerid]",
					function() {
						var customerid = $(this).attr("customerid");
						window.location.href = currentPageUrl.customer
								+ "?customerId=" + customerid + "&_r="
								+ Math.random();
					});

			$("div.list-page-search-div").on("change", "input", function() {
				SearchCustomer()
			}).on("change", "select", function() {
				SearchCustomer()
			}).on("click", "table.category-table td", function() {
				SearchCustomer()
			});

			// 移交
			/*   $("table#customer-list").on("click", "button[customerid]", function () {
			      var customerId = $(this).attr("customerid");
			      var customerTr = $(this).parents("tr");
				alert(1);
			      OpenIFrame("您确定将这个客户移交给下面的客户经理吗？", "_customer/customer_transfer.html?customer_id=" + customerId, 640, 500, function () { ReloadData(); });
			  }); */

			// 全选按钮
			$("table#customer-list thead tr th ins.iCheck-helper").click(
					function() {
						$("input.flat[type=checkbox][name=customer-cb]")
								.each(
										function() {
											if ($("input.flat.checkall").is(
													":checked")) {
												$(this).iCheck("check");
											} else {
												$(this).iCheck('uncheck');
											}
										});

						ShowTransfer();
					});

			// 选择按钮
			$("table#customer-list tbody tr td ins.iCheck-helper").click(
					function() {
						ShowTransfer();
					});

			$("#btn-tranfer")
					.click(
							function() {
								var customerRelationCheckBox = $("input.flat[type=checkbox][name=customer-cb]:checked");
								if (customerRelationCheckBox.length == 0) {
									AlertMessage("请选择需要移交的客户");
									return;
								}

								var customerRelationArray = new Array();
								customerRelationCheckBox.each(function() {
									customerRelationArray.push($(this).val());
								});

								OpenIFrame(
										"您确定将客户分配给下面的客户经理吗？",
										"${ctx }/sys/user/userSelect",
										640,
										500,
										function() {
											if (GetLayerData("_select_user_id")) {
												var _user_id = GetLayerData("_select_user_id");
												SetLayerData("_select_user_id",
														null);
												$
														.ajax({
															url : "${ctx}/wd/customer/customerTransfer",
															async : false,
															cache : false,
															type : "POST",
															data : {
																userId : _user_id,
																customerRaletions : customerRelationArray
																		.join(',')
															},
															dataType : "json",
															success : function(
																	result) {
																if (result.success) {
																	ReloadData();
																} else {
																	NotifyInCurrentPage(
																			"error",
																			result.msg,
																			"删除机构错误");
																}
															}
														});
											}
										});
							});
		});

		function page(n, s) {
			$("#current").val(n);
			if ($.isNumeric(s)) {
				$("#length").val(s);
			}
			$("#searchForm").submit();
			return false;
		}
	</script>
</body>
</html>