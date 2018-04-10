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
				<h2>客户类型设置</h2>
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
							<th>编号</th>
							<th style="width: 480px">描述</th>
							<th>图片URL</th>
							<th style="width: 100px">是否启用</th>
							<th style="width: 200px"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pagination.dataList}" var="data">
							<tr data-id="${data.id }">
								<td>${data.name }</td>
								<td>${data.code }</td>
								<td>${data.remarks }</td>
								<td>${data.img }</td>
								<td><input data-id="${data.id }" type="checkbox"
									${data.enable eq '1' ? 'checked': ''} class="js-switch" /></td>
								<td>
									<button type="button"
										class="btn wd-btn-small wd-btn-indigo btn-edit-list"
										data-id="${data.id }">编辑</button>
									<button type="button"
										class="btn wd-btn-small btn-dark btn-add-child—item"
										data-id="${data.id }">设置个人信息</button>
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
			//switch初始化
			if ($(".js-switch")[0]) {
				var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not([data-switchery])'));

				elems.forEach(function(dom, index) {
					var switchery = new Switchery(dom, {
						color : '#26B99A'
					});
					dom.onchange = function() {
						var enable = dom.checked ? 1 : 0;
						var id = $(dom).data("id");
						$.ajax({
							url : "${ctx }/wd/customerType/save",
							data : {
								id : id,
								enable : enable
							},
							type : "post",
							success : function(data) {
								if (data.code == 200) {
								}
							}
						});
					};
				});
			}

			//新增模块
			$(document).on("click", "#btn-add-element", function() {
				OpenIFrame("新增", "${ctx}/wd/customerType/form", 1000, 460, function() {
					if (GetLayerData("_save_customerType_module_data")) {
						SetLayerData("_save_customerType_module_data", null);
						location.reload();
					}
				});
			});
			//编辑
			$(document).on("click", ".btn-edit-list", function() {
				OpenIFrame("编辑", "${ctx}/wd/customerType/form?id=" + $(this).data("id"), 1000, 460, function() {
					if (GetLayerData("_save_customerType_module_data")) {
						SetLayerData("_save_customerType_module_data", null);
						location.reload();
					}
				});
			});

			//设置个人信息
			$(document).on("click", ".btn-add-child—item", function() {
				OpenIFrame("新增", "${ctx}/wd/customerType/settingForm?id=" + $(this).data("id"), 1300, 660);
			});

			//排序拖动时的样式
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
				var ids = "";
				$("#datatable tbody tr").each(function(dom, index) {
					ids += $(this).data("id") + ",";
				})

				$.ajax({
					url : "${ctx }/wd/customerType/sorts",
					data : {
						ids : ids
					},
					type : "post",
					success : function(data) {
						if (data.code == 200) {
						}
					}
				});
			};

			$("#datatable tbody").sortable({
				helper : fixHelperModified,
				stop : updateIndex
			}).disableSelection();
		});
	</script>
</body>
</html>