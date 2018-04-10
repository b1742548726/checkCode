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
<link href="${imgStatic }/zwy/LBQ/css/overview.css" rel="stylesheet">

<style>
	* {
		margin: 0;
		padding: 0;
	}
	
	input.wd-btn-small {
		height: 20px;
		line-height: 20px;
		margin-left: 16px;
	}
</style>
</head>
<body>
	<div class="wd-content">
		<div class="left_info">
			<div class="client_deatil_top">
				<a href="javascript:;" class="back">返&nbsp;&nbsp;回</a>
				<c:set var="hasRisk" value="false" />
				<div class="risk_notice">
					<spring:eval expression="@wdPersonService.hasRisk(wdCustomer.personId, 'zhixin')" var="hasZhixin" />
					<spring:eval expression="@wdPersonService.hasRisk(wdCustomer.personId, 'shixin')" var="hasShixin" />
					<spring:eval expression="@wdCustomerBacklistService.selectBackByCustomerId(wdCustomer.id)" var="backlist" />
					<c:choose>
						<c:when test="${hasZhixin or hasShixin or not empty backlist }">
							<img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png" alt="">
							<c:set var="hasRisk" value="true" />
						</c:when>
						<c:otherwise>
							<img src="${imgStatic }/zwy/LBQ/images/icn_gray_s_risk.png" alt="">
						</c:otherwise>
					</c:choose>
					<p>
						<c:choose>
							<c:when test="${hasZhixin or hasShixin or not empty backlist }">
								<span>风险提示：</span>
								<c:if test="${not empty backlist }">
									黑名单客户，
                                </c:if>
								<c:if test="${hasZhixin }">
									被执行人，
                                </c:if>
								<c:if test="${hasShixin }">
									失信被执行人，
                                </c:if>
							</c:when>
							<c:otherwise>
								<span style="color: #ccc">风险提示：</span>无风险
                            </c:otherwise>
						</c:choose>
					</p>
				</div>
                <shiro:hasPermission name="wd:application:delete">
                    <a href="javascript:;" class="delcustomer" style="margin-left: 115px;background-color: #ff9630;border-radius: 5px;line-height: 35px;display: block;color: #f4f4f4;width: 100px;text-align: center;border: solid 1px #ccc;">删&nbsp;&nbsp;除</a>
                </shiro:hasPermission>
			</div>

			<ul class="client_detail_tab">
				<li class="cur"><a href="javascript:void(0);">客户信息</a></li>
				<li>
					<a href="${ctx }/wd/customer/riskWarning?customerId=${wdCustomer.id}">
						<c:if test="${hasRisk}">
							<img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png" alt="" class="tab_risk">
						</c:if> 风险提示
					</a>
				</li>
				<li>
					<a href="${ctx }/wd/customer/task?customerId=${wdCustomer.id}">客户动态</a>
				</li>
			</ul>

			<div class="personal_top">
				<div class="personal_info" id="client_info">
					<div class="innerHtml">
						<h3>
							个人信息 <!-- <span class="edit"></span> -->
							<span class="pos">${wdCustomer.customerTypeName}</span>
						</h3>
						<ul style="float: left; border-top: none" id="client_info_list">
							<c:forEach items="${wdCustomerTypeSettingList }"
								var="wdCustomerTypeSetting" varStatus="statusItem">
								<li>
									<label>${wdCustomerTypeSetting.elementName }：</label>
									<c:set var="wdBusinessElement" value="${wdBusinessElementConfig[wdCustomerTypeSetting.businessElementId] }" />
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
												<c:if test="${hasZhixin or hasShixin or not empty backlist }">
													<a href="${ctx }/wd/customer/riskWarning?customerId=${wdCustomer.id}" class="red_risk"></a>
												</c:if>
												
												<shiro:hasPermission name="wd:customer:editspecialinfo">
													<input type="text" value="${ wdPerson.getJsonData()[wdBusinessElement.key] }" name="personName" style="display: none; border: 1px solid #a4c3e2;padding: 0px 4px;border-radius: 4px;height: 24px;line-height: 24px;width:128px;" />
													<input type="button" class="btn wd-btn-small wd-btn-viridity saveName" name="personName" personId="${ wdPerson.id }" value="保存" style="display: none;margin: 0px 0px 2px 4px;" />
													<input type="button" class="btn wd-btn-small wd-btn-indigo cancelSave" name="personName" personId="${ wdPerson.id }" value="放弃" style="display: none;margin: 0px 0px 2px 2px;" />
													
													<input type="button" class="btn wd-btn-small wd-btn-white editName" personId="${ wdPerson.id }" value="修改" />
												</shiro:hasPermission>
											</p>
										</c:when>
										
										<c:when test="${wdBusinessElement.key eq 'base_info_idcard'}">
											<p>
												<ins>${wdPerson.getJsonData()[wdBusinessElement.key] }</ins>
												
												<shiro:hasPermission name="wd:customer:editspecialinfo">
													<input type="text" value="${ wdPerson.getJsonData()[wdBusinessElement.key] }" name="personIdNo" style="display: none; border: 1px solid #a4c3e2;padding: 0px 4px;border-radius: 4px;height: 24px;line-height: 24px;width:128px;" />
													<input type="button" class="btn wd-btn-small wd-btn-viridity saveIdNo" name="personIdNo" personId="${ wdPerson.id }" value="保存" style="display: none;margin: 0px 0px 2px 4px;" />
													<input type="button" class="btn wd-btn-small wd-btn-indigo cancelSave" name="personIdNo" personId="${ wdPerson.id }" value="放弃" style="display: none;margin: 0px 0px 2px 2px;" />
													
													<input type="button" class="btn wd-btn-small wd-btn-white editIdNo" personId="${ wdPerson.id }" value="修改" />
												</shiro:hasPermission>
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

			<div class="shop_info">
				<h3>
					贷款记录 <span>${applicationList.size() }条记录</span>
					<!-- <a href="#" class="color1 fr pos">逾期记录</a> -->
				</h3>
				<div class="tb_wrap">
					<table>
						<thead>
							<tr>
								<th>贷款编号</th>
								<th>产品名称</th>
								<th>贷款金额</th>
								<th>贷款状态</th>
								<th>最后更新时间</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${applicationList }" var="application">
								<tr>
									<td>
										<a class="btn color1" href="${ctx}/wd/application/detail?applicationId=${application.id}">${application.code }</a>
									</td>
									<td>${application.product_name }</td>
									<td>
										${application.amount }
									</td>
									<td>${fns:getProcessStatus(application.status_name) }</td>
									<td>
										<fmt:formatDate value="${application.update_date}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="shop_info ">
				<h3>
					客户关系人 <span>${customerRelationList.size() }条记录</span>
					<!-- <span class="add"></span> -->
				</h3>
				<div class="tb_wrap bg_color">
					<c:forEach items="${customerRelationList }" var="customerRelation">
						<ul>
							<li>
								<label for="">与申请人关系</label>
								<p>${customerRelation.relationType }</p> 
							</li>
							<c:forEach items="${config.customerRelation }" var="customerRelationConfig" varStatus="statusItem">
								<c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerRelationConfig.businessElementId] }" />
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
												<a href="${ctx }/wd/person/detail?personId=${customerRelation.personId}" class="color1 fl">
													${ customerRelation.getJsonData()[wdBusinessElement.key] }
												</a>
												<spring:eval expression="@wdPersonService.hasRisk(customerRelation.personId, null)" var="hasRisk" />
												<c:if test="${hasRisk }">
													<a href="${ctx }/wd/person/detail/risk?personId=${customerRelation.personId}&target=risk" class="red_risk"></a>
												</c:if>
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
				<h3>
					家庭主要资产（房产）<span>${customerBuildingList.size() }条记录</span>
					<!-- <span class="add"></span> -->
				</h3>
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
									<spring:eval expression="@wdPersonAssetsBuildingRelationService.selectBuildingRelationALLPerson(customerBuilding.id, wdCustomer.personId)" var="propertyOwnerList" />
									<td>
										<c:forEach items="${propertyOwnerList }" var="propertyOwner">
											${propertyOwner.name }（${propertyOwner.relationType }）
                                        </c:forEach>
                                    </td>
									<c:forEach items="${config.customerBuilding }" var="customerBuildingConfig">
										<c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerBuildingConfig.businessElementId] }" />
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
				<h3>
					家庭主要资产（车辆）<span>${customerCarList.size() }条记录</span>
					<!-- <span class="add"></span> -->
				</h3>
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
										<c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerCarConfig.businessElementId] }" />
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
	<script src="${imgStatic }/zwy/LBQ/js/overview.js"></script>
	<script>
		$(function() {
			function picPreview(_html, _index) {
				var parentId = $(parent.window.document).find('#dowebok')
				parentId.html(_html) //数据传入父页面图片列表
				window.parent.viewInit() //调用父页面图片预览注册方法
				parentId.find('li:eq(' + _index + ') img').click() //传入参数并触发预览
			}

			//计算iframe内部高度
			var list_height = $('.right_list').height()
			var content_height = $('.wd-content').height()
			if (list_height > content_height) {
				$('.wd-content').css('height', list_height + 20)
			}

			$('.innerHtml > ul > li:nth-of-type(even),.bg_color > ul > li:nth-of-type(even)').each(function() {
				$(this).prev("li").append($(this).html());
				$(this).remove();
			});

			$(".picbtn").click(function() {
				var _html = $(this).parent().siblings(".picList").html();
				if (!_html.trim()) {
					alert("暂无图片")
					return false;
				}
				picPreview(_html, 0);
			});

			$(".back").on("click", function() {
				location.href = "${customer_detail_back_url}";
			});
			
			$(".delcustomer").on("click", function() {
			 	confirmDelAppliation(function(){
			 		$.ajax({
		                url: "${ctx }/wd/customer/del",
		                type: "POST",
		                data: { "customerId": "${ wdCustomer.id }" },
		                dataType: "json",
		                cache: false,
		                success: function (result) { 
		                	if (result.success) {
		                		location.href = "${ customer_detail_back_url }";
		                    } else {
		                    	alert(result.msg);
		                    }
		                }
		            });	
			 	})
				
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

			function hideSaveSpecialInfo(obj) {
				$(obj).siblings(":hidden").show();
				$(obj).siblings("[name]").hide();
				$(obj).hide();
			}
			function showSaveSpecialInfo(obj) {
				$(obj).siblings("[name]").show();
				$(obj).siblings("ins").hide();
				$(obj).siblings("a").hide();
				$(obj).hide();
			}
			
			$(".cancelSave").on("click", function() {
				hideSaveSpecialInfo(this);
			});

			$(".editName").on("click", function() {
				showSaveSpecialInfo(this);
			});
			$(".editIdNo").on("click", function() {
				showSaveSpecialInfo(this);
			});
			
			$(".saveName").on("click", function() {
				var name = $(this).siblings("input[type=text][name=personName]").val();
				var personId = $(this).attr("personId");
				var element = $(this);

				$.ajax({
	                url: "${ctx }/wd/customer/change_name",
	                type: "POST",
	                data: { "personId": personId, "name": name },
	                dataType: "json",
	                cache: false,
	                success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
	                	if (result.success) {
	                		console.log(result.msg);

	        				$(element).siblings("ins").html(name);
	        				hideSaveSpecialInfo(element);
	                    } else {
	                    	alert(result.msg);
	                    }
	                }
	            });
				
			});
			$(".saveIdNo").on("click", function() {
				var idno = $(this).siblings("input[type=text][name=personIdNo]").val();
				var personId = $(this).attr("personId");
				var element = $(this);

				$.ajax({
	                url: "${ctx }/wd/customer/change_idno",
	                type: "POST",
	                data: { "personId": personId, "idno": idno },
	                dataType: "json",
	                cache: false,
	                success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
	                	if (result.success) {
	                		console.log(result.msg);

	        				$(element).siblings("ins").html(idno);
	        				hideSaveSpecialInfo(element);
	                    } else {
	                    	alert(result.msg);
	                    }
	                }
	            });
				
			});
			
		});
	</script>
</body>
</html>