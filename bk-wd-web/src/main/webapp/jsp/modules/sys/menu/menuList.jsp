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

    <title>Gentelella Alela! | </title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
</head>
<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2> 菜单管理</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-item">新增</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <table id="treeTable" class="wd-table table table-striped table-bordered">
            		<thead>
            			<tr class="headings">
            				<th class="column-title">名称</th>
            				<th class="column-title">链接</th>
            				<th class="column-title">排序</th>
            				<th class="column-title">可见</th>
            				<th class="column-title">权限标识</th>
            				<shiro:hasPermission name="sys:menu:edit">
            					<th class="column-title">操作</th>
            				</shiro:hasPermission>
            			</tr>
            		</thead>
            		<tbody>
            			<c:forEach items="${list}" var="menu" varStatus="status">
            				<tr pointer" id="${menu.id}" pId="${not empty menu.parentId ? menu.parentId :'0'}">
            					<td nowrap>
            						<i class="icon-${not empty menu.icon?menu.icon:' hide'}"></i>
            						<a href="${ctx}/sys/menu/form?id=${menu.id}">${menu.name}</a>
            					</td>
            					<td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
            					<td>
            						${menu.sort}
            					<td>${menu.show eq '1'?'显示':'隐藏'}</td>
            					<td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
            					<shiro:hasPermission name="sys:menu:edit">
            						<td nowrap>
            							<a href="javascript:;" onclick="editMenuFrom('${menu.id}')" title="编辑"><i class="fa fa-edit"></i></a>
            							<a href="javascript:;" title="删除" onclick="return confirm('要删除该菜单及所有子菜单项吗？', delMenu('${menu.id}'))"><i class="fa fa-remove"></i></a>
            							<a href="javascript:;" onclick="showMenuFrom('${menu.id}')">添加下级菜单</a>
            						</td>
            					</shiro:hasPermission>
            				</tr>
            			</c:forEach>
            		</tbody>
            	</table>
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
    
    <link href="${ctxStatic}/vendors/treeTable/themes/vsStyle/treeTable.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctxStatic}/vendors/treeTable/jquery.treeTable.js" type="text/javascript"></script>
    <!-- common -->
    <script src="${ctxStatic}/common/common.js" type="text/javascript"></script>
    
    <!-- jquery ui -->
    <script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#treeTable").treeTable({expandLevel : 2}).show();
            $("#btn-add-item").on("click", function() {
                showMenuFrom();
            });
        });
        
        function showMenuFrom(parentId){
            $.get("${ctx }/sys/menu/form", {parentId: parentId}, function(data){
                OpenLayer("添加菜单", data, 600, 380,function (){
                	if (GetLayerData("_save_menu_data")) {
                    	SetLayerData("_save_menu_data", null);
                    	location.reload();
                	}
                });
            })
        }
        
        function editMenuFrom(id){
            $.get("${ctx }/sys/menu/form", {id: id}, function(data){
                OpenLayer("编辑菜单", data, 600, 380, function (){
                	if (GetLayerData("_save_menu_data")) {
                    	SetLayerData("_save_menu_data", null);
                    	location.reload();
                	}
                });
            })
        }
        
        function delMenu(menuId){
            $.post("${ctx }/sys/menu/delete", {menuId: menuId}, function(data){
                    location.reload();
            });
        }
    </script>
</body>
</html>