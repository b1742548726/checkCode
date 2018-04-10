<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<!-- Switchery -->
<link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
<!-- Switchery -->
<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>

<div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
    <div class="x_panel">
        <div class="x_content">
            <br />
            <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" method="post">
                <input type="hidden" name="id" value="${wdDefaultPhotoSetting.id }">
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                                        图片组名称 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="name" value="${wdDefaultPhotoSetting.name }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="key">
                        Key <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="code" value="${wdDefaultPhotoSetting.code }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="maxLimit">
                                        默认照片最大数 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="tel"  name="maxLimit" value="${wdDefaultPhotoSetting.maxLimit }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="album">
                                        默认是否允许相册选取 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="checkbox" ${wdDefaultPhotoSetting.album == 0 ? 'checked': ''} name="album" class="js-switch" value="0"  />
                    </div>
                </div>
                <div class="ln_solid"></div>
                <div class="form-group">
                    <div class="col-md-9 col-sm-9 col-xs-9 col-xs-offset-3">
                        <button class="btn btn-primary" type="button" onclick="javascript:CloseLayer();">取消</button>
                        <button class="btn btn-success" type="button" onclick="javascript:save();" id="submit-add-module">确认</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
$(function(){
	if ($(".js-switch")[0]) {
        var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not([data-switchery])'));

        elems.forEach(function (html) {
            var switchery = new Switchery(html, {
                color: '#26B99A'
            });
        });
    }
});
function save() {
	$.ajax({
        url : "${ctx }/wd/photoSetting/save",
        data : $("#form-add-module").serialize(),
        type: "post",
        success : function (data) {
        	if (data.code == 200) {
        		mainFrame.src = mainFrame.src;
        		CloseLayer();
        	}
        }
	});
}
</script>