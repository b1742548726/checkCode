<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<c:set var="xpsPic" value="${imgStatic }/zwy/img/XPS.png"/>
<c:set var="addDefault" value="${imgStatic }/zwy/img/default_add.png"/>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>全局</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<!-- Switchery -->
<link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
<!-- Custom Theme Style -->
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

<!-- 重要！样式重写! -->
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
<link href="${imgStatic}zwy/LBQ/css/warning.css" rel="stylesheet">
<style type="text/css">
div.pic_handle {
    position: absolute;bottom: 0em;left: .7em;width: 120px;padding: .2em 1em; height: 22px; background-color: rgba(0, 0, 0, 0.5);
}
img.preview {
    float: left;width: 120px; height: 90px;
}
</style>
</head>

<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-9 col-sm-9 col-xs-9">
            <div class="x_title">
                <h2> 系统设置 </h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-save-module">保存配置</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="col-md-9 col-sm-9 col-xs-9">
    			<div class="x_panel">
    				<div class="x_content">
    					<form id="globalSettingForm" data-parsley-validate class="form-horizontal form-label-left" action="${ctx }/sys/globalSetting/save" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${sysGlobalSetting.id }"/>
    						<div class="form-group">
    							<label class="control-label col-xs-2" for="systemName">
    								系统名称 <span class="required"></span>
    							</label>
    							<div class="col-xs-6">
    								<input type="text" name="systemName" value="${sysGlobalSetting.systemName }" required="required" class="form-control col-md-4 col-xs-6" />
    								<div class="warning hide">
    									<ins class="import"></ins>
    									<span class="hide"><i>不能为空</i></span>
    								</div>
    							</div>
    						</div>
                            <div class="form-group">
                                <label class="control-label col-xs-2" for="moduleName">
                                                                 系统ICO <span class="required"></span>
                                </label>
                                <div class="col-xs-9" style="padding-top: 8px;">
                                    <c:choose>
                                        <c:when test="${not empty sysGlobalSetting.systemIco}">
                                            <img class="preview" style="width: 32px;height: 32px;" data-original="${imagesStatic }${sysGlobalSetting.systemIco}" src="${imagesStatic }${sysGlobalSetting.systemIco}">
                                        </c:when>
                                        <c:otherwise>
                                            <img class="preview" style="width: 32px;height: 32px;" src="${defaultPic}">
                                        </c:otherwise>
                                    </c:choose>
                                    <span style="float: left;padding-left: 1.5em;font-size: 12px;color: #aaaaaa;">必须是ICO图标</span>
                                    <input type="file" name="systemIcoFile" style="display: none;">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-xs-2" for="moduleName">
                                                                 系统LOGO <span class="required"></span>
                                </label>
                                <div class="col-xs-9" style="padding-top: 8px;">
                                    <c:choose>
                                        <c:when test="${not empty sysGlobalSetting.systemLogo}">
                                            <img class="preview" data-original="${imagesStatic }${sysGlobalSetting.systemLogo}" src="${imagesStatic }${fns:choiceImgUrl('320X200', sysGlobalSetting.systemLogo)}">
                                        </c:when>
                                        <c:otherwise>
                                            <img class="preview" src="${defaultPic}">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="pic_handle" style="display: none;">
                                        <span class="pic-view" style="cursor:pointer;color: #bbbbbb;">查看</span>
                                        <span class="pic-replace" style="cursor:pointer;color: #bbbbbb; padding-left: 1.6em;">替换</span>
                                    </div>
                                    <span style="float: left;padding-left: 1.5em;font-size: 12px;color: #aaaaaa;">图片尺寸比例必须为8:5</span>
                                    <input type="file" name="systemLogoFile" style="display: none;">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-xs-2" for="moduleName">
                                                                 登录页背景 <span class="required"></span>
                                </label>
                                <div class="col-xs-9" style="padding-top: 8px;">
                                    <c:choose>
                                        <c:when test="${not empty sysGlobalSetting.loginPhoto}">
                                            <img class="preview" data-original="${imagesStatic }${sysGlobalSetting.loginPhoto}" src="${imagesStatic }${fns:choiceImgUrl('400X300', sysGlobalSetting.loginPhoto)}">
                                        </c:when>
                                        <c:otherwise>
                                            <img class="preview" src="${defaultPic}">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="pic_handle" style="display: none;">
                                        <span class="pic-view" style="cursor:pointer;color: #bbbbbb;">查看</span>
                                        <span class="pic-replace" style="cursor:pointer;color: #bbbbbb; padding-left: 1.6em;">替换</span>
                                    </div>
                                    <span style="float: left;padding-left: 1.5em;font-size: 12px;color: #aaaaaa;">图片尺寸必须为4:3</span>
                                    <input type="file" name="loginPhotoFile" style="display: none;">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-xs-2" for="versoinNo">
                                     PC版本号 <span class="required"></span>
                                </label>
                                <div class="col-xs-4">
    								<input type="text" name="versoinNo" required="required" value="${sysGlobalSetting.versoinNo }" class="form-control col-md-4 col-xs-6" />
    								<div class="warning hide">
    									<ins class="import"></ins>
    									<span class="hide"><i>不能为空</i></span>
    								</div>
    							</div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-xs-2" for="app_lock_time">APP锁定时长（秒）<span class="required"></span></label>
                                <div class="col-xs-4">
                                    <input type="text" name="appLockTime" required="required" value="${sysGlobalSetting.appLockTime }" class="form-control col-md-4 col-xs-6" />
                                    <div class="warning hide">
                                        <ins class="import"></ins>
                                        <span class="hide"><i>不能为空</i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="hasTimeWatermark">
                                                               图片是否带水印<span class="required"></span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12" style="padding-top: 8px;">
                                    <input type="checkbox" ${sysGlobalSetting.hasTimeWatermark eq '1' ? 'checked': ''} for="hasTimeWatermark" class="js-switch" />
                                    <input type="hidden" name="hasTimeWatermark" value="${sysGlobalSetting.hasTimeWatermark}" />
                                </div>
                            </div>
    					</form>
    				</div>
    			</div>
    		</div>
        </div>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<!-- PNotify -->
<script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
<script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
<script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

<!-- Switchery -->
<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>

<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>

<script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
<script>

/*
 * 图片上传
 * ------------------------------------------------------------------
 */
$(function(){
	if ($(".js-switch")[0]) {
        var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
        elems.forEach(function (html) {
            html.onchange = function() {
				var checked = html.checked ? 1 : 0;
				var name = $(html).attr("for");
				$("[name="+name+"]").val(checked);
			};
        });
    }
	
	$("#globalSettingForm img").each(function(){
		if ($(this).data("original")) {
			$(this).siblings("div.pic_handle").show();
		}
	});
	
	$("#globalSettingForm img").on("click", function(){
		$(this).siblings(":input[type=file]").trigger("click");
	});
	
	$("#globalSettingForm :input[type=file]").on("change", function(){
		showPreview(this);
	})
	
	$("#globalSettingForm .pic-view").on("click", function(){
		var _li  =$("<li></li>");
		_li.append($(this).parent().siblings("img").clone());
		picPreview(_li, 0);
	});
	$("#globalSettingForm .pic-replace").on("click", function(){
		$(this).parent().siblings(":input[type=file]").trigger("click");
	});
	
	$("#btn-save-module").on("click", function() {
		$("#globalSettingForm").submit();
	}); 
	
});


function showPreview(source) {
	_img = $(source).siblings("img");
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

function picPreview(_html, _index) {
	var parentId = $(parent.window.document).find('#dowebok')
    parentId.html(_html)                            //数据传入父页面图片列表
    window.parent.viewInit()                        //调用父页面图片预览注册方法
    parentId.find('li:eq('+_index+') img').click()  //传入参数并触发预览
}
</script>
</body>
</html>