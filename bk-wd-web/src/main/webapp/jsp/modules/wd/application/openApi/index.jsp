<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${wdApplication.customerName}【 ${wdApplication.code}】</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css?timer=0.32323323" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/overview.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/soft_info.css?timer=0.32323323" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/assets.css?timer=0.32323323" rel="stylesheet">
<!-- iCheck -->
<link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<link href="${imgStatic }/vendors/iCheck/skins/flat/blue.css" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/applicant_info.css?timer=0.32323323" rel="stylesheet">

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
	
	#photoViewer {
		min-height: 286px;
		padding-bottom: 20px;
	}
	
	#photoViewer .picgroupBtn {
		margin-bottom: 20px;
	}
	
	#layerIframe1 {
		background:transparent;
		position:fixed;
		z-index:1;
		top:0;
		left:0;
		overflow: scroll;
		height: 100%;
		width:100%
	}
	
	.title {
		background: orange!important;
		filter:progid:DXImageTransform.Microsoft.Alpha(opacity=40);
		opacity: .8;
	}
	
	#menu_content {
		display:block;
		filter:progid:DXImageTransform.Microsoft.Alpha(opacity=40);
		background: #000000!important;
		opacity: .5;
	}
	
	.picgroupBtn {
		cursor: pointer;
	}
	
	table {
		border-collapse: collapse;
	}
	
	.index_relation td, #_creditInvestigation td, #_assets td {
		border:1px solid #ddd!important;
	}
	
	h3 {
		color:black;
	}
	
	.left_info .tab_content .personal_info .innerHtml .tb_wrap ul {
		border: none!important;
	}
	
	.tab_content {
		padding-bottom: 30px;
	}
	
	#_applicationTask {
		padding-bottom: 10px;
	}
	
	/*jyshen*/
	#tab_relationship td {
		padding:5px;
	}

    
</style>
</head>
<body>
    <div class="wd-content wd-content1" id="applicationPrintArea">
        <div class="left_info">
            <div class="tab_content">
                <div class="shop_info index_relation" data-indexname="人员列表" id="_personList">
                    <div class="shop_info index_relation" id="div_rylb">
                        <h3>人员列表</h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>与本次贷款的关系</th>
                                        <th>姓名</th>
                                        <th>关系</th>
                                        <th>性别</th>
                                        <th>身份证</th>
                                       <!--  <th>年龄</th> -->
                                        <!-- <th>风险提示</th> -->
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="hasOtherRelation" value="0"/>
                                    <c:forEach items="${personRelationList }" var="personRelation">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${('本人' eq personRelation.relationType)}">
                                                                                                                                                                                                本人
                                                    </c:when>
                                                    <c:when test="${personRelation.isCoborrower}">
                                                                                                                                                                                                共同借款人
                                                    </c:when>
                                                    <c:when test="${personRelation.isRecognizor}">
                                                                                                                                                                                                         担保人
                                                    </c:when>
                                                    <c:otherwise>
                                                                                                                                                                                                 其他关系人
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${personRelation.wdPerson.getJsonData().base_info_name }</td>
                                            <td>${personRelation.relationType }</td>
                                            <td>${personRelation.wdPerson.getJsonData().base_info_gender }</td>
                                            <td>${personRelation.wdPerson.getJsonData().base_info_idcard }</td>
                                           <!--  <td>43</td> -->
                                           <%--  <td>
                                                <spring:eval expression="@wdPersonService.hasRisk(personRelation.wdPerson.id, null)" var="hasRisk" />
                                                <c:choose>
                                                    <c:when test="${hasRisk }">
                                                        <a class="color3 btn openlink" href="${ctx}/wd/application/detail/riskNotice?applicationId=${applicationId}&personId=${personRelation.wdPerson.id}">有风险</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="color2 btn openlink" href="${ctx}/wd/application/detail/riskNotice?applicationId=${applicationId}&personId=${personRelation.wdPerson.id}">无风险</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td> --%>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <c:if test="${null != productConfig['00000000-0000-0000-0000-111111111111']}">
                    <div class="personal_info" data-indexname="房产抵押" id="_buildingMortgage">
                        <div class="innerHtml">
                            <h3>
                                                                                                             房产抵押 <span>${applicationBuildingMortgageList.size() }条记录</span>
                            </h3>
                            <div class="tb_wrap bg_color">
                                <c:forEach items="${applicationBuildingMortgageList }" var="data">
                                    <spring:eval expression="@wdPersonAssetsBuildingService.selectByPrimaryKey(data.originalId)"
                                        var="wdPersonAssetsBuilding" />
                                    <ul>
                                        <li>
                                            <label>产权人：</label>  
                                            <p>
                                                <spring:eval expression="@wdPersonAssetsBuildingRelationService.selectBuildingRelationALLPerson(wdPersonAssetsBuilding.id, wdCustomer.personId)" var="propertyOwnerList"/>
                                                <c:forEach items="${propertyOwnerList }" var="propertyOwner">
                                                    ${propertyOwner.name }（${propertyOwner.relationType }）
                                                </c:forEach>
                                            </p>
                                        </li>
                                        <c:forEach items="${customerBuildingConfigList }" var="customerBuildingConfig">
                                            <c:set var="wdBusinessElement"
                                                value="${wdBusinessElementConfig[customerBuildingConfig.businessElementId] }" />
                                            <li><label>${customerBuildingConfig.elementName }：</label> <c:choose>
                                                    <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                        <wd:picList
                                                            dataList="${wdPersonAssetsBuilding.getJsonData()[wdBusinessElement.key]}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p>${wdPersonAssetsBuilding.getJsonData()[wdBusinessElement.key] }</p>
                                                    </c:otherwise>
                                                </c:choose></li>
                                        </c:forEach>
                                        <c:forEach items="${productConfig['00000000-0000-0000-0000-111111111111']}" var="config">
                                            <c:set var="wdBusinessElement"
                                                value="${wdBusinessElementConfig[config.businessElementId] }" />
                                            <li>
                                            	<label>${wdBusinessElement.name }：</label> <c:choose>
                                                    <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                        <wd:picList dataList="${data.getJsonData()[wdBusinessElement.key]}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p>${data.getJsonData()[wdBusinessElement.key] }</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </c:forEach>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${null != productConfig['EEEEEEEE-EEEE-EEEE-EEEE-FFFFFFFFFFFF']}">
                    <div class="personal_info" data-indexname="车贷抵押" id="_carLoanMortgage">
                        <div class="innerHtml">
                            <h3>
                                车贷抵押 <span>${applicationCarLoanMortgageList.size() }条记录</span>
                            </h3>
                            <div class="tb_wrap bg_color">
                                <c:forEach items="${applicationCarLoanMortgageList }" var="data">
                                    <ul>
                                        <li>
                                            <label>抵押人：</label>  
                                            <p>
                                                ${data.personName }【${data.relationType}】
                                            </p>
                                        </li>
                                        <c:forEach items="${productConfig['EEEEEEEE-EEEE-EEEE-EEEE-FFFFFFFFFFFF']}" var="config">
                                            <c:set var="wdBusinessElement"
                                                value="${wdBusinessElementConfig[config.businessElementId] }" />
                                            <li><label>${wdBusinessElement.name }：</label> <c:choose>
                                                    <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                        <wd:picList dataList="${data.getJsonData()[wdBusinessElement.key]}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p>${data.getJsonData()[wdBusinessElement.key] }</p>
                                                    </c:otherwise>
                                                </c:choose></li>
                                        </c:forEach>
                                    </ul>
                                </c:forEach>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <div class="shop_info" data-indexname="征信" id="_creditInvestigation">
                    <div class="innerHtml">
                    <h3>征信<span>${applicationCreditInvestigationList.size() }条记录</span></h3>
                    <div class="tb_wrap bg_color">
                        <table>
                            <thead>
                                <tr>
                                    <th>姓名/企业</th>
                                    <th>与借款人关系</th>
                                    <th>信用卡信用记录</th>
                                    <th>贷款信用记录</th>
                                    <th>个人征信系统</th>
                                    <th>贷款记录（个人征信）</th>
                                    <th>贷款记录（在我行）</th>
                                    <th>征信结果</th>
                                    <!-- <th>征信资料</th> -->
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${applicationCreditInvestigationList }" var="applicationCreditInvestigation">
                                    <tr>
                                        <td>${applicationCreditInvestigation.name}</td>
                                        <td>${applicationCreditInvestigation.relationType}</td>
                                        <td>${applicationCreditInvestigation.creditCardRecord}</td>
                                        <td>${applicationCreditInvestigation.loanRecord}</td>
                                        <td>${applicationCreditInvestigation.personalCreditSystem}</td>
                                        <td>${applicationCreditInvestigation.creditRecord}</td>
                                        <td>${applicationCreditInvestigation.creditRecordOurBank}</td>
                                        <td>${applicationCreditInvestigation.result}</td>
                                        <%-- <td><p><a class="color1 btn openlink" href="${ctx}/wd/application/credit/detail?creditId=${applicationCreditInvestigation.id}">征信资料</a></p></td> --%>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                    </div>
                </div>
                
                <div class="personal_info">
                    <div class="innerHtml">
                        <h3>个人信息<!-- <span class="edit"></span> --><span class="pos">${wdCustomer.customerTypeName}</span></h3>
                        <ul style="border-top: none">
                            <c:forEach items="${customerTypeConfigList }" var="wdCustomerTypeSetting" varStatus="statusItem">
                                <li>
                                    <label>${wdCustomerTypeSetting.elementName }：</label>
                                    <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[wdCustomerTypeSetting.businessElementId] }"/>
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
                                            <p><ins>${wdPerson.getJsonData()[wdBusinessElement.key] }</ins><!-- <a href="#" class="red_risk"></a> --></p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>${wdPerson.getJsonData()[wdBusinessElement.key] }</p>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
                
                <div class="personal_info" data-indexname="申请信息" id="_applicationinfo">
                    <div class="innerHtml">
                        <h3>
                            申请信息<span class="pos">申请编号：${wdApplication.code}</span>
                        </h3>
                        <ul style="border-top: none">
                            <li><label for="">产品名称：</label>
                                <p>${wdApplication.productName }</p></li>
                            <li><label for="">申请时间：</label>
                                <p>
                                    <fmt:formatDate value="${wdApplication.createDate}" pattern="yyyy-MM-dd HH:mm:dd" />
                                </p></li>
                            <c:if test="${not empty wdApplication.contractCode }">
                                <li><label for="">合同编号：</label>
                                    <p>${wdApplication.contractCode }</p></li>
                            </c:if>
                            <c:forEach items="${applyAuditInfoConfig }" var="simpleModuleSetting" varStatus="statusItem">
                                <li><c:set var="wdBusinessElement" value="${wdBusinessElementConfig[simpleModuleSetting.businessElementId] }" />
                                         <label for="">${wdBusinessElement.name }：</label>
                                    <p>${wdApplication.getApplyInfoJson()[wdBusinessElement.key] }</p></li>
                            </c:forEach>
                            <c:forEach items="${productConfig['AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA']}" var="applictionInfoConfig"
                                varStatus="statusItem">
                                <li><c:set var="wdBusinessElement"
                                        value="${wdBusinessElementConfig[applictionInfoConfig.businessElementId] }" /> <label
                                        for="">${wdBusinessElement.name }：</label>
                                    <p>${wdApplication.getApplyInfoJson()[wdBusinessElement.key] }</p></li>
                            </c:forEach>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
                
                <c:if test="${not empty wdApplication.getAuditConclusionJson()}">
                    <div class="personal_info" data-indexname="调查结论" id="_auditConclusion">
                        <div class="innerHtml">
                            <h3>调查结论</h3>
                            <div class="tb_wrap bg_color">
                                <ul>
                                    <c:forEach items="${applyAuditInfoConfig }" var="simpleModuleSetting" varStatus="statusItem">
                                        <spring:eval
                                            expression="@wdBusinessElementService.selectByPrimaryKey(simpleModuleSetting.businessElementId)"
                                            var="wdBusinessElement" />
                                        <li><label for="">${wdBusinessElement.name }：</label>
                                            <p>${wdApplication.getAuditConclusionJson()[wdBusinessElement.key] }</p></li>
                                    </c:forEach>
                                    <c:forEach items="${productConfig['BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB']}"
                                        var="auditConclusionConfig" varStatus="statusItem">
                                        <c:set var="wdBusinessElement"
                                            value="${wdBusinessElementConfig[auditConclusionConfig.businessElementId] }" />
                                        <li><label for="">${wdBusinessElement.name }：</label>
                                            <p>${wdApplication.getAuditConclusionJson()[wdBusinessElement.key] }</p></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <div class="personal_info" id="${wdCustomer.personId }">
                    <div class="innerHtml ordinary" data-indexname="个人信息" id="_personInfo">
                        <h3>
                                                                                                 个人信息<span class="pos">${wdCustomer.customerTypeName}</span>
                        </h3>
                        <ul style="float: left; border-top: none">
                            <c:forEach items="${customerTypeConfigList }" var="wdCustomerTypeSetting" varStatus="statusItem">
                                <li><label>${wdCustomerTypeSetting.elementName }：</label> <c:set var="wdBusinessElement"
                                        value="${wdBusinessElementConfig[wdCustomerTypeSetting.businessElementId] }" /> <c:choose>
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
                                                <!-- <a href="#" class="red_risk"></a> -->
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
                                    </c:choose></li>
                            </c:forEach>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
                
                <c:if test="${null != productConfig['44444444-4444-4444-4444-444444444444']}">
                    <div class="personal_info" data-indexname="辅助信息" id="_extendInfo">
                        <div class="innerHtml">
                            <h3>辅助信息</h3>
                            <div class="tb_wrap bg_color">
                                <ul>
                                    <c:forEach items="${productConfig['44444444-4444-4444-4444-444444444444']}" var="config"
                                        varStatus="statusItem">
                                        <li><c:set var="wdBusinessElement"
                                                value="${wdBusinessElementConfig[config.businessElementId] }" /> <label for="">${wdBusinessElement.name }：</label>
                                            <p>${wdApplicationExtendInfo.getJsonData()[wdBusinessElement.key] }</p></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <%-- <c:if test="${null != productConfig['GGGGGGGG-GGGG-GGGG-GGGG-GGGGGGGGGGGG']}">
                    <div class="personal_info" data-indexname="信用卡信息" id="_creditCardInfo">
                        <div class="innerHtml">
                            <h3>信用卡信息</h3>
                            <div class="tb_wrap bg_color">
                                <ul>
                                    <c:forEach items="${productConfig['GGGGGGGG-GGGG-GGGG-GGGG-GGGGGGGGGGGG']}" var="config">
                                        <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }" />
                                        <li>
                                            <label>${wdBusinessElement.name }：</label>
                                            <c:choose>
                                                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                    <wd:picList dataList="${wdApplicationCreditCardInfo.getJsonData()[wdBusinessElement.key]}" />
                                                </c:when>
                                                <c:when test="${fns:getDataCategory(wdBusinessElement) == 3}">
                                                    <c:choose>
                                                        <c:when test="${not empty wdApplicationCreditCardInfo.getJsonData()[wdBusinessElement.key] }">
                                                            <P><button class="color1 id_card_photo" data-idcard='${wdApplicationCreditCardInfo.getJsonData()[wdBusinessElement.key] }'>打印身份证照片</button></P>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <P><button class="color4">无身份证照片</button></P>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <p>${wdApplicationCreditCardInfo.getJsonData()[wdBusinessElement.key] }</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if> --%>
                
                <c:if test="${null != productConfig['66666666-6666-6666-6666-666666666666']}">
                    <div class="personal_info" data-indexname="收入损益表(月)" id="_monthlyIncomeStatement">
                        <div class="innerHtml">
                            <h3>收入损益表(月)</h3>
                            <div class="tb_wrap bg_color">
                                <ul>
                                    <c:forEach items="${productConfig['66666666-6666-6666-6666-666666666666']}" var="config"
                                        varStatus="statusItem">
                                        <li><c:set var="wdBusinessElement"
                                                value="${wdBusinessElementConfig[config.businessElementId] }" /> <label for="">${wdBusinessElement.name }：</label>
                                            <p>${applicationMonthlyIncomeStatement.getJsonData()[wdBusinessElement.key] }</p></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${null != productConfig['55555555-5555-5555-5555-555555555555']}">
                    <div class="personal_info" data-indexname="收入损益表(年)" id="_yearlyIncomeStatement">
                        <div class="innerHtml">
                            <h3>收入损益表(年)</h3>
                            <div class="tb_wrap bg_color">
                                <ul>
                                    <c:forEach items="${productConfig['55555555-5555-5555-5555-555555555555']}" var="config"
                                        varStatus="statusItem">
                                        <li><c:set var="wdBusinessElement"
                                                value="${wdBusinessElementConfig[config.businessElementId] }" /> <label for="">${wdBusinessElement.name }：</label>
                                            <p>${applicationYearlyIncomeStatement.getJsonData()[wdBusinessElement.key] }</p></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${null != productConfig['77777777-7777-7777-7777-777777777777']}">
                    <div class="personal_info" data-indexname="家庭资产负债表" id="_balanceSheet">
                        <div class="innerHtml">
                            <h3>家庭资产负债表</h3>
                            <div class="tb_wrap bg_color">
                                <ul>
                                    <c:forEach items="${productConfig['77777777-7777-7777-7777-777777777777']}" var="config"
                                        varStatus="statusItem">
                                        <li><c:set var="wdBusinessElement"
                                                value="${wdBusinessElementConfig[config.businessElementId] }" /> <label for="">${wdBusinessElement.name }：</label>
                                            <p>${applicationBalanceSheet.getJsonData()[wdBusinessElement.key] }</p></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <div class="shop_info" data-indexname="家庭主要资产（房产）" id="_customerBuilding">
                    <h3>
                                                                            家庭主要资产（房产）<span>${customerBuildingList.size() }条记录</span>
                    </h3>
                    <div class="tb_wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>产权人</th>
                                    <c:forEach items="${customerBuildingConfigList }" var="customerBuildingConfig">
                                        <th>${customerBuildingConfig.elementName }</th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customerBuildingList }" var="customerBuilding">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty customerBuilding.getOwnerData()}">
                                                    <c:forEach items="${customerBuilding.getOwnerData() }" var="propertyOwner">
                                                        ${propertyOwner.name }（${propertyOwner.relationType }）
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <spring:eval expression="@wdPersonAssetsBuildingRelationService.selectBuildingRelationALLPerson(customerBuilding.id, wdCustomer.personId)" var="propertyOwnerList"/>
                                                    <c:forEach items="${propertyOwnerList }" var="propertyOwner">
                                                        ${propertyOwner.name }（${propertyOwner.relationType }）
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <c:forEach items="${customerBuildingConfigList }" var="customerBuildingConfig">
                                            <c:set var="wdBusinessElement"
                                                value="${wdBusinessElementConfig[customerBuildingConfig.businessElementId] }" />
                                            <td><c:choose>
                                                    <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                        <wd:picList
                                                            dataList="${customerBuilding.getJsonData()[wdBusinessElement.key]}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                    ${customerBuilding.getJsonData()[wdBusinessElement.key] }
                                                </c:otherwise>
                                                </c:choose></td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="shop_info" data-indexname="家庭主要资产（车辆）" id="_customerCar">
                    <h3>
                                                                            家庭主要资产（车辆）<span>${customerCarList.size() }条记录</span>
                    </h3>
                    <div class="tb_wrap">
                        <table>
                            <thead>
                                <tr>
                                    <c:forEach items="${customerCarConfigList }" var="customerCarConfig">
                                        <th>${customerCarConfig.elementName }</th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customerCarList }" var="customerCar">
                                    <tr>
                                        <c:forEach items="${customerCarConfigList }" var="customerCarConfig">
                                            <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerCarConfig.businessElementId] }" />
                                            <td><c:choose>
                                                    <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                        <wd:picList dataList="${customerCar.getJsonData()[wdBusinessElement.key]}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${customerCar.getJsonData()[wdBusinessElement.key] }
                                                    </c:otherwise>
                                                </c:choose></td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <c:if test="${not empty complexProductConfig['11111111-1111-1111-1111-111111111111']}">
                    <div class="personal_info" data-indexname="经营信息" id="_business">
                        <div class="innerHtml">
                            <h3>
                                                                                                         经营信息<span>${wdApplicationBusinesList.size() }条记录</span>
                            </h3>
                            <div class="tb_wrap bg_color">
                                <c:forEach items="${wdApplicationBusinesList }" var="wdApplicationBusines">
                                    <ul>
                                        <c:forEach items="${productConfig['11111111-1111-1111-1111-111111111111']}" var="config"
                                            varStatus="itemStatus">
                                            <li><label for="">${config.name }：</label>
                                                <p>${wdApplicationBusines.getJsonData()[config.key] }</p></li>
                                        </c:forEach>
                                    </ul>
                                </c:forEach>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    
                    <div class="shop_info" data-indexname="侧面调查" id="_indirectInvestigation">
                        <h3>侧面调查</h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>名称</th>
                                        <th>对借款人人品评价</th>
                                        <th>对借款人家庭情况评价</th>
                                        <th>对借款人收入来源评价</th>
                                        <th>对借款人资产情况评价</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${wdApplicationIndirectInvestigationList }"
                                        var="wdApplicationIndirectInvestigation">
                                        <tr>
                                            <td>${wdApplicationIndirectInvestigation.name }</td>
                                            <td>${wdApplicationIndirectInvestigation.characters }</td>
                                            <td>${wdApplicationIndirectInvestigation.familySituation }</td>
                                            <td>${wdApplicationIndirectInvestigation.courceIncome }</td>
                                            <td>${wdApplicationIndirectInvestigation.assetSituation }</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="shop_info" data-indexname="软信息不对称偏差分析" id="_softinfo">
                        <h3>软信息不对称偏差分析</h3>
                        <!--modified by jyshen-->
                        <div class="tb_wrap" style="position: relative;">
                            <table class="style2 soft-left-sheet-tabel" style="border-collapse:separate!important">
                                <thead>
                                <tr>
                                    <th>婚姻情况<div name="div_source">来源：基本信息</div></th>
                                    <th>年龄<div name="div_source">基本信息</div></th>
                                    <th>经营年限<div name="div_source">辅助信息</div></th>
                                    <th>居住年限<div name="div_source">辅助信息</div></th>
                                    <th>财产状况<div name="div_source">辅助信息</div></th>
                                    <th>信用记录<div name="div_source">征信报告</div></th>
                                    <th>子女<div name="div_source">辅助信息</div></th>
                                    <th>配偶<div name="div_source">辅助信息</div></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="cl1" data-index="0">离婚</td>
                                    <td class="cl1" data-index="1">45岁-55(60)岁</td>
                                    <td class="cl1 " data-index="2">1年以下</td>
                                    <td class="cl1" data-index="3">3年以下</td>
                                    <td class="cl1" data-index="4">少量私人财产</td>
                                    <td class="cl1" data-index="5">非主观不良信用记录</td>
                                    <td class="cl1" data-index="6">无事</td>
                                    <td class="cl1" data-index="7">无单位</td>
                                </tr>
                                <tr>
                                    <td class="cl2" data-index="0">再婚</td>
                                    <td rowspan="2" data-index="1" class="cl3 ">30岁-45岁</td>
                                    <td class="cl2" data-index="2">3-5年</td>
                                    <td rowspan="2" class="cl3 " data-index="3">本地人或居住10年以上</td>
                                    <td class="cl2" data-index="4">有部分私人财产</td>
                                    <td rowspan="2" class="cl3 " data-index="5">良好信用记录或无信用记录</td>
                                    <td class="cl2" data-index="6">工作</td>
                                    <td class="cl2" data-index="7">当地单位稳定</td>
                                </tr>
                                <tr>
                                    <td class="cl3 " data-index="0">已婚</td>
                                    <td class="cl3" data-index="2">5年以上</td>
                                    <td class="cl3 " data-index="4" >良好私人财产状况</td>
                                    <td class="cl3 " data-index="6">年幼或上学</td>
                                    <td class="cl3" data-index="7">参与生意</td>
                                </tr>
                                <tr>
                                    <td class="cl1" data-index="0">未婚</td>
                                    <td class="cl1" data-index="1">30岁以下</td>
                                    <td class="cl1" data-index="2">1-3年</td>
                                    <td class="cl1" data-index="3">3-10年</td>
                                    <td class="cl1" data-index="4">没有私人财产</td>
                                    <td class="cl1" data-index="5">不良信用记录</td>
                                    <td class="cl1" data-index="6">无子女</td>
                                    <td class="cl1 " data-index="7">其他工作或生意</td>
                                </tr>
                                
                                <tr id="tr_Explanation">
                                    <td>合理性解释</td>
                                    <td colspan="7">${applicationInfoDeviationAnalysis.rationalExplanation}</td>
                                </tr>
                            </tbody>
                            </table>
                        </div>
                    
                        <ul class="si_list">
                            <li><label>私人财产类型</label>
                                <div class="label_content">
                                    <c:forEach items="${applicationInfoDeviationAnalysis.getPrivatePropertyTypeJson()}"
                                        var="privatePropertyType">
                                        ${privatePropertyType } &nbsp;&nbsp;
                                    </c:forEach>
                                </div></li>
                            <li><label>客户信息收集与核实</label>
                                <div class="label_content">
                                    <c:forEach items="${applicationInfoDeviationAnalysis.getCollectionVerificationJson()}"
                                        var="collectionVerification">
                                        ${collectionVerification } &nbsp;&nbsp;
                                    </c:forEach>
                                </div></li>
                            <li><label>借款人履历，附带其资本累计</label>
                                <div class="label_content">${applicationInfoDeviationAnalysis.customerRecord}</div></li>
                            <li><label>对现状的评价：经营组织，市场及财务情况</label>
                                <div class="label_content">${applicationInfoDeviationAnalysis.actualityAssessment}</div></li>
                            <li><label>事业情况</label>
                                <div class="label_content">${applicationInfoDeviationAnalysis.careerSituation}</div></li>
                            <li><label>申请贷款的原因</label>
                                <div class="label_content">${applicationInfoDeviationAnalysis.loanReason}</div></li>
                            <li><label>客户在家庭或在社会经济网中的状况</label>
                                <div class="label_content">${applicationInfoDeviationAnalysis.customerSituation}</div></li>
                            <li><label>主要供应商</label>
                                <div class="label_content">
                                    <table class="style3 wd100">
                                        <thead>
                                            <tr>
                                                <th>主要供应商</th>
                                                <th>采购比例 (%)</th>
                                                <th>付款条件</th>
                                                <th>往来时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${applicationInfoDeviationAnalysis.getMainVendorJson() }" var="mainVendor">
                                               <c:choose>
                                                 <c:when test="${fns:isString(mainVendor) || empty mainVendor}">
                                                        ${mainVendor }
                                                 </c:when>
                                                     <c:otherwise>
                                                        <tr>
                                                            <td>${mainVendor.supplier}</td>
                                                            <td>${mainVendor.Proportion}</td>
                                                            <td>${mainVendor.Condition}</td>
                                                            <td>${mainVendor.time}</td>
                                                        </tr>
                                                 </c:otherwise>
                                               </c:choose>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="clearfix"></div></li>
                            <li><label>主要客户</label>
                                <div class="label_content">
                                    <table class="style3 wd100">
                                        <thead>
                                            <tr>
                                                <th>主要客户</th>
                                                <th>销售比例 (%)</th>
                                                <th>付款条件</th>
                                                <th>往来时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${applicationInfoDeviationAnalysis.getMainCustomerJson() }"
                                                var="mainCustomer">
                                                <tr>
                                                    <td>${mainCustomer.client}</td>
                                                    <td>${mainCustomer.Proportion}</td>
                                                    <td>${mainCustomer.Condition}</td>
                                                    <td>${mainCustomer.time}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="clearfix"></div></li>
                        </ul>
                    </div>
                    
                    <div class="shop_info">
                        <h3>存货<span style="margin-left: 2em;">存货可销售金额: ${wdApplicationOutstandingAccount.goodsSaleTotal } </span><span>存货合计 : ${wdApplicationOutstandingAccount.goodsTotal } </span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>货物地点</th>
                                        <th>类别</th>
                                        <th>名称</th>
                                        <th>比例</th>
                                        <th>金额</th>
                                        <th>数量</th>
                                        <th>单位</th>
                                        <th>进价</th>
                                        <th>售价</th>
                                        <th>毛利率</th>
                                        <th>备注</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${wdApplicationGoodsList }" var="wdApplicationGoods">
                                        <tr>
                                            <td>${wdApplicationGoods.goodsAddress }</td>
                                            <td>${wdApplicationGoods.type }</td>
                                            <td>${wdApplicationGoods.name }</td>
                                            <td>${wdApplicationGoods.proportion }</td>
                                            <td>${wdApplicationGoods.price }</td>
                                            <td>${wdApplicationGoods.number }</td>
                                            <td>${wdApplicationGoods.units }</td>
                                            <td>${wdApplicationGoods.buyPrice }</td>
                                            <td>${wdApplicationGoods.sellingPrice }</td>
                                            <td>${wdApplicationGoods.rate }</td>
                                            <td>${wdApplicationGoods.memo }</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="shop_info">
                        <h3>固定资产<span style="margin-left: 2em;">折旧总额 : ${wdApplicationOutstandingAccount.fixAssetsDeratingTotal } </span><span>现在价值合计（元） : ${wdApplicationOutstandingAccount.fixAssetsTotal } </span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>固定资产名称</th>
                                        <th>购入时间</th>
                                        <th>购入价格</th>
                                        <th>现在价值</th>
                                        <th>购入价占比</th>
                                        <th>折旧额</th>
                                        <th>备注</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${wdApplicationFixAssetsList }" var="wdApplicationFixAssets">
                                        <tr>
                                            <td>${wdApplicationFixAssets.assetsName }</td>
                                            <td>${wdApplicationFixAssets.buyDate }</td>
                                            <td>${wdApplicationFixAssets.cost }</td>
                                            <td>${wdApplicationFixAssets.nowPrice }</td>
                                            <td>${wdApplicationFixAssets.rate }</td>
                                            <td>${wdApplicationFixAssets.poorPrice }</td>
                                            <td>${wdApplicationFixAssets.memo }</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="shop_info">
                        <h3>应收帐款<span>应收帐款总额 : ${wdApplicationOutstandingAccount.accountsReceivable } </span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>客户名称</th>
                                        <th>应收款占比(%)</th>
                                        <th>应收款金额</th>
                                        <th>交易内容</th>
                                        <th>应收账款发生日期</th>
                                        <th>生意往来时间(月)</th>
                                        <th>是否还有生意往来</th>
                                        <th>一般生意往来月营业额</th>
                                        <th>上个月营业额</th>
                                        <th>应何时结清</th>
                                        <th>预计何时结清</th>
                                        <th>备注</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${receivableList }" var="outstandingAccountDetail">
                                        <tr>
                                            <td>${outstandingAccountDetail.customerName }</td>
                                            <td>${outstandingAccountDetail.proportion }</td>
                                            <td>${outstandingAccountDetail.amount }</td>
                                            <td>${outstandingAccountDetail.transactionContent }</td>
                                            <td>${outstandingAccountDetail.diesCedin }</td>
                                            <td>${outstandingAccountDetail.businessMonth }</td>
                                            <td>${outstandingAccountDetail.dealings }</td>
                                            <td>${outstandingAccountDetail.usualTurnover }</td>
                                            <td>${outstandingAccountDetail.lastMonthTurnover }</td>
                                            <td>${outstandingAccountDetail.settlementPlan }</td>
                                            <td>${outstandingAccountDetail.settlementPredict }</td>
                                            <td>${outstandingAccountDetail.remarks }</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
    
                    <div class="shop_info">
                        <h3>预付账款<span>预付帐款总额 : ${wdApplicationOutstandingAccount.advancePayment } </span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>客户名称</th>
                                        <th>应收款占比(%)</th>
                                        <th>应收款金额</th>
                                        <th>交易内容</th>
                                        <th>应收账款发生日期</th>
                                        <th>生意往来时间(月)</th>
                                        <th>是否还有生意往来</th>
                                        <th>一般生意往来月营业额</th>
                                        <th>上个月营业额</th>
                                        <th>应何时结清</th>
                                        <th>预计何时结清</th>
                                        <th>备注</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${paymentList }" var="outstandingAccountDetail">
                                        <tr>
                                            <td>${outstandingAccountDetail.customerName }</td>
                                            <td>${outstandingAccountDetail.proportion }</td>
                                            <td>${outstandingAccountDetail.amount }</td>
                                            <td>${outstandingAccountDetail.transactionContent }</td>
                                            <td>${outstandingAccountDetail.diesCedin }</td>
                                            <td>${outstandingAccountDetail.businessMonth }</td>
                                            <td>${outstandingAccountDetail.dealings }</td>
                                            <td>${outstandingAccountDetail.usualTurnover }</td>
                                            <td>${outstandingAccountDetail.lastMonthTurnover }</td>
                                            <td>${outstandingAccountDetail.settlementPlan }</td>
                                            <td>${outstandingAccountDetail.settlementPredict }</td>
                                            <td>${outstandingAccountDetail.remarks }</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="assets" data-indexname="资产负债表" id="_assets">
                        <h3> 资产负债表</h3>
                        <div class="personal_info">
                            <div class="innerHtml">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>资产名称</th>
                                            <th>本期</th>
                                            <th>上期</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>资产记录时间</td>
                                            <td>${currentPeriod.pointTime }</td>
                                            <td>${priorPeriod.pointTime }</td>
                                        </tr>
                                        <tr>
                                            <td>现金</td>
                                            <td>${fns:toNumber(currentPeriod.cash) }</td>
                                            <td>${fns:toNumber(priorPeriod.cash) }</td>
                                        </tr>
                                        <tr>
                                            <td>银行存款</td>
                                            <td>${fns:toNumber(currentPeriod.bankDeposit) }</td>
                                            <td>${fns:toNumber(priorPeriod.bankDeposit) }</td>
                                        </tr>
                                        <tr>
                                            <td>应收账款</td>
                                            <td>
                                                ${fns:toNumber(currentPeriod.receivables) }
                                            </td>
                                            <td>${fns:toNumber(priorPeriod.receivables) }</td>
                                        </tr>
                                        <tr>
                                            <td>预付款项</td>
                                            <td>
                                                ${fns:toNumber(currentPeriod.prepayments) }
                                            </td>
                                            <td>${fns:toNumber(priorPeriod.prepayments) }</td>
                                        </tr>
                                        <tr>
                                            <td>存货</td>
                                            <td>
                                                ${fns:toNumber(currentPeriod.stock) }
                                            </td>
                                            <td>${fns:toNumber(priorPeriod.stock) }</td>
                                        </tr>
                                        <tr class="amount">
                                            <td>流动资产合计</td>
                                            <td>${fns:toNumber(currentPeriod.totalCurrentAsset) }</td>
                                            <td>${fns:toNumber(priorPeriod.totalCurrentAsset) }</td>
                                        </tr>
                                        <tr>
                                            <td>固定资产</td>
                                            <td>
                                                ${fns:toNumber(currentPeriod.fixedAsset) }
                                            </td>
                                            <td>${fns:toNumber(priorPeriod.fixedAsset) }</td>
                                        </tr>
                                        <tr>
                                            <td>待摊租金（${currentPeriod.rentSpreadRemarks }）</td>
                                            <td>${fns:toNumber(currentPeriod.rentSpread) }</td>
                                            <td>${fns:toNumber(priorPeriod.rentSpread) }</td>
                                        </tr>
                                        <tr>
                                            <td>其他经营资产</td>
                                            <td>${fns:toNumber(currentPeriod.otherOperatingAsset) }</td>
                                            <td>${fns:toNumber(priorPeriod.otherOperatingAsset) }</td>
                                        </tr>
                                        <tr>
                                            <td>其他非经营资产</td>
                                            <td>${fns:toNumber(currentPeriod.otherNonOperatingAsset) }</td>
                                            <td>${fns:toNumber(priorPeriod.otherNonOperatingAsset) }</td>
                                        </tr>
                                        <tr class="amount">
                                            <td>总资产合计</td>
                                            <td>${fns:toNumber(currentPeriod.totalAssets) }</td>
                                            <td>${fns:toNumber(priorPeriod.totalAssets) }</td>
                                        </tr>
                                        <tr class="amount">
                                            <td>速动比率</td>
                                            <td><fmt:formatNumber value='${fns:toNumber(currentPeriod.acidTestRatio)}' type='number'/>%</td>
                                            <td><fmt:formatNumber value='${fns:toNumber(priorPeriod.acidTestRatio)}' type='number'/>%</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="personal_info">
                            <div class="innerHtml last">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>负债名称</th>
                                            <th>本期</th>
                                            <th>上期</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>负债记录时间</td>
                                            <td>${currentPeriod.pointTime }</td>
                                            <td>${priorPeriod.pointTime }</td>
                                        </tr>
                                        <tr>
                                            <td>应付账款</td>
                                            <td>${fns:toNumber(currentPeriod.payables) }</td>
                                            <td>${fns:toNumber(priorPeriod.payables) }</td>
                                        </tr>
                                        <tr>
                                            <td>预收款项</td>
                                            <td>${fns:toNumber(currentPeriod.advancepay) }</td>
                                            <td>${fns:toNumber(priorPeriod.advancepay) }</td>
                                        </tr>
                                        <tr>
                                            <td>信用卡</td>
                                            <td>${fns:toNumber(currentPeriod.creditCard) }</td>
                                            <td>${fns:toNumber(priorPeriod.creditCard) }</td>
                                        </tr>
                                        <tr>
                                            <td>短期贷款</td>
                                            <td>${fns:toNumber(currentPeriod.shortTermLoan) }</td>
                                            <td>${fns:toNumber(priorPeriod.shortTermLoan) }</td>
                                        </tr>
                                        <tr class="amount">
                                            <td>短期负债合计</td>
                                            <td>${fns:toNumber(currentPeriod.totalShortTermLiabilities) }</td>
                                            <td>${fns:toNumber(priorPeriod.totalShortTermLiabilities) }</td>
                                        </tr>
                                        <tr>
                                            <td>长期贷款</td>
                                            <td>${fns:toNumber(currentPeriod.longTermLoan) }</td>
                                            <td>${fns:toNumber(priorPeriod.longTermLoan) }</td>
                                        </tr>
                                        <tr>
                                            <td>其他负债</td>
                                            <td>${fns:toNumber(currentPeriod.otherLiability) }</td>
                                            <td>${fns:toNumber(priorPeriod.otherLiability) }</td>
                                        </tr>
                                        <tr class="amount">
                                            <td>长期负债合计</td>
                                            <td>${fns:toNumber(currentPeriod.totalLongTermLiabilities) }</td>
                                            <td>${fns:toNumber(priorPeriod.totalLongTermLiabilities) }</td>
                                        </tr>
                                        <tr class="amount">
                                            <td>总负债合计</td>
                                            <td>${fns:toNumber(currentPeriod.totalLiabilities) }</td>
                                            <td>${fns:toNumber(priorPeriod.totalLiabilities) }</td>
                                        </tr>
                                        <tr>
                                            <td>权益</td>
                                            <td>${fns:toNumber(currentPeriod.equity) }</td>
                                            <td>${fns:toNumber(priorPeriod.equity) }</td>
                                        </tr>
                                        <tr class="amount">
                                            <td>负债及权益合计</td>
                                            <td>${fns:toNumber(currentPeriod.totalAssets) }</td>
                                            <td>${fns:toNumber(priorPeriod.totalAssets) }</td>
                                        </tr>
                                        <tr class="amount">
                                            <td>资产负债率</td>
                                            <td><fmt:formatNumber value='${fns:toNumber(currentPeriod.debtToAssetsRatio)}' type='number'/>%</td>
                                            <td><fmt:formatNumber value='${fns:toNumber(priorPeriod.debtToAssetsRatio)}' type='number'/>%</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="shop_info">
                            <h3>信贷历史</h3>
                            <div class="tb_wrap">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>融资来源</th>
                                            <th>贷款金额</th>
                                            <th>期限</th>
                                            <th>用途</th>
                                            <th>发放日期</th>
                                            <th>余额</th>
                                            <th>担保</th>
                                            <th>逾期信息</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${wdApplicationCreditHistoryDetailList }"
                                            var="wdApplicationCreditHistoryDetail">
                                            <tr>
                                                <td>${wdApplicationCreditHistoryDetail.financingSources }</td>
                                                <td>${wdApplicationCreditHistoryDetail.loanAmount }</td>
                                                <td>${wdApplicationCreditHistoryDetail.term }</td>
                                                <td>${wdApplicationCreditHistoryDetail.purpose }</td>
                                                <td>${wdApplicationCreditHistoryDetail.releaseDate }</td>
                                                <td>${wdApplicationCreditHistoryDetail.lalance }</td>
                                                <td>${wdApplicationCreditHistoryDetail.guarantee }</td>
                                                <td>${wdApplicationCreditHistoryDetail.overdueInformation }</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="shop_info">
                            <h3>信用卡使用情况</h3>
                            <div class="tb_wrap">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>信用卡卡主</th>
                                            <th>信用卡授信额度</th>
                                            <th>已用额度</th>
                                            <th>近6个月使用额度</th>
                                            <th>信用卡余额</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${wdApplicationCreditHistoryList }"
                                            var="wdApplicationCreditHistory">
                                            <tr>
                                                <td>${wdApplicationCreditHistory.owner }</td>
                                                <td>${wdApplicationCreditHistory.limitAmount }</td>
                                                <td>${wdApplicationCreditHistory.useAmount }</td>
                                                <td>${wdApplicationCreditHistory.sixMonthUseAmount }</td>
                                                <td>${wdApplicationCreditHistory.balanceAmount }</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="shop_info">
                            <h3>表外资产</h3>
                            <div class="tb_wrap">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>名称</th>
                                            <th>价值或者金额</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${assetAdditionals }" var="assetAdditional">
                                            <tr>
                                                <td>${assetAdditional.text}</td>
                                                <td>${assetAdditional.amount}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="shop_info last">
                            <h3>表外负债</h3>
                            <div class="tb_wrap">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>名称</th>
                                            <th>价值或者金额</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${debtsAdditionals }" var="debtsAdditional">
                                            <tr>
                                                <td>${debtsAdditional.text}</td>
                                                <td>${debtsAdditional.amount}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="shop_info">
                            <h3>对外担保情况</h3>
                            <div class="tb_wrap">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>名称</th>
                                            <th>价值或者金额</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${assureAdditionals }" var="assureAdditional">
                                            <tr>
                                                <td>${assureAdditional.text}</td>
                                                <td>${assureAdditional.amount}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="appraisal personal_info" style="width: 100%;">
                            <div class="innerHtml ordinary" style="min-height: auto;">
                                <h3>资产负债评价</h3>
                                <ul style="float: left; border-top: none">
                                    <li style="width: 100%; border-bottom: dotted 0px #ccc; padding: 10px 0;"><label
                                            style="width: 25%;">应收款与月平均营业额对比：</label>
                                        <p style="width: 25%;">${wdApplicationOperatingBalanceSheet.receivablesVsTurnover }</p></li>
                                    <li style="width: 100%; border-bottom: dotted 0px #ccc; padding: 10px 0;"><label
                                            style="width: 25%;">应收款与月平均营业额对比说明：</label>
                                        <p style="width: 25%;">${wdApplicationOperatingBalanceSheet.receivablesVsTurnoverText }</p></li>
                                    <li style="width: 100%; border-bottom: dotted 0px #ccc; padding: 10px 0;"><label
                                            style="width: 25%;">存货可销售与月平均营业额对比：</label>
                                        <p style="width: 25%;">${wdApplicationOperatingBalanceSheet.stockVsTurnover}</p></li>
                                    <li style="width: 100%; border-bottom: dotted 0px #ccc; padding: 10px 0;"><label
                                            style="width: 25%;">存货可销售与月平均营业额对比说明：</label>
                                        <p style="width: 25%;">${wdApplicationOperatingBalanceSheet.stockVsTurnoverText }</p></li>
                                    <li style="width: 100%; border-bottom: dotted 0px #ccc; padding: 10px 0;"><label
                                            style="width: 25%;">借款人权益与借款人家庭开支（月）对比：</label>
                                        <p style="width: 25%;">${wdApplicationOperatingBalanceSheet.equityVsExpense }</p></li>
                                    <li style="width: 100%; border-bottom: dotted 0px #ccc; padding: 10px 0;"><label
                                            style="width: 25%;">借款人权限与借款人家庭开支（月）对比说明：</label>
                                        <p style="width: 25%;">${wdApplicationOperatingBalanceSheet.equityVsExpenseText }</p></li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="shop_info" data-indexname="毛利率检验" id="_profit">
                        <h3>毛利率检验</h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>产品</th>
                                        <th>毛利率</th>
                                        <th>口述毛利率</th>
                                        <th>偏差率</th>
                                        <th>谨慎毛利率</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${wdApplicationProfitList }" var="wdApplicationProfit">
                                        <tr>
                                            <td>${wdApplicationProfit.product }</td>
                                            <td><fmt:formatNumber value='${wdApplicationProfit.profitsRate * 100 }' type='number'/>%</td>
                                            <td><fmt:formatNumber value='${wdApplicationProfit.expectedRate * 100 }' type='number'/>%</td>
                                            <td><fmt:formatNumber value='${wdApplicationProfit.deviationRate * 100 }' type='number'/>%</td>
                                            <td><fmt:formatNumber value='${wdApplicationProfit.cautiousRate * 100 }' type='number'/>%</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="shop_info" data-indexname="净利检验" id="_netProfitLogic">
                        <h3>净利检验</h3>
                        <div class="tb_wrap">
                            <table>
                                <tbody>
                                    <tr>
                                        <th>客户口述净利润为    </th>
                                        <th>损益表中净利润</th>
                                        <th>偏差率</th>
                                    </tr>
                                    <tr>
                                        <td>${wdApplicationNetProfitLogic.netIncomeValue }</td>
                                        <td>${wdApplicationNetProfitLogic.netIncome }</td>
                                        <td>
                                            <fmt:formatNumber value='${wdApplicationNetProfitLogic.netIncomeDeviationRate * 100 }' type='number'/>%
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="shop_info index_relation" data-indexname="逻辑检验" id="_profitLogic">
                        <h3>逻辑检验</h3>
                        <div class="tb_wrap">
                            <c:forEach items="${wdApplicationProfitLogicList }" var="wdApplicationProfitLogic">
                                <table name="logicRate">
                                    <tbody>
                                        <tr>
                                            <td rowspan="19" class="td_col_title">
                                                ${wdApplicationProfitLogic.productCheckName }
                                            </td>
                                        </tr>
                                        <tr>
                                            <th colspan="4" class="td_title">
                                                营业额检验1
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>${wdApplicationProfitLogic.turnoverCheck1Text }</td>
                                            <td>${wdApplicationProfitLogic.turnoverCheck1Memo }</td>
                                            <td>
                                                                                                                                                             损益表中营业额为
                                            </td>
                                            <td>
                                                                                                                                                             偏差率
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>${wdApplicationProfitLogic.turnoverCheck1Value }</td>
                                            <td>${wdApplicationProfitLogic.annualTurnover1 }</td>
                                            <td>${wdApplicationProfitLogic.turnover1 }</td>
                                            <td>
                                                <fmt:formatNumber value='${wdApplicationProfitLogic.deviationRate1 * 100 }' type='number'/>%
                                            </td>
                                        </tr>
                                        <tr>
                                            <th colspan="4" class="td_title">
                                                                                                                                                            营业额检验2
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>${wdApplicationProfitLogic.turnoverCheck2Text }</td>
                                            <td>${wdApplicationProfitLogic.turnoverCheck2Memo }</td>
                                            <td>损益表中营业额为</td>
                                            <td>偏差率</td>
                                        </tr>
                                        <tr>
                                            <td>${wdApplicationProfitLogic.turnoverCheck2Value }</td>
                                            <td>${wdApplicationProfitLogic.annualTurnover2 }</td>
                                            <td>${wdApplicationProfitLogic.turnover2 }</td>
                                            <td>
                                                <fmt:formatNumber value='${wdApplicationProfitLogic.deviationRate2 * 100 }' type='number'/>%
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <th colspan="4" class="td_title">
                                                                                                                                                            营业额检验3
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>${wdApplicationProfitLogic.turnoverCheck3Text }</td>
                                            <td>${wdApplicationProfitLogic.turnoverCheck3Memo }</td>
                                            <td>损益表中营业额为</td>
                                            <td>偏差率</td>
                                        </tr>
                                        <tr>
                                            <td>${wdApplicationProfitLogic.turnoverCheck3Value }</td>
                                            <td>${wdApplicationProfitLogic.annualTurnover3 }</td>
                                            <td>${wdApplicationProfitLogic.turnover3 }</td>
                                            <td> 
                                                <fmt:formatNumber value='${wdApplicationProfitLogic.deviationRate3 * 100 }' type='number'/>%
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div class="shop_info" data-indexname="行业需求与资金使用的时间关系" id="_industryDemandFundUse">
                        <h3>行业需求与资金使用的时间关系</h3>
                        <div class="tb_wrap">
                            <table id="tab_relationship">
                                <thead>
                                    <tr>
                                        <th>月份</th>
                                        <th>1月</th>
                                        <th>2月</th>
                                        <th>3月</th>
                                        <th>4月</th>
                                        <th>5月</th>
                                        <th>6月</th>
                                        <th>7月</th>
                                        <th>8月</th>
                                        <th>9月</th>
                                        <th>10月</th>
                                        <th>11月</th>
                                        <th>12月</th>
                                        <th>解释</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr id="industryCapitalDemandTime">
                                        <td>行业资金需求</td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td><input type="checkbox" name="chk_requirement"></td>
                                        <td id="industryCapitalDemandTimeDesc" name="td_explain"></td>
                                    </tr>
                                    <tr id="fundApplicationTime">
                                        <td>资金使用申请时间</td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td><input type="checkbox" name="chk_apptime"></td>
                                        <td id="fundApplicationTimeDesc" name="td_explain"></td>
                                    </tr>
                                    <tr>
                                        <td>淡旺季描述</td>
                                        <td colspan="13" id="td_season">
                                            <span>淡旺季明显</span><span>淡旺季不明显</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>提议还款来源</td>
                                        <td colspan="13" id="proposingRepaymentSource"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="shop_info">
                        <h3>损益表</h3>
                        <div class="tb_wrap">
                            <!-- <table class="style2 ht20"> -->
                             <table class="style3 wd100">
                                <tbody>
                                    <tr>
                                        <td colspan="17">损益表(近12个月)</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">项目</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                ${detailsList.size() >= num ? detailsList[num].pointMonth : ''}
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        <td rowspan="4">收入</td>
                                        <td width="10%">${wdApplicationBusinessIncomeStatement.income0Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].income0Amount : ""}' type='number'/> 
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.income1Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].income1Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.income2Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].income2Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>总额（1）</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].incomeSum : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        <td rowspan="4">可变成本</td>
                                        <td>${wdApplicationBusinessIncomeStatement.variableCost0Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].variableCost0Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.variableCost1Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].variableCost1Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.variableCost2Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].variableCost2Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>总额（2）</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].variableCostSum : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        <td colspan="2">毛利润（3）＝ （1） － （2）</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].grossProfit : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    
                                    <tr>
                                        <td rowspan="12">固定支出</td>
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge0Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge0Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge1Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge1Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge2Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge2Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge3Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge3Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge4Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge4Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge5Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge5Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge6Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge6Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge7Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge7Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge8Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge8Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.fixedCharge9Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedCharge9Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>${wdApplicationBusinessIncomeStatement.fixedChargeAText }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedChargeAAmount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        
                                        <td>总额（4）</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].fixedChargeSum : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td colspan="2">税前利润（5）＝ （3） － （4）</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].pretaxProfit : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td colspan="2">所得税（6）</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].incomeTax : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td colspan="2">净利润（7）＝ （5） － （6）</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].netProfit : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td rowspan="4">其他</td>
                                        <td>${wdApplicationBusinessIncomeStatement.otherCharge0Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].otherCharge0Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>${wdApplicationBusinessIncomeStatement.otherCharge1Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].otherCharge1Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>${wdApplicationBusinessIncomeStatement.otherCharge2Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].otherCharge2Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>${wdApplicationBusinessIncomeStatement.otherIncome0Text }</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].otherIncome0Amount : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td colspan="2">月可支配资金</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].spendableIncome : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        <td colspan="2">其他影响现金流的因素</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                ${detailsList.size() >= num ? detailsList[num].remarks : ''}
                                            </td>
                                        </c:forEach>
                                    </tr>
    
                                    <tr>
                                        <td colspan="2">前12个月的营业额</td>
                                        <c:forEach begin="0" end="14" var="num">
                                            <td>
                                                <fmt:formatNumber value='${detailsList.size() >= num ? detailsList[num].turnover : ""}' type='number'/>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="personal_info" data-indexname="权益检查" id="_operatingBalanceSheetCheck">
                        <div class="innerHtml ordinary">
                            <h3>初始权益点资产负债表</h3>
                            <ul style="float: left; border-top: none">
                                <li><label for="">权益检验原始点：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.checkPoint}</p></li>
                                <li><p>&nbsp;</p></li>
                                <li><label for="">现金及银行存款：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.cashAndDeposit}</p></li>
                                <li><label for="">应付账款：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.payables}</p></li>
                                <li><label for="">应收账款：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.receivables}</p></li>
                                <li><label for="">预收款项：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.advancepay}</p></li>
                                <li><label for="">预付款项：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.prepayments}</p></li>
                                <li><label for="">短期贷款：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.shortTermLoan}</p></li>
                                <li><label for="">存货：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.stock}</p></li>
                                <li><label for="">长期贷款：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.longTermLoan}</p></li>
                                <li><label for="">固定资产：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.fixedAsset}</p></li>
                                <li><label for="">其他负债：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.otherLiability}</p></li>
                                <li><label for="">待摊租金：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.otherOperatingAsset}</p></li>
                                <li><p>&nbsp;</p></li>
                                <li><label for="">其它非经营资产：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.otherNonOperatingAsset}</p></li>
                                <li><label for="">权益：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.equity}</p></li>
                                <li><label for="">总资产：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.totalAssets}</p></li>
                                <li><label for="">负债及权益合计：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.liabilitiesAndEquity}</p></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div class="personal_info">
                        <div class="innerHtml ordinary">
                            <h3>权益逻辑检验</h3>
                            <ul style="float: left; border-top: none">
                                <li><label for="">初始权益金额：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.initialEquityAmount}&nbsp;</p></li>
                                <li><label for="">初始权益：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.initialEquity}&nbsp;</p></li>
                                <li><label for="">期间内的利润金额：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.periodProfitAmount}&nbsp;</p></li>
                                <li><label for="">期间内的利润：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.periodProfit}&nbsp;</p></li>
                                <li><label for="">期间内资本注入金额：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.periodCapitalAmount}&nbsp;</p></li>
                                <li><label for="">期间内资本注入：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.periodCapital}&nbsp;</p></li>
                                <li><label for="">期内提取的资金金额：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.periodFundingAmount}&nbsp;</p></li>
                                <li><label for="">期内提取的资金：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.periodFunding}&nbsp;</p></li>
                                <li><label for="">折旧/升值金额：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.deOrAppreciationAmount}&nbsp;</p></li>
                                <li><label for="">折旧/升值：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.deOrAppreciation}&nbsp;</p></li>
                                <li class="percent30"><label for="">应有权益：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.entitlement}</p></li>
                                <li class="percent30"><label for="">偏差值：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.deviationValue}</p></li>
                                <li class="percent30"><label for="">偏差率：</label>
                                    <p>${wdApplicationOperatingBalanceSheetCheck.deviationRate}%</p></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    
                    <div class="shop_info">
                        <h3>还款计划表</h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>期数</th>
                                        <th>每月还款</th>
                                        <th>本金</th>
                                        <th>利息</th>
                                        <th>剩余余额</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${wdApplicationRefundPlanList }" var="wdApplicationRefundPlan">
                                        <tr>
                                            <td>${wdApplicationRefundPlan.periods}</td>
                                            <td>${wdApplicationRefundPlan.monthRefund}</td>
                                            <td>${wdApplicationRefundPlan.capital}</td>
                                            <td>${wdApplicationRefundPlan.interests}</td>
                                            <td>${wdApplicationRefundPlan.balance}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                </c:if>
                
                <spring:eval expression="@wdApplicationScoreService.selectByApplicationId(applicationId)" var="scoreList"/>
                <c:if test="${not empty scoreList }">
                    <div class="appraisal" data-indexname="评分" id="_scoreList">
                        <div class="innerHtml result nopadr">
                            <h3>评分</h3>
                            <c:forEach items="${scoreList }" var="scoreData">
                                <dl>
                                    <spring:eval expression="@smModelService.selectByModelKey(scoreData.modelKey)" var="model"/>
                                    <dd style="text-align: left">${model.name }</dd>
                                    <dt class="none">${scoreData.score }</dt>
                                </dl>
                            </c:forEach>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${null != productConfig['FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF']}">
                    <div class="shop_info" id="photoViewer">
                        <h3>调查图片</h3>
                        <div class="tb_wrap">
                            <c:forEach items="${productConfig['FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF']}" var="config">
                                <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }"/>
                                <div class="zc picgroupBtn">
                                    <spring:eval expression="@wdApplicationPhotoService.selectByCategory(surveyPhotoList, wdBusinessElement.key)" var="photoList"/>
                                    <c:choose>
                                        <c:when test="${not empty photoList}">
                                            <img src="${imagesStatic}${fns:choiceImgUrl('520X390', photoList[0].photoUrl)}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${defaultPic}">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="title">${photoList.size() }张</div>
                                    <p>${wdBusinessElement.name }</p>
                                    
                                    <ul class="picList" style="display: none">
                                        <c:forEach items="${surveyPhotoList}" var="surveyPhoto">
                                            <c:if test="${surveyPhoto.category eq wdBusinessElement.key }">
                                                <c:if test="${not empty fns:choiceImgUrl('520X390', surveyPhoto.photoUrl) }">
                                                    <li><img data-original="${imagesStatic }${surveyPhoto.photoUrl}" src="${imagesStatic }${fns:choiceImgUrl('520X390', surveyPhoto.photoUrl)}"></li>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                
                <div class="shop_info" data-indexname="审批进度" id="_applicationTask">
                    <h3>审批进度</h3>
                    <div class="list_wrap">
                        <ul class="sp_list">
                            <c:forEach items="${wdApplicationTaskList}" var="wdApplicationTask">
                                <li>
                                    <div class="time">
                                        <h2>
                                            <fmt:formatDate value="${wdApplicationTask.updateDate}" pattern="HH:mm:ss" />
                                        </h2>
                                        <h4>
                                            <fmt:formatDate value="${wdApplicationTask.updateDate}" pattern="yyyy-MM-dd" />
                                            </h3>
                                    </div>
                                    <div class="head"></div>
                                    <div class="list_right">
                                        <i></i>
                                        <div class="content">
                                            <h5>${wdApplicationTask.statusName }</h4>
                                                <h6 class="name">${wdApplicationTask.ownerName }
                                            </h5>
                                            <c:choose>
                                                <c:when test="${'1' eq wdApplicationTask.close }">
                                                    <p>${wdApplicationTask.actionName }</p>
                                                    <c:set var="taskConfig" value="" />
                                                    <c:if test="${'Pass' eq wdApplicationTask.action or 'Submit' eq wdApplicationTask.action }">
		                                                <c:choose>
		                                                    <c:when test="${wdApplicationTask.status == 2 }">
		                                                        <c:set var="taskConfig" value="BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB" />
		                                                    </c:when>
		                                                    <c:when test="${wdApplicationTask.status == 32 }">
		                                                        <c:set var="taskConfig" value="CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC" />
		                                                    </c:when>
		                                                    <c:when test="${wdApplicationTask.status == 256 }">
		                                                        <c:set var="taskConfig" value="DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD" />
		                                                    </c:when>
		                                                        
		                                                    <c:when test="${wdApplicationTask.status == 8 }">
		                                                        <c:set var="taskConfig" value="BBBBBBBB-BBBB-BBBB-BBBB-CCCCCCCCCCCC" />
		                                                    </c:when>
		                                                    <c:when test="${wdApplicationTask.status == 16 }">
		                                                        <c:set var="taskConfig" value="BBBBBBBB-BBBB-BBBB-BBBB-DDDDDDDDDDDD" />
		                                                    </c:when>
		                                                    <c:when test="${wdApplicationTask.status == 128 }">
		                                                        <c:set var="taskConfig" value="CCCCCCCC-CCCC-CCCC-CCCC-EEEEEEEEEEEE" />
		                                                    </c:when>
		                                                        
		                                                </c:choose>
                                              		</c:if>
                                                    <ul class="txt">
                                                        <c:if test="${not empty taskConfig }">
                                                            <c:forEach items="${applyAuditInfoConfig }" var="simpleModuleSetting">
                                                                <c:set var="wdBusinessElement"
                                                                    value="${wdBusinessElementConfig[simpleModuleSetting.businessElementId] }" />
                                                                <li>${wdBusinessElement.name }：${wdApplicationTask.getJsonData()[wdBusinessElement.key] }
                                                                </li>
                                                            </c:forEach>
                                                            <c:forEach items="${productConfig[taskConfig] }" var="conclusionConfig">
                                                                <c:set var="wdBusinessElement"
                                                                    value="${wdBusinessElementConfig[conclusionConfig.businessElementId] }" />
                                                                <li>${wdBusinessElement.name }：${wdApplicationTask.getJsonData()[wdBusinessElement.key] }</li>
                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if test="${not empty wdApplicationTask.comment }">
                                                            <li>审批意见：${wdApplicationTask.comment}</li>
                                                        </c:if>
                                                    </ul>
                                                </c:when>
                                                <c:otherwise>
                                                    <p>正在处理中...</p>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${'1' eq wdApplicationTask.close }">
                                            </c:if>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
    
    <script>
    var json_data = null;
	window.HTMLElement = window.HTMLElement || window.Element;
	function ajax(url, data, callback)
	{
		var xmlhttp = null;
		if (window.XMLHttpRequest)
		{
			//  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp=new XMLHttpRequest();
		}
		else
		{
			// IE6, IE5 浏览器执行代码
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				if (typeof(callback) === "function") {
					callback();
				}
			}
		}
		
		xmlhttp.open("GET", url, true);
		xmlhttp.send(data);
	}
	
	HTMLElement.prototype.find = function(sel) {
		var obj = this.querySelectorAll(sel);
		return obj;
	};
	
	var _repaymentPlan = document.getElementById("_repaymentPlan");
	
	var g_imgs = [];
	
	function OpenFullIFrame(url) {
		var layerIframe1 = document.getElementById("layerIframe1");
		var _div = document.createElement("div");
		//layerIframe1.src = "http://dev-admin.bakejinfu.com/" + url;
		//layerIframe1.src = "prepay.html?aaa";
		layerIframe1.src = url;
		layerIframe1.style.display = "block";
		
		_div.id = "del_shadeIframe";
		_div.innerHTML = "X"
		_div.setAttribute("style", "cursor:pointer;position:fixed;left:95%;top:5%;z-index: 99;");
		_div.onclick = function() {
			layerIframe1.style.display = "none";
			this.parentNode.removeChild(this);
		}
		
		document.body.appendChild(_div);
	}
	
	window.onload = function() {
		var a_opens = document.querySelectorAll(".openlink");
		var photoViewer = document.getElementById("photoViewer");
		var obj = null, objs = null, data = null, str = "";
		
		//注册OPENlink的事件，打开一个IFRAME
		
		var func_openlink = function() {
			//http://dev-admin.bakejinfu.com/
			OpenFullIFrame(this.href);
			//window.event.preventDefault()
			
			return false;
		}
		
		for (var i=0;i<a_opens.length;i++) {
			a_opens[i].onclick = func_openlink;
			//a_opens[i].href = "javascript:void(0)";
		}
		
		//添加查看照片事件
		
		photoViewer.onclick = function(e) {
			e = e || window.event;
			var imgs = null;
			var layerIframe1 = null;
			var target = e.target || e.srcElement;

			if (target.tagName.toLowerCase() === "img" || target.className === "title") {
				imgs = target.parentNode.find(".picList li img") ;
				g_imgs = [];
				
    			if (!imgs || !imgs.length) {
    				return;
    			}
    			
    			for (var i=0;i<imgs.length;i++) {
    				g_imgs[i] = imgs[i].src;
    			}
    			
    			layerIframe1 = document.createElement("iframe")
    			layerIframe1.scrolling = "auto";
    			layerIframe1.id = "layerIframe1";
    			layerIframe1.frameborder = "0";
    			layerIframe1.src = "${ctx}/open/application/openIframe";
    			//layerIframe1.style = "background:transparent;position:fixed;z-index:1;top:0;left:0;height: 100%;width:100%";
    			
    			document.body.appendChild(layerIframe1);
			}
		};
		
		objs = document.querySelectorAll(".picbtn");
		
		for (var i=0;i<objs.length;i++) {
			objs[i].onclick = function(e) {
    			e = e || window.event;
    			var imgs = null;
    			var layerIframe1 = null;
    			var target = e.target || e.srcElement;
    			
    			imgs = this.parentNode.parentNode.find(".picList li img") ;
				g_imgs = [];
				
    			if (!imgs || !imgs.length) {
    				return;
    			}
    			
    			for (var i=0;i<imgs.length;i++) {
    				g_imgs[i] = imgs[i].getAttribute("data-original");
    			}
    			
    			layerIframe1 = document.createElement("iframe")
    			layerIframe1.scrolling = "auto";
    			layerIframe1.id = "layerIframe1";
    			layerIframe1.frameborder = "0";
    			layerIframe1.src = "${ctx}/open/application/openIframe";
    			//layerIframe1.style = "background:transparent;position:fixed;z-index:1;top:0;left:0;height: 100%;width:100%";
    			
    			document.body.appendChild(layerIframe1);
    		};	
		}
		
		var ajax_setting = function() {
			//初始化行业资金需求复选框
    		obj = document.getElementById("industryCapitalDemandTime");
    		
    		if (json_data && json_data.data && json_data.data.industryDemandFundUseSheetInfo && 
    			json_data.data.industryDemandFundUseSheetInfo.industryCapitalDemandTimeList) {
	    		if (obj) {
	    			objs = obj.find("[type=checkbox]");
	    			data = json_data.data.industryDemandFundUseSheetInfo.industryCapitalDemandTimeList;
	    			
	    			for (var i=0;i<data.length;i++) {
	    				objs[data[i]-1].checked = true;
	    			}
	    		}
			}
    			
			for (i=0;i<objs.length;i++) {
				objs[i].disabled = true;
			}
    			
    		//资金使用申请时间
    		obj = document.getElementById("fundApplicationTime");
    		
    		if (json_data && json_data.data && json_data.data.industryDemandFundUseSheetInfo && 
    			json_data.data.industryDemandFundUseSheetInfo.fundApplicationTimeList) {
	    		if (obj) {
	    			objs = obj.find("[type=checkbox]");
	    			data = json_data.data.industryDemandFundUseSheetInfo.fundApplicationTimeList;
	    			
	    			for (var i=0;i<data.length;i++) {
	    				objs[data[i]-1].checked = true;
	    			}
	    		}
			}
    			
    		for (i=0;i<objs.length;i++) {
				objs[i].disabled = true;
			}
    			
    		//淡旺季描述
    		obj = document.getElementById("td_season");
    		
    		if (json_data && json_data.data && json_data.data.industryDemandFundUseSheetInfo && 
    			json_data.data.industryDemandFundUseSheetInfo.lightSeasonDesc) {
    			data = json_data.data.industryDemandFundUseSheetInfo.lightSeasonDesc;
    			
    			if (data === "淡旺季明显") {
    				obj.find("span")[0].className = "checked";
    			} else {
    				obj.find("span")[1].className = "checked";
    			}
    		} else {
    			obj.find("span")[1].className = "checked";
    		}
		};
		
		objs = null;
		
		//表格划框
		//根据JSON来设置表格DATA-ARG属性，到时候可以划线
		var setDataArg = function(json_data) {
			var tds = document.querySelectorAll(".tab_content .shop_info .tb_wrap table.style2 tbody td");
			
			if (!tds) return;
			
			for (prop in json_data) {
				for (var i=0;i<tds.length;i++) {
					if (tds[i].innerText === json_data[prop]) {
						tds[i].style.border = "2px solid #000000";
					}
				}
			}
		};

		if ('${fns:toJsonString(softInfoSheet)}') {
			var softInfoSheet = JSON.parse('${fns:toJsonString(softInfoSheet)}');
			if (softInfoSheet) {
				setDataArg(softInfoSheet);
			}
		}
		
		if ('${fns:toJsonString(industryDemandFundUseSheetInfo)}') {
			var industryDemandFundUseSheetInfo = JSON.parse('${fns:toJsonString(industryDemandFundUseSheetInfo)}');
			if (industryDemandFundUseSheetInfo) {
				//行业资金需求
				obj = document.getElementById("industryCapitalDemandTime");
				data = industryDemandFundUseSheetInfo.industryCapitalDemandTime;
				
	    		if (data) {
	    			data = JSON.parse(data);
	    			
		    		if (obj) {
		    			objs = obj.find("[type=checkbox]");
		    			
		    			for (var i=0;i<data.length;i++) {
		    				objs[data[i]-1].checked = true;
		    			}
		    		}
				}
	    			
				for (i=0;i<objs.length;i++) {
					objs[i].disabled = true;
				}
				
				//资金使用申请时间
				obj = document.getElementById("fundApplicationTime");
				data = industryDemandFundUseSheetInfo.fundApplicationTime;
				
	    		if (data) {
	    			data = JSON.parse(data);
	    			
		    		if (obj) {
		    			objs = obj.find("[type=checkbox]");
		    			
		    			for (var i=0;i<data.length;i++) {
		    				objs[data[i]-1].checked = true;
		    			}
		    		}
				}
	    			
				for (i=0;i<objs.length;i++) {
					objs[i].disabled = true;
				}
				
				//行业资金需求解释
				if (industryDemandFundUseSheetInfo.industryCapitalDemandTimeDesc) {
					industryCapitalDemandTimeDesc.innerText = industryDemandFundUseSheetInfo.industryCapitalDemandTimeDesc;
				}
				
				//资金使用申请时间解释
				if (industryDemandFundUseSheetInfo.fundApplicationTimeDesc) {
					fundApplicationTimeDesc.innerText = industryDemandFundUseSheetInfo.fundApplicationTimeDesc;
				}
				
				//资金使用申请时间解释
				if (industryDemandFundUseSheetInfo.proposingRepaymentSource) {
					proposingRepaymentSource.innerText = industryDemandFundUseSheetInfo.proposingRepaymentSource;
				}

				
				//淡旺季描述
	    		obj = document.getElementById("td_season");
	    		
	    		if (industryDemandFundUseSheetInfo.lightSeasonDesc) {
	    			if (industryDemandFundUseSheetInfo.lightSeasonDesc === "淡旺季明显") {
	    				obj.find("span")[0].className = "checked";
	    			} else {
	    				obj.find("span")[1].className = "checked";
	    			}
	    		} else {
	    			obj.find("span")[1].className = "checked";
	    		}

			}
		} else {
			obj = document.getElementById("td_season");
			obj.find("span")[1].className = "checked";
			
			objs = document.body.find("[type=checkbox]");
			
			for (i=0;i<objs.length;i++) {
				objs[i].disabled = true;
			}

		}
		
		var objs = document.querySelectorAll(".innerHtml > ul > li,.bg_color > ul > li");
		
		for (var i=0;i<objs.length;i++) {
			if (i%2 === 1) {
				obj = objs[i].previousSibling;
				
				if (obj == null) {
					continue;
				}
				
				while (obj && obj.nodeType != 1) {
					obj = obj.previousSibling;
					console.log(obj)
				}
				
				if (obj == null) {
					continue;
				}
				
				obj.innerHTML += objs[i].innerHTML;
				objs[i].parentNode.removeChild(objs[i]);
			}
		}
	};

	</script>
</body>
</html>