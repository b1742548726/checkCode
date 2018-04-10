<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>预付及应收账款</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/overview.css" rel="stylesheet">
</head>

<body style="min-height: 590px">
    <div class="wd-content">
        <div class="left_info">
            <div class="tab_content wd100">

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