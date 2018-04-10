<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>逻辑检验表</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/overview.css" rel="stylesheet">

<style type="text/css">
table.soft-left-sheet-tabel td.cur1 {
    border: solid 3px #0ae !important;
}

table .td_title {
    background: #ccc;
    font-size:1.15em;
    padding: 5px 0 5px 0;
    color:#333!important;
}

table .td_col_title {
    background: #ddd;
    border-right: solid 1px #ddd!important;
    width: 10%;
}

table[name=logicRate] td{
    border-bottom: solid 1px #ddd!important;
}

table[name=logicRate] tr:nth-of-type(n+3) td:nth-of-type(1) {
    width:38%;
}

table[name=logicRate] tr:nth-of-type(n+3) td:nth-of-type(n+3) {
    width:12%;
}
</style>
</head>

<body>
    <div class="wd-content ">
        <div class="left_info">
            <div class="tab_content wd100">
                <div class="shop_info">
                    <h3>毛利率检验
                  <%--   <c:if test="${not empty wdApplication.excelFile }">
                        <a href="${imagesStatic }${wdApplication.excelFile}"><span class="pos">资料excel下载</span></a>
                    </c:if> --%>
                    </h3>
                    
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
                
                <div class="shop_info">
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
                
                <div class="shop_info index_relation">
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
            </div>
        </div>
    </div>

    <nav>
        <ul>
            <li><a href="${ctx}/wd/application/detail/index?applicationId=${applicationId}">总览</a></li>
            <li>
                <a href="${ctx}/wd/application/detail/riskNotice?applicationId=${applicationId}">
                                    风险提示
                    <spring:eval expression="@wdCustomerService.hasRisk(wdApplication.customerId)" var="hasRisk"/>
                    <c:if test="${hasRisk }">
                        <span class="risk">有风险</span>
                    </c:if>
                </a>
            </li>
            <li class="cur"><a href="javascript:void(0)">逻辑检验表</a></li>
            <li><a href="${ctx}/wd/application/detail/profitLoss?applicationId=${applicationId}">损益表</a></li>
            <li><a href="${ctx}/wd/application/detail/prepayList?applicationId=${applicationId}">预付及应收账款</a></li>
            <li><a href="${ctx}/wd/application/detail/goodsList?applicationId=${applicationId}">存货</a></li>
            <li><a href="${ctx}/wd/application/detail/fixAssetsList?applicationId=${applicationId}">固定资产</a></li>
            <li><a href="${ctx}/wd/application/detail/refundPlanList?applicationId=${applicationId}">还款计划表</a></li>
            <li><a href="${ctx}/wd/application/detail/surveyPhotoList?applicationId=${applicationId}">调查图片</a></li>
            <li><a href="${ctx}/wd/application/detail/crossManage?applicationId=${applicationId}">交叉管理</a></li>
        </ul>

        <div class="operation">
             <c:if test="${not empty appTaskId}">
                <a href="javascript:void(0);" id="pass_btn" class="color1">通过</a>
                <a href="javascript:void(0);" id="return_btn" class="color3">驳回</a>
                <a href="javascript:void(0);" id="reject_btn" class="color2">拒绝</a>
            </c:if>
            <a href="javascript:void(0);" id="closeCurrentWindow" class="color4">关闭窗口</a>
        </div>
    </nav>

<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/zwy/LBQ/js/iframeFix.js"></script>
<!-- Layer -->
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script type="text/javascript">
$(function(){
    $("#closeCurrentWindow").on("click", function(){
        location.href = "${app_detail_back_url}";
    })
    $("#pass_btn").on("click", function(){
        OpenIFrame("通过审批", "${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Pass", 1000, 500, function(){
            if (GetLayerData("close_review_view")) {
                SetLayerData("close_review_view", false);
                location.href = "${app_detail_back_url}";
            }
        });
    });
    $("#reject_btn").on("click", function(){
        OpenIFrame("审批拒绝", "${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Reject", 1000, 500, function(){
            if (GetLayerData("close_review_view")) {
                SetLayerData("close_review_view", false);
                location.href = "${app_detail_back_url}";
            }
        });
    });
    $("#return_btn").on("click", function(){
        OpenIFrame("审批驳回", "${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Return", 1000, 500, function(){
            if (GetLayerData("close_review_view")) {
                SetLayerData("close_review_view", false);
                location.href = "${app_detail_back_url}";
            }
        });
    });
})
</script>
</body>
</html>