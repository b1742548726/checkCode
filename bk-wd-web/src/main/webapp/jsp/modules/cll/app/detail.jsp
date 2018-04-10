<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${cllApplication.cllCustomer.name}【 ${cllApplication.code}】</title>
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
	
	.left_info .tab_content .personal_info .innerHtml ul li p {
    	width: 18%;
    }
    .left_info .tab_content .personal_info .innerHtml ul li label {
    	width: 15%;
    }
</style>
</head>
<body>
    <div class="wd-content wd-content1">
        <div class="left_info">
            <div class="tab_content">
            	<div class="personal_info">
                    <div class="innerHtml ordinary" data-indexname="客户信息" id="_personInfo">
                        <h3>
                             ${cllApplication.cllCustomer.name } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                             <a href="javascript:history.back();" class="color4 btn">返回</a>&nbsp;&nbsp;&nbsp;&nbsp;
                             
			                <c:if test="${not empty cllApplication.contractFile1}">
								<a href="${imagesStatic}${cllApplication.contractFile1}" target="_blank" class="color4 btn">征信授权书</a>&nbsp;&nbsp;&nbsp;&nbsp;
			                </c:if>
			                <c:if test="${not empty cllApplication.contractFile2}">
			                	<a href="${imagesStatic}${cllApplication.contractFile2}" target="_blank" class="color4 btn">借款合同</a>&nbsp;&nbsp;&nbsp;&nbsp;
			                </c:if>
                             
                        </h3>
                        <ul style="float: left; border-top: none">
                           <li>
                           		<label>身份证：</label><p>${cllApplication.cllCustomer.idno }</p>
                           		<label>身份证照片：</label>
						        <P><button class="color1 picbtn">查看照片</button></P>
						        <ul class="picList" style="display: none">
				                    <li><img data-original="${imagesStatic }${cllApplication.cllCustomer.idnoFontPhoto}" src="${imagesStatic }${fns:choiceImgUrl('80X100', cllApplication.cllCustomer.idnoFontPhoto)}" /></li>
				                    <li><img data-original="${imagesStatic }${cllApplication.cllCustomer.idnoBackPhoto}" src="${imagesStatic }${fns:choiceImgUrl('80X100', cllApplication.cllCustomer.idnoBackPhoto)}" /></li>
				                    <li><img data-original="${imagesStatic }${cllApplication.cllCustomer.idnoHandheldPhoto}" src="${imagesStatic }${fns:choiceImgUrl('80X100', cllApplication.cllCustomer.idnoHandheldPhoto)}" /></li>
						        </ul>
                           		<label>年收入：</label><p>${cllApplication.cllCustomer.annualIncome }</p>
                           		<%-- <label>有效期：</label><p>${cllApplication.cllCustomer.idnoDueDate }</p> --%>
                       	   </li>
                       	   
                           <li>
                           	   <label>年龄：</label><p>${cllApplication.cllCustomer.getAge() }</p>
	                           <label>学历：</label><p>${cllApplication.cllCustomer.education }</p>
	                           <label>婚姻：</label><p>${cllApplication.cllCustomer.marriage }</p>
                           </li>
                           
                           <li>
                           		<label>性别：</label><p>${cllApplication.cllCustomer.gender }</p>
                           		<label>手机号：</label><p>${cllApplication.cllCustomer.mobile }</p>
                           		<label>银行卡：</label><p>${cllApplication.cllCustomer.bankCard }</p>
                           </li>
                           
                           <li>
                           		<label>家庭住址：</label><p>${cllApplication.cllCustomer.homeAddress }</p>
                           </li>
                           
                           <li>
                           		<label>现居地地址：</label><p>${cllApplication.cllCustomer.presentArea } ${cllApplication.cllCustomer.presentAddress }</p>
                           </li>
                           
                           <li>
                           		<label>工作单位：</label><p>${cllApplication.cllCustomer.workUnit }</p>
                           		<label>职业：</label><p>${cllApplication.cllCustomer.profession }</p>
                           		<label>行业类别：</label><p>${cllApplication.cllCustomer.workType }</p>
                       	   </li>
                           
                           <li>
	                           <label>本单位工作年限：</label><p>${cllApplication.cllCustomer.unitWorkingLife }</p>
	                           <label>单位属性：</label><p>${cllApplication.cllCustomer.unitAttribute }</p>
	                           <label>单位电话：</label><p>${cllApplication.cllCustomer.unitTelephone }</p>
                           </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
                
                <div class="personal_info">
                    <div class="innerHtml ordinary" data-indexname="联系人" id="_relitionshap">
                        <h3>
                         		  联系人                                                                 
                        </h3>
                        <c:forEach items="${cllApplication.cllCustomerRelationshipList }" var="customerRelationship">
                        	<c:if test="${customerRelationship.type == 1 }">
	                        	<ul style="float: left; border-top: none">
		                           <%-- <li><label>本地联系人姓名：</label><p>${customerRelationship.name }</p> --%>
		                           <li><label>第一联系人姓名：</label><p>${customerRelationship.name }</p>
		                           <label>联系电话：</label><p>${customerRelationship.mobile }</p>
		                           <label>关系：</label><p>${customerRelationship.relationshipType }</p></li>
		                        </ul>
	                        </c:if>
                        </c:forEach>
                        <c:forEach items="${cllApplication.cllCustomerRelationshipList }" var="customerRelationship">
                        	<c:if test="${customerRelationship.type == 2 }">
	                        	<ul style="float: left; border-top: none">
		                           <%-- <li><label>现居地联系人姓名：</label><p>${customerRelationship.name }</p> --%>
		                           <li><label>第二联系人姓名：</label><p>${customerRelationship.name }</p>
		                           <label>联系电话：</label><p>${customerRelationship.mobile }</p>
		                           <label>关系：</label><p>${customerRelationship.relationshipType }</p></li>
		                        </ul>
	                        </c:if>
                        </c:forEach>
                        <div class="clearfix"></div>
                    </div>
                </div>
            	
                <div class="personal_info" data-indexname="借款信息" id="_applicationinfo">
                    <div class="innerHtml">
                        <h3>
                          	 借款信息<span class="pos">编号：${cllApplication.code}</span>
                        </h3>
                        <ul style="border-top: none">
                        	<li><label>借款期限：</label><p>${cllApplication.applyLimit}</p>
                           <label>还款方式：</label><p>${cllApplication.repaymentCategory}</p>
                          <label>借款用途：</label><p>${cllApplication.applyUse}</p></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
                
                <c:if test="${not empty cllApplication.taskMap.preapproval }">
                	<div class="personal_info" data-indexname="预审结果" id="_preapproval">
	                    <div class="innerHtml">
	                        <h3>
	                          	预审结果<span>${cllApplication.taskMap.preapproval.reviewer} <fmt:formatDate value="${cllApplication.taskMap.preapproval.createDate}" pattern="| yyyy-MM-dd HH:mm:ss"/> </span>
	                        </h3>
	                        <ul style="border-top: none">
	                        	<c:choose>
		                        	<c:when test="${'Reject' eq cllApplication.taskMap.preapproval.result}">
		                        		<li>
			                        	 	<label style="color:red;">预审被拒：</label><p>${cllApplication.taskMap.preapproval.remarks}</p>
			                           	</li>
		                        	</c:when>
		                        	<c:otherwise>
		                        		<li>
				                           <label>建议年利率[%]：</label><p>${cllApplication.taskMap.preapproval.interestRate}</p>
				                           <label>授信最高额度：</label><p>${cllApplication.taskMap.preapproval.amount}</p>
				                           <label>风险提示：</label><p>${not empty cllApplication.taskMap.preapproval.remarks ? cllApplication.taskMap.preapproval.remarks : '无'}</p>
			                           	</li>
		                        	</c:otherwise>
	                        	</c:choose>
	                        </ul>
	                        <div class="clearfix"></div>
	                    </div>
	                </div>
                </c:if>
                
                <c:if test="${not empty cllApplication.taskMap.getCreditReport }">
                	<div class="personal_info" data-indexname="征信结果" id="_getCreditReport">
	                    <div class="innerHtml">
	                        <h3>
	                          	征信结果<span>${cllApplication.taskMap.getCreditReport.reviewer} <fmt:formatDate value="${cllApplication.taskMap.getCreditReport.createDate}" pattern="| yyyy-MM-dd HH:mm:ss"/> </span>
	                        </h3>
	                        <ul style="border-top: none">
	                        	<c:choose>
		                        	<c:when test="${'Reject' eq cllApplication.taskMap.getCreditReport.result}">
		                        		<li>
			                        	 	<label style="color:red;">征信被拒：</label><p>${cllApplication.taskMap.getCreditReport.remarks}</p>
			                           	</li>
		                        	</c:when>
		                        	<c:otherwise>
		                        		<li>
				                           <label>征信通过：</label><p>${not empty cllApplication.taskMap.getCreditReport.remarks ? cllApplication.taskMap.getCreditReport.remarks : '无'}</p>
			                           	</li>
		                        	</c:otherwise>
	                        	</c:choose>
	                        </ul>
	                        <div class="clearfix"></div>
	                    </div>
	                </div>
                </c:if>
                
                 <c:if test="${not empty cllApplication.comprehensiveQuality.createBy}">
	                <div class="personal_info" data-indexname="综合素质" id="_comprehensiveQuality">
	                    <div class="innerHtml">
	                        <h3>
	                          	 综合素质<span>${cllApplication.comprehensiveQuality.createByName} <fmt:formatDate value="${cllApplication.comprehensiveQuality.createDate}" pattern="| yyyy-MM-dd HH:mm:ss"/> </span>
	                        </h3>
	                        
	                        <p>本人</p>
	                        <ul style="border-top: none">
	                        	<li>
	                        		<label>身份证信息确认：</label><p>${cllApplication.comprehensiveQuality.idnoConsistency}</p>
	                        		<label>借款用途和期限确认：</label><p>${cllApplication.comprehensiveQuality.useConsistency}</p>
	                        		<label>工作单位确认：</label><p>${cllApplication.comprehensiveQuality.workConsistency}</p>
	                        	</li>
	                        	<li>
	                        		<label>现居地确认：</label><p>${cllApplication.comprehensiveQuality.localConsistency}</p>
	                        		<label>年收入确认：</label><p>${cllApplication.comprehensiveQuality.incomeConsistency}</p>
	                        		<label>联系人手机号确认：</label><p>${cllApplication.comprehensiveQuality.mobileConsistency}</p>
	                        	</li>
	                        </ul>
	                        
	                        <p>本地联系人</p>
	                        <ul style="border-top: none">
	                        	<li>
	                        		<label>和申请人关系确认：</label><p>${cllApplication.comprehensiveQuality.relater1RelationConsistency}</p>
	                        		<label>工作单位和年限确认：</label><p>${cllApplication.comprehensiveQuality.relater1WorkConsistency}</p>
	                        		<label>婚姻状况确认：</label><p>${cllApplication.comprehensiveQuality.relater1MarriageConsistency}</p>
	                        	</li>
	                        	<li>
	                        		<label>现居地确认：</label><p>${cllApplication.comprehensiveQuality.relater1LocalConsistency}</p>
	                        		<label>是否联系：</label><p>${cllApplication.comprehensiveQuality.relater1Connect}</p>
	                        	</li>
	                        </ul>
	                        
	                        <p>工作地联系人</p>
	                        <ul style="border-top: none">
	                        	<li>
	                        		<label>和申请人关系确认：</label><p>${cllApplication.comprehensiveQuality.relater2RelationConsistency}</p>
	                        		<label>工作单位和年限确认：</label><p>${cllApplication.comprehensiveQuality.relater2WorkConsistency}</p>
	                        		<label>婚姻状况确认：</label><p>${cllApplication.comprehensiveQuality.relater2MarriageConsistency}</p>
	                        	</li>
	                        	<li>
	                        		<label>现居地确认：</label><p>${cllApplication.comprehensiveQuality.relater2LocalConsistency}</p>
	                        		<label>是否联系：</label><p>${cllApplication.comprehensiveQuality.relater2Connect}</p>
	                        	</li>
	                        </ul>
	                        
	                        <p>客户经理建议</p>
	                        <ul style="border-top: none">
	                        	<li>
	                        		<label></label>
	                        		<p>
	                        			${cllApplication.comprehensiveQuality.customerManagerSuggestion}
	                        			<c:if test="${ not empty cllApplication.taskMap.investigation.remarks }">
	                        		 		[ ${ cllApplication.taskMap.investigation.remarks } ]
	                        		 	</c:if>
	                        		 </p>
	                        	</li>
	                        </ul>
	                        <%-- <ul style="border-top: none">
	                           <li>
	                           		<label>客户人品情况：</label><p>${cllApplication.comprehensiveQuality.customerQuality}</p>
	                           		<label>有无赌博等不良习性：</label><p>${cllApplication.comprehensiveQuality.gambling}</p>
	                           		<label>大龄未婚：</label><p>${cllApplication.comprehensiveQuality.unmarriedOldAge}</p>
	                           </li>
	                           <li>
	                           		<label>贷款被诉讼：</label><p>${cllApplication.comprehensiveQuality.loanLawsuits}</p>
	                           		<label>近期有无私人债务纠纷：</label><p>${cllApplication.comprehensiveQuality.debtDispute}</p>
	                           		<label>群众关系情况：</label><p>${cllApplication.comprehensiveQuality.massesRelationship}</p>
	                           </li>
	                           <li>
	                           		<label>患病、残疾：</label><p>${cllApplication.comprehensiveQuality.illnessDisability}</p>
	                           		<label>家庭是否稳定情况：</label><p>${cllApplication.comprehensiveQuality.familyStable}</p>
	                           		<label>有前科：</label><p>${cllApplication.comprehensiveQuality.previousStudy}</p>
	                           </li>
	                           <li>
	                           		<label>调查方式：</label><p>${cllApplication.comprehensiveQuality.investigationMethod}</p>
	                           		<label>评价人关系：</label><p>${cllApplication.comprehensiveQuality.evaluationerRelations}</p>
	                           		<label>评价人姓名：</label><p>${cllApplication.comprehensiveQuality.evaluationerName}</p>
	                           </li>
	                           <li>
	                           		<label>客户经理建议：</label><p>${cllApplication.comprehensiveQuality.customerManagerSuggestion}</p>
	                           </li>
	                        </ul> --%>
	                        <div class="clearfix"></div>
	                    </div>
	                </div>
                </c:if>
                
                <c:if test="${not empty cllApplication.taskMap.approval }">
                	<div class="personal_info" data-indexname="审批结果" id="_approval">
	                    <div class="innerHtml">
	                        <h3>
	                          	审批结果<span>${cllApplication.taskMap.approval.reviewer} <fmt:formatDate value="${cllApplication.taskMap.approval.createDate}" pattern="| yyyy-MM-dd HH:mm:ss"/> </span>
	                        </h3>
	                        <ul style="border-top: none">
	                        	<c:choose>
		                        	<c:when test="${'Reject' eq cllApplication.taskMap.approval.result}">
		                        		<li>
			                        	 	<label style="color:red;">审批被拒：</label><p>${cllApplication.taskMap.approval.remarks}</p>
			                           	</li>
		                        	</c:when>
		                        	<c:otherwise>
		                        		<li>
		                        		   <label>合同编号：</label><p>${cllApplication.contractCode}</p>
				                           <label>建议年利率[%]：</label><p>${cllApplication.taskMap.approval.interestRate}</p>
				                           <label>授信最高额度：</label><p>${cllApplication.taskMap.approval.amount}</p>
			                           	</li>
			                           	<li>
			                           		<label>备注：</label><p>${cllApplication.taskMap.approval.remarks}</p>
			                           	</li>
		                        	</c:otherwise>
	                        	</c:choose>
	                        </ul>
	                        <div class="clearfix"></div>
	                    </div>
	                </div>
                </c:if>
                
                <div class="personal_info" data-indexname="评分参考" id="_approval">
                    <div class="innerHtml">
                        <h3>
                          	评分参考
                        </h3>
                        <ul style="border-top: none">
                       		<li>
	                           <label>软信息评分A：</label><p>${bkScore.infoScoreA}</p>
	                           <label>智闪分策略A：</label><p>${bkScore.scoreA}</p>
	                           <label>芝麻分：</label><p>${zmScore.zmScore}</p>
                           	</li>
	                        <li>
	                           <label>软信息评分B：</label><p>${bkScore.infoScoreB}</p>
	                           <label>智闪分策略B：</label><p>${bkScore.scoreB}</p>
                           	</li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
                
                <c:if test="${not empty shixinList}">
                    <div class="shop_info">
                        <h3>失信被执行人查询记录<span>${shixinList.size()}条记录</span><span class="notice">*该数据采集自全国法院失信被执行人名单，仅供参考。</span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th width="18%">查询时间</th>
                                        <th width="35%">查询信息</th>
                                        <th>查询状态</th>
                                        <th>查询结果</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${shixinList }" var="courtInfo">
                                        <tr>
                                            <td><fmt:formatDate value="${courtInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                            <td style="text-align:left">姓名：${courtInfo.targetName }<br />身份证：${courtInfo.targetIdcard }</td>
                                            <td>${courtInfo.statusDesc}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty courtInfo.getJsonListData()}">
                                                        <button class="color3" data-id="${courtInfo.id }" data-shixin>${courtInfo.getJsonListData().size() }条记录</button>
                                                    </c:when>
                                                    <c:when test="${not empty courtInfo.errorMassage}">
                                                    	${courtInfo.errorMassage}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${not empty courtInfo.id ? '查询无数据' : ''}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty zhixinList}">
                    <div class="shop_info">
                        <h3>被执行人查询记录<span>${zhixinList.size()}条记录</span><span class="notice">*该数据采集自全国法院被执行人名单，仅供参考。</span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th width="18%">查询时间</th>
                                        <th width="35%">查询信息</th>
                                        <th>查询状态</th>
                                        <th>查询结果</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${zhixinList }" var="courtInfo">
                                        <tr>
                                            <td><fmt:formatDate value="${courtInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                            <td style="text-align:left">姓名：${courtInfo.targetName }<br />身份证：${courtInfo.targetIdcard }</td>
                                            <td>${courtInfo.statusDesc}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty courtInfo.getJsonListData()}">
                                                        <button class="color3" data-id="${courtInfo.id }" data-zhixin>${courtInfo.getJsonListData().size() }条记录</button>
                                                    </c:when>
                                                    <c:when test="${not empty courtInfo.errorMassage}">
                                                    	${courtInfo.errorMassage}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${not empty courtInfo.id ? '查询无数据' : ''}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
    
                <c:if test="${not empty cllRwZmCreditAntifraudVerifyList}">
                    <div class="shop_info">
                        <h3>欺诈信息验证查询记录<span>${cllRwZmCreditAntifraudVerifyList.size() }条记录</span><span class="notice">*该数据采集自蚂蚁金服芝麻信用，仅供参考。</span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th width="18%">查询时间</th>
                                        <th width="35%">查询信息</th>
                                        <th>查询结果</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${cllRwZmCreditAntifraudVerifyList }" var="wdRwZmCreditAntifraudVerify">
                                        <tr>
                                            <td><fmt:formatDate value="${cllRwZmCreditAntifraudVerify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                            <td style="text-align:left">
                                                                                姓名：${cllRwZmCreditAntifraudVerify.name }<br />
                                                                                身份证：${cllRwZmCreditAntifraudVerify.certNo }<br />
                                                                                手机号：${cllRwZmCreditAntifraudVerify.mobile }<br />
                                                                                家庭地址：${cllRwZmCreditAntifraudVerify.addr }</td>
                                            <td style="text-align:left">
                                                <c:if test="${not empty cllRwZmCreditAntifraudVerify.getJsonData()}">
                                                    <c:choose>
                                                        <c:when test="${not empty cllRwZmCreditAntifraudVerify.getJsonData()}">
                                                            <c:forEach items="${cllRwZmCreditAntifraudVerify.getJsonData() }" var="result">
                                                                <p>● ${result }</p>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                                                                        查询无数据
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty cllRwTxCreditAntifraudVerifyList}">
                    <div class="shop_info">
                        <h3>反欺诈信息查询记录<span>${cllRwTxCreditAntifraudVerifyList.size() }条记录</span><span class="notice">*该数据采集自腾讯云，仅供参考。</span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th width="18%">查询时间</th>
                                        <th width="35%">查询信息</th>
                                        <th>查询结果</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${cllRwTxCreditAntifraudVerifyList }" var="cllRwTxCreditAntifraudVerify">
                                        <tr>
                                            <td><fmt:formatDate value="${cllRwTxCreditAntifraudVerify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                            <td style="text-align:left">
                                                                                姓名：${cllRwTxCreditAntifraudVerify.name }<br />
                                                                                身份证：${cllRwTxCreditAntifraudVerify.certNo }<br />
                                                                                手机号：${cllRwTxCreditAntifraudVerify.mobile }</td>
                                            <td style="text-align:left">
                                                <c:choose>
                                                	<c:when test="${not empty cllRwTxCreditAntifraudVerify.getJsonData()}">
                                                        <c:forEach items="${cllRwTxCreditAntifraudVerify.getJsonData() }" var="result">
                                                            <p>● ${result }</p>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                                                                    查询无数据
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty cllRwEmaySinowayCreditList}">
                    <div class="shop_info">
                        <h3>多头借贷查询记录<span>${cllRwEmaySinowayCreditList.size()}条记录</span><span class="notice">*该数据采集自华道征信，仅供参考。</span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th width="18%">查询时间</th>
                                        <th width="35%">查询信息</th>
                                        <th>查询结果</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${cllRwEmaySinowayCreditList }" var="data">
                                        <tr>
                                            <td><fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                            <td style="text-align:left">手机号：${data.mobile }<br />查询跨度：<fmt:formatDate value="${data.getStartDate()}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty data.getJsonData()}">
                                                        <button class="color3" data-id="${data.id }" data-emaysinowaycredit>详情</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                                                                                                                                                                    查询无数据
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty cllRwTdBodyguardList}">
                    <div class="shop_info">
                        <h3>同盾反欺诈信息查询记录<span class="notice">*该数据采集自同盾科技，仅供参考。</span></h3>
                        <div class="tb_wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th width="18%">查询时间</th>
                                        <th width="35%">查询信息</th>
                                        <th>总分</th>
                                        <th>查询结果</th>
                                    </tr>
                                </thead>
                                <tbody>
                                
                                    <c:forEach items="${cllRwEmaySinowayCreditList }" var="data">
                                   <tr>
                                       <td><fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                       <td style="text-align:left">
                                       	姓名：${data.name }<br />
                                       	身份证：${data.idno }<br />
                                       	手机号：${data.mobile }
                                       </td>
                                       <td>${data.score }
                                       </td>
                                       <td>
                                           <c:choose>
                                               <c:when test="${'false' eq data.success}">
                                                   ${data.response }
                                               </c:when>
                                               
                                               <c:otherwise>
	                                               	<c:forEach items="${data.getResultJson().result_desc.ANTIFRAUD.risk_items}" var="itemData" varStatus="s">
	                                               		<c:if test="${s.index != 0 }">
	                                               			<br />
	                                               		</c:if>
	                                               		${itemData.risk_name }(${itemData.score })
	                                               	</c:forEach>
                                               </c:otherwise>
                                           </c:choose>
                                       </td>
                                   </tr>
                                   </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
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
			init_overview();
			
			$("button[data-shixin]").click("click", function() {
				 OpenIFrame("失信被执行人查询记录","${ctx}/cll/customer/shixinDetail?id=" + $(this).data("id"), 1000, 600);
			});
			
		   $("button[data-zhixin]").click("click", function() {
				 OpenIFrame("被执行人查询记录","${ctx}/cll/customer/zhixinDetail?id=" + $(this).data("id"), 1000, 600);
			});
		   
		   $("button[data-emaysinowaycredit]").click("click", function() {
			   OpenFullIFrame("多头借贷查询记录","${ctx}/cll/customer/emaySinowayCreditDetail?id=" + $(this).data("id"));
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