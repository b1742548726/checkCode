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

    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/warning.css" rel="stylesheet">
    
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/LBQ/css/layer.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/popup_style.css" rel="stylesheet">
    
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <style type="text/css">
        textarea:focus {
          outline-style: solid;
          outline-width: 2px;
          outline-color: #ccc;
        }
    </style>
</head>
<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-9 col-sm-9 col-xs-9">
            <div class="x_panel">
                <div class="x_content">
                    <form id="submit-module" data-parsley-validate class="form-horizontal form-label-left">
                    	<input type="hidden" name="creditId" value="${creditId}">
                        <input type="hidden" name="taskId" value="${taskId}">
                        <div class="form-group" id="remarksDiv" >
                            <label class="control-label col-md-3 col-xs-3" for="moduleCode">
                                                       终止原因<span class="required"></span>
                            </label>
                            <div class="col-md-9 col-xs-9">
                                <textarea name="remarks" style="width: 60%;" class="form-control2 col-md-9 col-xs-9" rows="10" required="required"></textarea>
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
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-white" type="button" id="cancle-add-module">取消</button>
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-viridity" type="submit" id="submit-add-module">确认</button>
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

    <!-- Layer -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    
    <!-- iCheck -->
    <script src="${imgStatic }/vendors/iCheck/icheck.min.js"></script>
    <script type="text/javascript">
        function setModuleValue() {
            var addmodule = { "name": $("#moduleName").val(), "code": $("#moduleCode").val() };
            SetLayerData("AddOneModule", addmodule);
        }

        $(document).ready(function () {
        	
            //待选项样式
            if ($("#addBlank")[0]) {
            	$("#addBlank").iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
            }
        	
            $("#cancle-add-module").click(function (event) {
                SetLayerData("AddOneModule", null);
                CloseIFrame();
            });
            
            $('.warning ins').hover(function(e){
                $(this).siblings('span').removeClass('hide')
            },function(){
                $(this).siblings('span').addClass('hide')
            })

            $("#submit-add-module").click(function (event) {
                event.preventDefault();
                
                var _form = $('#submit-module').find('input[required],textarea[required]');
                var _haserror = false;
                _form.each(function(){
                    if($(this).val() == ''){
                        $(this).addClass('error')
                        $(this).next().removeClass('hide')
                        _haserror = true;
                    }else{
                        $(this).removeClass('error')
                        $(this).next().addClass('hide')
                    }
                })
                if (_haserror) {
                	return false;
                }
                
                var data = {};
            	$("#submit-module :input").each(function(){
                	if ($(this).attr("name")) {
                		data[$(this).attr("name")] = $(this).val();
                	}
                });
            	
            	$.ajax({
                    url: "${ctx}/wd/application/credit/cancel",
                    async: false,
                    cache: false,
                    type: "POST",
                    data: $("#submit-module").serialize(),
                    dataType: "json",
                    success: function (result) {
                        if (result.success) {
                        	SetLayerData("close_credit_view", true);
                        	CloseIFrame();
                        } else {
                        	AlertMessage(result.msg);
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>