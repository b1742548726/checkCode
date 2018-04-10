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
			<div class="x_content">
				<table class="table table-striped table-bordered wd-table"
					id="merge-list">
					<colgroup>
						<col style="width: 256px" />
						<col style="width: auto" />
						<col style="width: auto" />
						<col style="width: auto" />
						<col style="width: 100px" />
					</colgroup>
					<thead>
						<tr>
							<th>身份证号</th>
							<th>客户姓名</th>
							<th>客户电话</th>
							<th>客户经理</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ result }" var="data">
							<tr name="${ data.idNo }">
								<td rowspan="${ data.customers.size() }">${ data.idNo }</td>
								<td>${ data.customers.get(0).name }</td>
								<td>${ data.customers.get(0).phone }</td>
								<td>${ data.customers.get(0).userName }</td>
								<td>
									<button type="button" name="${ data.idNo }"
										class="btn wd-btn-small wd-btn-orange"
										user-id="${ data.customers.get(0).userId }"
										person-id="${ data.customers.get(0).personId }">交给他</button>
								</td>
							</tr>
							<c:forEach items="${ data.customers }" begin="1" var="customer">
								<tr name="${ data.idNo }">
									<td>${ customer.name }</td>
									<td>${ customer.phone }</td>
									<td>${ customer.userName }</td>
									<td>
										<button type="button" name="${ data.idNo }"
											class="btn wd-btn-small wd-btn-orange"
											user-id="${ customer.userId }"
											person-id="${ customer.personId }">交给他</button>
									</td>
								</tr>
							</c:forEach>

							<tr name="${ data.idNo }">
								<td colspan="5" style="background-color: #dce8f4;"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
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
		$(function() {
			$("button[name][user-id][person-id]").click(function() {
				var trName = $(this).attr("name");
				var personId = $(this).attr("person-id");
				var userId = $(this).attr("user-id");
				
				$.ajax({
					url : "${ctx}/wd/customer/merge",
					async : false,
					cache : false,
					type : "POST",
					data : { "userId": userId, "personId": personId },
					dataType : "json",
					success : function(result) {
						if (result.success) {
                            $("tr[name="+trName+"]").fadeOut(512, function () {
                                productTr.remove();
                            });
						} else {
							NotifyInCurrentPage("error", result.msg, "删除机构错误");
						}
					}
				});
			});
		});
	</script>
</body>
</html>