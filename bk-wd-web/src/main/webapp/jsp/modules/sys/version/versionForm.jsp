<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

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
<!-- Date Range Picker -->
<link
	href="${imgStatic }vendors/bootstrap-daterangepicker/daterangepicker.css"
	rel="stylesheet" />

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
<body>
	<div class="wd-content">
		<div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
			<div class="x_panel">
				<div class="x_content">
					<br />
					<form id="form-add-module" data-parsley-validate
						class="form-horizontal form-label-left" method="post">
						<input type="hidden" name="id" value="${sysVersion.id }">
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="versionName"> 版本代号: <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<input type="text" name="versionName" value="${sysVersion.versionName }" class="form-control col-md-7 col-xs-12">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="versionCode"> 版本编号（整数）: <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<input type="text" name="versionCode" value="${sysVersion.versionCode }" class="form-control col-md-7 col-xs-12">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="versionName"> 发布时间: <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<input type="text" id="versionTime"  name="versionTime" value="${ fns:formatDateTimeCus(sysVersion.versionTime, "yyyy-MM-dd HH:mm") }" class="form-control col-md-7 col-xs-12">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="platform"> 移动平台: <span class="required"></span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<%-- <input type="text"  name="platform" value="${sysVersion.platform }" class="form-control col-md-7 col-xs-12"> --%>
								<select name="platform" class="form-control col-md-7 col-xs-12">
									<option value="Android"
										${ sysVersion.platform eq "Android" ? "selected='seleced'" : "" }>Android</option>
									<option value="iOS"
										${ sysVersion.platform eq "iOS" ? "selected='seleced'" : "" }>iOS</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="action"> 更新方式: <span class="required"></span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<%-- <input type="text" name="action" value="${sysVersion.action }" class="form-control col-md-7 col-xs-12"> --%> 
								<select
									name="action" class="form-control col-md-7 col-xs-12">
									<option value="1"
										${ sysVersion.action eq "1" ? "selected='seleced'" : "" }>强制更新</option>
									<option value="2"
										${ sysVersion.action eq "2" ? "selected='seleced'" : "" }>可选更新</option>
									<option value="3"
										${ sysVersion.action eq "3" ? "selected='seleced'" : "" }>可忽略更新</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12" for="url">
								下载地址: <span class="required"></span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<input type="text" name="url" value="${sysVersion.url }"
									class="form-control col-md-7 col-xs-12">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="features">版本描述:</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<textarea name="features" class="form-control col-md-7 col-xs-12"
									rows="3">${sysVersion.features}</textarea>
							</div>
						</div>
						<div class="ln_solid"></div>
						<div class="form-group">
							<div class="col-md-9 col-sm-9 col-xs-9 col-xs-offset-3">
								<button class="btn btn-primary" type="button"
									onclick="javascript:CloseLayer();">取消</button>
								<button class="btn btn-success" type="button"
									onclick="javascript:save();" id="submit-add-module">确认</button>
							</div>
						</div>
					</form>
				</div>
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
	<!-- Date Range Picker -->
	<script src="${imgStatic }vendors/moment/min/moment.min.js"></script>
	<script src="${imgStatic }vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

	<script src="${imgStatic }/vendors/layer/layer.js"></script>
	<script src="${imgStatic }/zwy/js/layer-customer.js"></script>

	<script>
		
		function save() {
			var postData = decodeURIComponent($("#form-add-module").serialize(), true);
			$.ajax({
				url : "${ ctx }/sys/version/save",
				data : postData,
				type: "post",
				success : function(data) {
					if (data.code == 200) {
						SetLayerData("temp_save_version", true);
						CloseIFrame();
					}
				}
			});
		}
		
		$(document).ready(function() {
			$('#versionTime').daterangepicker({
				minDate: moment().format('YYYY-MM-DD HH:mm'),
				format : 'YYYY-MM-DD HH:mm',
		        singleDatePicker: true,
				timePicker: true,
				timePickerIncrement: 1,
				timePicker24Hour: true,
		        singleClasses: "picker_4",
		        locale: {
		            format: 'YYYY-MM-DD HH:mm',
		            applyLabel: '确认',
		            cancelLabel: '取消',
		            fromLabel: '从',
		            toLabel: '到',
		            weekLabel: 'W',
		            customRangeLabel: 'Custom Range',
		            daysOfWeek: ["日", "一", "二", "三", "四", "五", "六"],
		            monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
		        }
		    }, function (start, end, label) {
		        console.log(start.toISOString(), end.toISOString(), label);
		    });
			
		});
	</script>
</body>
</html>