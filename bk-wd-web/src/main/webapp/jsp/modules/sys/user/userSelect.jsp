<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<c:set var="defaultUserPhoto" value="${imgStatic }/zwy/img/default-user.png"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title></title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet" />
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet" />
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet" />
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet" />

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet" />

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet" />

    <style type="text/css">
        html, body {
            min-width: initial;
            background-color: white;
        }

        form {
            margin: 30px 40px 10px;
        }

            form label {
                font-weight: 400;
            }

        div.span-user {
            margin: 10px 15px;
            display: inline-block;
            cursor: pointer;
            width: 60px;
            height: 80px;
            vertical-align: middle;
            text-align: center;
        }


            div.span-user i {
                display: inline-block;
                width: 52px;
                height: 52px;
                line-height: 52px;
                text-align: center;
                border: 2px solid white;
                background-color: #ccc;
                border-radius: 26px;
                font-size: 30px;
                font-weight: 700;
                font-family: STXingkai,STKaiti,KaiTi;
                font-style: normal;
                color: #4e6378;
            }

                div.span-user i img {
                    width: 48px;
                    height: 48px;
                    border-radius: 48px;
                }

            div.span-user[checked] i {
                background-color: #ff661b;
                border: 2px solid #ff661b;
                color: white;
            }

            div.span-user span {
                display: block;
                padding: 2px;
                width: 100%;
                text-align: center;
            }

            div.span-user[checked] span {
                color: #ff661b;
            }
    </style>
</head>

<body>
    <!-- page content -->
    <form id="demo-form2" data-parsley-validate=data-parsley-validate class="form-horizontal form-label-left">
        <div class="col-md-6 col-sm-6 col-xs-6">
            <div class="form-group">
                <input type="text" name="officeName" class="form-control" placeholder="请输入团队名称" value="${params.officeName }"/>
            </div>
        </div>
        <div class="col-md-6 col-sm-6 col-xs-6">
            <div class="form-group">
                <input type="text" name="userName" class="form-control" placeholder="请输入客户经理姓名" value="${params.userName }"/>
            </div>
        </div>
        <div class="row">
            <c:forEach items="${userList }" var="user">
                <div class="span-user" userid="${user.id }">
                    <i>
                        <c:choose>
                            <c:when test="${empty user.photo }">
                                <img src="${defaultUserPhoto }" />
                            </c:when>
                            <c:otherwise>
                                <img src="${imagesStatic }${user.photo }" />
                            </c:otherwise>
                        </c:choose>
                    </i>
                    <span>${user.name}</span>
                </div>
            </c:forEach>
        </div>

        <div class="row" style="margin-top:20px;">
            <div class="col-md-6 col-sm-6 col-xs-6">
                <input id="btn-submit" type="button" class="btn wd-btn-normal wd-btn-orange wd-btn-width-middle pull-right" value="确  定" />
            </div>
            <div class="col-md-6 col-sm-6 col-xs-6">
                <input id="btn-cancle" type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" value="取  消" />
            </div>
        </div>
    </form>

    <!-- /page content -->
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

    <script src="${imgStatic }/zwy/js/wd-common.js"></script>
    <script src="${imgStatic }/zwy/js/wd-common-bind.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>

    <script type="text/javascript">
    	function SearchCustomer() {
    		$("#demo-form2").submit();
    	}
    	
        $(function () {
            $("#btn-cancle").click(function () {
                CloseIFrame();
            });

            $("#btn-submit").click(function () {
                var userId = $("div.span-user[checked]").attr("userid");

                // 验证控件之后修改
                if (!userId) {
                    AlertMessage("请选择客户经理", function () { });
                    return;
                }
                SetLayerData("_select_user_id", userId);
                CloseIFrame();
            });

            $(document).on("click", "div.span-user", function () {
                if ($(this).attr("checked") == "checked") {
                    $(this).removeAttr("checked");
                } else {
                    $("div.span-user[checked]").removeAttr("checked");

                    $(this).attr("checked", "checked");
                }
            });

            $("#demo-form2").on("change", "input", function () {
                SearchCustomer()
            });
        });
    </script>
</body>
</html>
