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

        table tbody tr td:nth-child(2) {
            text-align: center;
        }

        table tbody tr td:nth-child(3) {
            text-align: center;
        }

        table tbody tr td:nth-child(4) {
            text-align: center;
        }
        
	</style>

</head>

<body>
	<!-- page content -->
	<div class="wd-content">
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<div class="x_title non_bottom_border">
				<h2>渠道设置</h2>
				<ul class="nav navbar-right panel_toolbox">
					<li>
						<button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-from" style="margin-right: 0px;">新增</button>
					</li>
				</ul>
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<table class="table table-striped table-bordered wd-table">
					<thead>
						<tr>
							<th>渠道名称</th>
							<th style="width: 240px">添加时间</th>
							<th style="width: 160px">渠道推广数</th>
							<th style="width: 160px">二维码</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${ list }" var="data">
							<tr>
								<td>${ data.fromA }</td>
                                <td><fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td>${ data.count }</td>
								<td>
									<button type="button" class="btn wd-btn-small wd-btn-gray"
										fromid="${ data.id }">下载</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%--  <div class="dataTables_wrapper">${pagination}</div> --%>
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
			editFrom : "${ctx}/customerEntrance//form"
		};

		function ReloadData() {
			location.reload();
		}

		function EditFrom() {
			OpenSmallIFrame("新增渠道", currentPageUrl.editFrom + "?r="
					+ Math.random(), function() {
				if (GetLayerData("_save_ce_from")) {
					SetLayerData("_save_ce_from", null);
					ReloadData();
				}
			});
		}

		$(document).ready(function() {

			// 新增产品
			$("#btn-add-from").click(function() {
				EditFrom();
			});

			$(".btn[fromid]").click(function() {
				var fromid = $(this).attr("fromid");
				window.open("${ctx}/customerEntrance//DRCode?id=" + fromid);
			});

		});
	</script>
</body>
</html>