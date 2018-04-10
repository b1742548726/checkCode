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

    <title>区域管理</title>

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
    <script src="${ctxStatic}/vendors/mustache/mustache.min.js" type="text/javascript"></script>
    
    <!-- jquery ui -->
    <script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>
</head>
<body>
<html>
<head>
	<style>
		html, body {
			height: auto;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJsonString(list)}, rootId = "0";
			addRow("#treeTableList", tpl, data, rootId, true);
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
							type: getDictLabel(${fns:toJsonString(fns:getDictList('sys_area_type'))}, row.type)
						},
						pid: (root?0:pid),
						row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
		
        $(document).on("click", ".btn-edit", function () {
        	var _area_id = $(this).closest("tr").attr("id");
            OpenBigIFrame("编译区域", "${ctx}/sys/area/form?id=" + _area_id, function () {
            });
        });
        
        // 添加下级
        $(document).on("click", ".btn-add-child", function () {
        	var _area_id = $(this).closest("tr").attr("id");
            OpenBigIFrame("编译区域", "${ctx}/sys/area/form?parentId=" + _area_id, function () {
            });
        });

        //删除
        $(document).on("click", ".btn-del", function () {
        	var currentTr = $(this).parents("tr");
            Confirm("确定要删除当前数据？", function (){
                if (currentTr.length == 1) {
                    var groupId = currentTr.attr("groupid"); //wd_select_group表的id

                    //ajax请求删除对应的item
                    $.ajax({
        				url : "${ctx}/wd/selectItem/delSelectGroup",
        				data : {groupId : groupId},
        				type: "post",
        				success : function (data){
        					currentTr.fadeOut(512, function () {
        	                    currentTr.remove();
        	                });
        				}
        			})
                }
            });
        });
	</script>
</head>
<body>
	<table id="treeTable" class="table table-bordered table-striped jambo_table bulk_action">
		<thead><tr><th>区域名称</th><th>区域编码</th><th>区域类型</th><th>备注</th><th>操作</th></tr></thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pid="{{pid}}">
			<td>{{row.name}}</td>
			<td>{{row.code}}</td>
			<td>{{dict.type}}</td>
			<td>{{row.remarks}}</td>
			<td>
				<button type="button" class="btn wd-btn-small wd-btn-indigo btn-edit">编辑</button>
                <button type="button" class="btn wd-btn-small wd-btn-orange btn-del">删除</button>
                <button type="button" class="btn wd-btn-small wd-btn-gray btn-add-child">添加下级区域</button>
			</td>
		</tr>
	</script>
</body>
</html>