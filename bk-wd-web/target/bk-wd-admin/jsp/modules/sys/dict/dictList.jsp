<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>字典管理</title>
	<!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">

    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2> 字典管理</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <form:form id="searchForm" modelAttribute="sysDict" action="${ctx}/sys/dict/" method="get">
                            <input id="pgCurrent" name="current" type="hidden" value="${pagination.current}" />
                            <label>类型：</label>
                            <form:input path="type" htmlEscape="false" maxlength="50" class="input-medium"/>
                            &nbsp;&nbsp;
                            <label>描述 ：</label>
                            <form:input path="description" htmlEscape="false" maxlength="50" class="input-medium"/>
                            &nbsp;
                            <input class="btn btn-primary wd-btn-width-middle" type="submit" value="查询"/>
                        </form:form>
                    </li>
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-item">新增</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <table id="treeTable" class="wd-table table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>索引</th>
                            <th>标签</th>
                            <th>键值</th>
                            <th>类型</th>
                            <th>描述</th>
                            <th>排序</th>
                            <shiro:hasPermission name="sys:dict:edit"><th style="width:20%">操作</th></shiro:hasPermission></tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pagination.dataList}" var="dict" varStatus="status">
                        <tr>
                            <td>${status.index + pagination.begin}</td>
                            <td>${dict.label}</td>
                            <td>${dict.value}</td>
                            <td><a href="javascript:" class="btn wd-btn-small wd-btn-indigo" onclick="$('#type').val('${dict.type}');$('#searchForm').submit();return false;">${dict.type}</a></td>
                            <td>${dict.description}</td>
                            <td>${dict.sort}</td>
                            <td class="cursor-default">
                                <button type="button" class="btn wd-btn-small wd-btn-indigo btn-edit-list" data-id="${dict.id}">编辑</button>
                                <button type="button" class="btn wd-btn-small wd-btn-orange btn-del-list" data-id="${dict.id}" onclick="return confirmx('确认要删除该字典吗？', this.href)">删除</button>
                                <button type="button" class="btn wd-btn-small btn-dark btn-add_child-list" data-description="${dict.description}" data-sort="${dict.sort+10}" data-type="${dict.type}">添加键值</button>
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
    
     <!-- Parsley -->
    <script src="${imgStatic }/vendors/parsleyjs-2.6/dist/parsley.min.js"></script>
    <script src="${imgStatic }/vendors/parsleyjs-2.6/dist/i18n/zh_cn.js"></script>

    
    <script type="text/javascript">
        function page(n,s){
            $("#pgCurrent").val(n);
            $("#searchForm").submit();
            return false;
        }
        //新增模块
        $(document).on("click", "#btn-add-item", function () {
        	$.get("${ctx}/sys/dict/form", null, function(data) {
        		OpenFullLayer("新增", data);
        	})
        });
        //编辑
        $(document).on("click", ".btn-edit-list", function () {
        	$.get("${ctx}/sys/dict/form", {id : $(this).data("id")}, function(data) {
        		OpenFullLayer("编辑", data);
        	})
        });
      	//添加鍵值
        $(document).on("click", ".btn-add_child-list", function () {
        	$.get("${ctx}/sys/dict/form", {sort : $(this).data("sort"), type : $(this).data("type"), description : $(this).data("description")}, function(data) {
        		OpenFullLayer("添加", data);
        	})
        });
      	//刪除
        $(document).on("click", ".btn-del-list", function () {
        	$.post("${ctx}/sys/dict/delete", {id : $(this).data("id")}, function(data) {
        		$("#searchForm").submit();
        	})
        });
    </script>
</body>
</html>