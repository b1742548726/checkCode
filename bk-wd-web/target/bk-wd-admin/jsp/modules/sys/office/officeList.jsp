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

<!-- PNotify -->
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/organization.css?timer=188342342342" rel="stylesheet">
</head>

<body>
    <div class="wd-content">
        <div class="organization">
            <h2>人员组织架构</h2>
            <div class="left_wrap" style="width: 400px">
                <div class="organ_list" style="min-height: 400px;">
                    <c:forEach items="${officeList }" var="office">
                        <h3 class="root" data-id="${office.id }">
                            <span>${office.name }</span>
                            <c:if test="${currentUser.isAdmin() }">
                                <spring:eval expression="@sysUserOfficeService.selectByOfficeId(office.id)" var="userOfficeList"/>
                                <c:forEach items="${userOfficeList }" var="userOffice">
                                    <spring:eval expression="@sysUserService.selectByPrimaryKey(userOffice.userId)" var="user"/>
                                    <c:if test="${not empty user }">
                                        <lable style="padding: 5px 2px; background-color: #ccc; margin-left: 1px;font-size: 11px;" name="${user.id }">${user.name }</lable>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <shiro:hasPermission name="sys:office:edit">
                                <i class="add"></i>
                            </shiro:hasPermission>
                        </h3>
                        <ul>
                            <c:if test="${not empty office.childList}">
                                <sys:officeManagerTree dataList="${office.childList }" add="sys:office:edit" edit="sys:office:edit" remove="sys:office:del"/>
                            </c:if>
                        </ul>
                    </c:forEach>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="right_wrap" id="user_list_table" style="margin-left: 400px;">
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

<!-- PNotify -->
<script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
<script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
<script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

<script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
<script>
$(function(){
    Module.init();
    $(".organ_list h3:eq(0)").trigger("click");
  //  seachTable();
})

var Module = {
    init:function(){
        $('.organ_list ul').each(function(){
            if($(this).parent().hasClass('plus')){
                $(this).hide()
            }
        })
        this.add()
        this.hover()
        this.click()
        this.selected();
        this.remove();
        this.edit();
    },
    edit: function() {
    	$('.edit').off().on('click',function(e){
    		var _officeId = $(this).parent().data("id"); 
    		OpenIFrame("分配角色", "${ctx}/sys/office/editForm?id="+ _officeId, 900, 620, function() {
    			if (GetLayerData("_save_office_data")) {
    				SetLayerData("_save_office_data", null);
    				location.reload();
    			}
    		});
    	});
    },
    add:function() {
        var self = this;
        $('.add').off().on('click',function(e){
        	var _self = $(this);
            e.stopPropagation();
            $.get("${ctx}/sys/office/form", {parentId : $(this).parent().data("id")}, function(data) {
                OpenLayer("添加机构", data, 450, 220, function() {
                	if (GetLayerData("_office_data")) {
                		var _remove = '';
                		<shiro:hasPermission name="sys:office:del">
                			_remove = '<i class="remove"></i>';
                		</shiro:hasPermission>
                		
                		var _data = GetLayerData("_office_data");
                		SetLayerData("_office_data", null);
                		if($(_self).parent().hasClass('root')){
                            var _html = '<li><p data-id="'+ _data.id + '">'+ _data.name +'<i class="add"></i>'+ _remove +'<i class="edit"></i></p></li>'
                            $('.root').next().append(_html)
                        }else{
                            var _html = '<ul><li><p data-id="'+ _data.id + '">'+ _data.name +'<i class="add"></i>'+ _remove +'<i class="edit"></i></p></li></ul>'
                            $(_self).closest('li').removeClass('cur').addClass('reduce').append(_html)
                        }
                	}
                	self.add()
                    self.hover()
                    self.click()
                    self.selected();
                	self.remove();
                	self.edit();
                });
            });
           
        })
    },
    hover:function(){
    	$('.organ_list ul li').bind('mouseover',function(e){
            e.stopPropagation();
            $('.organ_list ul li').find('i').hide()
            $(this).children("p").children('i').show()
        })
        $('.organ_list ul li').bind('mouseout',function(e){
            e.stopPropagation();
            $(this).children("p").children('i').hide()
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
            $('.organ_list .cur').removeClass('cur')
            $(this).addClass('cur')
            
            $("#searchName").val("");
            seachTable();
        })
        $('.root').on('click',function(e){
            e.stopPropagation();
            $('.organ_list .cur').removeClass('cur')
            $(this).addClass('cur');
            
            $("#searchName").val("");
            seachTable();
        })
    },
    remove:function(){
        $('.remove').off().on('click',function(e){
            var self = $(this)
            e.stopPropagation();
            $.get("${ctx}/sys/office/removeView", {id : $(this).closest("p").data("id")}, function(data) {
            	OpenLayer("警告", data, 400, 280, function(){
            		if (GetLayerData("_office_remove_success")) {
                		SetLayerData("_office_remove_success", false);
                		self.closest('li').remove()
            		}
            	});
            });
        })
    }
}

var _user_search_data;
function seachTable(n, searchData) {
    var searchName = $("#searchName").val();
    var _office_id = $(".organ_list .cur").data("id");
    _user_search_data = {id : _office_id, searchName: searchName, current : n};
    if (searchData) {
    	_user_search_data = searchData;
    }
    $.get("${ctx}/sys/office/userList", _user_search_data, function(data){
        $("#user_list_table").html(data);
    });
}
</script>
</body>
</html>