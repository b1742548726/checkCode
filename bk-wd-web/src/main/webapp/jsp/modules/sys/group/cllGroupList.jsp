<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>流程节点配置</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/organization.css" rel="stylesheet">
<style type="text/css">
span.cat {
   padding: .4em 1em;
    background-color: #babdc5;
    color: #fff;
    margin-left: .5em;
}

</style>
</head>

<body>
    <div class="wd-content">
        <div class="organization">
            <h2>
            	流程节点配置
            	<shiro:hasPermission name="sys:group:init:online:config">
	            	<input type="button" style="float: right;" class="btn wd-btn-normal wd-btn-gray init-default-usergroup" value="生成默认流程节点">
            	</shiro:hasPermission>
            </h2>
            <div class="left_wrap">
                <div class="role_list">
                    <h3>
                        <p>节点列表</p>
                    </h3>
                    <ul>
                        <c:forEach items="${list}" var="data" varStatus="status">
                            <li>
                                <p class="${0 == status.index ? 'cur' : ''}" data-id="${data.id}">
                                    ${data.name}
                                </p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="right_wrap">
                <h3><span id="_group_name"></span>
                    <shiro:hasPermission name="sys:group:assignment">
                        <img id="_edit_group_user" src="${imgStatic }/zwy/LBQ/images/people.png" alt="">
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
	$("#_group_name").html($(".role_list p.cur").html());
    $('.role_list').on('click','ul li',function(){
        $(this).children('p').addClass('cur').end().siblings().children('p').removeClass('cur');
        $("#_group_name").html($(this).children('p').html());
        seachTable();
    })
     $("#_edit_group_user").on("click", function(){
    	var groupId = $(".role_list p.cur").data("id");
    	OpenIFrame("分配用户组", "${ctx}/sys/group/groupUserForm?name=&id="+ groupId, 900, 580, function() {
    		if (GetLayerData("_save_group_user")) {
				SetLayerData("_save_group_user", null);
				seachTable();
			}
    	});
    });
    
    $('.role_list').on('click','ul li',function(){
        $(this).children('p').addClass('cur').end().siblings().children('p').removeClass('cur')
    })
    
    $("#searchName").on("change", function(){
    	seachTable();
    })
    
    $(".init-default-usergroup").on("click", function(){
    	$.ajax({
            url : "${ctx}/sys/group/initOnlineUserGroupCategory",
            async : false,
            cache : false,
            type : "POST",
            dataType : "json",
            success : function(result) {
                if (result.success) {
                	location.reload();
                } else {
                    NotifyInCurrentPage("error", result.msg, "生成默认流程节点");
                }
            }
        });
    });

    Module.init()
    seachTable();
})

function seachTable(n){
	var searchName = $("#searchName").val();
	var roleId = $(".role_list p.cur").data("id");
	$.get("${ctx}/sys/group/userList", {id: roleId, seacheUserName: searchName, current : n}, function(data){
		$("#user_table").html(data);
	});
}

function page(n,s){
	seachTable(n);
	return false;
}

var Module = {
    init:function(){
        this.add()
        this.edit()
        this.remove()
    },
    add:function(){
        var that = this
        $('.add').off().on('click',function(){
        	$.get("${ctx}/sys/group/form", null, function(data) {
                OpenLayer("添加分组配置", data, 600, 350, function() {
                	if (GetLayerData("_office_data")) {
                		var _data = GetLayerData("_office_data");
                		SetLayerData("_office_data", null);
                		var _remove = '';
                		<shiro:hasPermission name="sys:group:del">
                			_remove = '<i class="remove"></i>';
                		</shiro:hasPermission>
                		/* var _html = '<li><p data-id="'+ _data.id + '">'+ _data.name +'<span class="cat">'+ _data.categoryName +'</span>'+ _remove + '<i class="edit"></i></p></li>'; */
                        var _html = '<li><p data-id="'+ _data.id + '">'+ _data.name + _remove + '<i class="edit"></i></p></li>';
                        $(".role_list ul").append(_html)
                        that.edit()
                        that.remove()
                	}
                });
            });
        })
    },
    remove:function(){
        $('.remove').off().on('click',function(e){
        	var _me = this;
        	var groupId = $(this).parent().data("id");
        	Confirm("确定要删除当前数据？", function (){
            	$.ajax({
                    url : "${ctx}/sys/group/delete",
                    async : false,
                    cache : false,
                    type : "POST",
                    data : {
                    	id : groupId
                    },
                    dataType : "json",
                    success : function(result) {
                        if (result.success) {
                        	$(_me).closest("li").remove();
                        	$(".role_list li:eq(0)").trigger("click");
                        } else {
                            NotifyInCurrentPage("error", result.msg, "删除分组配置错误");
                        }
                    }
                });
        	});
        })
    },
    edit:function(){
        var that = this
        $('.edit').off().on('click',function(){
        	var _me = this;
        	var groupId = $(this).parent().data("id");
        	$.get("${ctx}/sys/group/form", {id : $(this).closest("p").data("id")}, function(data) {
                OpenLayer("编辑分组配置", data, 600, 350, function() {
                	if (GetLayerData("_office_data")) {
                		var _data = GetLayerData("_office_data");
                		SetLayerData("_office_data", null);
                		var _remove = '';
                		<shiro:hasPermission name="sys:group:del">
                			_remove = '<i class="remove"></i>';
                		</shiro:hasPermission>
                		$(_me).parent().html(_data.name +'<span class="cat">'+ _data.categoryName +'</span>'+ _remove + '<i class="edit"></i>');
                        that.edit()
                        that.remove()
                	}
                });
            });
        })
    }
}
</script>
</body>
</html>