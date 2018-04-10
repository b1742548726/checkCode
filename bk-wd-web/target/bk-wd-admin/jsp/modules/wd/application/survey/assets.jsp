<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>资产负债表</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
<link href="${imgStatic }/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/assets.css?timer=0.32323323" rel="stylesheet">
<style type="text/css">
.yearselect, .monthselect{
    background-color: #35465d
}
.only_monthy .table-condensed thead tr:nth-child(2),
.only_monthy .table-condensed tbody {
  display: none
}

</style>
</head>

<body>
    <div class="wd-content">
        <div class="left_info">
            <div class="tab">
                <ul>
                    <li><a href="${ctx}/wd/application/survey/applicantInfo?applicationId=${wdApplication.id}">申请人信息</a></li>
                    <li><a href="${ctx}/wd/application/survey/softInfo?applicationId=${wdApplication.id}">软信息不对称偏差</a></li>
                    <li><a href="${ctx}/wd/application/survey/implExcel?applicationId=${wdApplication.id}">导入Excel数据</a></li>
                    <li class="cur"><a href="javascript:void(0);">资产负债表</a></li>
                    <li><a href="${ctx}/wd/application/survey/rights?applicationId=${wdApplication.id}">权益检查</a></li>
                </ul>
            </div>
            <div class="btn4" id="close_applicant">保存退出</div>
            <div class="btn3" id="submit_applicant">提交审核</div>

            <div class="tab_content">
                <div class="assets">
                    <h3>资产负债表<span id="span_btnHelp">显示帮助 </span></h3>
                    <div class="personal_info">
                        <div class="innerHtml">
                            <table id="zcb">
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
                                        <td class="zc_date_curr"><input type="date" name="pointTime" data-index="0" data-category="currentPeriod" data-table="detail" value="${currentPeriod.pointTime }"></td>
                                        <td class="zc_date_prev"><input type="date" name="pointTime" data-index="1" data-category="priorPeriod" data-table="detail" value="${priorPeriod.pointTime }"></td>
                                    </tr>
                                    <tr>
                                        <td>现金</td>
                                        <td><input type="text" name="cash" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.cash)}' type='number'/>" class="zzc_curr number ldzc_curr"></td>
                                        <td><input type="text" name="cash" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.cash)}' type='number'/>" class="zzc_prev number ldzc_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>银行存款</td>
                                        <td><input type="text" name="bankDeposit" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.bankDeposit)}' type='number'/>" class="zzc_curr number ldzc_curr"></td>
                                        <td><input type="text" name="bankDeposit" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.bankDeposit)}' type='number'/>" class="zzc_prev number ldzc_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>应收账款</td>
                                        <td class="zzc_curr ldzc_curr bgcolor strNum" id="currentPeriodReceivables"><fmt:formatNumber value='${fns:toNumber(currentPeriod.receivables)}' type='number'/></td>
                                        <td><input type="text" name="receivables" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.receivables)}' type='number'/>" class="zzc_prev number ldzc_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>预付款项</td>
                                        <td class="zzc_curr ldzc_curr bgcolor strNum" id="currentPeriodPrepayments"><fmt:formatNumber value='${fns:toNumber(currentPeriod.prepayments)}' type='number'/></td>
                                        <td><input type="text" name="prepayments" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.prepayments)}' type='number'/>" class="zzc_prev number ldzc_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>存货</td>
                                        <td class="zzc_curr ldzc_curr bgcolor strNum" id="currentPeriodStock"><fmt:formatNumber value='${fns:toNumber(currentPeriod.stock)}' type='number'/></td>
                                        <td><input type="text" name="stock" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.stock)}' type='number'/>" class="zzc_prev number ldzc_prev"></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>流动资产合计</td>
                                        <td class="amount_ldzc_curr strNum" id="currentPeriodTotalCurrentAsset"><fmt:formatNumber value='${fns:toNumber(currentPeriod.totalCurrentAsset)}' type='number'/></td>
                                        <td class="amount_ldzc_prev strNum" id="priorPeriodTotalCurrentAsset"><fmt:formatNumber value='${fns:toNumber(priorPeriod.totalCurrentAsset)}' type='number'/></td>
                                    </tr>
                                    <tr>
                                        <td>固定资产</td>
                                        <td class="zzc_curr bgcolor strNum" id="currentPeriodFixedAsset"><fmt:formatNumber value='${fns:toNumber(currentPeriod.fixedAsset)}' type='number'/></td>
                                        <td><input type="text" name="fixedAsset" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.fixedAsset)}' type='number'/>" class="number zzc_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>待摊租金（<input type="text" id="currentPeriodRentSpreadRemarks" value="${currentPeriod.rentSpreadRemarks}" class="zjInput">）</td>
                                        <td><input type="text" name="rentSpread" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.rentSpread)}' type='number'/>" class="number zzc_curr"></td>
                                        <td><input type="text" name="rentSpread" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.rentSpread)}' type='number'/>" class="number zzc_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>其他经营资产</td>
                                        <td><input type="text" name="otherOperatingAsset" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.otherOperatingAsset)}' type='number'/>" class="number zzc_curr"></td>
                                        <td><input type="text" name="otherOperatingAsset" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.otherOperatingAsset)}' type='number'/>" class="number zzc_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>其他非经营资产</td>
                                        <td><input type="text" name="otherNonOperatingAsset" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.otherNonOperatingAsset)}' type='number'/>" class="number zzc_curr"></td>
                                        <td><input type="text" name="otherNonOperatingAsset" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.otherNonOperatingAsset)}' type='number'/>" class="number zzc_prev"></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>总资产合计</td>
                                        <td class=" amount_zzc_curr strNum" id="currentPeriodTotalAssets"><fmt:formatNumber value='${fns:toNumber(currentPeriod.totalAssets)}' type='number'/></td>
                                        <td class=" amount_zzc_prev strNum" id="priorPeriodTotalAssets"><fmt:formatNumber value='${fns:toNumber(priorPeriod.totalAssets)}' type='number'/></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>速动比率</td>
                                        <td class=" amount_sdbl_curr strNum" id="currentPeriodAcidTestRatio"><fmt:formatNumber value='${fns:toNumber(currentPeriod.acidTestRatio)}' type='number'/>%</td>
                                        <td class=" amount_sdbl_prev strNum" id="priorPeriodAcidTestRatio"><fmt:formatNumber value='${fns:toNumber(priorPeriod.acidTestRatio)}' type='number'/>%</td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    
                    <div class="personal_info">
                        <div class="innerHtml last">
                            <table id="fzb">
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
                                        <td class="fz_date_curr"><input data-index="2" type="date" value="${currentPeriod.pointTime }"></td>
                                        <td class="fz_date_prev"><input data-index="3" type="date" value="${priorPeriod.pointTime }"></td>
                                    </tr>
                                    <tr>
                                        <td>应付账款</td>
                                        <td><input type="text" name="payables" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.payables)}' type='number'/>" class="number dqfz_curr"></td>
                                        <td><input type="text" name="payables" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.payables)}' type='number'/>" class="number dqfz_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>预收款项</td>
                                        <td><input type="text" name="advancepay" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.advancepay)}' type='number'/>" class="number dqfz_curr"></td>
                                        <td><input type="text" name="advancepay" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.advancepay)}' type='number'/>" class="number dqfz_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>信用卡</td>
                                        <td class=" dqfz_curr bgcolor strNum" id="currentPeriodCreditCard"><fmt:formatNumber value='${fns:toNumber(currentPeriod.creditCard)}' type='number'/></td>
                                        <td><input type="text" name="creditCard" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.creditCard)}' type='number'/>" class="number dqfz_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>短期贷款</td>
                                        <td class=" dqfz_curr bgcolor strNum" id="currentPeriodShortTermLoan"><fmt:formatNumber value='${fns:toNumber(currentPeriod.shortTermLoan)}' type='number'/></td>
                                        <td><input type="text" name="shortTermLoan" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.shortTermLoan)}' type='number'/>" class="number dqfz_prev"></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>短期负债合计</td>
                                        <td class="amount_dqfz_curr strNum" id="currentPeriodTotalShortTermLiabilities"><fmt:formatNumber value='${fns:toNumber(currentPeriod.totalShortTermLiabilities)}' type='number'/></td>
                                        <td class="amount_dqfz_prev strNum" id="priorPeriodTotalShortTermLiabilities"><fmt:formatNumber value='${fns:toNumber(priorPeriod.totalShortTermLiabilities)}' type='number'/></td>
                                    </tr>
                                    <tr>
                                        <td>长期贷款</td>
                                        <td><input type="text" name="longTermLoan" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.longTermLoan)}' type='number'/>" class="number cqfz_curr"></td>
                                        <td><input type="text" name="longTermLoan" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.longTermLoan)}' type='number'/>" class="number cqfz_prev"></td>
                                    </tr>
                                    <tr>
                                        <td>其他负债</td>
                                        <td><input type="text" name="otherLiability" data-category="currentPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(currentPeriod.otherLiability)}' type='number'/>" class="number cqfz_curr"></td>
                                        <td><input type="text" name="otherLiability" data-category="priorPeriod" data-table="detail" value="<fmt:formatNumber value='${fns:toNumber(priorPeriod.otherLiability)}' type='number'/>" class="number cqfz_prev"></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>长期负债合计</td>
                                        <td class="amount_cqfz_curr strNum" id="currentPeriodTotalLongTermLiabilities"><fmt:formatNumber value='${fns:toNumber(currentPeriod.totalLongTermLiabilities)}' type='number'/></td>
                                        <td class="amount_cqfz_prev strNum" id="priorPeriodTotalLongTermLiabilities"><fmt:formatNumber value='${fns:toNumber(priorPeriod.totalLongTermLiabilities)}' type='number'/></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>总负债合计</td>
                                        <td class="total_fz_curr strNum" id="currentPeriodTotalLiabilities"><fmt:formatNumber value='${fns:toNumber(currentPeriod.totalLiabilities)}' type='number'/></td>
                                        <td class="total_fz_prev strNum" id="priorPeriodTotalLiabilities"><fmt:formatNumber value='${fns:toNumber(priorPeriod.totalLiabilities)}' type='number'/></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>权益</td>
                                        <td class="qy_curr bgcolor strNum" id="currentPeriodEquity"><fmt:formatNumber value='${fns:toNumber(currentPeriod.equity)}' type='number'/></td>
                                        <td class="qy_prev bgcolor strNum" id="priorPeriodEquity"><fmt:formatNumber value='${fns:toNumber(priorPeriod.equity)}' type='number'/></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>负债及权益合计</td>
                                        <td class="amount_qy_curr strNum"><fmt:formatNumber value='${fns:toNumber(currentPeriod.totalAssets)}' type='number'/></td>
                                        <td class="amount_qy_prev strNum"><fmt:formatNumber value='${fns:toNumber(priorPeriod.totalAssets)}' type='number'/></td>
                                    </tr>
                                    <tr class="amount">
                                        <td>资产负债率</td>
                                        <td class="amount_zcfzl_curr strNum" id="currentPerioDebtToAssetsRatio"><fmt:formatNumber value='${fns:toNumber(currentPeriod.debtToAssetsRatio)}' type='number'/>%</td>
                                        <td class="amount_zcfzl_prev strNum" id="priorPeriodDebtToAssetsRatio"><fmt:formatNumber value='${fns:toNumber(priorPeriod.debtToAssetsRatio)}' type='number'/>%</td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                
                <!--信贷历史-->
                <div class="form_assets">
                    <div class="tb_outwrap width100">
                        <div class="shop_info">
                            <h3>信贷历史</h3>
                            <div class="tb_wrap">
                                <table id="creditHistory">
                                    <thead>
                                        <tr>
                                            <th>融资来源</th>
                                            <th>贷款金额</th>
                                            <th>期限（月）</th>
                                            <th>用途</th>
                                            <th>发放日期</th>
                                            <th>余额</th>
                                            <th>担保形式</th>
                                            <th>逾期信息</th>
                                            <th><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt="" id="add_creadiHistory"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!--end 信贷历史-->
                    
                    <!--信用卡使用情况-->
                    <div class="tb_outwrap width100">
                        <div class="shop_info">
                            <h3>信用卡使用情况</h3>
                            <div class="tb_wrap">
                                <table id="creditInfo">
                                    <thead>
                                        <tr>
                                            <th>信用卡卡主</th>
                                            <th>信用卡授信额度</th>
                                            <th>已用额度</th>
                                            <th>近6个月使用额度</th>
                                            <th>信用卡余额</th>
                                            <th><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt="" id="add_creadiInfo"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!--end 信用卡使用情况-->
                

                <div class="form_assets">
                    <div class="tb_outwrap">
                        <div class="shop_info">
                            <h3>表外资产</h3>
                            <div class="tb_wrap">
                                <table class="offBalanceAsset">
                                    <thead>
                                        <tr>
                                            <th>名称</th>
                                            <th>价值或者金额</th>
                                            <th class="add"><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt=""></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${assetAdditionals }" var="assetAdditional">
                                            <tr>
                                                <td><input type="text" value="${assetAdditional.text}"></td>
                                                <td><input type="text" value="${assetAdditional.amount}"></td>
                                                <td><button class="color3">删除</button></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
    
                    <div class="tb_outwrap">
                        <div class="shop_info last">
                            <h3>表外负债</h3>
                            <div class="tb_wrap">
                                <table class="offBalanceSheet">
                                    <thead>
                                        <tr>
                                            <th>名称</th>
                                            <th>价值或者金额</th>
                                            <th class="add"><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt=""></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${debtsAdditionals }" var="debtsAdditional">
                                            <tr>
                                                <td><input type="text" value="${debtsAdditional.text}"></td>
                                                <td><input type="text" value="${debtsAdditional.amount}"></td>
                                                <td><button class="color3">删除</button></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tb_outwrap">
                    <div class="shop_info">
                        <h3>对外担保情况</h3>
                        <div class="tb_wrap">
                            <table class="externalSecurity">
                                <thead>
                                    <tr>
                                        <th>名称</th>
                                        <th>价值或者金额</th>
                                        <th class="add"><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt=""></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${assureAdditionals }" var="assureAdditional">
                                        <tr>
                                            <td><input type="text" value="${assureAdditional.text}"></td>
                                            <td><input type="text" value="${assureAdditional.amount}"></td>
                                            <td><button class="color3">删除</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            
                <div class="appraisal">
                    <div class="innerHtml">
                        <h3>资产负债评价</h3>
                        <ul>
                            <li><label for="">应收款与月平均营业额对比(%)：</label><input type="text" disabled="" id="receivablesVsTurnover" value="${wdApplicationOperatingBalanceSheet.receivablesVsTurnover }"></li>
                            <li>
                                <label for="">应收款与月平均营业额对比说明：</label>
                                <textarea id="receivablesVsTurnoverText">${wdApplicationOperatingBalanceSheet.receivablesVsTurnoverText }</textarea>
                            </li>
                            
                            <li><label for="">存货可销售与月平均营业额对比(%)：</label><input type="text" disabled="" id="stockVsTurnover" value="${wdApplicationOperatingBalanceSheet.stockVsTurnover }"></li>
                            <li><label for="">存货可销售与月平均营业额对比说明：</label>
                                <textarea id="stockVsTurnoverText">${wdApplicationOperatingBalanceSheet.stockVsTurnoverText }</textarea>
                            </li>
                            
                            <li><label for="">借款人权益与借款人家庭开支（月）对比(%)：</label><input type="text" disabled="" id="equityVsExpense" value="${wdApplicationOperatingBalanceSheet.equityVsExpense }"></li>
                            <li><label for="">借款人权限与借款人家庭开支（月）对比说明：</label>
                                <textarea id="equityVsExpenseText">${wdApplicationOperatingBalanceSheet.equityVsExpenseText }</textarea>
                            </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="display: none;">
        <table>
        <tr id="addTd">
            <td><input type="text" value="黄新国"></td>
            <td><input type="text" value="否"></td>
            <td><button class="color3">删除</button></td>
        </tr>
        </table>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script src="${imgStatic }/vendors/moment/min/moment.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

<script src="${imgStatic }/zwy/js/common_bake_jyshen.js?timer=0.32323323"></script>
<script src="${imgStatic }/zwy/LBQ/js/dealIn.js?timer=0.32323323"></script>

<script>
$(function(){
	init_menuShade();
	 
    //提交申请
    $(document).on("click", "#submit_applicant", function () {
    	var _success = save();
    	if (!_success)
    		return _success;
    	// 保存当前页面数据
        OpenIFrame("提交审核", "${ctx}/wd/application/survey/submitSurvey?applicationId=${wdApplication.id}", 800, 480, function(){
        	if (GetLayerData("close_survey")) {
        		SetLayerData("close_survey", false);
    			location.href = "${survey_back_url}";
        	}
        });
    });
    $(document).on("click", "#close_applicant", function () {
    	var _success = save();
    	if (!_success)
    		return _success;
    	location.href = "${survey_back_url}";
    });
    $('.tab').on('click','ul li',function(){
    	var _success = save();
    	if (!_success)
    		return _success;
    })
})

function save() {
	//所有数据内容去逗号
    $(".strNum").each(function(){
        $(this).html(exchange($(this).html()))
    })
    $(".number").each(function(){
        $(this).val(exchange($(this).val()))
    })
	
	var balanceSheet = {}; //资产负债表数据
	balanceSheet.id="${wdApplicationOperatingBalanceSheet.id}";
	balanceSheet.applicationId= "${wdApplication.id}";
	
	balanceSheet.clickTime = $("#clickTime").val();
	balanceSheet.receivablesVsTurnover = $("#receivablesVsTurnover").val() ? exchange($("#receivablesVsTurnover").val()) : '';
	balanceSheet.receivablesVsTurnoverText = $("#receivablesVsTurnoverText").val();
	balanceSheet.stockVsTurnover = $("#stockVsTurnover").val() ? exchange($("#stockVsTurnover").val()) : "";
	balanceSheet.stockVsTurnoverText = $("#stockVsTurnoverText").val();
	balanceSheet.equityVsExpense = $("#equityVsExpense").val() ? exchange($("#equityVsExpense").val()) : "";
	balanceSheet.equityVsExpenseText = $("#equityVsExpenseText").val();
	balanceSheet.familyChargeMonth = "${wdApplicationOperatingBalanceSheet.familyChargeMonth }";
	balanceSheet.incomeMonth = "${wdApplicationOperatingBalanceSheet.incomeMonth }";
	console.log(balanceSheet);
	
	var balanceSheetDetailData = [];
	var currentPeriod = {}; //本期
	currentPeriod.category = "1";
	currentPeriod.receivables = $("#currentPeriodReceivables").text(); // 应收账款
	currentPeriod.prepayments = $("#currentPeriodPrepayments").text(); //预付款项
	currentPeriod.stock = $("#currentPeriodStock").text(); //存货
	currentPeriod.totalCurrentAsset = $("#currentPeriodTotalCurrentAsset").text(); //流动资产合计
	currentPeriod.fixedAsset = $("#currentPeriodFixedAsset").text(); //固定资产
	currentPeriod.totalAssets = $("#currentPeriodTotalAssets").text(); //总资产合计
	currentPeriod.creditCard = $("#currentPeriodCreditCard").text(); //信用卡
	currentPeriod.shortTermLoan = $("#currentPeriodShortTermLoan").text(); //短期贷款
	currentPeriod.totalShortTermLiabilities = $("#currentPeriodTotalShortTermLiabilities").text(); //短期负债合计
	currentPeriod.totalLongTermLiabilities = $("#currentPeriodTotalLongTermLiabilities").text(); //长期负债合计
	currentPeriod.totalLiabilities = $("#currentPeriodTotalLiabilities").text(); //总负债合计
	currentPeriod.equity = $("#currentPeriodEquity").text(); //权益
	currentPeriod.rentSpreadRemarks = $("#currentPeriodRentSpreadRemarks").val();
	
	currentPeriod.acidTestRatio = $("#currentPeriodAcidTestRatio").text();		//速动比率
	currentPeriod.debtToAssetsRatio = $(".amount_zcfzl_curr").text();		//资产负债率

	var priorPeriod = {}; //上期
	priorPeriod.category = "2";
	priorPeriod.totalCurrentAsset = $("#priorPeriodTotalCurrentAsset").text(); //流动资产合计
	priorPeriod.totalShortTermLiabilities = $("#priorPeriodTotalShortTermLiabilities").text(); //短期负债合计
	priorPeriod.totalLongTermLiabilities = $("#priorPeriodTotalLongTermLiabilities").text(); //长期负债合计
	priorPeriod.totalLiabilities = $("#priorPeriodTotalLiabilities").text(); //总负债合计
	priorPeriod.equity = $("#priorPeriodEquity").text(); //权益
	
	priorPeriod.acidTestRatio = $("#priorPeriodAcidTestRatio").text();		//速动比率
	priorPeriod.debtToAssetsRatio = $(".amount_zcfzl_prev").text();		//资产负债率

	$(":input[data-table=detail]").each(function(index, dom){
		var category = $(dom).data("category");
		if (category == 'currentPeriod') {
			currentPeriod[$(dom).attr("name")] = $(dom).val();
		} else {
			priorPeriod[$(dom).attr("name")] = $(dom).val();
		}
	});
	balanceSheetDetailData.push(currentPeriod);
	balanceSheetDetailData.push(priorPeriod);
	balanceSheet.balanceSheetDetailData = JSON.stringify(balanceSheetDetailData);
	
	var obj = $('.offBalanceAsset').find('tbody').children('tr')
    var balanceSheetAdditionalData = []
    obj.each(function(){
    	balanceSheetAdditionalData.push({
    		 text : $(this).children('td').eq(0).find("input").val(),
    		 amount : $(this).children('td').eq(1).find("input").val(),
             category : "1"
        })
    })
	
    obj = $('.offBalanceSheet').find('tbody').children('tr')
    obj.each(function(){
    	balanceSheetAdditionalData.push({
    		 text : $(this).children('td').eq(0).find("input").val(),
    		 amount : $(this).children('td').eq(1).find("input").val(),
             category : "2"
        })
    })
    
    obj = $('.externalSecurity').find('tbody').children('tr')
    obj.each(function(){
    	balanceSheetAdditionalData.push({
    		text : $(this).children('td').eq(0).find("input").val(),
    		amount : $(this).children('td').eq(1).find("input").val(),
            category : "3"
        })
    })
    
    balanceSheet.balanceSheetAdditionalData = JSON.stringify(balanceSheetAdditionalData);
	
	$(".strNum").each(function(){
        $(this).html(ex_reverse($(this).html()))
    })
    $(".number").each(function(){
        $(this).val(ex_reverse($(this).val()))
    })
    
	var creditData = getCreditDate();
    if (creditData) {
        if (creditData.creditHistoryListData) {
        	balanceSheet.creditHistoryListData = JSON.stringify(creditData.creditHistoryListData);
        }
        if (creditData.creditCardUseInfoListdata) {
            balanceSheet.creditCardUseInfoListdata = JSON.stringify(creditData.creditCardUseInfoListdata);
        }
    }
	
    
    var _success = false;
    $.ajax({
        url: "${ctx}/wd/application/survey/saveAssets",
        async: false,
        cache: false,
        type: "POST",
        data: balanceSheet,
        dataType: "json",
        success: function (result) {
            if (result.success) {
            	_success = true;
            } else {
                NotifyInCurrentPage("error", result.msg, "错误！");
            }
        }
    });
    return _success;
}

//转换
function exchange(value){
    var val = parseFloat(value.replace(/\,/g,''))
    return val
}
//反向转换
function ex_reverse(value){
    var val
    if(typeof value == 'number'){
        val = parseFloat(value).toLocaleString()
    }else{
        val = parseFloat(value.replace(/\,/g,''))
        val = parseFloat(val).toLocaleString()
    }
    return val
}

$(function(){
    // 表格添加
    $('.color3').on('click',function(){
        $(this).closest('tr').remove()
    })
    
    $('.add').on('click',function(){
        var _html = $("#addTd").clone(true);
        _html.find('input').val('')
        $(this).closest('table').children('tbody').append(_html)
    })
})

var _familyChargeMonth = ${fns:toNumber(wdApplicationOperatingBalanceSheet.familyChargeMonth) };
$(function(){
	$.get("${ctx}/wd/application/survey/getAssetsInfo", {applicationId : "${wdApplication.id}"}, function(data){
		init_asset(data);
	});
});

</script>
</body>
</html>