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
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">

				<div class="x_content">
					<br />
					<form id="form-add-select" data-parsley-validate
						class="form-horizontal form-label-left">
						<input type="hidden" id="hidden-itemId" name="id"
							value="${ message.id }">
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="title"> 标题 <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<input type="text" id="title" required="required" name="title" value="${ message.title }" class="form-control col-md-7 col-xs-12" max-length="100" maxlength="100">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="selectCode"> 发布时间 <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<input type="text" id="messageDate" name="messageDate" value="${ fns:formatDateTimeCus(message.messageDate, "yyyy-MM-dd HH:mm") }" class="form-control col-md-7 col-xs-12" value="20000">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="content"> 内容 <span class="required">*</span></label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<textarea id="content" required="required" name="content" class="form-control col-md-7 col-xs-12" rows="12" max-length="1000" maxlength="1000"> ${ message.content }</textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-xs-12 wd-center">
				<button class="btn wd-btn-normal wd-btn-width-middle wd-btn-white"
					type="button" id="cancle-add-select">取消</button>
				<button
					class="btn wd-btn-normal wd-btn-width-middle wd-btn-viridity"
					type="submit" id="submit-add-select">确认</button>
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

	<script type="text/javascript">
	
		$(document).ready(function() {
			
			$('#messageDate').daterangepicker({
				//startDate: moment().format('YYYY-MM-DD HH:mm'),
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

			$("#cancle-add-select").click(function(event) {
				SetLayerData("temp_save_message", null);
				CloseIFrame();
			});

			$("#submit-add-select").click(function(event) {
				event.preventDefault();

				var formParsley = $('#form-add-select').parsley();
				if (formParsley.validate()) {

					var postData = $("#form-add-select").serialize();
					$.ajax({
						url : "${ctx}/wd/message/save",
						async : true,
						cache : false,
						data : postData,
						dataType : "json",
						type : "POST",
						success : function(data) {
							if (data.success) {
								SetLayerData("temp_save_message", true);
								CloseIFrame();
							} else {
								AlertMessage(data.msg);
							}
						}
					})
				}
			});

		});
	</script>
</body>
</html>