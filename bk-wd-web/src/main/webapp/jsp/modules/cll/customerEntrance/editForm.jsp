<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html style="min-width: auto;">
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
<style type="text/css">
ul.parsley-errors-list {
	position: absolute;
	top: .5em;
	right: -3em;
}
</style>
</head>
<body style="min-width: auto;">

	<div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
		<div class="x_panel">
			<div class="x_content">
				<br />
				<form id="form-add-module" data-parsley-validate
					class="form-horizontal form-label-left"
					action="${ctx }/customerEntrance/form" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="companyId" id="companyId" value="${ from.companyId }">
					<div class="form-group" style="margin-top:20px">
						<label class="control-label col-xs-2 col-xs-offset-1" for="fromA"> 渠道名称 </label>
						<div class="col-xs-8">
							<input type="text" id="fromA" name="fromA" value="${ from.fromA }" required="required" class="form-control col-xs-10" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-10 col-xs-offset-1">
							<span style="color: red; font-size: 12px;"> * 渠道名称一旦确定无法修改 </span>
						</div>
					</div>

					<div class="form-group" style="margin-top:50px">
						<div class="col-md-9 col-sm-9 col-xs-9 col-xs-offset-3">
							<button class="btn btn-primary" type="button" onclick="javascript:CloseIFrame();">取消</button>
							<button class="btn btn-success" type="button" onclick="javascript:save();">确认</button>
						</div>
					</div>
				</form>
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
	<!-- <script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script> -->
	<!-- 弹出层 -->
	<script src="${imgStatic }/vendors/layer/layer.js"></script>
	<script src="${imgStatic }/zwy/js/layer-customer.js"></script>

	<script src="${imgStatic }/zwy/js/ajaxfileupload.js"
		type="text/javascript"></script>

	<script>
		function save() {
			var $form = $('#form-add-module');
            var formParsley = $form.parsley();
            if (!formParsley.validate()) {
				return;
            }
			
			SetLayerData("_save_ce_from", true);
			$("#form-add-module").submit();
			CloseIFrame();
		}
	</script>
</body>
</html>