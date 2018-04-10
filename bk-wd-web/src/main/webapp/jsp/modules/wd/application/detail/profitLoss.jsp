<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>损益表</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/overview.css" rel="stylesheet">
<style type="text/css">
    table {
    font-size: 5px;
}
    table td {
        padding: 0 !important;
    }
</style>
</head>

<body style="min-height: 590px">
    <div class="wd-content">
        <div class="left_info">
            <div class="tab_content post">
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
            </div>
        </div>
    </div>


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