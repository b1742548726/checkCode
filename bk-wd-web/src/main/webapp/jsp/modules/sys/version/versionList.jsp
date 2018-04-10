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
    <title>字典管理</title>
    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
	<!-- Date Range Picker -->
	<link href="${imgStatic }vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" />
    
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>
	<div class="wd-content">
        <form:form id="searchForm" modelAttribute="sysDict" action="${ctx}/sys/version/" method="get">
            <input id="pgCurrent" name="current" type="hidden" value="1" />
            <input type="hidden" name="platform" for="status" value="${sysVersion.platform }" />
        </form:form>
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<div class="x_title">
				<h2>版本管理</h2>

				<ul class="nav navbar-right panel_toolbox">
					<li>
						<button type="button"
							class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle"
							id="btn-add-item">新增</button>
					</li>
				</ul>

				<div class="list-page-search-div col-md-2 pull-right">
					<!-- 右边搜索条件 -->
					<div>
						<table class="category-table" name="status">
							<tbody>
								<tr>
									<td style="width: 50%" value="iOS"
										${ sysVersion.platform eq 'iOS' ? 'checked="checked"' : '' }>iOS</td>
									<td style="width: 50%" value="android"
										${ sysVersion.platform eq 'android' ? 'checked="checked"' : '' }>Android</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<%-- <ul class="nav navbar-right panel_toolbox" role="tablist">
					<li class="${sysVersion.platform eq 'iOS' ? 'active' : ''}"><a
						href="${ctx}/sys/version?platform=iOS">iOS</a></li>
					<li class="${sysVersion.platform eq 'android' ? 'active' : ''}">
						<a href="${ctx}/sys/version?platform=android">android</a>
					</li>
				</ul> --%>

				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<table id="treeTable"
					class="wd-table table table-striped table-bordered">
					<colgroup>
						<col style="width: 180px;" />
						<col style="width: 160px;" />
						<col style="width: 220px;" />
						<col style="width: auto;" />
						<col style="width: 160px;" />
					</colgroup>
					<thead>
						<tr>
							<th>版本编号</th>
							<th>版本代号</th>
							<th>更新方式</th>
							<th>发版时间</th>
							<th>版本描述</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pagination.dataList}" var="data"
							varStatus="status">
							<tr>
								<td>${data.versionCode}</td>
								<td>${data.versionName}</td>
								<td>${fns:getDictLabel(data.action, 'SYS_VERSION_ACTION', '')}</td>
								<td><fmt:formatDate value="${data.versionTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td>${data.features}</td>
								<td class="cursor-default">
									<button type="button"
										class="btn wd-btn-small wd-btn-indigo btn-edit-list"
										data-id="${data.id}">编辑</button>
									<button type="button"
										class="btn wd-btn-small wd-btn-orange btn-del-list"
										data-id="${data.id}">删除</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="dataTables_wrapper">${pagination}</div>
			</div>
		</div>
	</div>
	<!-- jQuery -->
	<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- 弹出层 -->
	<script src="${imgStatic }/vendors/layer/layer.js"></script>
	<script src="${imgStatic }/zwy/js/layer-customer.js"></script>

	<!-- Parsley -->
	<script src="${imgStatic }/vendors/parsleyjs-2.6/dist/parsley.min.js"></script>
	<script src="${imgStatic }/vendors/parsleyjs-2.6/dist/i18n/zh_cn.js"></script>

	<!-- PNotify -->
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>
	<script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
	<!-- Date Range Picker -->
	<script src="${imgStatic }vendors/moment/min/moment.min.js"></script>
	<script src="${imgStatic }vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

	<script type="text/javascript">
		function page(n, s) {
			$("#pgCurrent").val(n);
			$("#searchForm").submit();
			return false;
		}
		
		function ReloadData() {
			//alert(1);
			location.reload();
		}
		
		//新增
		$(document).on("click", "#btn-add-item", function() {

			OpenBigIFrame("新增", "${ctx}/sys/version/form", function() {
				if (GetLayerData("temp_save_version")) {
					SetLayerData("temp_save_version", null);
					ReloadData();
				}
			});
			
			//$.get("${ctx}/sys/version/form", null, function(data) {
			//	OpenLayer("新增", data, 720, 540);
			//})
		});
		//编辑
		$(document).on("click", ".btn-edit-list", function() {

			OpenBigIFrame("编辑", "${ctx}/sys/version/form?id=" + $(this).data("id"), function() {
				if (GetLayerData("temp_save_version")) {
					SetLayerData("temp_save_version", null);
					ReloadData();
				}
			});
			
			//$.get("${ctx}/sys/version/form", { id : $(this).data("id") }, function(data) {
			//	OpenLayer("编辑", data, 720, 540);
			//})
		});
		//刪除
		$(document).on("click", ".btn-del-list", function() {

			var versiontTr = $(this).parents("tr");
			var versionId = $(this).data("id");

			Confirm("是否确认删除该版本？", function() {
				$.ajax({
					url : "${ctx}/sys/version/delete?id=" + versionId,
					type : "DELETE",
					dataType : "json",
					async : false,
					cache : false,
					success : function(result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
						if (result.success) {
							versiontTr.fadeOut(512, function() {
								versiontTr.remove();
							});

							//刷新页面，重新载入数据
							//ReloadData();
						} else {
							NotifyError(result.msg, "删除版本时出现一个错误");
						}
					}
				});
			});

		});

		$("div.list-page-search-div").on("click", "table.category-table td", function() {
			var platform = $(this).attr("value");
			var url = "${ctx}/sys/version?platform=" + platform;
			window.location.href = url;
		});
	</script>
</body>
</html>