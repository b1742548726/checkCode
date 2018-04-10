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
                <input type="hidden" name="id" value="${sysOffice.id }">
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                                            公司名称 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="name" value="${sysOffice.name }" required="required" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="placeholder">
                                            公司区域<span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="" value="${sysOffice.areaId }" class="form-control col-md-7 col-xs-12">
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

<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script>
function save(){
	var formParsley = $("#form-add-module").parsley();
    if (formParsley.validate()) {
    	$.ajax({
            url : "${ctx }/wd/element/save",
            data : $("#form-add-module").serialize(),
            type: "post",
            success : function (data) {
            	if (data.code == 200) {
            		CloseIFrame();
            	}
            }
    	});
    }
}
</script>
</body>
</html>