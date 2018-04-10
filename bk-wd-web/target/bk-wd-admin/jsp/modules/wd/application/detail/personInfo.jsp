<%@ page contentType="text/html;charset=UTF-8"%>
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
    
    <!--统一样式，不删-->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/LBQ/css/client_detail.css" rel="stylesheet">
    <link rel="stylesheet" href="${imgStatic }/zwy/LBQ/css/viewer.min.css">
</head>
<body>

    <div class="wd-content" style="background:#fff">
        <div class="left_info" style="margin:0">
            <div class="shop_info" style="margin:0">
                <div class="tb_wrap bg_color">
                    <ul id="${wdPerson.id }" style='${dataStatus.index == 0 ? "border: none;" : "" }'>
                        <li>
                        	<label>与申请人关系：</label>
                            <p>${extendInfo.relationType }</p>
                        </li>
                        <c:forEach items="${customerRelationConfigList }" var="customerRelationConfig">
                            <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(customerRelationConfig.businessElementId)" var="wdBusinessElement"/>
                            <li>
                            	<label>${customerRelationConfig.elementName }：</label>
                            	<c:choose>
                                    <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                        <wd:picList dataList="${wdPerson.getJsonData()[wdBusinessElement.key]}" />
                                    </c:when>
                                    <c:when test="${fns:getDataCategory(wdBusinessElement) == 4}">
                                        <p>
                                            ${(fns:getJSONType(wdPerson.getJsonData()[wdBusinessElement.key]) == 1) ?  fns:parseObject(wdPerson.getJsonData()[wdBusinessElement.key]).position_name : wdPerson.getJsonData()[wdBusinessElement.key]}
                                        </p>
                                    </c:when>
                                    <c:when test="${wdBusinessElement.specialType eq '1'}">
    									<p>
    										<ins>${ fns:hideTelInfo(wdPerson.getJsonData()[wdBusinessElement.key]) }</ins>
    											
    										<shiro:hasPermission name="wd:customer:showhideinfo">
    											<input type="button" class="btn wd-btn-small btn wd-btn-white hideTelInfo" key="${ wdBusinessElement.key }" personId="${ wdPerson.id }" value="查看" />
    										</shiro:hasPermission>
    									</p>
    								</c:when>
                                    <c:otherwise>
                                        <p>${wdPerson.getJsonData()[wdBusinessElement.key] }</p>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                        <c:if test="${null != configList}">
                            <c:forEach items="${configList}" var="config">
                                <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(config.businessElementId)" var="wdBusinessElement"/>
                                <li>
                                    <label>${wdBusinessElement.name }：</label>
                                    <c:choose>
                                        <c:when test="${fns:getDataCategory(wdBusinessElement) == 1 }">
                                            <wd:picList dataList="${extendInfo.getJsonData()[wdBusinessElement.key]}" />
                                        </c:when>
                                        <c:when test="${fns:getDataCategory(wdBusinessElement) == 4}">
                                            <p>
                                                ${(fns:getJSONType(extendInfo.getJsonData()[wdBusinessElement.key]) == 1) ?  fns:parseObject(extendInfo.getJsonData()[wdBusinessElement.key]).position_name : extendInfo.getJsonData()[wdBusinessElement.key]}
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>${extendInfo.getJsonData()[wdBusinessElement.key] }</p>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>

    </div>
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="${imgStatic }/build/js/custom.js"></script>
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    <script src="${imgStatic }/zwy/LBQ/js/viewer-jquery.min.js"></script>

    <script type="text/javascript">

        function setModuleValue() {
            var addmodule = { "name": $("#moduleName").val(), "code": $("#moduleCode").val() };
            SetLayerData("AddOneModule", addmodule);
        }
        
        $('.innerHtml > ul > li:nth-of-type(even),.bg_color > ul > li:nth-of-type(even)').each(function() {
			$(this).prev("li").append($(this).html());
			$(this).remove();
		})


        $(document).ready(function () {
            $("#cancle-add-module").click(function (event) {
                SetLayerData("AddOneModule", null);
                CloseIFrame();
            });

            $("#submit-add-module").click(function (event) {
                event.preventDefault();

                var _form = $('#form-add-module').find('input,textarea')
                _form.each(function(){
                    if($(this).val() == ''){
                        $(this).addClass('error')
                        $(this).next().removeClass('hide')
                    }else{
                        $(this).removeClass('error')
                        $(this).next().addClass('hide')
                    }
                })
                $('.warning ins').hover(function(e){
                    $(this).siblings('span').removeClass('hide')
                },function(){
                    $(this).siblings('span').addClass('hide')
                })

            });
            
            $(".hideTelInfo").on("click",function() {
				var element = $(this);
				$.ajax({
	                url: "${ctx }/wd/customer/hide_info?elementKey="+$(element).attr("key")+"&personId="+$(element).attr("personId"),
	                type: "GET",
	                dataType: "json",
	                cache: false,
	                success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
	                	if (result.success) {
							$(element).prev("ins").html(result.msg);
	        				$(element).hide();
	                    } else {
	                    	alert(result.msg);
	                    }
	                }
	            });
			});
            
            function picPreview(_html, _index) {
				var parentId = $(parent.window.document).find('#dowebok')
				parentId.html(_html) //数据传入父页面图片列表
				window.parent.viewInit() //调用父页面图片预览注册方法
				parentId.find('li:eq(' + _index + ') img').click() //传入参数并触发预览
			}

			$(".picbtn").click(function() {
				var _html = $(this).parent().siblings(".picList").html();
				if (!_html.trim()) {
					alert("暂无图片")
					return false;
				}
				picPreview(_html, 0);
			});
        });
    </script>
</body>
</html>