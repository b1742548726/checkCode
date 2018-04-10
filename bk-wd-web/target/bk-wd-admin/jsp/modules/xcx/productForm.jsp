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
<body>

	<div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
		<div class="x_panel">
			<div class="x_content">
				<br />
                <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" action="${ctx }/customer4c/product/form" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" id="id" value="${ product.id }">
					<input type="hidden" name="belongCompanyId" id="belongCompanyId" value="${ product.belongCompanyId }">
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
							名称
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<input type="text" id="name" name="name" value="${ product.name }" required="required" class="form-control col-md-7 col-xs-12" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="title">
							标语
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<input type="text" name="title" id="title" value="${ product.title }" required="required" class="form-control col-md-7 col-xs-12" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="hotline">
							客服电话
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<input type="text" name="hotline" id="hotline"value="${ product.hotline }" required="required" class="form-control col-md-7 col-xs-12" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="remarks">
							产品描述
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<textarea name="remarks" id="remarks" class="form-control col-md-7 col-xs-12" rows="3">${ product.remarks}</textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="loanTerm">
							贷款期限范围
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<input type="text" id="loanTerm" name="loanTerm" value="${ product.loanTerm }" required="required" class="form-control col-md-7 col-xs-12" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="loanRat">
							贷款利率范围
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<input type="text" id="loanRat" name="loanRat" value="${ product.loanRat }" required="required" class="form-control col-md-7 col-xs-12" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="loanAmount">
							贷款金额范围
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<input type="text" id="loanAmount" name="loanAmount" value="${ product.loanAmount }" required="required" class="form-control col-md-7 col-xs-12" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="applyCondition">
							申请条件
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<textarea name="applyCondition" id="applyCondition" class="form-control col-md-7 col-xs-12" rows="3">${ product.applyCondition}</textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="applyMaterial">
							所需材料
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<textarea name="applyMaterial" id="applyMaterial" class="form-control col-md-7 col-xs-12" rows="3">${ product.applyMaterial}</textarea>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12"for="imgFile">
							产品背景图
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
                            <c:choose>
                                <c:when test="${not empty fns:choiceImgUrl('420x1095', product.backgroundUrl)}">
                                    <img class="preview" style="width: 365px;height: 140px; float: left;    cursor: pointer;" data-original="${imagesStatic }${product.backgroundUrl}" src="${imagesStatic }${fns:choiceImgUrl('420x1095',  product.backgroundUrl)}">
                                </c:when>
                                <c:otherwise>
                                    <img class="preview" style="width: 365px;height: 140px; float: left;    cursor: pointer;" src="${defaultPic}">
                                </c:otherwise>
                            </c:choose>
                            <span style="float: left;padding-left: 1.5em;font-size: 12px;color: #aaaaaa;">图片尺寸必须为420x1095</span>
                            <input type="file" name="backgroundImg" style="display: none;" onchange="javascript:showPreview(this);">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12"for="logoUrl">
							LOGO
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
                            <c:choose>
                                <c:when test="${not empty fns:choiceImgUrl('108x300', product.logoUrl)}">
                                    <img class="preview" style="width: 100px;height: 36px;float: left;    cursor: pointer;" data-original="${imagesStatic }${product.logoUrl}" src="${imagesStatic }${fns:choiceImgUrl('108x300',  product.logoUrl)}">
                                </c:when>
                                <c:otherwise>
                                    <img class="preview" style="width: 100px;height: 36px;float: left;    cursor: pointer;" src="${defaultPic}">
                                </c:otherwise>
                            </c:choose>
                            <span style="float: left;padding-left: 1.5em;font-size: 12px;color: #aaaaaa;">图片尺寸必须为108x300</span>
                            <input type="file" name="logoImg" style="display: none;" onchange="javascript:showPreview(this);">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="loanTerm">
							页面标题
						</label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<input type="text" id="titile" name="titile" value="${ product.titile }" class="form-control col-md-7 col-xs-12" />
						</div>
					</div>

					<div class="ln_solid"></div>
					<div class="form-group">
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

	<script src="${imgStatic }/zwy/js/ajaxfileupload.js" type="text/javascript"></script>

	<script>
		$(function() {

			$(".picDel").click(function(event) {
				event.preventDefault();
				
				$(this).hide();
				
				$("#picImg").hide();
				$("#imgFile").show();
			});

			$(".picDel2").click(function(event) {
				event.preventDefault();
				
				$(this).hide();
				
				$("#picImg2").hide();
				$("#imgFile2").show();
			});
			
			$(".preview").on("click", function(){
				$(this).siblings(":input[type=file]").trigger("click");
			})
		});
/* 
		function uploadFile(imgType) {
			var fileId = "imgFile";
			if(imgType == "logo") {
				fileId = "imgFile2";
			}
			
			console.log(fileId);
			
			StartLoad();
			$.ajaxFileUpload({
				url : "${ctx }/customer4c/product/uploadImg?t=" + Math.random() + "&id=" + $("#id").val() + "&imgType=" + imgType,
				type : "POST",
				secureuri : false, //一般设置为false
				fileElementId : fileId, // 文件选择框的id属性 
				dataType : 'json', // 服务器返回的格式，可以是json 
				success : function(data) {
					if (data.success) {
						$("#id").val(data.msg);
					} else {
						alert(data.msg);
					}
				},
				error : function(data, status) {// 相当于java中try语句块的用法 
				},
				complete : function() {
					FinishLoad();
				}
			});
		} */
		function showPreview(source) {
			var _img = $(source).siblings("img");
			if (!source.value) {
				return false;
			}
			if(!/\.(jpg|jpeg|png|JPG|PNG|JPEG|ico|ICO)$/.test(source.value)) {
			  source.outerHTML=source.outerHTML; 
		      alertx("图片类型必须是,jpeg,jpg,png中的一种");
		      return false;
		    }
			
			var file = source.files[0];
			if(source.files[0].size/1024/1024 > 1) {
				$(source).val("");
				alert("图片太大");
				return false;
			}
			if(window.FileReader) {
				var fr = new FileReader(); 
				fr.onloadend = function(e) {
					_img.attr("src", e.target.result);
					_img.data("original", e.target.result);
					_img.siblings("div.pic_handle").show();
				};
				fr.readAsDataURL(file);
			}else{
				alert("您的浏览器不支持FileReader，图片无法预览！");
			}
		}

		function save() {
			var $form = $('#form-add-module');
            var formParsley = $form.parsley();
            if (!formParsley.validate()) {
				return;
            }
            
			SetLayerData("_save_ce_product", true);
			$("#form-add-module").submit();
			CloseIFrame();
		}
	</script>
</body>
</html>