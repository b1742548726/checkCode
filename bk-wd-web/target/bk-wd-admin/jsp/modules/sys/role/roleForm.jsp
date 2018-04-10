<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>角色配置-编辑</title>
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
                    <h3><p>角色列表</p></h3>
                    <ul>
                        <c:forEach items="${list}" var="data">
                            <li>
                                <p class="${data.id eq sysRole.id ? 'cur' : ''}" data-id="${data.id}">${data.name}
                                </p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="clearfix"></div>
            </div>

            <div class="right_wrap">
                <h3> ${empty sysRole.name ? '新增' : '编辑'}
                    <a href="javascript:void(0);" class="btn_col2">保存</a>
                    <a href="javascript:history.back();" class="btn_col1">返回</a>
                </h3>

                <div class="r_list role_name">
                    <label for="">角色名称<span>*</span></label>
                    <input type="text" id="_roleName" value="${sysRole.name }">
                </div>

                <div class="r_list menu_permission">
                    <label for="">菜单权限</label>
                    <div class="organ_list menu_role wd500">
                        <h3 class="root">全部菜单</h3>
                        <ul>
                            <sys:tree dataList="${menuList }" box="true" />
                        </ul>
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
    $(".btn_col2").on("click", function(){
    	var name = $("#_roleName").val();
    	var menuIdArray = [];
    	$(".menu_role i.cur").each(function(){
    		menuIdArray.push($(this).parent().data("id"));
    	});
    	$.ajax({
            url : "${ctx}/sys/role/save",
            async : false,
            cache : false,
            type : "POST",
            data : {
            	_csrf: "${_csrf }",
            	name : name,
            	id : "${sysRole.id}",
            	menuIds : menuIdArray.join(',')
            },
            dataType : "json",
            success : function(result) {
                if (result.success) {
                	location.href = "${ctx}/sys/role/list?repage";
                } else {
                    NotifyInCurrentPage("error", result.msg, "删除机构错误");
                }
            }
        });
    })
    
    Module.init();
    <c:forEach items="${roleMenuList }" var="roleMenu">
    	$(".menu_role p[data-id=${roleMenu.menuId}]").find("i.box").addClass("cur"); // .trigger("click");
    </c:forEach>
})

//联动
var Module = {
    init:function(){
        $('.organ_list ul').each(function(){
            if($(this).parent().hasClass('plus')){
                $(this).hide()
            }
        })
        this.add()
        this.click()
        this.selected()
    },
    add:function(){
        var self = this
        $('.add').off().on('click',function(e){
            e.stopPropagation();
            if(self.parent().hasClass('root')){
                var _html = '<li><p>新增<i class="add"></i><i class="remove"></i><i class="edit"></i></p></li>'
                $('.root').next().append(_html)
            }else if(self.parent().next('ul').length > 0){
                var _html = '<li><p>新增<i class="add"></i><i class="remove"></i><i class="edit"></i></p></li>'
                self.parent().next('ul').append(_html)
            }else{
                var _html = '<ul><li><p>新增<i class="add"></i><i class="remove"></i><i class="edit"></i></p></li></ul>'
                self.closest('li').removeClass('cur').addClass('reduce').append(_html)
            }

            self.add()
        })
    },
    click:function(){
        $('.organ_list').off().on('click','ul li',function(e){
            e.stopPropagation();
            if($(this).hasClass('reduce')){
                $(this).children('ul').hide(50)
                $(this).removeClass('reduce').addClass('plus')
            }else if($(this).hasClass('plus')){
                $(this).children('ul').show(50)
                $(this).removeClass('plus').addClass('reduce')
            }
        })
    },
    selected:function(){
        $('.organ_list').on('click','ul li p',function(e){
            e.stopPropagation();
            if($(this).children('i').hasClass('cur')){
                $(this).children('i').removeClass('cur')
                $(this).siblings('ul').find('i').removeClass('cur')
                /* var _parent = $(this).parents('li')
                _parent.each(function(){
                    var self = $(this)
                    if(!self.siblings('li').find('i').hasClass('cur') && !self.find('i').hasClass('cur')){
                        self.parent().parent().children('p').find('i').removeClass('cur')
                    }
                }) */
            }else{
                $(this).children('i').addClass('cur')
                $(this).siblings('ul').find('i').addClass('cur')
                $(this).parents('li').children('p').children('i').addClass('cur')
            }
            
        })
    }
}
</script>
</body>
</html>