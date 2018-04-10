<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html style="min-width:auto;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

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
<body style="min-width:auto;">

	<div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
		<div class="x_panel">
			<div class="x_content">
				<table style="margin: 0% 0 0 10%; width: 100%">
					<c:forEach items="${ customerTracks }" var="data">
						<tr>
							<td
								style="width: 20%; height: 100px; font-size: 20px; font-weight: 900">跟进客户经理:</td>
							<td style="font-size: 20px;">${ data.ownerName }</td>
						</tr>
						<tr>
							<td style="font-size: 20px; font-weight: 900;">联系结果:</td>
							<td style="font-size: 20px;">${ data.remarks }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<!-- jQuery -->
	<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- Parsley -->
	<script src="${imgStatic }/vendors/parsleyjs-2.6/dist/parsley.min.js"></script>
	<script src="${imgStatic }/vendors/parsleyjs-2.6/dist/i18n/zh_cn.js"></script>

	<!-- Switchery -->
	<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
	<!-- 弹出层 -->
	<script src="${imgStatic }/vendors/layer/layer.js"></script>
	<script src="${imgStatic }/zwy/js/layer-customer.js"></script>

	<script src="${imgStatic }/zwy/js/ajaxfileupload.js"
		type="text/javascript"></script>

</body>
</html>