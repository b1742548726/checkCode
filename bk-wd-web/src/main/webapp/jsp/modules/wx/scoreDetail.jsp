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
table#customer-list tbody tr td:nth-child(2) {
	text-align: center;
}

table#customer-list tbody tr td:nth-child(3) {
	text-align: center;
}

table#customer-list tbody tr td:nth-child(4) {
	text-align: center;
}

table#customer-list tbody tr td:nth-child(5) {
	text-align: center;
}
</style>
</head>

<body>
	<!-- page content -->
	<div class="wd-content">
		<div class="list-page-search-div col-xs-12">
			<div class="col-xs-2">
				<button type="button" class="btn wd-btn-small wd-btn-gray" id="btn-back" style="margin-right: 0px;" current="${ current }" manager="${ manager }"> 返回 </button>
			</div>
		</div>
		<div class="col-md-6 col-sm-6 col-xs-6">
			<div class="x_content" style="padding: 8px 8px 8px 0px;">
				<span style="font-size:14px;font-weight:600;display:inline-block;margin-bottom:8px;">历史综合排名</span>
				<table class="table table-striped table-bordered wd-table" id="user-list">
					<thead>
						<tr>
							<th>客户经理</th>
							<th>服务均分</th>
							<th>效率均分</th>
							<th>廉洁均分</th>
							<th>综合均分</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ list }" var="data">
							<tr userid="${ data.userId }">
								<td>${ data.userName }</td>
								<td>${ data.scoreService }</td>
								<td>${ data.scoreEfficiency }</td>
								<td>${ data.scoreProbity }</td>
								<td>${ fns:formatNumber((data.scoreService + data.scoreEfficiency + data.scoreProbity) / 3, "0.0") }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="col-md-6 col-sm-6 col-xs-6">
			<div class="x_content" style="padding: 8px 0px 8px 8px;" id="user-detail">
				
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
			$("#user-list tbody").on("click", "tr", function() {
				var userId = $(this).attr("userid");

				$("#user-detail").load("${ctx}/wx/feedback/score/user?userId=" + userId);			
			});
			
			$("#btn-back").click(function() {
				var current = $(this).attr("current");
				var manager = $(this).attr("manager");

				var url = "${ctx}/wx/feedback/score/list";

	            var parames = new Array();
	            parames.push({ name: "current", value: current});
	            parames.push({ name: "manager", value: manager});

	            Post(url, parames);
			});
			
			$("#user-list tbody tr:eq(0)").click();
		});
        function Post(URL, PARAMTERS) {
            //创建form表单
            var temp_form = document.createElement("form");
            temp_form.action = URL;
            //如需打开新窗口，form的target属性要设置为'_blank'
            temp_form.target = "_self";
            temp_form.method = "post";
            temp_form.style.display = "none";
            //添加参数
            for (var item in PARAMTERS) {
                var opt = document.createElement("textarea");
                opt.name = PARAMTERS[item].name;
                opt.value = PARAMTERS[item].value;
                temp_form.appendChild(opt);
            }
            document.body.appendChild(temp_form);
            //提交数据
            temp_form.submit();
        }
	</script>
</body>
</html>