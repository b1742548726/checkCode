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
                <a href="javascript:void(0);" class="back">返回</a>
                <c:set var="hasRisk" value="false"/>
                <div class="risk_notice">
                    <spring:eval expression="@wdPersonService.hasRisk(wdCustomer.personId, 'zhixin')" var="hasZhixin" />
                    <spring:eval expression="@wdPersonService.hasRisk(wdCustomer.personId, 'shixin')" var="hasShixin" />
                    <spring:eval expression="@wdCustomerBacklistService.selectBackByCustomerId(wdCustomer.id)" var="backlist"/>
                    <c:choose>
                        <c:when test="${hasZhixin or hasShixin or not empty backlist }">
                            <img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png" alt="">
                            <c:set var="hasRisk" value="true"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${imgStatic }/zwy/LBQ/images/icn_gray_s_risk.png" alt="">
                        </c:otherwise>
                    </c:choose>
                    <p>
                        <c:choose>
                            <c:when test="${hasZhixin or hasShixin or not empty backlist }">
                                <span >风险提示：</span>
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
                                <span style="color:#ccc">风险提示：</span>无风险
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>

            <ul class="client_detail_tab">
                <li><a href="${ctx }/wd/customer/detail/index?customerId=${wdCustomer.id}">客户信息</a></li>
                <li class="cur"><a href="javascript:void(0);">
                    <c:if test="${hasRisk}">
                        <img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png" alt="" class="tab_risk">
                    </c:if>
                                风险提示</a></li>
                <li ><a href="${ctx }/wd/customer/task?customerId=${wdCustomer.id}">客户动态</a></li>
            </ul>

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

            <%-- <div class="shop_info">
                <h3>裁判文书<span>2条记录</span><span class="notice">*该数据采集自中国裁判文书网，仅供参考。</span></h3>
                <div class="tb_wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>查询时间</th>
                                <th>查询信息</th>
                                <th>查询结果</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>2017-02-03 12:00:00</td>
                                <td style="text-align:left">兴隆科技有限公司</td>
                                <td>2条记录</td>
                                <td><button class="color3">查看详情</button></td>
                            </tr>
                            <tr>
                                <td>2017-02-03 12:00:00</td>
                                <td style="text-align:left">兴隆科技有限公司</td>
                                <td>2条记录</td>
                                <td><button class="color3">查看详情</button></td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="shop_info">
                <h3>他人共同借款人<span>2条记录</span><span class="notice">*该数据展示的是本客户在当前系统中作为他人共同借款人的关联关系。</span></h3>
                <div class="tb_wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>他人姓名</th>
                                <th>贷款编号</th>
                                <th>共同贷款金额</th>
                                <th>贷款状态</th>
                                <th>客户经理</th>
                                <th>借贷时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>万石</td>
                                <td><button class="color1">YC213412341234</button></td>
                                <td>4000000</td>
                                <td>还款中</td>
                                <td>周田夏</td>
                                <td>2017-02-03 12:00:00</td>
                            </tr>
                            <tr>
                                <td>万石</td>
                                <td><button class="color1">YC213412341234</button></td>
                                <td>4000000</td>
                                <td>还款中</td>
                                <td>周田夏</td>
                                <td>2017-02-03 12:00:00</td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="shop_info">
                <h3>他人担保人<span>2条记录</span><span class="notice">*该数据展示的是本客户在当前系统中作为他人担保人的关联关系。</span></h3>
                <div class="tb_wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>他人姓名</th>
                                <th>贷款编号</th>
                                <th>贷款金额</th>
                                <th>贷款状态</th>
                                <th>客户经理</th>
                                <th>借贷时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>万石</td>
                                <td><button class="color1">YC213412341234</button></td>
                                <td>4000000</td>
                                <td>还款中</td>
                                <td>周田夏</td>
                                <td>2017-02-03 12:00:00</td>
                            </tr>
                            <tr>
                                <td>万石</td>
                                <td><button class="color1">YC213412341234</button></td>
                                <td>4000000</td>
                                <td>还款中</td>
                                <td>周田夏</td>
                                <td>2017-02-03 12:00:00</td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
            </div> --%>
            <c:if test="${empty wdCustomerBacklist and empty wdRwZmCreditAntifraudVerifyList and empty shixinList and empty zhixinList and empty wdRwEmaySinowayCreditList}">
                <div class="nodata">
                    <img src="${imgStatic }/zwy/LBQ/images/icn_gray_risk.png" alt="">
                    <h3>抱歉，暂无任何风险提示数据！</h3>
                    <p>说明：本页面会展示客户的失信被执行人、被执行人、欺诈信息验证、他人担保人、他人共同借款人等风险信息！</p>
                </div>
            </c:if>
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

    //计算个人信息和图片栏目高度
    var _amount = $('.personal_top').height(),
    _clientInfo = $('#client_info_list').height(),
    _idCard = $('#id_card').height()

    if(_idCard > _clientInfo){
        $('.personal_top').height(_idCard)
        $('#client_info .innerHtml').height(_idCard)
    }else{
        $('.personal_top').height(_clientInfo + 60)
        $('#client_info_list').parent('.innerHtml').css('height',_clientInfo + 60)
        $('#id_card .innerHtml').height(_clientInfo + 60)
    }

    //计算iframe内部高度
    var list_height = $('.right_list').height()
    var content_height = $('.wd-content').height()
    if(list_height > content_height){
        $('.wd-content').css('height',list_height + 20)
    }
    
    $(".back").on("click", function(){
		location.href = "${customer_detail_back_url}";
	})
	
	$("button[data-shixin]").click("click", function() {
		 OpenIFrame("失信被执行人查询记录","${ctx}/wd/customer/shixinDetail?id=" + $(this).data("id"), 1000, 600);
	});
	
    $("button[data-zhixin]").click("click", function() {
		 OpenIFrame("被执行人查询记录","${ctx}/wd/customer/zhixinDetail?id=" + $(this).data("id"), 1000, 600);
	});
    
    $("button[data-emaysinowaycredit]").click("click", function() {
    	 OpenFullIFrame("多头借贷查询记录","${ctx}/wd/customer/emaySinowayCreditDetail?id=" + $(this).data("id"));
  	});
});
</script>
</body>
</html>