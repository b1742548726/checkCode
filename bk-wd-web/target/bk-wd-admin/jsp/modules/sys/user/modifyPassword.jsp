<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>


	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Gentelella Alela! | </title>

	<!-- Bootstrap -->
	<link href="${imgStatic}vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Font Awesome -->
	<link href="${imgStatic}vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">

	<!-- Custom Theme Style -->
	<link href="${imgStatic}build/css/custom.css" rel="stylesheet">

	<!-- 重要！样式重写! -->
	<link href="${imgStatic}zwy/css/custom-override.css" rel="stylesheet">
	<link href="${imgStatic}zwy/LBQ/css/warning.css" rel="stylesheet">
	
	<style type="text/css">
		html, body {
			min-width:600px;
		}
	</style>
</head>
<body>

	<div class="wd-content">
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_content">
					<form id="mdyPassword" data-parsley-validate class="form-horizontal form-label-left">
                        <input type="hidden" name="_csrf" value="${_csrf }">
						<div class="form-group">
							<label class="control-label col-xs-2" for="moduleName">
								当前的密码 <span class="required"></span>
							</label>
							<div class="col-xs-9">
								<input type="password" id="oldPassword" name="oldPassword" required="required" class="form-control col-md-8 col-xs-12" />
								<div class="warning hide">
									<ins class="import"></ins>
									<span class="hide"><i>不能为空</i></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-xs-2" for="moduleCode">
								新&emsp;密&emsp;码 <span class="required"></span>
							</label>
							<div class="col-xs-9">
								<input type="password" id="newPassword" name="newPassword" required="required" class="form-control col-md-8col-xs-12" />
								<div class="warning hide">
									<ins class="import"></ins>
									<span class="hide"><i>不能为空</i></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-xs-2" for="moduleCode">
								确认新密码 <span class="required"></span>
							</label>
							<div class="col-xs-9">
								<input type="password" id="newPassword2" name="newPassword2" required="required" class="form-control col-md-8col-xs-12" />
								<div class="warning hide">
									<ins class="import"></ins>
									<span class="hide"><i>不能为空</i></span>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-xs-12 wd-center">
				<button class="btn wd-btn-normal wd-btn-width-middle wd-btn-white" type="button" id="btn-cancle">取消</button>
				<button class="btn wd-btn-normal wd-btn-width-middle wd-btn-viridity" type="submit" id="btn-submit">确认</button>
			</div>
		</div>
	</div>

	<!-- jQuery -->
	<script src="${imgStatic}vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${imgStatic}vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- Parsley -->
	<script src="${imgStatic}vendors/parsleyjs-2.6/dist/parsley.min.js"></script>
	<script src="${imgStatic}vendors/parsleyjs-2.6/dist/i18n/zh_cn.js"></script>

	<!-- Layer -->
	<script src="${imgStatic}vendors/layer/layer.js"></script>
	<script src="${imgStatic}zwy/js/layer-customer.js"></script>

	<script type="text/javascript">
	
		function setErrorMessage(obj, message) {
			
			$(obj).addClass('error');
			$(obj).next().removeClass('hide');
			$(obj).next().find("i").html(message);
		}
		
		function validateInputRequired(obj) {
			if($(obj).is("[required]") && $(obj).val() == "") {
				$(obj).addClass('error');
				$(obj).next().removeClass('hide');
				$(obj).next().find("i").html("必填项不能为空");
				
				return false;
			} else {
				$(obj).removeClass('error');
				$(obj).next().addClass('hide');
				
				return true;
			}
		}
			
		$(document).ready(function () {
			
			$("input[required]").blur(function(){
				validateInputRequired(this);
			});
			
			$('.warning ins').hover(function(e) {
				$(this).siblings('span').removeClass('hide');
			}, function(){
				$(this).siblings('span').addClass('hide');
			});
			
			$("#btn-cancle").click(function (event) {
				CloseIFrame();
			});

			$("#btn-submit").click(function (event) {
				event.preventDefault();

				var _form = $('#mdyPassword').find('input');
				var submit_able = true;
				_form.each(function(){
					if(!validateInputRequired(this)) {
						submit_able = false;
					}
				});
				
				if(submit_able) {
					$.ajax({
						url: '${ctx}/sys/user/modifyPwd',
						async: false,
						cache: false,
						type: "POST",
						dataType: "json",
						data: $('#mdyPassword').serialize(),
						success: function (result) {
							if (result.result) {
								CloseIFrame();
							} else if(result.para) {
								var p = $("#" + result.para);
								setErrorMessage(p, result.message);
							}
						}
					});
				}
				//var formParsley = $('#form-add-module').parsley();
				// if (formParsley.validate()) {
				//	 //ajax提交数据，在ajax的成功方法中添加下面语句
				//	 CloseIFrame();
				// }
			});
		});
		
	</script>
	
</body>
</html>