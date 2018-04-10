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

<title></title>

<!-- Bootstrap -->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">

<!-- iCheck -->
<link href="${imgStatic }/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<!-- PNotify -->
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.css"
	rel="stylesheet">
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css"
	rel="stylesheet">
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

<!-- 重要！样式重写! -->
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<style type="text/css">
table tbody tr td:nth-child(3) {
	text-align: center;
}

table tbody tr td:nth-child(4) {
	text-align: center;
}
</style>

</head>

<body>
	<form action="${ctx}/wd/message/list/mine" id="searchForm" method="GET">
		<input id="current" name="current" type="hidden" value="1" />
	</form>
	<!-- page content -->
	<div class="wd-content">
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<div class="x_title non_bottom_border">
				<h2>通知</h2>
				<!-- <input id="customer-type-id" name="customer-type-id" type="hidden" value="00000000-0000-0000-0000-000000000000" /> -->
				<!-- <input id="customer-type-version" name="customer-type-version" type="hidden" value="" /> -->
				<ul class="nav navbar-right panel_toolbox">
					<li>
                        <shiro:hasPermission name="wd:message:edit">
    						<button type="button"
    							class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle"
    							id="btn-add-message" style="margin-right: 0px;">新增</button>
                        </shiro:hasPermission>
					</li>
				</ul>
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<table class="table table-striped table-bordered wd-table">
					<thead>
						<tr>
							<th>标题</th>
							<th>内容</th>
							<th style="width: 220px">发布时间</th>
							<th style="width: 160px"></th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${pagination.dataList}" var="data">
							<tr messageid="${data.id }">
								<td>${data.title }</td>
								<td>${data.content }</td>
								<td><fmt:formatDate value="${data.messageDate}"
										pattern="yyyy-MM-dd HH:mm" /></td>
								<td><c:if
										test='${ fns:formatDateTime(data.messageDate) gt fns:getDate("yyyy-MM-dd HH:mm:ss") }'>
                                        <shiro:hasPermission name="wd:message:del">
    										<button type="button"
    											class="btn wd-btn-small wd-btn-orange btn-del-message">删除</button>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="wd:configuration:edit">
    										<button type="button"
    											class="btn wd-btn-small wd-btn-gray btn-edit-message">编辑</button>
                                        </shiro:hasPermission>
									</c:if> <c:if
										test='${ fns:formatDateTime(data.messageDate) le fns:getDate("yyyy-MM-dd HH:mm:ss") }'>
										<button type="button"
											class="btn wd-btn-small wd-btn-gray btn-show-message">查看</button>
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="dataTables_wrapper">${pagination}</div>
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

	<!--  <script src="${imgStatic }/zwy/js/wd-common.js"></script> -->

	<script src="${imgStatic }/vendors/layer/layer.js"></script>
	<script src="${imgStatic }/zwy/js/layer-customer.js"></script>

	<script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
	<script type="text/javascript">
		// Hi, boy! look at here! this function need you override!
		// 注意！注意！这个方法要你处理的
		// 写上真是的地址
		var currentPageUrl = {
			delMessage : "${ctx}/wd/message/delete", // 删除产品的地址，参数：message_id，请求方式：GET，返回值：Json，格式{ "result": false, "error": "xxxxxxxxxxxxxxxxxxx" }
			editMessage : "${ctx}/wd/message/edit", // 编辑产品的地址，参数：message_id（无表示新增），请求方式：GET，返回值：Page }
			showMessage : "${ctx}/wd/message/show",
		};

		function ReloadData() {
			location.reload();
		}

		function DelMessage(button) {

			var messageTr = $(button).parents("tr[messageid]");
			var messageId = messageTr.attr("messageid");
			var messageName = messageTr.children("td:eq(1)").html().trim();

			Confirm("是否确认删除该通知？", function() {
				$.ajax({
					url : currentPageUrl.delMessage + "?id=" + messageId,
					type : "GET",
					dataType : "json",
					async : false,
					cache : false,
					success : function(result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
						if (result.success) {
							messageTr.fadeOut(512, function() {
								messageTr.remove();
							});
							//刷新页面，重新载入数据
							//ReloadData();
						} else {
							NotifyError(result.msg, "删除通知时出现一个错误");
						}
					}
				});
			});
		}

		function EditMessage(messageId) {
			OpenBigIFrame("通知", currentPageUrl.editMessage + "?id=" + messageId
					+ "&r=" + Math.random(), function() {
				if (GetLayerData("temp_save_message")) {
					SetLayerData("temp_save_message", null);
					ReloadData();
				}
			});
		}

		function ShowMessage(messageId) {
			OpenFullIFrame("通知", currentPageUrl.showMessage + "?id="
					+ messageId + "&r=" + Math.random());
		}

		$(document).ready(function() {
			// 删除产品
			$(".btn-del-message").click(function() {
				DelMessage(this);
			});

			// 新增产品
			$("#btn-add-message").click(function() {
				EditMessage();
			});

			// 编辑产品
			$(".btn-edit-message").click(function() {
				var messageTr = $(this).parents("tr[messageid]");
				var messageId = messageTr.attr("messageid");

				EditMessage(messageId);
			});

			$(".btn-show-message").click(function() {
				var messageTr = $(this).parents("tr[messageid]");
				var messageId = messageTr.attr("messageid");

				ShowMessage(messageId);
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