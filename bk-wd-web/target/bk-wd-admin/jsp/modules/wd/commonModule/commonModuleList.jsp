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
<!-- Switchery -->
<link href="${imgStatic }/vendors/switchery/dist/switchery.min.css"
	rel="stylesheet">
<!-- Custom Theme Style -->
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

<!-- 重要！样式重写! -->
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>
	<div class="wd-content">
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<div class="x_title">
				<h2>其他配置</h2>
				<ul class="nav navbar-right panel_toolbox">
					<li>
						<button type="button"
							class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle"
							id="btn-add-element">新增</button>
					</li>
				</ul>
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<table id="datatable"
					class="wd-table table table-striped table-bordered">
					<thead>
						<tr>
							<th>名称</th>
							<!--  <th>描述</th> -->
							<th style="width: 200px">最后更新时间</th>
							<th style="width: 160px"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pagination.dataList}" var="data">
							<tr data-id="${data.id }">
								<td>${data.moduleName }</td>
								<%--  <td>${data.remarks }</td> --%>
								<td><fmt:formatDate value="${data.updateDate}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td>
									<button type="button"
										class="btn wd-btn-small wd-btn-indigo btn-edit-list"
										data-id="${data.id }">编辑</button>
									<button type="button"
										class="btn wd-btn-small btn-dark btn-add-child—item"
										data-id="${data.id }">设置</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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

	<!-- Switchery -->
	<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
	<!-- jquery ui -->
	<script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>

	<script>
		$(function() {
			//新增模块
			$(document).on("click", "#btn-add-element", function() {
				$.get("${ctx}/wd/commonModule/form", null, function(data) {
					OpenBigLayer("新增", data, function (){
                    	if (GetLayerData("_save_common_module_data")) {
            				SetLayerData("_save_common_module_data", null);
            				location.reload();
            			}
                    });
				})
			});
			//编辑
			$(document).on("click", ".btn-edit-list", function() {
				$.get("${ctx}/wd/commonModule/form", {
					id : $(this).data("id")
				}, function(data) {
					OpenBigLayer("编辑", data, function (){
                    	if (GetLayerData("_save_common_module_data")) {
            				SetLayerData("_save_common_module_data", null);
            				location.reload();
            			}
                    });
				})
			});

			//设置个人信息
			$(document).on(
					"click",
					".btn-add-child—item",
					function() {
						OpenIFrame("新增",
								"${ctx}/wd/commonModule/settingForm?id="
										+ $(this).data("id"), 1300, 660);
					});
		})
	</script>
</body>
</html>