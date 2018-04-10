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

    <title>Gentelella Alela! | </title>

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

    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <!--<div class="x_title">
                    <h2> 新增模块 </h2>
                    <div class="clearfix"></div>
                </div>-->
                <div class="x_content">
                    <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" method="post">
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-3" for="moduleName">
                                名称 <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-9">
                                <input type="text" id="moduleName" name="name" required="required" class="form-control col-md-8 col-xs-12">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-3" for="moduleCode">
                                代码 <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-9">
                                <input type="text" id="moduleCode" name="code" required="required" class="form-control col-md-8col-xs-12">
                            </div>
                        </div>
                       
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-3" for="moduleRemarks">说明</label>
                            <div class="col-md-6 col-sm-6 col-xs-9">
                                <textarea id="moduleRemarks" name="remarks" class="form-control col-md-8 col-xs-12" rows="4"></textarea>
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
    <!-- Switchery -->
    <script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script type="text/javascript">
        function setModuleValue() {
            var addmodule = { "name": $("#mouleName").val(), "code": $("#mouleCode").val() };
            SetLayerData("AddOneModule", addmodule);
        }

        $(document).ready(function () {
        	if ($(".js-switch")[0]) {
                var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not([data-switchery])'));

                elems.forEach(function (html) {
                    var switchery = new Switchery(html, {
                        color: '#26B99A'
                    });
                });
            }
        	
            $("#cancle-add-module").click(function (event) {
                SetLayerData("AddOneModule", null);
                CloseIFrame();
            });

            $("#submit-add-module").click(function (event) {
                event.preventDefault();
				var $form = $('#form-add-module');
                var formParsley = $form.parsley();
                if (formParsley.validate()) {
                	$.ajax({
                        url : "${ctx }/wd/simlpeModule/save",
                        data : $form.serialize(),
                        type: "post",
                        success : function (data) {
                        	if (data.code == 200) {
                                setModuleValue();
                                CloseIFrame();
                        	}
                        }
                	});
                }
            });
        });
    </script>
</body>
</html>