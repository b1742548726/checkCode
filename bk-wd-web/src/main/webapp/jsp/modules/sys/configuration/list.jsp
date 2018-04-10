<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title></title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>

<body>
    <!-- page content -->
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title non_bottom_border">
                <h2> 配置列表 </h2>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table">
                    <thead>
                        <tr>
                            <th> 配置项 </th>
                            <th> 描述 </th>
                            <th> 类型 </th>
                            <th style="width:80px"> 状态 </th>
                        </tr>
                    </thead>
                    
                    <tbody>
                        <c:forEach items="${ Configurations }" var="data">
                            <tr configurationid="${ data.id }">
                                <td>${ data.remarks }</td>
                                <td>${ data.description }</td>
                                <td>${ data.type }</td>
                                <td>
                                    <c:if test="${data.value eq 'enable'}">
                                        <button type="button" class="btn wd-btn-small wd-btn-viridity wd-btn-round btn-disable-product">已启用</button>
                                    </c:if>
                                    <c:if test="${data.value eq 'disable'}">
                                        <button type="button" class="btn wd-btn-small wd-btn-orange wd-btn-round btn-enable-product">已禁用</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- /page content -->
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

   <!--  <script src="${imgStatic }/zwy/js/wd-common.js"></script> -->

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    <script type="text/javascript">

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        // 写上真是的地址
        var currentPageUrl = {
        	enableConfiguration: "${ctx}/wd/configuration/enable"
        };

        function ReloadData() {
			location.reload();
        }

        function EnableConfiguration(button) {

            var configurationTr = $(button).parents("tr[configurationid]");
            var configurationId = configurationTr.attr("configurationid");
            var configurationName = configurationTr.children("td:eq(0)").html().trim();

            var enable = $(button).hasClass("btn-disable-product") ? "disable" : "enable";

            $.ajax({
                url: currentPageUrl.enableConfiguration + "?id=" + configurationId + "&enable=" + enable,
                type: "PUT",
                dataType: "json",
                async: false,
                cache: false,
                success: function (result) { // result要求返回Json，格式{ "success": false, "msg": "!@#$%^&**&^%^^$#@!" }
                    if (result.success) {
                        if (enable == "enable") {
                            $(button).removeClass("wd-btn-orange btn-enable-product");
                            $(button).addClass("wd-btn-viridity btn-disable-product");
                            $(button).html("已启用");
                        } else {
                            $(button).removeClass("wd-btn-viridity btn-disable-product");
                            $(button).addClass("wd-btn-orange btn-enable-product");
                            $(button).html("已禁用");
                        }
                    } else {
                        NotifyError(result.msg, (enable == "enable" ? "已启用" : "已禁用") + "配置【" + configurationName + "】时出现一个错误");
                    }
                }
            });
        }


        $(document).ready(function () {

            // 禁用产品
            $(".btn-enable-product").click(function () {
                EnableConfiguration(this);
            });

            // 啟用产品
            $(".btn-disable-product").click(function () {
                EnableConfiguration(this);
            });

        });
    </script>
</body>
</html>