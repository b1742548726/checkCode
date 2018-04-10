<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<spring:eval expression="@systemService.getGlobalSetting()" var="sysGlobalSetting" />
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>${sysGlobalSetting.systemName }</title>
    <link rel="icon" href="${imagesStatic }${sysGlobalSetting.systemIco}" type="image/x-icon" />
    <link rel="shortcut icon" href="${imagesStatic }${sysGlobalSetting.systemIco}" type="image/x-icon" />
    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${imgStatic }/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/LBQ/css/layer.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/popup_style.css" rel="stylesheet">
    
    <!--图片预览样式-->
    <link rel="stylesheet" href="${imgStatic }/zwy/LBQ/css/viewer.min.css">
    
</head>

<body class="nav-md" style="background-color: rgb(240,240,240)">
    <div class="container body">
        <div class="main_container">
            <div class="col-md-3 left_col menu_fixed" id="navbar-page">
                <div class="left_col scroll-view">
                    <div class="navbar nav_title" style="background: rgb(77,77,77);">
                        <a href="#" class="site_title" style="text-align:center; vertical-align:middle; position:relative; height: 100px;">
                            <c:if test="${not empty sysGlobalSetting.systemLogo}">
                                <img src="${imagesStatic }${fns:choiceImgUrl('80x50',sysGlobalSetting.systemLogo)}" style="margin-top: 10px;"/>
                            </c:if>
                            <span style="top: 51px;">${sysGlobalSetting.systemName }</span>
                        </a>
                    </div>
                    <div class="clearfix"></div>

                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                        <div class="menu_section">
                            <ul class="nav side-menu">
                                <li class="active active-sm">
                                    <a data-href="${ctx}/welcome"><i class="fa fa-home"></i>首页</a>
                                </li>
                                <c:set var="menuList" value="${fns:getMenuList()}" />
                                <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
                                    <c:if test="${empty menu.parentId && menu.show eq '1'}">
                                        <li>
                                            <c:if test="${empty menu.href}">
                                                <a>
                                                    <i class="fa ${not empty menu.icon ? menu.icon : 'fa-bars'}"></i>${menu.name}
                                                </a>
                                            </c:if>
                                            <c:if test="${not empty menu.href}">
                                                <a data-href="${ctx}${menu.href}">
                                                    <i class="fa ${not empty menu.icon ? menu.icon : 'fa-bars'}"></i>${menu.name}
                                                </a>
                                            </c:if>
                                            
                                            <!-- 三级菜单 -->
                                            <ul class="nav child_menu">
                                                <c:forEach items="${menuList}" var="menu2">
                                                    <c:if test="${menu2.parentId eq menu.id && menu2.show eq '1'}">
                                                        <li><a href="${ctx}${menu2.href}" data-href="${ctx}${menu2.href}">${menu2.name }</a></li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <!-- /sidebar menu -->
                </div>
            </div>

            <!-- top navigation -->
            <div class="top_nav">
                <div class="nav_menu" style="position: fixed;">
                    <!-- <nav> -->
                        <div class="nav toggle">
                            <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                        </div>

                        <!-- <ul class="nav nav-pills navbar-left" style="float: left!important;">
                            <li class="dropdown">
                                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="padding:1.5em;">
                                    上海农商银行 <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-usermenu pull-left">
                                    <li><a href="javascript:;">上海农商银行</a></li>
                                    <li><a href="javascript:;">上海农商银行</a></li>
                                </ul>
                            </li>
                        </ul> -->
                        <ul class="nav navbar-nav navbar-right" style="width: auto;">
                            <li class="">
                                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <c:choose>
                                        <c:when test="${not empty fns:getUser().photo}">
                                            <img src="${imagesStatic }${fns:getUser().photo}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${imgStatic }/zwy/img/default_avatar.png">
                                        </c:otherwise>
                                    </c:choose>
                                    ${fns:getUser().name}
                                    <span class=" fa fa-angle-down"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-usermenu pull-right">
                                    <!-- <li><a href="javascript:;">个人信息</a></li> -->
                                    <li><a id="btn_changepwd" href="${ctx }/sys/user/modifyPwd">修改密码</a></li>
                                    <li><a href="${ctx }/logout"><i class="fa fa-sign-out pull-right"></i>退出</a></li>
                                </ul>
                            </li>
                        </ul>
                    <!-- </nav> -->
                </div>
            </div>
            <!-- /top navigation -->
            <!-- page content -->
            <div class="right_col" role="main" id="content-page">
                <iframe id="mainFrame" scrolling="yes" frameborder="0" style="width:100%; margin:58px 0 0 0px; padding:0px; border-width:0px;" name="mainFrame"></iframe>
            </div>
            <!-- /page content -->
            <!-- footer content -->
            <!--  <footer>
               <div class="pull-right">
                 Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
               </div>
               <div class="clearfix"></div>
             </footer> -->
            <!-- /footer content -->
        </div>
    </div>
    <ul id="dowebok" style="display: none;">
        <!-- <li><img data-original="images/temp/tibet-1.jpg" src="images/temp/tibet-1.jpg" alt="图片1"></li>
        <li><img data-original="images/temp/tibet-2.jpg" src="images/temp/tibet-2.jpg" alt="图片2"></li>-->
    </ul>
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="${imgStatic }/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="${imgStatic }/vendors/nprogress/nprogress.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="${imgStatic }/build/js/custom.js"></script>


    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

    <script src="${imgStatic }/zwy/js/wd-common.js"></script>
    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    <!--图片预览js-->
    <script src="${imgStatic }/zwy/LBQ/js/viewer-jquery.min.js"></script>
    <script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>
    
    <script type="text/javascript">
        var _welcome_url = "${ctx}/welcome";
        var imgServer = "${imgStatic}";
    </script>
    <script src="${imgStatic }/zwy/js/indexHtml.js"></script>
</body>
</html>