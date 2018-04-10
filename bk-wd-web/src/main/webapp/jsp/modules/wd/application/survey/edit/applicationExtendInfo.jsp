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

    <title>编辑辅助信息</title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/warning.css" rel="stylesheet">
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
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left">
                        <c:forEach items="${config }" var="simpleModuleSetting">
                            <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(simpleModuleSetting.businessElementId)" var="wdBusinessElement"/>
                            <wd:baseElement wdBusinessElement="${wdBusinessElement }" required="${simpleModuleSetting.required == '1'}" elementSelectListId="${simpleModuleSetting.elementSelectListId }" defValue="${wdApplicationExtendInfo.getJsonData()[wdBusinessElement.key] }"/>
                        </c:forEach>
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

    <script type="text/javascript">
        $(document).ready(function () {
            $("#cancle-add-module").click(function (event) {
                CloseIFrame();
            });
            
            $('.warning ins').hover(function(e){
                $(this).siblings('span').removeClass('hide')
            },function(){
                $(this).siblings('span').addClass('hide')
            })

            $("#submit-add-module").click(function (event) {
                event.preventDefault();
                var _form_select = $('#form-add-module').find('input[required],textarea[required]');
                var _haserror = false;
                _form_select.each(function(){
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
                var _data = {};
                $("#form-add-module :input").each(function(){
                    if ($(this).attr("name")) {
                    	_data[$(this).attr("name")] = $(this).val().replace("%", "");
                    }
                });
                $.ajax({
                    url: "${ctx}/wd/application/survey/save_application_extend_info",
                    async: false,
                    cache: false,
                    type: "POST",
                    data: {
                    	id : "${wdApplicationExtendInfo.id}",
                    	applicationId: "${wdApplication.id}",
                        data : JSON.stringify(_data)
                    },
                    dataType: "json",
                    success: function (result) {
                        if (result.success) {
                            SetLayerData("save_application_extend_info_data", result.data);
                            CloseIFrame();
                        } else {
                            NotifyInCurrentPage("error", result.msg, "错误！");
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>