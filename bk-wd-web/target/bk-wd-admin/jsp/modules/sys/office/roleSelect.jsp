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

    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

    <link href="${imgStatic }/zwy/LBQ/css/warning.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/organization.css" rel="stylesheet">
</head>
<body>

    <div class="wd-content">
        <div class="popupHtml">
            <div class="popLeft">
                <h4>角色列表</h4>
                <div class="popList">
                    <ul class="roleList" id="pop_roleList">
                        <c:forEach items="${roleList }" var="role">
                            <li data-id="${role.id }">${role.name }</li>
                        </c:forEach>
                    </ul>
                </div> 
            </div>

            <div class="popMiddle"><i></i></div>

            <div class="popRight">
                <h4>用户拥有查看以下团队数据的权限</h4>
                <ul class="memberList">
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
    
    <!-- 弹出层 -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script type="text/javascript">

        function setModuleValue() {
            var addmodule = { "name": $("#moduleName").val(), "code": $("#moduleCode").val() };
            SetLayerData("AddOneModule", addmodule);
        }

        $(document).ready(function () {
        	$('.roleList').on('click','li',function(){
                if($(this).hasClass('cur')){
                    $(this).removeClass('cur')
                }else{
                    $(this).addClass('cur')
                }
                $('.popMiddle i').click()
            })
            $('.memberList').empty()

            var objList2
            $('.popMiddle i').off().on('click',function(){
                var html = ''
                objList2 = $('#pop_roleList .cur')
                objList2.each(function(){
                    var _id = $(this).data('id')
                    html += '<li data-id="'+_id+'">'+$(this).html()+'<i></i></li>'
                })
                $('.memberList').empty().append(html)
            })

            $('.memberList').on('click','li i',function(){
                $(this).parent().remove()
                var _id = $(this).parent().data('id')
                $('#pop_roleList li').each(function(){
                    if($(this).data('id') == _id){
                        $(this).removeClass('cur')
                    }
                })
            })

            $('.save').on('click',function(){
            	var _role_list_data = {
        			_name : [],
        			_id : []
            	}
            	$('#pop_roleList .cur').each(function(){
            		_role_list_data._name.push($(this).html())
                    _role_list_data._id.push($(this).data("id"));
                })
            	SetLayerData("_user_role_save", true);
                SetLayerData("_role_list_data", _role_list_data);
                CloseIFrame();
            })
            
            var roleIds = "${roleIds}";
            if (roleIds) {
            	var roleArray = roleIds.split(",");
            	for (var i = 0; i < roleArray.length; i++) {
            		if (roleArray[i]) {
                    	$("#pop_roleList li[data-id=" + roleArray[i] + "]").trigger("click");
            		}
				}
            }
            $('.popMiddle i').click();
        });
    </script>
</body>
</html>