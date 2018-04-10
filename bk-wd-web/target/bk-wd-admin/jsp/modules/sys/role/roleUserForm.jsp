<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
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
    <link href="${imgStatic }/zwy/LBQ/css/warning.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/organization.css" rel="stylesheet">
</head>
<body>
    <div class="wd-content">
        <div class="popupHtml2">
            <div class="popLeft">
                <h4>机构列表</h4>
                <div class="popList">
                    <div class="organ_list" id="organ_list" style="min-height:auto;background:#fff">
                        <c:forEach items="${officeList }" var="office">
                            <h3 class="root" data-id="${office.id }"><span>${office.name }</span>
                            </h3>
                            <c:if test="${not empty office.childList}">
                                <ul>
                                    <sys:tree dataList="${office.childList }"/>
                                </ul>
                            </c:if>
                        </c:forEach>
                    </div>
                </div> 
            </div>

            <div class="popLeft2">
                <h4>备选用户</h4>
                <div class="popList">
                    <ul class="reserve_member" id="reserve_member">
                    </ul>
                </div>
            </div>
            <div class="popMiddle"><i></i></div>

            <div class="popRight">
                <h4>用户拥有查看以下团队数据的权限</h4>
                <ul class="memberList">
                    <c:forEach items="${userList }" var="sysUser">
                        <li data-id="${sysUser.id }">${sysUser.name }<i></i></li>
                    </c:forEach>
                </ul>
            </div>

            <div class="popBottom">
                <a href="javascript:CloseIFrame();" class="cancel">取消</a>
                <a href="javascript:;" class="save">保存</a>
            </div>
        </div>

    </div>
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Parsley -->
    <script src="${imgStatic }/vendors/parsleyjs-2.6/dist/parsley.min.js"></script>
    <script src="${imgStatic }/vendors/parsleyjs-2.6/dist/i18n/zh_cn.js"></script>

    <!-- Layer -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script type="text/javascript">
        function setModuleValue() {
            var addmodule = { "name": $("#moduleName").val(), "code": $("#moduleCode").val() };
            SetLayerData("AddOneModule", addmodule);
        }

        $(document).ready(function () {
        	$('.reserve_member').on('click','li',function(){
                var _id = $(this).data('id')
                if($(this).hasClass('cur')){
                    $(this).removeClass('cur')
                    $(".memberList li[data-id=" + _id + "]").remove();
                }else{
                    $(this).addClass('cur');
                    $('.memberList').append('<li data-id="'+_id+'">'+$(this).html()+'</li>');
                }
            })

            var objList;
            $('.popMiddle i').off().on('click',function(){
                /* var html = ''
                objList = $('#reserve_member .cur')
                objList.each(function(){
                    var _id = $(this).data('id')
                    html += '<li data-id="'+_id+'">'+$(this).html()+'</li>'
                })
                $('.memberList').empty().append(html) */
            })

            $('.memberList').on('click','li i',function(){
                $(this).parent().remove()
                var _id = $(this).parent().data('id')
                $('#reserve_member li').each(function(){
                    if($(this).data('id') == _id){
                        $(this).removeClass('cur')
                    }
                })
            })

            $('.save').on('click',function(){
            	var _select_user_ids = [];
            	$(".memberList li").each(function(){
            		_select_user_ids.push($(this).data("id"));
            	});
            	
            	$.ajax({
                    url : "${ctx}/sys/role/saveRoleUser",
                    async : false,
                    cache : false,
                    type : "POST",
                    data : {
                    	id: "${sysRole.id}",
                    	_csrf: "${_csrf }",
                    	"userIds": _select_user_ids.join(',')
                    },
                    dataType : "json",
                    success : function(result) {
                        if (result.success) {
                        	SetLayerData("_save_role_user", true);
                        	CloseIFrame();
                        } else {
                            NotifyInCurrentPage("error", result.msg, "删除机构错误");
                        }
                    }
                });
            })

            Module.init()
            
            $("#organ_list .root").trigger("click");
        });
        
        // 显示备选用户
        function showAlternativeUser() {
        	var _office_id = $("#organ_list .cur").data("id");
        	
        	var _select_user_ids = [];
        	$(".memberList li").each(function(){
        		_select_user_ids.push($(this).data("id") + "");
        	});
        	$("#reserve_member").empty();
        	$.get("${ctx}/sys/office/queryUserList", {id: _office_id, name : null}, function(data){
		    	if (data.success && data.data) {
		    		for (var i = 0; i < data.data.length; i++) {
		    			var _cur = "";
						if ($.inArray(data.data[i].id, _select_user_ids) >= 0) {
							_cur = "cur";
						}
						$("#reserve_member").append('<li data-id="' + data.data[i].id + '" class="'+ _cur +'">' + data.data[i].name + '<i></i></li>');
					}
		    	}
        	});
        }
        
        var Module = {
    		init:function(){
                $('#organ_list ul').each(function(){
                    if($(this).parent().hasClass('plus')){
                        $(this).hide()
                    }
                })
                this.hover()
                this.click()
                this.selected()
            },
            hover:function(){
                $('#organ_list ul li').bind('mouseover',function(e){
                    e.stopPropagation();
                    $('#organ_list ul li').find('i').hide()
                    $(this).children("p").children('i').show()
                })
                $('#organ_list ul li').bind('mouseout',function(e){
                    e.stopPropagation();
                    $(this).children("p").children('i').hide()
                })
            },
            click:function(){
                $('#organ_list').off().on('click','ul li',function(e){
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
                $('#organ_list').on('click','ul li p',function(e){
                    e.stopPropagation();
                    $('#organ_list li p,.root').removeClass('cur')
                    $('#organ_list li p').removeClass('cur')
                    $(this).addClass('cur')
                    showAlternativeUser();
                })
                $('.root').on('click',function(e){
                    e.stopPropagation();
                    $('#organ_list li p').removeClass('cur')
                    $(this).addClass('cur')
                    showAlternativeUser();
                })
            }
        }
    </script>
</body>
</html>
