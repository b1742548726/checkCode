<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>导入excel数据</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/organization.css" rel="stylesheet">
</head>

<body>
    <div class="wd-content">
        <div class="organization">
            <h2>角色配置</h2>
            <div class="left_wrap">
                <div class="role_list">
                    <h3>
                        <p>角色列表</p>
                        <shiro:hasPermission name="sys:role:edit"><span class="add"></span></shiro:hasPermission>
                    </h3>
                    <ul>
                        <c:forEach items="${list}" var="data" varStatus="status">
                            <li>
                                <p class="${0 == status.index ? 'cur' : ''}" data-id="${data.id}">${data.name}
                                    <shiro:hasPermission name="sys:role:del">
                                        <i class="remove"></i>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="sys:role:edit">
                                        <i class="edit"></i>
                                    </shiro:hasPermission>
                                </p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="clearfix"></div>
            </div>

            <div class="right_wrap">
                <h3><span id="_role_name"></span>
                    <shiro:hasPermission name="sys:role:assignment">
                        <img id="_edit_role_user" src="${imgStatic }/zwy/LBQ/images/people2.png" alt="">
                    </shiro:hasPermission>
                    <input type="text" placeholder="查询姓名" class="search" id="searchName">
                </h3>

                <div class="shop_info">
                    <div class="tb_wrap" id="user_table">
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>

<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script>
$(function(){
	$("#_role_name").html($(".role_list p.cur").html());
    $("#_edit_role_user").on("click", function(){
    	var roleId = $(".role_list p.cur").data("id");
    	OpenIFrame("分配角色", "${ctx}/sys/role/roleUserForm?name=&id="+ roleId, 900, 580, function() {
			if (GetLayerData("_save_role_user")) {
				SetLayerData("_save_role_user", null);
				seachTable();
			}
    	});
    });
    $('.role_list').on('click','ul li',function(){
        $(this).children('p').addClass('cur').end().siblings().children('p').removeClass('cur');
        $("#_role_name").html($(this).children('p').html());
        seachTable();
    });
    $('.add').on('click',function(){
		location.href = "${ctx}/sys/role/form";
    });
    $(".edit").on("click", function(){
    	var roleId = $(this).parent().data("id");
    	location.href = "${ctx}/sys/role/form?id=" + roleId;
    });
    $("#searchName").on("change", function(){
    	seachTable();
    })
    
    $(".remove").on("click", function(){
    	var _me = this;
    	var roleId = $(this).parent().data("id");
    	Confirm("确定要删除当前数据？", function (){
        	$.ajax({
                url : "${ctx}/sys/role/delete",
                async : false,
                cache : false,
                type : "POST",
                data : {
                	id : roleId,
                	_csrf: "${_csrf }"
                },
                dataType : "json",
                success : function(result) {
                    if (result.success) {
                    	$(_me).closest("li").remove();
                    	$(".role_list li:eq(0)").trigger("click");
                    } else {
                        NotifyInCurrentPage("error", result.msg, "删除机构错误");
                    }
                }
            });
    	});
    });
})

seachTable();
function seachTable(n){
	var searchName = $("#searchName").val();
	var roleId = $(".role_list p.cur").data("id");
	$.get("${ctx}/sys/role/userList", {id: roleId, seacheUserName: searchName, current : n}, function(data){
		$("#user_table").html(data);
	});
}

function page(n,s){
	seachTable(n);
	return false;
}
</script>
</body>
</html>