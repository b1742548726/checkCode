<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
</head>

<body>
    <!-- page content -->
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2>公司列表</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button"  class="btn wd-btn-normal wd-btn-gray" id="btn-add-element">新增</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table" id="blacklist-list">
                    <thead>
                        <tr>
                            <th style="width:120px"> 公司编号 </th>
                            <th > 公司名称 </th>
                            <th > 公司区域 </th>
                            <th style="width:256px"> 创建时间 </th>
                            <th> </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${companyList}" var="data">
                            <tr>
                                <td> ${data.id }</td>
                                <td> ${data.name} </td>
                                <td>
                                    <spring:eval expression="@sysAreaService.selectByPrimaryKey(data.areaId)" var="area"/>
                                    ${area.name }
                                </td>
                                <td> <fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                <td>
                                    <button type="button" class="btn wd-btn-small wd-btn-orange btn-edit-element" data-id="${data.id}"> 编辑 </button>
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

    <script src="${imgStatic }/zwy/js/wd-common.js"></script>
    <script src="${imgStatic }/zwy/js/wd-common-bind.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>

    <script>
        //新增模块
        $(document).on("click", "#btn-add-element", function () {
        	$.get("${ctx}/wd/element/form", null, function(data) {
        		OpenFullLayer("新增", data);
        	})
        });
        //编辑
        $(document).on("click", ".btn-edit-element", function () {
        	$.get("${ctx}/wd/element/form", {id : $(this).data("id")}, function(data) {
        		OpenFullLayer("编辑", data);
        	})
        });
    </script>
</body>
</html>