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

    <title>Gentelella Alela! | </title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2> 业务元件 </h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-element">新增</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <table id="datatable" class="wd-table table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>组件类型</th>
                            <th>标题</th>
                            <th>占位符</th>
                            <th>Key</th>
                            <th>高度</th>
                            <th>选择项</th>
                            <th>键盘类型</th>
                            <th>正则</th>
                            <th>错误提示</th>
                            <th>辅助功能</th>
                            <th></th>
                        </tr>
                    </thead>
    
                    <tbody>
                        <c:forEach items="${pagination.dataList}" var="businessElement">
                            <tr >
                                <td>
                                     <spring:eval expression="@wdBaseElementService.selectByPrimaryKey(businessElement.baseElementId)" var="baseElement"/>
                                     ${baseElement.name }
                                </td>
                                <td>${businessElement.name }</td>
                                <td>${businessElement.placeholder }</td>
                                <td>${businessElement.key }</td>
                                <td>${businessElement.height }</td>
                                <td>
                                    <spring:eval expression="@wdSelectGroupService.selectByPrimaryKey(businessElement.selectGroupId)" var="selectGroup"/>
                                    ${selectGroup.name }
                                </td>
                                <td>${fns:getDictLabel(businessElement.keyboardType , 'keyboard_type', '')}</td>
                                <td>${businessElement.regularExpression }</td>
                                <td>${businessElement.errorMessage }</td>
                                <td>${fns:getDictLabel(businessElement.accessorialFunction , 'accessorial_function', '')}</td>
                                <td class="cursor-default">
                                    <button type="button" class="btn wd-btn-small wd-btn-indigo btn-edit-element" data-id="${businessElement.id }">编辑</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="dataTables_wrapper">${pagination}</div>
            </div>
        </div>
    </div>
    
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    
    <!-- 弹出层 -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

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
<body>