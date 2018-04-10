<%@ page import="com.bk.wd.model.WdApplication" %>
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
                                        <th>风险提示</th>
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
                                                        <a class="color1 btn openlink" href="${ctx }/wd/application/detail/selectCoborrowerInfo?applicationId=${applicationId}&personId=${personRelation.wdPerson.id}">共同借款人</a>
                                                                                                                                                                                               
                                                    </c:when>
                                                    <c:when test="${personRelation.isRecognizor}">
                                                        <a class="color1 btn openlink" href="${ctx }/wd/application/detail/selectRecognizorInfo?applicationId=${applicationId}&personId=${personRelation.wdPerson.id}">担保人</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                                                                                                                                                                 其他关系人
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><a class="color1 btn openlink" href="${ctx }/wd/person/detail?personId=${personRelation.wdPerson.id}&targetType=alert">${personRelation.wdPerson.getJsonData().base_info_name }</a></td>
                                            <td>${personRelation.relationType }</td>
                                            <td>${personRelation.wdPerson.getJsonData().base_info_gender }</td>
                                            <td>${personRelation.wdPerson.getJsonData().base_info_idcard }</td>
                                           <!--  <td>43</td> -->
                                            <td>
                                                <spring:eval expression="@wdPersonService.hasRisk(personRelation.wdPerson.id, null)" var="hasRisk" />
                                                <c:choose>
                                                    <c:when test="${hasRisk }">
                                                        <a class="color3 btn openlink" href="${ctx}/wd/application/detail/riskNotice?applicationId=${applicationId}&personId=${personRelation.wdPerson.id}">有风险</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="color2 btn openlink" href="${ctx}/wd/application/detail/riskNotice?applicationId=${applicationId}&personId=${personRelation.wdPerson.id}">无风险</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
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
                                    <!-- <th>信用卡信用记录</th> -->
                                    <th>贷款信用记录</th>
                                   <!--  <th>个人征信系统</th>
                                    <th>贷款记录（个人征信）</th>
                                    <th>贷款记录（在我行）</th> -->
                                    <th>征信结果</th>
                                    <th>身份证打印</th>
                                    <th>征信资料</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${applicationCreditInvestigationList }" var="applicationCreditInvestigation">
                                    <tr>
                                        <td>${applicationCreditInvestigation.name}</td>
                                        <td>${applicationCreditInvestigation.relationType}</td>
                                       <%--  <td>${applicationCreditInvestigation.creditCardRecord}</td> --%>
                                        <td>${applicationCreditInvestigation.loanRecord}</td>
                                      <%--   <td>${applicationCreditInvestigation.personalCreditSystem}</td>
                                        <td>${applicationCreditInvestigation.creditRecord}</td>
                                        <td>${applicationCreditInvestigation.creditRecordOurBank}</td> --%>
                                        <td>${applicationCreditInvestigation.result}</td>
                                        <td><button class="color1 id_card_photo" data-idcard='${wdApplicationCreditCardInfo.getJsonData()[wdBusinessElement.key] }'>打印复印件</button></td>
                                        <td><p><a class="color1 btn openlink" href="${ctx}/wd/application/credit/detail?creditId=${applicationCreditInvestigation.id}">征信资料</a></p></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
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
                                <li>
                                    <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[applictionInfoConfig.businessElementId] }" />
                                    <label  for="">${wdBusinessElement.name }：</label>
                                    <c:choose>
                                        <c:when test="${wdBusinessElement.key eq 'apply_estate' || wdBusinessElement.key eq 'apply_vehicle_dealers'}">
                                            <p>${fn:replace(wdApplication.getApplyInfoJson()[wdBusinessElement.key], ',', ' ') }</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>${wdApplication.getApplyInfoJson()[wdBusinessElement.key] }</p>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
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
                
                <c:if test="${null != productConfig['GGGGGGGG-GGGG-GGGG-GGGG-GGGGGGGGGGGG']}">
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
                </c:if>
                
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

                <div class="shop_info">
                    <h3>
                        家庭损益表
                        <!-- <span class="add"></span> -->
                    </h3>
                    <div class="tb_wrap">
                        <table>
                            <thead>
                            <tr>
                                <th>
                                    月份
                                </th>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo1 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo1.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            1月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                               <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo2 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo2.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            2月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo3 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo3.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            3月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo4 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo4.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            4月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo5 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo5.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            5月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo6 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo6.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            6月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo7 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo7.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            7月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo8 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo8.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            8月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo9 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo9.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            9月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo10 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo10.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            10月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo11 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo11.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            11月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthInfo12 !=null}">
                                        <th>
                                                ${familyProfitLoss.monthInfo12.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            12月份
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.yearSum !=null}">
                                        <th>
                                                ${familyProfitLoss.yearSum.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            年合计
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${familyProfitLoss.monthAvg !=null}">
                                        <th>
                                                ${familyProfitLoss.monthAvg.monthName}
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>
                                            月平均
                                        </th>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach items="${familyProfitLoss.monthInfo1.incomeInfo}" var="fpl" varStatus="status">
                                <tr>
                                    <td>${fpl.title}</td>
                                    <td>${fpl.amount}</td>
                                    <td>${familyProfitLoss.monthInfo2.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo3.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo4.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo5.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo6.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo7.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo8.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo9.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo10.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo11.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo12.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.yearSum.incomeInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthAvg.incomeInfo[status.index].amount}</td>
                                </tr>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${familyProfitLoss!=null}">
                                    <tr>
                                        <td>
                                            收入合计
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo1.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo2.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo3.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo4.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo5.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo6.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo7.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo8.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo9.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo10.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo11.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo12.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.yearSum.incomeSum}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthAvg.incomeSum}
                                        </td>
                                    </tr>
                                </c:when>
                            </c:choose>

                            <c:forEach items="${familyProfitLoss.monthInfo1.expensesInfo}" var="fpl" varStatus="status">
                                <tr>
                                    <td>${fpl.title}</td>
                                    <td>${fpl.amount}</td>
                                    <td>${familyProfitLoss.monthInfo2.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo3.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo4.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo5.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo6.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo7.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo8.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo9.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo10.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo11.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthInfo12.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.yearSum.expensesInfo[status.index].amount}</td>
                                    <td>${familyProfitLoss.monthAvg.expensesInfo[status.index].amount}</td>

                                </tr>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${familyProfitLoss!=null}">
                                    <tr>
                                        <td>
                                            月可支
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo1.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo2.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo3.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo4.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo5.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo6.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo7.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo8.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo9.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo10.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo11.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthInfo12.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.yearSum.monthBalance}
                                        </td>
                                        <td>
                                                ${familyProfitLoss.monthAvg.monthBalance}
                                        </td>
                                    </tr>
                                </c:when>
                            </c:choose>

                            </tbody>
                        </table>
                    </div>
                </div>
                
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
                                                <a class="color1 btn openlink" href="${ctx}/wd/application/detail/prepayList?applicationId=${applicationId}">${fns:toNumber(currentPeriod.receivables) }</a>
                                            </td>
                                            <td>${fns:toNumber(priorPeriod.receivables) }</td>
                                        </tr>
                                        <tr>
                                            <td>预付款项</td>
                                            <td>
                                                <a class="color1 btn openlink" href="${ctx}/wd/application/detail/prepayList?applicationId=${applicationId}">${fns:toNumber(currentPeriod.prepayments) }</a>
                                            </td>
                                            <td>${fns:toNumber(priorPeriod.prepayments) }</td>
                                        </tr>
                                        <tr>
                                            <td>存货</td>
                                            <td>
                                                <a class="color1 btn openlink" href="${ctx}/wd/application/detail/goodsList?applicationId=${applicationId}">${fns:toNumber(currentPeriod.stock) }</a>
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
                                                <a class="color1 btn openlink" href="${ctx}/wd/application/detail/fixAssetsList?applicationId=${applicationId}">${fns:toNumber(currentPeriod.fixedAsset) }</a>
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
                    
                    <div class="shop_info" data-indexname="净利检验" id="_netProfitLogic">
                        <h3>损益表</h3>
                        <div class="tb_wrap">
                            <table>
                                <tbody>
                                    <tr>
                                        <th>年可支    </th>
                                        <th>月可支</th>
                                        <th>详情</th>
                                    </tr>
                                    <tr>
                                        <td>${wdApplicationBusinessIncomeStatement.spendableIncome }</td>
                                        <td>${wdApplicationOperatingBalanceSheet.spendableIncomeAvg }</td>
                                        <td>
                                            <a class="color1 btn openlink" href="${ctx}/wd/application/detail/profitLoss?applicationId=${applicationId}">详情</a>
                                        </td>
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
                    
                    <div class="shop_info" data-indexname="还款计划表" id="_repaymentPlan">
                        <h3>还款计划表</h3>
                        <div class="tb_wrap">
                            <div id="div_repaymentPlan">
                                <a href="${ctx}/wd/application/detail/refundPlanList?applicationId=${applicationId}" class="color3 detail openlink">详情</a>
                            </div>
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
                                                        <c:if test="${wdApplicationTask.status == 8192}">
                                                        	<li>终止原因：${wdApplication.stopCause}</li>
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
    
    <!--modified statt 下边菜单-->
    <div id="menu_bottom" class="operation">
        <span id="span_btnWrap_left">
            <a href="javascript:void(0);" id="closeCurrentWindow" class="color4">关闭</a>
            <c:if test="${not empty appTaskId}">
                <c:if test="${btnStatus.pass}">
                    <a href="javascript:void(0);" id="pass_btn" class="color1">通过</a>
                </c:if>
                <c:if test="${btnStatus.overrule}">
                    <a href="javascript:void(0);" id="return_btn" class="color3">驳回</a>
                </c:if>
                <c:if test="${btnStatus.reject}">
                    <a href="javascript:void(0);" id="reject_btn" class="color2">拒绝</a>
                </c:if>
                <shiro:hasPermission name="wd:application:cancel">
                    <c:if test="${btnStatus.cancel}">
                        <a href="javascript:void(0);" id="cancel_btn" class="color2">终止</a>
                    </c:if>
                </shiro:hasPermission>
                <c:if test="${btnStatus.submit}">
                    <a href="javascript:void(0);" id="submit_btn" class="color1">放款</a>
                </c:if>
            </c:if>
            <shiro:hasPermission name="wd:application:settlement">
                <c:if test="${wdApplication.status == 2048}">
                    <a href="javascript:void(0);" id="end_btn" class="color3">结清</a>
                </c:if>
            </shiro:hasPermission>
        </span>
        <span id="span_btnWrap">
            <c:if test="${null != productConfig['FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF']}">
                <a class="color1 openlink" href="${ctx}/wd/application/detail/surveyPhotoList?applicationId=${applicationId}">调查照片</a>
            </c:if>
            <a href="${ctx}/wd/application/detail/crossManage?applicationId=${applicationId}" class="color4 openlink">交叉管理</a>
       </span>

        <span id="span_float">
            <div id="overview_menu" onmouseleave="">
                <div id="overview_mimgSpan"><img src="${imgStatic}//zwy/LBQ/images/zk_menu.png"></div>
            </div>
       </span>
    </div>
    
    <ul id="overview_menuul">
         <shiro:hasPermission name="wd:application:delete">
            <li>
                <a href="javascript:void(0);" id="del_application">
                    <img src="${imgStatic}/zwy/LBQ/images/zk_delete.png">
                    <p>删除申请</p>
                </a>
            </li>
        </shiro:hasPermission>
        <c:if test="${not empty wdApplication.excelFile}">
            <li>
                <a href="${imagesStatic }${wdApplication.excelFile}">
                    <img src="${imgStatic}/zwy/LBQ/images/zk_excel.png">
                    <p>经营EXCEL</p>
                </a>
            </li>
        </c:if>
        <li>
            <a id="btn-print—all-photo" href="javascript:void();">
                <img src="${imgStatic}/zwy/LBQ/images/zk_photo.png">
                <p>打印照片</p>
            </a>
        </li>
        <c:if test="${wdApplication.status > 2}">
            <li>
                <a href="${ctx}/wd/application/detail/downloadPhotoFile?applicationId=${applicationId}">
                    <img src="${imgStatic}/zwy/LBQ/images/download_photo.png">
                    <p>下载照片</p>
                </a>
            </li>
        </c:if>
        <c:if test="${not empty wdApplication.archiveFile}">
            <li>
                <a href="${imagesStatic }${wdApplication.archiveFile}">
                    <img src="${imgStatic}/zwy/LBQ/images/download_photo.png">
                    <p>归档下载</p>
                </a>
            </li>
        </c:if>
         <spring:eval expression="@wdApplicationDualNoteService.selectByApplicationId(applicationId)" var="dualNoteList"/>
         <c:if test="${not empty dualNoteList}">
            <li>
                <a href="javascript:void();" id="voiceDualNote">
                    <img src="${imgStatic}/zwy/LBQ/images/video.png">
                    <p>双录视频</p>
                </a>
            </li>
         </c:if>
        
        <li>
            <a href="javascript:window.print();">
                <img src="${imgStatic}/zwy/LBQ/images/zk_print.png">
                <p>打印本页</p>
            </a>
        </li>
        <c:if test="${wdApplication.status >= 512}">
            <shiro:hasPermission name="wd:application:resolution">
                <li>
                    <a id="resolution-zhengjiang" href="javascript:void();">
                        <img src="${imgStatic}/zwy/LBQ/images/zk_decision.png">
                        <p>决议表</p>
                    </a>
                </li>
            </shiro:hasPermission>
            <shiro:hasPermission name="wd:application:resolutionxuanhua">
                <li>
                    <a id="resolution-xuanhua" href="javascript:void();">
                        <img src="${imgStatic}/zwy/LBQ/images/zk_decision.png">
                        <p>决议表</p>
                    </a>
                </li>
            </shiro:hasPermission>
            <shiro:hasPermission name="wd:application:resolutionluoshan">
                 <li>
                    <a id="_resolution_luoshan" href="javascript:void();">
                        <img src="${imgStatic}/zwy/LBQ/images/zk_decision.png">
                        <p>决议表</p>
                    </a>
                </li>
            </shiro:hasPermission>
            <shiro:hasPermission name="wd:application:resolutionqingyuan">
                <li>
                    <a id="resolution-qingyuan" href="javascript:void();">
                        <img src="${imgStatic}/zwy/LBQ/images/zk_decision.png">
                        <p>决议表</p>
                    </a>
                </li>
            </shiro:hasPermission>
            <shiro:hasPermission name="wd:application:resolutiondashiqiao">
                <li>
                    <a id="resolution-dashiqiao" href="javascript:void();">
                        <img src="${imgStatic}/zwy/LBQ/images/zk_decision.png">
                        <p>决议表</p>
                    </a>
                </li>
            </shiro:hasPermission>
            <shiro:hasPermission name="wd:application:resolutionluoyang">
                <li>
                    <a id="resolution-luoyang" href="javascript:void();">
                        <img src="${imgStatic}/zwy/LBQ/images/zk_decision.png">
                        <p>决议表</p>
                    </a>
                </li>
            </shiro:hasPermission>
            <shiro:hasPermission name="wd:application:printtable">
                <li><a id="_review_report" href="javascript:void();">
                    <img src="${imgStatic}/zwy/LBQ/images/zk_note.png">
                    <p>会议记录</p>
                </a></li>
                <li><a id="_meeting" href="javascript:void();">
                    <img src="${imgStatic}/zwy/LBQ/images/zk_report.png">
                    <p>审查报告</p>
                </a></li>
            </shiro:hasPermission>
        </c:if>
    </ul>
    <!--modified end 右边菜单-->
    
    <!--modified 右边菜单-->
    <div id="menu_floatRight">
        <div id="menu_icon"></div>
        <div id="menu_content"></div>
    </div>
    
    <!-- 统一js，不删 -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="${imgStatic }/build/js/custom.js"></script>
    <script src="${imgStatic }/zwy/LBQ/js/iframeFix.js"></script>
    <!-- Layer -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    <!-- PrintArea -->
    <script src="${ imgStatic }/vendors/RitsC-PrintArea-2cc7234/demo/jquery.PrintArea.js"></script>
    
    <script src="${imgStatic }/zwy/LBQ/js/dealIn.js?timer=0.32323323"></script>
    <script src="${imgStatic }/zwy/LBQ/js/overview.js?timer=0.32323323"></script>
    <!-- iCheck -->
    <script src="${ imgStatic }/vendors/iCheck/icheck.min.js"></script>
    
    <script>
        var data_menu = [
    		{name:"人员列表", id:"div_rylb"},
    		{name:"房产抵押", id:"div_fcdy"},
    		{name:"征信", id:"div_zhengxin"},
    		{name:"软件信息 ", id:"div_rxxbdc"}
    	];
    
		$(function() {
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
			
			$(".openlink").on("click", function(){
		    	OpenFullIFrame("", this.href);
		    	return false;
		    });
		    $(".id_card_photo").on("click", function(){
		    	var _idcardInfo = $(this).data("idcard")
		    	window.open('${ctx}/wd/application/print/printIdcard?idcard1=' +_idcardInfo[0] + '&idcard2=' +_idcardInfo[1]);  
		    });
			
			// 打印照片
       	 	$("#btn-print—all-photo").on("click", function () {
        		window.open('${ctx}/wd/application/detail/print_all_photo?applicationId=${applicationId}');  
            });
			
       	 	$("#resolution-zhengjiang").on("click", function() {
				OpenFullIFrame("决议表", "${ctx}/wd/application/print/resolution?applicationId=${applicationId }" );
			});
			$("#resolution-xuanhua").on("click",function() {
				OpenFullIFrame("决议表", "${ctx}/wd/application/print/resolutionXuanhua?applicationId=${applicationId }" );
			});
			$("#resolution-dashiqiao").on("click",function() {
				OpenFullIFrame("决议表", "${ctx}/wd/application/print/resolutionDashiqiao?applicationId=${applicationId }" );
			});
			$("#_resolution_luoshan").on("click",function() {
				OpenFullIFrame("决议表", "${ctx}/wd/application/print/resolutionLuosan?applicationId=${applicationId }" );
			});
			$("#resolution-qingyuan").on("click",function() {
				OpenFullIFrame("决议表", "${ctx}/wd/application/print/resolutionQingyuan?applicationId=${applicationId }" );
			});
			$("#resolution-luoyang").on("click",function() {
				OpenFullIFrame("决议表", "${ctx}/wd/application/print/resolutionLuoyang?applicationId=${applicationId }" );
			});
			$("#_review_report").on("click", function() {
				OpenFullIFrame("审查报告", "${ctx}/wd/application/print/review_report?applicationId=${applicationId }" );
			});
			$("#_meeting").on("click", function() {
				OpenFullIFrame("会议记录", "${ctx}/wd/application/print/meeting?applicationId=${applicationId }" );
			});
			$("#voiceDualNote").on("click", function() {
				OpenFullIFrame("双录视频", "${ctx}/wd/application/detail/voiceDualNote?applicationId=${applicationId}" );
            });
			
			$('.innerHtml > ul > li:nth-of-type(even),.bg_color > ul > li:nth-of-type(even)').each(function() {
				$(this).prev("li").append($(this).html());
				$(this).remove();
			})

			var _height1 = $('.result:eq(0) ul').height()
			var _height2 = $('.result:eq(1) dl').height()
			if (_height1 > _height2) {
				$('.result:eq(1) dl').css('height', _height1)
			}

			$("#closeCurrentWindow").on("click", function() {
				location.href = "${app_detail_back_url}";
			})
			$("#del_application").on("click", function() {
				confirmDelAppliation(function(){
					$.ajax({
		                url: "${ctx }/wd/application/del",
		                type: "POST",
		                data: { "applicationId": "${ applicationId }" },
		                dataType: "json",
		                cache: false,
		                success: function (result) {
		                	if (result.success) {
		                		location.href = "${app_detail_back_url}";
		                    } else {
		                    	alert(result.msg);
		                    }
		                }
		            });
				})
			})

			$("#pass_btn").on("click",function() {
				OpenIFrame("通过审批","${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Pass",1000,500,function() {
					if (GetLayerData("close_review_view")) {
						SetLayerData("close_review_view",false);
						location.href = "${app_detail_back_url}";
					}
				});
			});
			
			$("#reject_btn").on("click",function() {
				OpenIFrame("审批拒绝","${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Reject",1000,500,function() {
					if (GetLayerData("close_review_view")) {
						SetLayerData("close_review_view",false);
						location.href = "${app_detail_back_url}";
					}
				});
			});
			
			$("#return_btn").on("click",function() {
				OpenIFrame("审批驳回","${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Return",1000,500,function() {
					if (GetLayerData("close_review_view")) {
						SetLayerData("close_review_view",false);
						location.href = "${app_detail_back_url}";
					}
				});
			});

            $("#submit_btn").on("click", "", function () {
                OpenIFrame("放款完成", "${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Pass", 1000, 500, function () {
                    if (GetLayerData("close_review_view")) {
                        SetLayerData("close_review_view",false);
                        location.href = "${app_detail_back_url}";
                    }
                });
            });

            $("#cancel_btn").on("click", function () {
                OpenIFrame("终止", "${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Cancel", 1000, 500, function () {
                    if (GetLayerData("close_review_view")) {
                        SetLayerData("close_review_view",false);

                        location.href = "${app_detail_back_url}";
                    }
                });
            });

            $("#end_btn").on("click", function () {
            	Confirm("确认该笔贷款已经结清吗？", function (){
            		$.post("${ctx}/wd/application/loaned/settlement", {"applicationId": "${applicationId}"}, function(data){
            			if(data.success) {
            				location.href = "${app_detail_back_url}";
            			} else {
            				NotifyInfo(data.msg);
            			}
            	    });	
            	});
            	
            });

			if ('${fns:toJsonString(softInfoSheet)}') {
				var softInfoSheet = JSON.parse('${fns:toJsonString(softInfoSheet)}');
				if (softInfoSheet) {
					setDataArg(softInfoSheet);
					$('<canvas id="myCanvas" width="300px" height="200px">').insertAfter(".tab_content .tb_wrap .style2");
					drawLine();
				}
			}
			
		  	$.get("${ctx}/wd/application/survey/getApplicationInfo", {applicationId : "${wdApplication.id}"}, function(data){
		  		init_overview(data);
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