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

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <style type="text/css">
        .messageshow {
            height:36px;
            line-height:36px;
        }
    </style>
</head>
<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <br />
                    <form id="form-add-select" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12"> 标题 </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <span class="messageshow">${ message.title }</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12"> 发布时间 </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <span class="messageshow">${ fns:formatDateTimeCus(message.messageDate, "yyyy-MM-dd HH:mm") }</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12"> 内容 </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <p style="margin-top:8px;">${ message.content }</p>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-xs-12 wd-center">
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-white" type="button" id="cancle-add-select">关闭</button>
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

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#cancle-add-select").click(function (event) {
                CloseIFrame();
            });
        });

    </script>
</body>
</html>