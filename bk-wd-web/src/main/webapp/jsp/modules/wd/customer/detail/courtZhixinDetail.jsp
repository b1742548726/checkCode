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
    
    <!--统一样式，不删-->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/LBQ/css/client_detail.css" rel="stylesheet">
    <link rel="stylesheet" href="${imgStatic }/zwy/LBQ/css/viewer.min.css">
</head>
<body>

    <div class="wd-content" style="background:#fff">
        <div class="left_info" style="margin:0">
            <div class="shop_info" style="margin:0">
                <!-- 被执行人查询结果（2条结果） -->
                <div class="tb_wrap bg_color">
                    <c:forEach items="${wdCourtQuery.getJsonListData() }" var="data">
                        <ul>
                            <li><label for="">立案时间</label><p>${data.caseCreateTime }</p><label for="">执行法院</label><p>${data.execCourtName }</p></li>
                            <li><label for="">案号</label><p>${data.caseCode }</p><label for="">执行标的</label><p>${data.execMoney }</p></li>
                        </ul>
                    </c:forEach>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>

    </div>
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="${imgStatic }/build/js/custom.js"></script>
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    <script src="${imgStatic }/zwy/LBQ/js/viewer-jquery.min.js"></script>

    <script type="text/javascript">

        function setModuleValue() {
            var addmodule = { "name": $("#moduleName").val(), "code": $("#moduleCode").val() };
            SetLayerData("AddOneModule", addmodule);
        }


        $(document).ready(function () {
            $("#cancle-add-module").click(function (event) {
                SetLayerData("AddOneModule", null);
                CloseIFrame();
            });

            $("#submit-add-module").click(function (event) {
                event.preventDefault();

                var _form = $('#form-add-module').find('input,textarea')
                _form.each(function(){
                    if($(this).val() == ''){
                        $(this).addClass('error')
                        $(this).next().removeClass('hide')
                    }else{
                        $(this).removeClass('error')
                        $(this).next().addClass('hide')
                    }
                })
                $('.warning ins').hover(function(e){
                    $(this).siblings('span').removeClass('hide')
                },function(){
                    $(this).siblings('span').addClass('hide')
                })

            });
        });
    </script>
</body>
</html>