<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>风险提示</title>
<!--统一样式，不删-->

<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/overview.css" rel="stylesheet">
</head>

<body>
    <div class="wd-content">
        <div class="left_info">
            <ul class="risk_list">
                <c:forEach items="${personRelationList }" var="personRelation">
                    <c:if test="${personRelation.wdPerson.id eq personId }">
                        <c:set var="currentPersonRelation" value="${personRelation }"/>
                    </c:if>
                    <li class="${personRelation.wdPerson.id eq personId ? 'cur' : '' }" data-id="${personRelation.wdPerson.id}">
                        <span>${personRelation.wdPerson.getJsonData().base_info_name }
                        <spring:eval expression="@wdPersonService.hasRisk(personRelation.wdPerson.id, null)" var="hasRisk"/>
                        <c:if test="${hasRisk }">
                            <img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png" alt="">
                        </c:if>
                        </span>
                    </li>
                </c:forEach>
            </ul>
            <div class="tab_content risk_notice" style="min-height: 600px;width:85%">
                <div class="personal_info">
                    <div class="risk_notice_top">
                        <label for="">与申请人关系</label>
                        <p>${currentPersonRelation.relationType }</p>
                        <c:if test="${!('本人' eq currentPersonRelation.relationType)}">
                            <label for="">是否是共同借款人</label>
                            <p>${currentPersonRelation.isCoborrower ? '是' : '否'}</p>
                            <label for="">是否是担保人</label>
                            <p>${currentPersonRelation.isRecognizor ? '是' : '否' }</p>
                        </c:if>
                    </div>
                    
                    <c:if test="${not empty wdCustomerBacklist}">
                        <div class="shop_info">
                            <h3>黑名单信息</h3>
                            <div class="tb_wrap">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>时间</th>
                                            <th>说明</th>
                                            <th>操作人</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach items="${wdCustomerBacklist }" var="wdCustomerBack">
		                                    <c:if test="${wdCustomerBack.delFlag}">
		                                        <spring:eval expression="@sysUserService.selectByPrimaryKey(wdCustomerBack.updateBy)" var="updateBy"/>
		                                        <tr>
		                                            <td><fmt:formatDate value="${wdCustomerBack.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                                            <td>移出黑名单</td>
		                                            <td>${updateBy.name }</td>
		                                        </tr>
		                                    </c:if>
		                                    <spring:eval expression="@sysUserService.selectByPrimaryKey(wdCustomerBack.createBy)" var="createBy1"/>
		                                    <tr>
		                                        <td><fmt:formatDate value="${wdCustomerBack.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                                        <td>${wdCustomerBack.remarks}</td>
		                                        <td>${createBy1.name }</td>
		                                    </tr>
		                                </c:forEach>
                                       <%--  <c:forEach items="wdCustomerBacklist" var="wdCustomerBack">
                                            <spring:eval expression="@sysUserService.selectByPrimaryKey(wdCustomerBack.createBy)" var="createBy"/>
                                            <spring:eval expression="@sysUserService.selectByPrimaryKey(wdCustomerBack.updateBy)" var="updateBy"/>
                                            <tr>
                                                <td><fmt:formatDate value="${wdCustomerBack.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                <td>${wdCustomerBack.remarks}</td>
                                                <td>${createBy }</td>
                                            </tr>
                                            <tr>
                                                <td><fmt:formatDate value="${wdCustomerBack.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                <td>移出黑名单</td>
                                                <td>${updateBy }</td>
                                            </tr>
                                        </c:forEach> --%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
        
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
                                                        <c:otherwise>
                                                            ${not empty courtInfo.errorMassage ? courtInfo.errorMassage : '查询无数据'}
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
                                                        <c:otherwise>
                                                            ${not empty courtInfo.errorMassage ? courtInfo.errorMassage : '查询无数据'}
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
        
                    <c:if test="${not empty wdRwZmCreditAntifraudVerifyList}">
                        <div class="shop_info">
                            <h3>欺诈信息验证查询记录<span>${wdRwZmCreditAntifraudVerifyList.size() }条记录</span><span class="notice">*该数据采集自蚂蚁金服芝麻信用，仅供参考。</span></h3>
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
                                        <c:forEach items="${wdRwZmCreditAntifraudVerifyList }" var="wdRwZmCreditAntifraudVerify">
                                            <tr>
                                                <td><fmt:formatDate value="${wdRwZmCreditAntifraudVerify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                <td style="text-align:left">
                                                                                    姓名：${wdRwZmCreditAntifraudVerify.name }<br />
                                                                                    身份证：${wdRwZmCreditAntifraudVerify.certNo }<br />
                                                                                    手机号：${wdRwZmCreditAntifraudVerify.mobile }<br />
                                                                                    家庭地址：${wdRwZmCreditAntifraudVerify.addr }</td>
                                                <td style="text-align:left">
                                                    <c:if test="${not empty wdRwZmCreditAntifraudVerify.getJsonData()}">
                                                        <c:choose>
                                                            <c:when test="${not empty wdRwZmCreditAntifraudVerify.getJsonData()}">
                                                                <c:forEach items="${wdRwZmCreditAntifraudVerify.getJsonData() }" var="result">
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
                    
                    <c:if test="${not empty wdRwTxCreditAntifraudVerifyList}">
                        <div class="shop_info">
                            <h3>反欺诈信息查询记录<span>${wdRwTxCreditAntifraudVerifyList.size() }条记录</span><span class="notice">*该数据采集自腾讯云，仅供参考。</span></h3>
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
                                        <c:forEach items="${wdRwTxCreditAntifraudVerifyList }" var="wdRwTxCreditAntifraudVerify">
                                            <tr>
                                                <td><fmt:formatDate value="${wdRwTxCreditAntifraudVerify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                <td style="text-align:left">
                                                                                    姓名：${wdRwTxCreditAntifraudVerify.name }<br />
                                                                                    身份证：${wdRwTxCreditAntifraudVerify.certNo }<br />
                                                                                    手机号：${wdRwTxCreditAntifraudVerify.mobile }</td>
                                                <td style="text-align:left">
                                                    <c:choose>
                                                        <c:when test="${not empty wdRwTxCreditAntifraudVerify.getJsonData()}">
                                                            <c:forEach items="${wdRwTxCreditAntifraudVerify.getJsonData() }" var="result">
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
                    
                    <c:if test="${not empty wdRwEmaySinowayCreditList}">
                        <div class="shop_info">
                            <h3>多头借贷查询记录<span>${wdRwEmaySinowayCreditList.size()}条记录</span><span class="notice">*该数据采集自华道征信，仅供参考。</span></h3>
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
                                        <c:forEach items="${wdRwEmaySinowayCreditList }" var="data">
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
                        
                </div>
            </div>
        </div>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script src="${imgStatic }/zwy/LBQ/js/iframeFix.js"></script>
<script>
$(function(){
    var _height1 = $('.result:eq(0) ul').height()
    var _height2 = $('.result:eq(1) dl').height()
    if(_height1 > _height2){
        $('.result:eq(1) dl').css('height',_height1)
    }
    
	$("button[data-shixin]").click("click", function() {
		 OpenIFrame("失信被执行人查询记录","${ctx}/wd/customer/shixinDetail?id=" + $(this).data("id"), 1000, 600);
	});
	
   $("button[data-zhixin]").click("click", function() {
		 OpenIFrame("被执行人查询记录","${ctx}/wd/customer/zhixinDetail?id=" + $(this).data("id"), 1000, 600);
	});
   
   $("button[data-emaysinowaycredit]").click("click", function() {
	   OpenFullIFrame("多头借贷查询记录","${ctx}/wd/customer/emaySinowayCreditDetail?id=" + $(this).data("id"));
   });
   
   
   $(".risk_list li").on("click", function(){
	    var personId = $(this).data("id");
	    location.href = "${ctx}/wd/application/detail/riskNotice?applicationId=${applicationId}&personId=" + personId;
   });
})
</script>
</body>
</html>