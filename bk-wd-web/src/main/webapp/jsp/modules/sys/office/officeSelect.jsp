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
                <h4>权限列表</h4>
                <div class="popList">
                    <div class="organ_list" id="pop_organ_list">
                        <c:forEach items="${officeList }" var="office">
                            <div class="title" data-id="${office.id }">
                                <h3 class="root">${office.name }</h3>
                                <i class="box"></i>
                            </div>
                            <c:if test="${not empty office.childList}">
                                <ul>
                                    <sys:tree dataList="${office.childList }" box="true"></sys:tree>
                                </ul>
                            </c:if>
                        </c:forEach>
                    </div>
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
            $('.memberList').empty()

             var objList
            $('.popMiddle i').on('click',function(){
                var html = ''
                objList = $('#pop_organ_list .cur').prev()
                objList.each(function(){
                    var _id = $(this).parent().data('id')
                    html += '<li data-id="'+_id+'">'+$(this).html()+'<i></i></li>'
                })
                $('.memberList').empty().append(html)
            })

            $('.memberList').on('click','li i',function(){
                $(this).parent().remove()
                var _id = $(this).parent().data('id')
                $('#pop_organ_list i.box').each(function(){
                    if($(this).parent().data('id') == _id){
                        $(this).removeClass('cur')
                    }
                })
            })

            $('.save').on('click',function(){
            	var _office_list_data = {
        			_ids : [],
        			_names : []
            	}
                if (objList) {
                	objList.each(function(){
                		_office_list_data._names.push($(this).html())
                		_office_list_data._ids.push($(this).parent().data("id"));
                    })
                }
            	SetLayerData("_office_list_data", _office_list_data);
            	SetLayerData("_user_office_save", true);
                CloseIFrame();
            })

            //非联动列表组件
            var Module2 = {
                init:function(){
                    $('#pop_organ_list ul').each(function(){
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
                    $('#pop_organ_list .add').off().on('click',function(e){
                        e.stopPropagation();
                        if($(this).parent().hasClass('root')){
                            var _html = '<li><p>新增<i class="add"></i><i class="remove"></i><i class="edit"></i></p></li>'
                            $('#pop_organ_list .root').next().append(_html)
                        }else{
                            var _html = '<ul><li><p>新增<i class="add"></i><i class="remove"></i><i class="edit"></i></p></li></ul>'
                            $(this).closest('li').removeClass('cur').addClass('reduce').append(_html)
                        }
                        self.add()
                    })
                },
                click:function(){
                    $('#pop_organ_list').off().on('click','ul li',function(e){
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
                    $('#pop_organ_list').on('click','ul li p i',function(e){
                        e.stopPropagation();
                        if($(this).hasClass('cur')){
                            $(this).removeClass('cur')
                        }else{
                            $(this).addClass('cur')
                        }
                        $('.popMiddle i').click()
                    })
                    $('#pop_organ_list').on('click','.title i',function(e){
                        e.stopPropagation();
                        if($(this).hasClass('cur')){
                            $(this).removeClass('cur')
                        }else{
                            $(this).addClass('cur')
                        }
                        $('.popMiddle i').click()
                    })
                }
            }
            Module2.init();
            
            var officeIds = "${officeIds}";
            if (officeIds) {
            	var officeArray = officeIds.split(",");
            	for (var i = 0; i < officeArray.length; i++) {
            		if (officeArray[i]) {
                    	$("#pop_organ_list li p[data-id=" + officeArray[i] + "]").find("i.box").trigger("click");
            		}
				}
            }
            $('.popMiddle i').click();
        });
    </script>
</body>
</html>