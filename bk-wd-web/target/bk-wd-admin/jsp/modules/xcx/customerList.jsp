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
table#customer-list tbody tr td {
	text-align: center;
}

</style>
</head>

<body>
	<!-- page content -->
	<div class="wd-content">
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<form id="searchForm" method="get">
				<input id="target" name="target" type="hidden" value="${ target }" />
				<div class="list-page-search-div col-xs-12">
					<!-- 左边搜索条件 -->
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="col-xs-6">

							<span class="col-xs-12"> 贷款产品 </span>
							<table class="category-table" name="ceProductId">
								<tbody>
									<tr>
										<td value="0">全部</td>
										<c:if test="${not empty products}">
											<c:forEach items="${ products }" var="ceProduct">
												<td value="${ ceProduct.id }">${ ceProduct.name }
													</option>
											</c:forEach>
										</c:if>
									</tr>
								</tbody>
							</table>
							<input type="hidden" name="ceProductId" for="ceProductId" value="${ searchParms.ceProductId }" />

						</div>
						<c:if test="${ 'result' eq target }">
							<div class="col-xs-1"></div>
							<div class="col-xs-5">
								<span class="col-xs-12"> 跟进结果 </span>
								<table class="category-table" name="status">
									<tbody>
										<tr>
											<td value="0">全部</td>
											<td value="已接收">有效客户</td>
											<td value="无效客户">无效客户</td>
											<td value="待处理">未处理</td>
										</tr>
									</tbody>
								</table>
								<input type="hidden" name="status" for="status" value="${ searchParms.status }" />
							</div>
						</c:if>
					</div>
				</div>
				<div class="x_content">
					<table class="table table-striped table-bordered wd-table"
						id="customer-list">
						<colgroup>
							<c:if test="${ 'assign' eq target }">
								<col style="width: 50px" />
							</c:if>
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: auto" />
							<col style="width: auto" />
							<c:if test="${ 'result' eq target }">
								<col style="width: 100px" />
							</c:if>
						</colgroup>
						<thead>
							<tr>
								<c:if test="${ 'assign' eq target }">
									<th><input type="checkbox" class="flat checkall" /></th>
								</c:if>
								<th>客户姓名</th>
								<th>性别</th>
								<th>贷款产品</th>
								<th>年龄段</th>
								<th>手机号</th>
								<th>是否有信用卡</th>
								<th>是否有房</th>
								<th>是否有车</th>
								<th>渠道</th>
								<th>申请时间</th>
								<c:if test="${ 'result' eq target }">
									<th></th>
								</c:if>
								<th colspan="10" style="display: none; text-align: left; padding-top: 0px; padding-bottom: 0px;">
									<button type="button" class="btn wd-btn-small wd-btn-orange" id="btn-tranfer" style="margin-left: 13px;">批量移交</button>
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${customers}" var="data">
								<tr>
									<c:if test="${ 'assign' eq target }">
										<td>
											<input type="checkbox" class="flat" name="customer-cb" value="${ data.id }" />
										</td>
									</c:if>
									<td>${ data.name }</td>
									<td>${ data.gender }</td>
									<td>${ data.ceProductName }</td>
									<td>${ data.age }</td>
									<td>${ data.telphone }</td>
									<td>${ data.hasCreditCard }</td>
									<td>${ data.hasHouse }</td>
									<td>${ data.hasCar }</td>
									<td>
                                        <c:if test="${not empty data.fromA }">
                                            ${data.fromA}  
                                        </c:if>
                                        <c:if test="${not empty data.fromB }">
                                            ${data.fromB} 
                                        </c:if>
                                        <spring:eval expression="@sysUserService.selectByPrimaryKey(data.fromC)" var="createBy"/>
                                        ${createBy.name }
                                    </td>
									<td>
										<fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd" />
									</td>
									<c:if test="${ 'result' eq target }">
										<td>
											<c:if test="${ '无效客户' eq data.status }">
												<span class="td-span-block show-remarks" customerid="${ data.id }">${ data.status }</span>
											</c:if>
											<c:if test="${ '待处理' eq data.status }">
												${ data.ownerName } 暂未处理 
											</c:if>
											<c:if test="${ '已接收' eq data.status }">
												${ data.ownerName } 已接收
											</c:if>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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
	
		function SearchCustomer() {
			$("#searchForm").submit();
		}

		// 重新加载页面
		function ReloadData() {
			$("#searchForm").submit();
		}

		function ShowTransfer() {
			if ($("input.flat[type=checkbox][name=customer-cb]:checked").length == 0) {
				$("#customer-list thead tr th:gt(0):lt(11)").show();
				$("#customer-list thead tr th:eq(11)").hide();
			} else {
				$("#customer-list thead tr th:gt(0):lt(11)").hide();
				$("#customer-list thead tr th:eq(11)").show();
			}
		}

		$(function() {
			$("input.flat[type=checkbox]").each(function() {
				$(this).iCheck({
					checkboxClass : 'icheckbox_flat-green',
					radioClass : 'iradio_flat-green'
				});
			});

			$("div.list-page-search-div").on("click", "table.category-table td", function() {
				SearchCustomer()
			});

			$("table.category-table[name=status]").find("td[value=${not empty searchParms.status ? searchParms.status : 0}]").attr("checked", "checked");
			$("table.category-table[name=ceProductId]").find("td[value=${not empty searchParms.ceProductId ? searchParms.ceProductId : 0}]").attr("checked", "checked");

			// 全选按钮
			$("table#customer-list thead tr th ins.iCheck-helper").click(function() {
				$("input.flat[type=checkbox][name=customer-cb]").each(function() {
					if ($("input.flat.checkall").is(":checked")) {
						$(this).iCheck("check");
					} else {
						$(this).iCheck('uncheck');
					}
				});
				
				ShowTransfer();
			});

			// 选择按钮
			$("table#customer-list tbody tr td ins.iCheck-helper").click(function() {
				ShowTransfer();
			});

			$(".show-remarks").click(function() {
				var customerId = $(this).attr("customerid");
				OpenIFrame("跟进结果", "${ ctx }/customer4c/server/track?customerId=" + customerId, 720, 360);
			});

			$("#btn-tranfer").click(function() {
				var customerRelationCheckBox = $("input.flat[type=checkbox][name=customer-cb]:checked");
				if (customerRelationCheckBox.length == 0) {
					AlertMessage("请选择需要移交的客户");
					return;
				}
				
				var customerRelationArray = new Array();
				customerRelationCheckBox.each(function() {
					customerRelationArray.push($(this).val());
				});
				OpenIFrame("您确定将客户分配给下面的客户经理吗？", "${ ctx }/sys/user/userSelect", 640, 500, function() {
					if (GetLayerData("_select_user_id")) {
						var _user_id = GetLayerData("_select_user_id");
						SetLayerData("_select_user_id", null);
						$.ajax({
							url : "${ctx}/customer4c/server/assign",
							async : false,
							cache : false,
							type : "POST",
							data : { "userId": _user_id, "ceCustomerIds": customerRelationArray.join(',') },
							dataType : "json",
							success : function(result) {
								if (result.success) {
									ReloadData();
								} else {
									NotifyInCurrentPage("error", result.msg, "删除机构错误");
								}
							}
						});
					}
				});
			});
		});

		function page(n, s) {
			$("#current").val(n);
			$("#searchForm").submit();
			return false;
		}
	</script>
</body>
</html>