<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>客户详情</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/client_detail.css" rel="stylesheet">
<link rel="stylesheet" href="${imgStatic }/zwy/LBQ/css/viewer.min.css">
<style>
* { margin: 0; padding: 0;}
</style>
</head>
<body>
    <div class="wd-content">
        <div class="left_info">
           <div class="client_deatil_top">
                <c:if test="${empty targetType }">
                    <a href="javascript:;" class="back">返&nbsp;&nbsp;回</a>
                </c:if>
                <c:set var="hasRisk" value="false"/>
                <div class="risk_notice">
                    <spring:eval expression="@wdPersonService.hasRisk(personId, 'zhixin')" var="hasZhixin" />
                    <spring:eval expression="@wdPersonService.hasRisk(personId, 'shixin')" var="hasShixin" />
                    <c:choose>
                        <c:when test="${hasZhixin or hasShixin }">
                            <img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png">
                            <c:set var="hasRisk" value="true"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${imgStatic }/zwy/LBQ/images/icn_gray_s_risk.png">
                        </c:otherwise>
                    </c:choose>
                    <p>
                        <c:choose>
                            <c:when test="${hasZhixin or hasShixin }">
                                <span >风险提示：</span>
                                <c:if test="${hasZhixin }">
                                                                被执行人，
                                </c:if>
                                <c:if test="${hasShixin }">
                                                                失信被执行人，
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <span style="color:#ccc">风险提示：</span>无风险
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>

            <ul class="client_detail_tab">
                <li class="cur"><a href="javascript:void(0);">客户信息</a></li>
                <li><a href="${ctx }/wd/person/detail/risk?personId=${personId}">
                    <c:if test="${hasRisk}">
                        <img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png" alt="" class="tab_risk">
                    </c:if>
                                风险提示</a></li>
            </ul>

            <div class="personal_top">
                <div class="personal_info" id="client_info">
                    <div class="innerHtml">
                        <h3>个人信息</h3>
                        <ul style="float:left;border-top:none" id="client_info_list">
                            <c:forEach items="${config.customerRelation }" var="customerRelationConfig" varStatus="statusItem">
                                <li>
                                    <label>${customerRelationConfig.elementName }：</label>
                                    <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerRelationConfig.businessElementId] }"/>
                                    <c:choose>
    									<c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                            <wd:picList dataList="${wdPerson.getJsonData()[wdBusinessElement.key]}" />
                                        </c:when>
                                        <c:when test="${fns:getDataCategory(wdBusinessElement) == 4}">
                                            <p>
                                                ${(fns:getJSONType(wdPerson.getJsonData()[wdBusinessElement.key]) == 1) ?  fns:parseObject(wdPerson.getJsonData()[wdBusinessElement.key]).position_name : wdPerson.getJsonData()[wdBusinessElement.key]}
                                            </p>
                                        </c:when>
                                        <c:when test="${wdBusinessElement.key eq 'base_info_name'}">
                                            <p>
                                                <ins>${wdPerson.getJsonData()[wdBusinessElement.key] }</ins>
                                                <c:if test="${hasZhixin or hasShixin }">
                                                    <a href="${ctx }/wd/customer/riskWarning?customerId=${personId}" class="red_risk"></a>
                                                </c:if>
                                            </p>
                                        </c:when>
                                        
                                        
										<c:when test="${wdBusinessElement.specialType eq '1'}">
											<p>
                                            
												<ins>${ fns:hideTelInfo(wdPerson.getJsonData()[wdBusinessElement.key]) }</ins>
												
												<shiro:hasPermission name="wd:customer:showhideinfo">
													<input type="button" class="btn wd-btn-small wd-btn-white hideTelInfo" key="${ wdBusinessElement.key }" personId="${ wdPerson.id }" value="查看" />
												</shiro:hasPermission>
											</p>
										</c:when>
                                        
                                        <c:otherwise>
                                            <p>${wdPerson.getJsonData()[wdBusinessElement.key] }</p>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>


            <div class="shop_info ">
                <h3>客户关系人<span>${customerRelationList.size() }条记录</span><!-- <span class="add"></span> --></h3>
                <div class="tb_wrap bg_color">
                    <c:forEach items="${customerRelationList }" var="customerRelation">
                        <ul>
                            <li><label for="">与申请人关系</label><p>${customerRelation.relationType }<!-- <span class="edit"></span><span class="delete"></span> --></p>
                            <c:forEach items="${config.customerRelation }" var="customerRelationConfig" varStatus="statusItem">
                                <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerRelationConfig.businessElementId] }"/>
                                <li>
                                    <label>${customerRelationConfig.elementName }：</label>
                                    <c:choose>
                                        <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                            <wd:picList dataList="${customerRelation.getJsonData()[wdBusinessElement.key]}" />
                                        </c:when>
                                        <c:when test="${fns:getDataCategory(wdBusinessElement) == 4}">
                                            <p>
                                                ${(fns:getJSONType(customerRelation.getJsonData()[wdBusinessElement.key]) == 1) ?  fns:parseObject(customerRelation.getJsonData()[wdBusinessElement.key]).position_name : customerRelation.getJsonData()[wdBusinessElement.key]}
                                            </p>
                                        </c:when>
                                        <c:when test="${wdBusinessElement.key eq 'base_info_name'}">
                                            <p>
                                                <!-- <button class="color1 fl"> -->${customerRelation.getJsonData()[wdBusinessElement.key] }<!-- </button><a href="#" class="red_risk"></a> -->
                                            </p>
                                        </c:when>
                                        
										<c:when test="${wdBusinessElement.specialType eq '1'}">
											<p>
												<ins>${ fns:hideTelInfo(customerRelation.getJsonData()[wdBusinessElement.key]) }</ins>
												
												<shiro:hasPermission name="wd:customer:showhideinfo">
													<input type="button" class="btn wd-btn-small wd-btn-white hideTelInfo" key="${ wdBusinessElement.key }" personId="${ customerRelation.personId }" value="查看" />
												</shiro:hasPermission>
											</p>
										</c:when>
                                        
                                        <c:otherwise>
                                            <p>${customerRelation.getJsonData()[wdBusinessElement.key] }</p>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="shop_info">
                <h3>家庭主要资产（房产）<span>${customerBuildingList.size() }条记录</span><!-- <span class="add"></span> --></h3>
                <div class="tb_wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>产权人</th>
                                <c:forEach items="${config.customerBuilding }" var="customerBuildingConfig">
                                    <th>${customerBuildingConfig.elementName }</th>
                                </c:forEach>
                                <!-- <th>操作</th> -->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${customerBuildingList }" var="customerBuilding">
                                <tr>
                                    <spring:eval expression="@wdPersonAssetsBuildingRelationService.selectBuildingRelationALLPerson(customerBuilding.id, personId)" var="propertyOwnerList"/>
                                    <td>
                                        <c:forEach items="${propertyOwnerList }" var="propertyOwner">
                                            ${propertyOwner.name }（${propertyOwner.relationType }）
                                        </c:forEach>
                                    </td>
                                    <c:forEach items="${config.customerBuilding }" var="customerBuildingConfig">
                                        <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerBuildingConfig.businessElementId] }"/>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                    <wd:picList dataList="${customerBuilding.getJsonData()[wdBusinessElement.key]}" />
                                                </c:when>
                                                <c:otherwise>
                                                    ${customerBuilding.getJsonData()[wdBusinessElement.key] }
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </c:forEach>
                                   <!--  <td><span class="delete"></span><span class="edit"></span></td> -->
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="shop_info">
                <h3>家庭主要资产（车辆）<span>${customerCarList.size() }条记录</span><!-- <span class="add"></span> --></h3>
                <div class="tb_wrap">
                    <table>
                        <thead>
                            <tr>
                                 <c:forEach items="${config.customerCar }" var="customerCarConfig">
                                    <th>${customerCarConfig.elementName }</th>
                                </c:forEach>
                               <!--  <th>操作</th> -->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${customerCarList }" var="customerCar">
                                <tr>
                                    <c:forEach items="${config.customerCar }" var="customerCarConfig">
                                        <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerCarConfig.businessElementId] }"/>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                    <wd:picList dataList="${customerCar.getJsonData()[wdBusinessElement.key]}" />
                                                </c:when>
                                                <c:otherwise>
                                                    ${customerCar.getJsonData()[wdBusinessElement.key] }
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </c:forEach>
                                    <!-- <td><span class="delete"></span><span class="edit"></span></td> -->
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="clearfix"></div>
        </div>
    </div>
    
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script src="${imgStatic }/zwy/LBQ/js/viewer-jquery.min.js"></script>
<script>
$(function() {
	function picPreview(_html, _index) {
		var parentId = $(parent.window.document).find('#dowebok')
        parentId.html(_html)                            //数据传入父页面图片列表
        window.parent.viewInit()                        //调用父页面图片预览注册方法
        parentId.find('li:eq('+_index+') img').click()  //传入参数并触发预览
	}
	
    $('.innerHtml > ul > li:nth-of-type(even),.bg_color > ul > li:nth-of-type(even)').each(function(){
        $(this).prev("li").append($(this).html());
        $(this).remove();
    })
    
    $(".picbtn").click(function(){
		var _html = $(this).parent().siblings(".picList").html();
		if(!_html.trim()) {
			alert("暂无图片")	
			return false;
		}
		picPreview(_html, 0);
	});
    
    $(".back").on("click", function(){
		location.href = "${person_detail_back_url}";
	});
    
	$(".hideTelInfo").on("click", function() {
		var element = $(this);
		$.ajax({
            url: "${ctx }/wd/customer/hide_info?elementKey="+$(element).attr("key")+"&personId="+$(element).attr("personId"),
            type: "GET",
            dataType: "json",
            cache: false,
            success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
            	if (result.success) {
            		console.log(result.msg);
            		
					$(element).prev("ins").html(result.msg);
    				$(element).hide();
                } else {
                	alert(result.msg);
                }
            }
        });
	});
	
	//计算iframe内部高度
    var list_height = $('.right_list').height()
    var content_height = $('.wd-content').height()
    if(list_height > content_height){
        $('.wd-content').css('height',list_height + 20)
    }

});
</script>
</body>
</html>