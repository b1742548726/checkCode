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
            <ul class="name_bar">
                <li>
                    <label for="">机构名称</label>
                    <input type="text" id="name" value="${sysOffice.name }">
                </li>
            </ul>
            <div class="popLeft" style="width:50%;margin-right:0">
                <div class="title">父级机构</div>
                <div class="popList" style="width:auto">
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
            
            <div class="popMiddle" style="width:10%;height:352px;"><i></i></div>

            <div class="popRight" style="width:40%">
                <div class="ownership">
                    <div style="width:100%">
                        <h4>确认后将归属到以下组织</h4>
                        <ul class="memberList" style="height:45px;">
                        </ul>
                        <h5>不能将当前组归属到下级组中</h5>
                    </div>
                </div>
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
            $('.memberList').empty()

            var objList
            $('.popMiddle i').off().on('click',function(){
                var html = ''
                objList = $('#organ_list .cur')
                objList.each(function(){
                    html += '<li>'+$(this).html()+'</li>'
                })
                $('.memberList').empty().append(html)
            })

            $('.memberList').on('click','li i',function(){
                $(this).parent().remove()
            })
            $('.save').on('click',function(){
            	var _parent_id = $("#organ_list .cur").data("id");
            	$.ajax({
                    url : "${ctx}/sys/office/save",
                    async : false,
                    cache : false,
                    type : "POST",
                    data : {
                    	newParentId : _parent_id,
                    	name : $("#name").val(),
                    	_csrf: "${_csrf}",
                    	id : "${sysOffice.id}"
                    },
                    dataType : "json",
                    success : function(result) {
                        if (result.success) {
                        	SetLayerData("_save_office_data", true);
                        	CloseIFrame();
                        } else {
                            NotifyInCurrentPage("error", result.msg, "删除机构错误");
                        }
                    }
                });
            })

            Module.init()
            $("#organ_list [data-id=${sysOffice.parentId }]").trigger("click");
        });
        
        var Module = {
            init:function(){
                $('#organ_list ul').each(function(){
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
                $('#organ_list .add').off().on('click',function(e){
                    e.stopPropagation();
                    if($(this).parent().hasClass('root')){
                        var _html = '<li><p>新增<i class="add"></i><i class="remove"></i><i class="edit"></i></p></li>'
                        $('.root').next().append(_html)
                    }else if($(this).parent().next('ul').length > 0){
                        var _html = '<li><p>新增<i class="add"></i><i class="remove"></i><i class="edit"></i></p></li>'
                        $(this).parent().next('ul').append(_html)
                    }else{
                        var _html = '<ul><li><p>新增<i class="add"></i><i class="remove"></i><i class="edit"></i></p></li></ul>'
                        $(this).closest('li').removeClass('cur').addClass('reduce').append(_html)
                    }
                    self.add()
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
                    $(this).addClass('cur')
                    $('.popMiddle i').click()
                })
                $('.root').on('click',function(e){
                    e.stopPropagation();
                    $('#organ_list li p').removeClass('cur')
                    $(this).addClass('cur')
                    $('.popMiddle i').click()
                })
            }
        }
    </script>
</body>
</html>