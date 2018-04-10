<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html style="min-width:200px">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gentelella Alela! | </title>

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
<body style="min-width:200px">
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="form-group">
                            <label class="control-label col-md-3 col-xs-12" for="moduleCode">
                                                        审批结果 <span class="required"></span>
                            </label>
                            <div class="col-md-6 col-xs-12">
                           		<input type="hidden" id="taskId" name="taskId" value="${ taskId }"> 
                                <textarea style="width:100%" id="comment" required class="form-control2 col-md-8 col-xs-12"></textarea>
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
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-white" type="button" id="cancle-add-module" action="Return">退回</button>
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-viridity" type="button" id="submit-add-module" action="Pass">确认</button>
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

        $(document).ready(function () {

            $("button").click(function (event) {
                event.preventDefault();
                
                var _form = $('#form-add-module').find('input[required],textarea[required]');
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
				data["taskId"] = $("#taskId").val();
				data["comment"] = $("#comment").val();
				data["action"] = $(this).attr("action");
            	
            	$.ajax({
                    url: "${ctx}/wd/application/fz/deal",
                    async: false,
                    cache: false,
                    type: "POST",
                    data: data,
                    dataType: "json",
                    success: function (result) {
                        if (result.success) {
                        	SetLayerData("close_deal_page", true);
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