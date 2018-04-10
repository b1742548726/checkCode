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
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">

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
            <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" method="post">
                <input type="hidden" name="id" value="${wdCustomerType.id }">
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                                        名称 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="name" value="${wdCustomerType.name }" required="required" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="code">
                                       编号 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="code" value="${wdCustomerType.code }" required="required" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="img">
                                        图片URL <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="img" value="${wdCustomerType.img }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="enable">
                                        是否启用<span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="checkbox" ${wdCustomerType.enable eq '1' ? 'checked': ''} for="enable" class="js-switch" />
                    	<input type="hidden" name="enable" value="${wdCustomerType.enable}" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="newable">
                                       新建时是否可用<span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="checkbox" ${wdCustomerType.newable eq '1' ? 'checked': ''} for="newable" class="js-switch" />
                        <input type="hidden" name="newable" value="${wdCustomerType.newable eq '1' ? '1': '0'}" />
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="remarks">
                                        描述 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <textarea name="remarks" class="form-control col-md-7 col-xs-12" rows="3">${wdCustomerType.remarks}</textarea>
                    </div>
                </div>
                <div class="ln_solid"></div>
                <div class="form-group">
                    <div class="col-md-9 col-sm-9 col-xs-9 col-xs-offset-3">
                        <button class="btn btn-primary" type="button" onclick="javascript:CloseIFrame();">取消</button>
                        <button class="btn btn-success" type="button" onclick="javascript:save();" id="submit-add-module">确认</button>
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
<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
<!-- 弹出层 -->
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script>
$(function(){
    if ($(".js-switch")[0]) {
        var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not([data-switchery])'));
        elems.forEach(function (html) {
            var switchery = new Switchery(html, {
                color: '#26B99A'
            });
            html.onchange = function() {
				var checked = html.checked ? 1 : 0;
				var name = $(html).attr("for");
				$("[name="+name+"]").val(checked);
			};
        });
    }
});
function save() {
	var formParsley = $("#form-add-module").parsley();
    if (formParsley.validate()) {
        $.ajax({
            url : "${ctx }/wd/customerType/save",
            data : $("#form-add-module").serialize(),
            type: "post",
            success : function (data) {
                if (data.code == 200) {
                    SetLayerData("_save_customerType_module_data", true);
                    CloseIFrame();
                }
            }
        });
    }
}
</script>
</body>
</html>