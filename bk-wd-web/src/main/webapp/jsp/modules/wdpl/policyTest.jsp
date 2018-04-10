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
<link href="${ imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="${ imgStatic }/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- iCheck -->
<link href="${ imgStatic }/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<!-- PNotify -->
<link href="${ imgStatic }/vendors/pnotify/dist/pnotify.css"
	rel="stylesheet">
<link href="${ imgStatic }/vendors/pnotify/dist/pnotify.buttons.css"
	rel="stylesheet">
<link href="${ imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css"
	rel="stylesheet">

<link href="${imgStatic}/zwy/LBQ/css/popup_style.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="${ imgStatic }/build/css/custom.css" rel="stylesheet">

<link href="${ imgStatic }/zwy/css/afterLoanPolicy.css" rel="stylesheet">

<!-- 重要！样式重写! -->
<link href="${ imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>
	<!-- page content -->

	<div id="afterLoanList" class="wd-content">
		<p>
			<b>注意：</b>本页面仅仅作为演示或测试使用！在真实环境中，下方的两个按钮对应的逻辑由系统自动执行的。
		</p>
		<input type="button" class="btn wd-btn-big wd-btn-indigo"
			value="执行回访策略" onclick="javascript:excute1(this);" /> <input
			type="button" class="btn wd-btn-big wd-btn-viridity" value="执行回访策略"
			onclick="javascript:excute2(this);" />
	</div>
	<!-- /page content -->
	<!-- jQuery -->
	<script src="${ imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${ imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- PNotify -->
	<script src="${ imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
	<script src="${ imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
	<script src="${ imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

	<script src="${ imgStatic }/zwy/js/wd-common.js"></script>

	<script src="${ imgStatic }/vendors/layer/layer.js"></script>
	<script src="${ imgStatic }/zwy/js/layer-customer.js"></script>

	<script src="${ imgStatic }/zwy/js/pnotify-customer.js"></script>

	<script type="text/javascript">
		function excute1(obj) {
			$(obj).attr("disabled", "disabled");
			$(obj).removeClass("wd-btn-indigo");
			$(obj).addClass("wd-btn-dead");

			$.ajax({
				url : "${ctx}/wdpl/policy/test/review",
				type : "GET",
				dataType : "json",
				cache : false,
				success : function(result) {
					AlertMessage(result.msg);
				}
			});
		}
		function excute2(obj) {
			$(obj).attr("disabled", "disabled");
			$(obj).removeClass("wd-btn-viridity");
			$(obj).addClass("wd-btn-dead");

			$.ajax({
				url : "${ctx}/wdpl/policy/test/risk",
				type : "GET",
				dataType : "json",
				cache : false,
				success : function(result) {
					AlertMessage(result.msg);
				}
			});
		}
	</script>
</body>
</html>