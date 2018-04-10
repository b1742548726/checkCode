<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>申请人信息</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/applicant_info.css?timer=0.32323323" rel="stylesheet">
<link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<link href="${imgStatic }/vendors/iCheck/skins/flat/blue.css" rel="stylesheet">
</head>

<body>
    <div class="wd-content">
        <div class="left_info">
            <div class="tab">
                <ul>
                    <c:if test="${not empty complexProductConfig['11111111-1111-1111-1111-111111111111']}">
                        <li class="cur"><a href="javascript:void(0);">申请人信息</a></li>
                    
                        <li><a href="${ctx}/wd/application/survey/softInfo?applicationId=${wdApplication.id}">软信息不对称偏差</a></li>
                        <li><a href="${ctx}/wd/application/survey/implExcel?applicationId=${wdApplication.id}">导入Excel数据</a></li>
                        <li><a href="${ctx}/wd/application/survey/assets?applicationId=${wdApplication.id}">资产负债表</a></li>
                        <li><a href="${ctx}/wd/application/survey/rights?applicationId=${wdApplication.id}">权益检查</a></li>
                    </c:if>
                </ul>
            </div>
            <div class="btn4" id="close_applicant">保存退出</div>
            <div class="btn3" id="submit_applicant">提交审核</div>

            <div class="tab_content">
                <div class="personal_info">
                    <div class="innerHtml ordinary">
                        <h3>个人信息<!-- <span class="edit"></span> --><span class="pos">${wdCustomer.customerTypeName}</span></h3>
                        <ul style="float:left" id="client_info_list">
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
                
                <div class="personal_info">
                    <div class="innerHtml ordinary last">
                        <h3>申请信息<span>编号：${wdApplication.code}</span></h3>
                        <ul>
                            <li>
                                <label for="">产品名称：</label>
                                <p>
                                    ${wdApplication.productName }
                                </p>
                            </li>
                            <li>
                                <label for="">申请时间：</label>
                                <p>
                                    <fmt:formatDate value="${wdApplication.createDate}" pattern="yyyy-MM-dd HH:mm:dd"/>
                                </p>
                            </li>
                            <c:forEach items="${applyAuditInfoConfig }" var="simpleModuleSetting">
                                <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(simpleModuleSetting.businessElementId)" var="wdBusinessElement"/>
                                <li>
                                    <label for="">${wdBusinessElement.name }：</label>
                                    <p>
                                        ${wdApplication.getApplyInfoJson()[wdBusinessElement.key] }
                                    </p>
                                </li>
                            </c:forEach>
                            <c:forEach items="${productConfig['AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA']}" var="applictionInfoConfig">
                                <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[applictionInfoConfig.businessElementId] }"/>
                                <li>
                                    <label for="">${wdBusinessElement.name }：</label>
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
                
                <c:if test="${not empty complexProductConfig['11111111-1111-1111-1111-111111111111']}">
                     <div class="shop_info">
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
                                        <td><input type="text" id="industryCapitalDemandTimeDesc" name="txt_explain"></td>
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
                                        <td><input type="text" id="fundApplicationTimeDesc" name="txt_explain"></td>
                                    </tr>
                                    <tr>
                                        <td>淡旺季描述</td>
                                        <td colspan="13" id="td_season"><span>淡旺季明显</span><span>淡旺季不明显</span></td>
                                    </tr>
                                    <tr>
                                        <td>提议还款来源</td>
                                        <td colspan="13" name="td_paymant"><input type="text" id="proposingRepaymentSource" name="txt_Payment"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                
                     <div class="shop_info">
                        <h3>侧面调查</h3>
                        <div class="tb_wrap">
                            <table id="indirect_survey">
                                <thead>
                                    <tr>
                                        <th>名称</th>
                                        <th>对借款人人品评价</th>
                                        <th>对借款人家庭情况评价</th>
                                        <th>对借款人收入来源评价</th>
                                        <th>对借款人资产情况评价</th>
                                        <th><img src="${imgStatic}/zwy/LBQ/images/plus2.png" alt=""></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                
                    <div class="shop_info">
                        <h3>经营信息
                            <span>${wdApplicationBusinesList.size() }条记录</span>
                            <span class="add" id="addBusinessInfo"></span>
                        </h3>
                        <div class="tb_wrap tian bg_color" id="business_info_view">
                            <c:forEach items="${wdApplicationBusinesList }" var="wdApplicationBusines">
                                <ul>
                                    <c:forEach items="${productConfig['11111111-1111-1111-1111-111111111111']}" var="config" varStatus="itemStatus">
                                        <li>
                                            <label for="">${config.name }：</label>
                                            <p>
                                                ${wdApplicationBusines.getJsonData()[config.key] }
                                                <c:if test="${itemStatus.index == 0 }">
                                                    <span class="delete delBusinessInfo" data-id="${wdApplicationBusines.id }"></span>
                                                    <span class="edit editBusinessInfo" data-id="${wdApplicationBusines.id }"></span>
                                                </c:if>
                                            </p>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                
                <div class="shop_info">
                    <h3>家庭主要资产（房产）
                        <span>${customerBuildingList.size() }条记录</span>
                        <!-- <span class="add" id="addPersonAssetsBuilding"></span> -->
                    </h3>
                    <div class="tb_wrap" id="personAssetsBuildingView">
                        <table>
                            <thead>
                                <tr>
                                    <th>产权人</th>
                                    <c:forEach items="${customerBuildingConfigList }" var="customerBuildingConfig">
                                        <th>${customerBuildingConfig.elementName }</th>
                                    </c:forEach>
                                    <!-- <th>操作</th> -->
                                </tr>
                            </thead>
                            <tbody>
                               <c:forEach items="${customerBuildingList }" var="customerBuilding">
                                <tr>
                                    <spring:eval expression="@wdPersonAssetsBuildingRelationService.selectBuildingRelationALLPerson(customerBuilding.id, wdCustomer.personId)" var="propertyOwnerList"/>
                                    <td>
                                        <c:forEach items="${propertyOwnerList }" var="propertyOwner">
                                            ${propertyOwner.name }（${propertyOwner.relationType }）
                                        </c:forEach>
                                    </td>
                                    <c:forEach items="${customerBuildingConfigList }" var="customerBuildingConfig">
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
                                   <%--  <td>
                                        <span data-id="${customerBuilding.id}" class="delete del-person_assets_building"></span>
                                        <span data-id="${customerBuilding.id}" class="edit edit-person_assets_building"></span>
                                    </td> --%>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="shop_info">
                    <h3>家庭主要资产（车辆）
                        <span>${customerCarList.size() }条记录</span>
                        <!-- <span class="add" id="addPersonAssetsCar"></span> -->
                    </h3>
                    <div class="tb_wrap" id="personAssetsCarView">
                        <table>
                            <thead>
                                <tr>
                                    <c:forEach items="${customerCarConfigList }" var="customerCarConfig">
                                        <th>${customerCarConfig.elementName }</th>
                                    </c:forEach>
                                   <!--  <th>操作</th> -->
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customerCarList }" var="customerCar">
                                    <tr>
                                        <c:forEach items="${customerCarConfigList }" var="customerCarConfig">
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
                                       <%--  <td>
                                            <span data-id="${customerCar.id}" class="delete del-person_assets_car"></span>
                                            <span data-id="${customerCar.id}" class="edit edit-person_assets_car"></span>
                                        </td> --%>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="shop_info">
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
                                        <td><p><a class="color1 btn openlink" href="${ctx}/wd/application/credit/detail?creditId=${applicationCreditInvestigation.id}">征信资料</a></p></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                    </div>
                </div>

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

                <c:if test="${null != productConfig['44444444-4444-4444-4444-444444444444']}">
                    <div class="personal_info">
                        <div class="innerHtml ordinary">
                            <h3>辅助信息<%-- <span class="edit edit_application_extend_info" data-id="${wdApplicationExtendInfo.id }"></span> --%></h3>
                            <ul id="application_extend_info_view">
                                <c:forEach items="${productConfig['44444444-4444-4444-4444-444444444444']}" var="config">
                                    <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }"/>
                                     <li><label for="">${wdBusinessElement.name }：</label><p>${wdApplicationExtendInfo.getJsonData()[wdBusinessElement.key] }</p></li>
                                </c:forEach>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${null != productConfig['77777777-7777-7777-7777-777777777777']}">
                    <div class="personal_info">
                        <div class="innerHtml ordinary">
                            <h3>家庭资产负债表</h3>
                            <ul>
                                <c:forEach items="${productConfig['77777777-7777-7777-7777-777777777777']}" var="config">
                                    <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }"/>
                                     <li><label for="">${wdBusinessElement.name }：</label><p>${applicationBalanceSheet.getJsonData()[wdBusinessElement.key] }</p></li>
                                </c:forEach>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${null != productConfig['66666666-6666-6666-6666-666666666666']}">
                    <div class="personal_info">
                        <div class="innerHtml ordinary">
                            <h3>收入损益表(月)</h3>
                            <ul>
                                <c:forEach items="${productConfig['66666666-6666-6666-6666-666666666666']}" var="config">
                                    <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }"/>
                                     <li><label for="">${wdBusinessElement.name }：</label><p>${applicationMonthlyIncomeStatement.getJsonData()[wdBusinessElement.key] }</p></li>
                                </c:forEach>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${null != productConfig['55555555-5555-5555-5555-555555555555']}">
                    <div class="personal_info">
                        <div class="innerHtml ordinary">
                            <h3>收入损益表(年)</h3>
                            <ul>
                                <c:forEach items="${productConfig['55555555-5555-5555-5555-555555555555']}" var="config">
                                    <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }"/>
                                    <li><label for="">${wdBusinessElement.name }：</label><p>${applicationYearlyIncomeStatement.getJsonData()[wdBusinessElement.key] }</p></li>
                                </c:forEach>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${null != productConfig['FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF']}">
                    <div class="shop_info">
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
                
                <c:if test="${null != productConfig['00000000-0000-0000-0000-111111111111']}">
                    <div class="shop_info">
                        <h3>房产抵押
                            <span>${applicationBuildingMortgageList.size() }条记录</span>
                            <!-- <span class="add" id="add_application_building_mortgage"></span> -->
                        </h3>
                        <div class="tb_wrap bg_color">
                            <c:forEach items="${applicationBuildingMortgageList }" var="data">
                                <spring:eval expression="@wdPersonAssetsBuildingService.selectByPrimaryKey(data.originalId)" var="wdPersonAssetsBuilding"/>
                                <ul>
                                    <c:forEach items="${customerBuildingConfigList }" var="customerBuildingConfig" varStatus="itemStatus">
                                        <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerBuildingConfig.businessElementId] }"/>
                                        <li>
                                            <label>${customerBuildingConfig.elementName }：</label>
                                            <c:choose>
                                                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1 or fns:getDataCategory(wdBusinessElement) == 11 or fns:getDataCategory(wdBusinessElement) == 12}">
                                                    <wd:picList dataList="${wdPersonAssetsBuilding.getJsonData()[wdBusinessElement.key]}" />
                                                </c:when>
                                                <c:otherwise>
                                                   <p> ${wdPersonAssetsBuilding.getJsonData()[wdBusinessElement.key] }
                                                  <%--  <c:if test="${itemStatus.index == 0 }">
                                                    <span class="delete del_application_building_mortgage" data-id="${data.id }"></span>
                                                    <span class="edit edit_application_building_mortgage" data-id="${data.id }"></span>
                                                    </c:if> --%></p>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                    <c:forEach items="${productConfig['00000000-0000-0000-0000-111111111111']}" var="config">
                                        <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }"/>
                                         <li>
                                            <label>${wdBusinessElement.name }：</label>
                                            <c:choose>
                                                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1 or fns:getDataCategory(wdBusinessElement) == 11 or fns:getDataCategory(wdBusinessElement) == 12}">
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
                    </div>
                </c:if>
                
                 <c:if test="${null != productConfig['EEEEEEEE-EEEE-EEEE-EEEE-FFFFFFFFFFFF']}">
                    <div class="shop_info">
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
                </c:if>
                
                <div class="shop_info">
                    <h3>客户关系人
                        <span>${customerRelationList.size() }条记录</span>
                        <!-- <span class="add" id="addPersonRelation"></span> -->
                    </h3>
                    <div class="tb_wrap tian bg_color" id="person_relation_view">
                        <c:forEach items="${customerRelationList }" var="data">
                            <ul>
                                <li><label>与申请人关系：</label>
                                    <p>${data.relationType }
                                        <%-- <span class="delete del_person_relation" data-id="${data.relationId }"></span>
                                        <c:if test="${fns:formatNumber(customerRelationPermissions.get(data.personId), 2)}">
							            	<span class="edit edit_person_relation" data-id="${ data.relationId }"></span>
							            </c:if> --%>
                                     </p>
                                </li>
                                <c:forEach items="${customerRelationConfigList }" var="customerRelationConfig" varStatus="itemStatus">
                                    <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerRelationConfig.businessElementId] }"/>
                                    <li>
                                        <label>${customerRelationConfig.elementName }：</label>
                                        <c:choose>
                                            <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                                                <wd:picList dataList="${data.getJsonData()[wdBusinessElement.key]}" />
                                            </c:when>
                                            <c:when test="${fns:getDataCategory(wdBusinessElement) == 4}">
                                                <p>
                                                    ${(fns:getJSONType(wdPerson.getJsonData()[wdBusinessElement.key]) == 1) ?  fns:parseObject(wdPerson.getJsonData()[wdBusinessElement.key]).position_name : wdPerson.getJsonData()[wdBusinessElement.key]}
                                                </p>
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
                </div>
                
                <c:if test="${null != productConfig['99999999-9999-9999-9999-999999999999']}">
                    <div class="shop_info">
                        <h3>担保人
                            <span>${wdApplicationRecognizorList.size() }条记录</span>
                            <!-- <span class="add" id="add_application_recognizor"></span> -->
                        </h3>
                        <div class="tb_wrap tian bg_color" id="recognizo_info_view">
                            <c:forEach items="${wdApplicationRecognizorList }" var="data">
                                <spring:eval expression="@wdPersonRelationService.selectByPrimaryKey(data.applicationPersonRelationId)" var="wdPersonRelation"/>
                                <c:if test="${not empty wdPersonRelation }">
                                    <spring:eval expression="@wdPersonService.selectByPrimaryKey(wdPersonRelation.relatedPersonId)" var="wdPerson"/>
                                    <ul>
                                        <li><label>与申请人关系：</label>
                                            <p>${wdPersonRelation.relationType }
                                                <%-- <span class="delete del_application_recognizor" data-id="${data.id }"></span>
                                                <span class="edit edit_application_recognizor" data-id="${data.id }"></span> --%>
                                             </p>
                                        </li>
                                        <c:forEach items="${customerRelationConfigList }" var="customerRelationConfig" varStatus="itemStatus">
                                            <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerRelationConfig.businessElementId] }"/>
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
                                                    <c:otherwise>
                                                       <p>${wdPerson.getJsonData()[wdBusinessElement.key] }</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </c:forEach>
                                        <c:forEach items="${productConfig['99999999-9999-9999-9999-999999999999']}" var="config">
                                            <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }"/>
                                             <li>
                                                <label>${wdBusinessElement.name }：</label>
                                                <c:choose>
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
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${null != productConfig['00000000-0000-0000-0000-222222222222']}">
                    <div class="shop_info">
                        <h3>共同借款人
                            <span>${wdApplicationCoborrowerList.size() }条记录</span>
                            <!-- <span class="add" id="add_application_coborrower"></span> -->
                        </h3>
                        <div class="tb_wrap tian tian bg_color" id="coborrower_info_view">
                            <c:forEach items="${wdApplicationCoborrowerList }" var="data">
                                <spring:eval expression="@wdPersonRelationService.selectByPrimaryKey(data.applicationPersonRelationId)" var="wdPersonRelation"/>
                                <c:if test="${not empty wdPersonRelation }">
                                    <spring:eval expression="@wdPersonService.selectByPrimaryKey(wdPersonRelation.relatedPersonId)" var="wdPerson"/>
                                    <ul>
                                        <li><label>与申请人关系：</label>
                                            <p>${wdPersonRelation.relationType }
                                                   <%--  <span class="delete del_application_coborrower" data-id="${data.id }"></span>
                                                    <span class="edit edit_application_coborrower" data-id="${data.id }"></span> --%>
                                             </p>
                                         </li>
                                        <c:forEach items="${customerRelationConfigList }" var="customerRelationConfig">
                                            <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[customerRelationConfig.businessElementId] }"/>
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
                                                    <c:otherwise>
                                                       <p> ${wdPerson.getJsonData()[wdBusinessElement.key] }</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </c:forEach>
                                        <c:forEach items="${productConfig['00000000-0000-0000-0000-222222222222']}" var="config">
                                            <c:set var="wdBusinessElement" value="${wdBusinessElementConfig[config.businessElementId] }"/>
                                            <li>
                                                <label>${wdBusinessElement.name }：</label>
                                                <c:choose>
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
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<!-- iCheck -->
<script src="${imgStatic}/vendors/iCheck/icheck.min.js"></script>
<script src="${imgStatic}/zwy/LBQ/js/dealIn.js?timer=0.32323323"></script>

<script type="text/javascript">
$(function(){
	init_menuShade();
	
    /**
    * 经营信息操作 BEGIN
    *--------------------------------------------------------------------------------------
    */
    $("#addBusinessInfo").on("click", function() {
    	OpenIFrame("新增经营信息", "${ctx}/wd/application/survey/new_business_view?applicationId=${wdApplication.id}", 1000, 700, function(){
    		if (GetLayerData("save_business_data")) {
     			var save_business_data = GetLayerData("save_business_data");
         		SetLayerData("save_business_data", false);
         		StartLoad();
         		if (save_business_data.id) {
         			$.get("${ctx}/wd/application/survey/business_info_detail", {businessId : save_business_data.id, applicationId: "${wdApplication.id}"}, function(data) {
         				$("#business_info_view").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
         	}
        });
    });
    
    $(".wd-content").on("click", ".editBusinessInfo", function() {
    	var _id = $(this).data("id");
    	var _me = this;
    	OpenIFrame("修改经营信息", "${ctx}/wd/application/survey/new_business_view?applicationId=${wdApplication.id}&businessId=" + _id, 1000, 700, function(){
    		if (GetLayerData("save_business_data")) {
     			var save_business_data = GetLayerData("save_business_data");
         		SetLayerData("save_business_data", false);
         		StartLoad();
         		if (save_business_data.id) {
         			$(_me).closest("ul").remove();
         			$.get("${ctx}/wd/application/survey/business_info_detail", {businessId : save_business_data.id, applicationId: "${wdApplication.id}"}, function(data) {
         				$("#business_info_view").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
         	}
        });
    });
    $(".wd-content").on("click", ".delBusinessInfo", function() {
    	var _id = $(this).data("id");
    	var _me = this;
    	Confirm("确定要删除当前数据？", function (){
    		$.ajax({
                url: "${ctx}/wd/application/survey/del_business",
                cache: false,
                type: "POST",
                data: {
                	businessId : _id,
                },
                dataType: "json",
                success: function(result) {
                    if (result.success) {
                    	$(_me).closest("ul").remove();
                    } else {
                        NotifyInCurrentPage("error", result.msg, "错误！");
                    }
                }
            });
    	});
    });
    /**
     * 经营信息操作 END
     *--------------------------------------------------------------------------------------
     */
     
    /**
     * 客户关系人 BEGIN
     *--------------------------------------------------------------------------------------
     */
     $("#addPersonRelation").on("click", function() {
     	OpenIFrame("新增客户关系人", "${ctx}/wd/application/survey/new_person_relation_view?applicationId=${wdApplication.id}", 1000, 700, function(){
     		if (GetLayerData("save_person_relation_data")) {
     			var person_relation_data = GetLayerData("save_person_relation_data");
         		SetLayerData("save_person_relation_data", false);
         		StartLoad();
         		if (person_relation_data.id) {
         			$.get("${ctx}/wd/application/survey/person_relation_detail", {relationId:person_relation_data.id, applicationId: "${wdApplication.id}"}, function(data) {
         				$("#person_relation_view").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
         	}
         });
     });
     $(".wd-content").on("click", ".edit_person_relation", function() {
    	var _me = this;
     	var _id = $(this).data("id");
     	OpenIFrame("修改客户关系人", "${ctx}/wd/application/survey/new_person_relation_view?applicationId=${wdApplication.id}&relationId=" + _id, 1000, 700, function(){
     		if (GetLayerData("save_person_relation_data")) {
     			var person_relation_data = GetLayerData("save_person_relation_data");
         		SetLayerData("save_person_relation_data", false);
         		StartLoad();
         		if (person_relation_data.id) {
             		$(_me).closest("ul").remove();
         			$.get("${ctx}/wd/application/survey/person_relation_detail", {relationId:person_relation_data.id, applicationId: "${wdApplication.id}"}, function(data) {
         				$("#person_relation_view").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
         	}
         });
     });
     $(".wd-content").on("click", ".del_person_relation", function() {
     	var _id = $(this).data("id");
     	var _me = this;
     	Confirm("确定要删除当前数据？", function (){
     		$.ajax({
                url: "${ctx}/wd/application/survey/del_person_relationer",
                cache: false,
                type: "POST",
                data: {
                	relationId : _id,
                },
                dataType: "json",
                success: function(result) {
                    if (result.success) {
                    	$(_me).closest("ul").remove();
                    } else {
                        NotifyInCurrentPage("error", result.msg, "错误！");
                    }
                }
            });
     	});
     });
    
    /**
     * 客户关系人 END
     *--------------------------------------------------------------------------------------
     */
     
     /**
      * 家庭主要资产（房产） BEGIN
      *--------------------------------------------------------------------------------------
      */
      $("#addPersonAssetsBuilding").on("click", function() {
      	OpenIFrame("新增家庭主要资产（房产）", "${ctx}/wd/application/survey/new_person_assets_building_view?applicationId=${wdApplication.id}", 1000, 500, function(){
      		if (GetLayerData("save_person_assets_building_data")) {
      			var save_person_assets_building_data = GetLayerData("save_person_assets_building_data");
         		SetLayerData("save_person_assets_building_data", false);
         		StartLoad();
         		if (save_person_assets_building_data.id) {
         			$.get("${ctx}/wd/application/survey/person_assets_building_detail", {buildingId : save_person_assets_building_data.id, applicationId : "${wdApplication.id}"}, function(data) {
         				$("#personAssetsBuildingView tbody").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
          	 }
          });
      });
    
      $(".wd-content").on("click", ".edit-person_assets_building", function() {
    	var _me = this;
      	var _id = $(this).data("id");
      	OpenIFrame("修改家庭主要资产（房产）", "${ctx}/wd/application/survey/new_person_assets_building_view?applicationId=${wdApplication.id}&buildingId=" + _id, 1000, 500, function(){
      		if (GetLayerData("save_person_assets_building_data")) {
      			var save_person_assets_building_data = GetLayerData("save_person_assets_building_data");
         		SetLayerData("save_person_assets_building_data", false);
         		StartLoad();
         		if (save_person_assets_building_data.id) {
         			$(_me).closest("tr").remove();
         			$.get("${ctx}/wd/application/survey/person_assets_building_detail", {buildingId : save_person_assets_building_data.id, applicationId : "${wdApplication.id}"}, function(data) {
         				$("#personAssetsBuildingView tbody").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
          	 }
          });
      });
      
      $(".wd-content").on("click", ".del-person_assets_building", function() {
      	var _id = $(this).data("id");
      	var _me = this;
      	Confirm("确定要删除当前数据？", function (){
      		$.ajax({
                 url: "${ctx}/wd/application/survey/del_person_assets_building",
                 cache: false,
                 type: "POST",
                 data: {
                	 buildingId : _id,
                	 customerId : "${wdApplication.customerId}"
                 },
                 dataType: "json",
                 success: function(result) {
                     if (result.success) {
                     	$(_me).closest("tr").remove();
                     } else {
                         NotifyInCurrentPage("error", result.msg, "错误！");
                     }
                 }
             });
      	});
      });
     
     /**
      * 家庭主要资产（房产） END
      *--------------------------------------------------------------------------------------
      */
     
     /**
      * 家庭主要资产（车辆） BEGIN
      *--------------------------------------------------------------------------------------
      */
      $("#addPersonAssetsCar").on("click", function() {
      	  OpenIFrame("新增家庭主要资产（车辆）", "${ctx}/wd/application/survey/new_person_assets_car_view?applicationId=${wdApplication.id}", 1000, 500, function(){
      		  if (GetLayerData("save_person_car_data")) {
      			var save_person_car_data = GetLayerData("save_person_car_data");
         		SetLayerData("save_person_car_data", false);
         		StartLoad();
         		if (save_person_car_data.id) {
         			$.get("${ctx}/wd/application/survey/person_assets_car_detail", {carId : save_person_car_data.id, applicationId : "${wdApplication.id}"}, function(data) {
         				$("#personAssetsCarView tbody").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
          	  }
          });
      });
      $(".wd-content").on("click", ".edit-person_assets_car", function() {
    	var _me = this;
      	var _id = $(this).data("id");
      	OpenIFrame("修改家庭主要资产（车辆）", "${ctx}/wd/application/survey/new_person_assets_car_view?applicationId=${wdApplication.id}&carId=" + _id, 1000, 500, function(){
      		if (GetLayerData("save_person_car_data")) {
      			var save_person_car_data = GetLayerData("save_person_car_data");
         		SetLayerData("save_person_car_data", false);
         		StartLoad();
         		if (save_person_car_data.id) {
         			$(_me).closest("tr").remove();
         			$.get("${ctx}/wd/application/survey/person_assets_car_detail", {carId : save_person_car_data.id, applicationId : "${wdApplication.id}"}, function(data) {
         				$("#personAssetsCarView tbody").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
          	 }
          });
      });
      $(".wd-content").on("click", ".del-person_assets_car", function() {
      	var _id = $(this).data("id");
      	var _me = this;
      	Confirm("确定要删除当前数据？", function (){
      		$.ajax({
                 url: "${ctx}/wd/application/survey/del_person_assets_car",
                 cache: false,
                 type: "POST",
                 data: {
                 	carId : _id,
                 },
                 dataType: "json",
                 success: function(result) {
                     if (result.success) {
                     	$(_me).closest("tr").remove();
                     } else {
                         NotifyInCurrentPage("error", result.msg, "错误！");
                     }
                 }
             });
      	});
      });
     /**
      * 家庭主要资产（车辆） END
      *--------------------------------------------------------------------------------------
      */
      
      /**
       * 担保人 BEGIN
       *--------------------------------------------------------------------------------------
       */
       $("#add_application_recognizor"). on("click", function() {
       	   OpenIFrame("新增担保人", "${ctx}/wd/application/survey/application_recognizor_view?applicationId=${wdApplication.id}", 1000, 500, function(){
       		 if (GetLayerData("save_recognizor_data")) {
      			var save_recognizor_data = GetLayerData("save_recognizor_data");
         		SetLayerData("save_recognizor_data", false);
         		StartLoad();
         		if (save_recognizor_data.id) {
         			$.get("${ctx}/wd/application/survey/application_recognizor_detail", {recognizorId : save_recognizor_data.id, applicationId : "${wdApplication.id}"}, function(data) {
         				$("#recognizo_info_view").prepend(data);
         				FinishLoad();
         				window.parent.reinitIframe();
         			})
         		}
          	  }
           });
       });
       $(".wd-content").on("click", ".edit_application_recognizor", function() {
       		var _id = $(this).data("id");
       		var _me = this;
   			OpenIFrame("修改担保人", "${ctx}/wd/application/survey/application_recognizor_view?applicationId=${wdApplication.id}&recognizorId=" + _id, 1000, 500, function(){
           		if (GetLayerData("save_recognizor_data")) {
          			var save_recognizor_data = GetLayerData("save_recognizor_data");
             		SetLayerData("save_recognizor_data", false);
             		StartLoad();
             		if (save_recognizor_data.id) {
             			$(_me).closest("ul").remove();
             			$.get("${ctx}/wd/application/survey/application_recognizor_detail", {recognizorId : save_recognizor_data.id, applicationId : "${wdApplication.id}"}, function(data) {
             				$("#recognizo_info_view").prepend(data);
             				FinishLoad();
             				window.parent.reinitIframe();
             			})
             		}
              	}
           });
       });
       $(".wd-content").on("click", ".del_application_recognizor", function() {
       	var _id = $(this).data("id");
       	var _me = this;
       	Confirm("确定要删除当前数据？", function (){
       		$.ajax({
                  url: "${ctx}/wd/application/survey/del_recognizor",
                  cache: false,
                  type: "POST", 
                  data: {
                  	id : _id,
                  },
                  dataType: "json",
                  success: function(result) {
                      if (result.success) {
                      	$(_me).closest("ul").remove();
                      } else {
                          NotifyInCurrentPage("error", result.msg, "错误！");
                      }
                  }
              });
       	});
       });
      
      /**
       * 担保人） END
       *--------------------------------------------------------------------------------------
       */
       
       /**
        * 共同借款人 BEGIN
        *--------------------------------------------------------------------------------------
        */
        $("#add_application_coborrower"). on("click", function() {
        	   OpenIFrame("新增借款人", "${ctx}/wd/application/survey/edit_coborrower_view?applicationId=${wdApplication.id}", 1000, 500, function(){
        		 if (GetLayerData("save_coborrower_data")) {
       			var save_coborrower_data = GetLayerData("save_coborrower_data");
          		SetLayerData("save_coborrower_data", false);
          		StartLoad();
          		if (save_coborrower_data.id) {
          			$.get("${ctx}/wd/application/survey/coborrower_detail", {coborrowerId : save_coborrower_data.id, applicationId : "${wdApplication.id}"}, function(data) {
          				$("#coborrower_info_view").prepend(data);
          				FinishLoad();
          				window.parent.reinitIframe();
          			})
          		}
           	  }
            });
        });
        $(".wd-content").on("click", ".edit_application_coborrower", function() {
        		var _id = $(this).data("id");
        		var _me = this;
    			OpenIFrame("修改借款人", "${ctx}/wd/application/survey/edit_coborrower_view?applicationId=${wdApplication.id}&coborrowerId=" + _id, 1000, 500, function(){
            		if (GetLayerData("save_coborrower_data")) {
           			var save_coborrower_data = GetLayerData("save_coborrower_data");
              		SetLayerData("save_coborrower_data", false);
              		StartLoad();
              		if (save_coborrower_data.id) {
              			$(_me).closest("ul").remove();
              			$.get("${ctx}/wd/application/survey/coborrower_detail", {coborrowerId : save_coborrower_data.id, applicationId : "${wdApplication.id}"}, function(data) {
              				$("#coborrower_info_view").prepend(data);
              				FinishLoad();
              				window.parent.reinitIframe();
              			})
              		}
               	}
            });
        });
        $(".wd-content").on("click", ".del_application_coborrower", function() {
        	var _id = $(this).data("id");
        	var _me = this;
        	Confirm("确定要删除当前数据？", function (){
        		$.ajax({
                   url: "${ctx}/wd/application/survey/del_coborrower",
                   cache: false,
                   type: "POST", 
                   data: {
                   	id : _id,
                   },
                   dataType: "json",
                   success: function(result) {
                       if (result.success) {
                       	$(_me).closest("ul").remove();
                       } else {
                           NotifyInCurrentPage("error", result.msg, "错误！");
                       }
                   }
               });
        	});
        });
       /**
        * 共同借款人  END
        *--------------------------------------------------------------------------------------
        */
       
       /**
        * 房产抵押 BEGIN
        *--------------------------------------------------------------------------------------
        */
        $("#add_application_building_mortgage").on("click", function() {
        	OpenIFrame("新增房产抵押", "${ctx}/wd/application/survey/building_mortgage_view?applicationId=${wdApplication.id}", 1000, 500, function(){
        		if (GetLayerData("reload_survey_view")) {
            		SetLayerData("reload_survey_view", false);
            		StartLoad();
        			location.reload();
        			FinishLoad();
            	}
            });
        });
        $(".edit_application_building_mortgage").on("click", function() {
        	var _id = $(this).data("id");
        	OpenIFrame("修改房产抵押", "${ctx}/wd/application/survey/building_mortgage_view?applicationId=${wdApplication.id}&id=" + _id, 1000, 500, function(){
        		if (GetLayerData("reload_survey_view")) {
            		SetLayerData("reload_survey_view", false);
            		StartLoad();
        			location.reload();
        			FinishLoad();
            	}
            });
        });
        $(".del_application_building_mortgage").on("click", function() {
        	var _id = $(this).data("id");
        	var _me = this;
        	Confirm("确定要删除当前数据？", function (){
        		$.ajax({
                   url: "${ctx}/wd/application/survey/del_building_mortgage",
                   cache: false,
                   type: "POST",
                   data: {
                   	id : _id,
                   },
                   dataType: "json",
                   success: function(result) {
                       if (result.success) {
                       	$(_me).closest("ul").remove();
                       } else {
                           NotifyInCurrentPage("error", result.msg, "错误！");
                       }
                   }
               });
        	});
        });
       /**
        * 房产抵押  END
        *--------------------------------------------------------------------------------------
        */
        
        /**
         * 辅助信息 begin
         *--------------------------------------------------------------------------------------
         */
        $(".edit_application_extend_info").on("click", function() {
        	var _id = $(this).data("id");
        	OpenIFrame("修改辅助信息", "${ctx}/wd/application/survey/application_extend_info_view?applicationId=${wdApplication.id}&id=" + _id, 1000, 500, function(){
        		if (GetLayerData("save_application_extend_info_data")) {
          			var save_application_extend_info_data = GetLayerData("save_application_extend_info_data");
          			SetLayerData("save_application_extend_info_data", false);
             		StartLoad();
             		if (save_application_extend_info_data.id) {
             			$.get("${ctx}/wd/application/survey/application_extend_info_detail", {id : save_application_extend_info_data.id, applicationId : "${wdApplication.id}"}, function(data) {
             				$("#application_extend_info_view").after(data).remove();
             				FinishLoad();
             				window.parent.reinitIframe();
             			})
             		}
              	 }
            });
        });
        /**
         * 辅助信息 end
         *--------------------------------------------------------------------------------------
         */
        
})


var _applicationId = "${wdApplication.id}";
var save = null, url_save = '${ctx}/wd/application/survey/saveApplicationInfo';	

$(function(){
	$('.innerHtml > ul > li:nth-of-type(even),.bg_color > ul > li:nth-of-type(even)').each(function(){
        $(this).prev("li").append($(this).html());
        $(this).remove();
    })
	
    $(".wd-content").on("click", ".picbtn", function(){
		var _html = $(this).parent().siblings(".picList").html();
		if(!_html && !_html.trim()) {
			alert("暂无图片")	
			return false;
		}
		picPreview(_html, 0);
	})
	
	$(".picgroupBtn").click(function(){
		var _html = $(this).find(".picList").html();
		if(!_html.trim()) {
			return false;
		}
		picPreview(_html, 0);
	})
	
	function picPreview(_html, _index) {
		var parentId = $(parent.window.document).find('#dowebok')
        parentId.html(_html)                            //数据传入父页面图片列表
        window.parent.viewInit()                        //调用父页面图片预览注册方法
        parentId.find('li:eq('+_index+') img').click()  //传入参数并触发预览
	}
    
    $('.tian').each(function(){
        var num = 0
        if($(this).find('ul')){
            $(this).children('ul').each(function(){
                num ++
            })
        }
        if(num%2 == 0){
            $(this).children('ul').eq(num-2).css('border-bottom','none')
        }
    })

 	// 计算页面高度
     var list_height = $('.right_list').height()
     var content_height = $('.wd-content').height()
     if(list_height > content_height){
         $('.wd-content').css('height',list_height + 20)
     }
    
    $('.tab').on('click','ul li',function(){
    	var _success = save();
    	if (!_success)
    		return _success;
    })
    
    $(document).on("click", "#submit_applicant", function () {
    	// 保存当前页面数据
    	var _success = save();
    	if (!_success)
    		return _success;
    		
        OpenIFrame("提交审核", "${ctx}/wd/application/survey/submitSurvey?applicationId=${wdApplication.id}", 800, 480, function(){
        	if (GetLayerData("close_survey")) {
        		SetLayerData("close_survey", false);
    			location.href = "${ctx}/wd/application/mineList";
        	}
        });
    });
    $(document).on("click", "#close_applicant", function () {
    	var _success = save();
    	if (!_success)
    		return _success;
    		
    	location.href = "${ctx}/wd/application/mineList";
    });
    
    var jsondata = {};
    
    $.get("${ctx}/wd/application/survey/getApplicationInfo", {applicationId : "${wdApplication.id}"}, function(data){
    	init_appInfo(data);
	});
    
    $(".openlink").on("click", function(){
    	OpenFullIFrame("", this.href);
    	return false;
    })
})
</script>
</body>
</html>