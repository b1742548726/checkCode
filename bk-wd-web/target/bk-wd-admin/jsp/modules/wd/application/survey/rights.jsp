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

<link href="${imgStatic }/zwy/LBQ/css/assets.css" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/rights.css?timer=0.32323323" rel="stylesheet">
</head>
<body>
    <div class="wd-content">
        <div class="left_info">
            <div class="tab">
                <ul>
                    <li><a href="${ctx}/wd/application/survey/applicantInfo?applicationId=${wdApplication.id}">申请人信息</a></li>
                    <li><a href="${ctx}/wd/application/survey/softInfo?applicationId=${wdApplication.id}">软信息不对称偏差</a></li>
                    <li><a href="${ctx}/wd/application/survey/implExcel?applicationId=${wdApplication.id}">导入Excel数据</a></li>
                    <li><a href="${ctx}/wd/application/survey/assets?applicationId=${wdApplication.id}">资产负债表</a></li>
                    <li class="cur"><a href="javascript:void(0);">权益检查</a></li>
                </ul>
            </div>
            <div class="btn4" id="close_applicant">保存退出</div>
            <div class="btn3" id="submit_applicant">提交审核</div>
            
            <div class="tab_content">
            <form id="submitForm">
                <input type="hidden" name="id" value="${wdApplicationOperatingBalanceSheetCheck.id}">
                <input type="hidden" name="applicationId" value="${wdApplication.id}">
                <div class="appraisal">
                    <div class="innerHtml" id="check1">
                        <h3>初始权益点资产负债表<span id="span_btnHelp">显示帮助</span></h3>
                        <ul>
                             <!-- name="checkPoint" -->
                            <li><label for="">权益检验原始点：</label><input type="month" class="primitive" id="checkPoint" name="checkPoint" value="${wdApplicationOperatingBalanceSheetCheck.checkPoint}"></li>
                            <li>&nbsp;</li>

                            <li><label for="">现金及银行存款：</label><input type="text" class="yhck" name="cashAndDeposit" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.cashAndDeposit)}' type='number'/>"></li>
                            <li><label for="">应付账款：</label><input type="text" class="yfzk" name="payables" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.payables)}' type='number'/>"></li>
                            <li><label for="">应收账款：</label><input type="text" class="yszk" name="receivables" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.receivables)}' type='number'/>"></li>
                            <li><label for="">预收款项：</label><input type="text" class="yskx" name="advancepay" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.advancepay)}' type='number'/>"></li>
                            <li><label for="">预付款项：</label><input type="text" class="yfkx" name="prepayments" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.prepayments)}' type='number'/>"></li>
                            <li><label for="">短期贷款：</label><input type="text" class="dqdk" name="shortTermLoan" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.shortTermLoan)}' type='number'/>"></li>
                            <li><label for="">存货：</label><input type="text" class="ch" name="stock" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.stock)}' type='number'/>"></li>
                            <li><label for="">长期贷款：</label><input type="text" class="cqdk" name="longTermLoan" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.longTermLoan)}' type='number'/>"></li>
                            <li><label for="">固定资产：</label><input type="text" class="gdzc" name="fixedAsset" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.fixedAsset)}' type='number'/>"></li>
                            <li><label for="">其他负债：</label><input type="text" class="qtfz" name="otherLiability" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.otherLiability)}' type='number'/>"></li>
                            
                            <li><label for="">待摊租金：</label><input type="text" class="dtzj" name="otherOperatingAsset" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.otherOperatingAsset)}' type='number'/>"></li>
                            <li>&nbsp;</li>
                            <li><label for="">其它非经营资产：</label><input type="text" class="fjyzc" name="otherNonOperatingAsset" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.otherNonOperatingAsset)}' type='number'/>"></li>
                            <li><label for="">权益：</label><input type="text" disabled class="qy" name="equity" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.equity)}' type='number'/>"></li>
                            <li><label for="">总资产：</label><input type="text" disabled class="zzc" name="totalAssets" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.totalAssets)}' type='number'/>"></li>
                            <li><label for="">负债及权益合计：</label><input type="text" disabled class="amount_qy" name="liabilitiesAndEquity" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.liabilitiesAndEquity)}' type='number'/>"></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>

                <div class="appraisal">
                    <div class="innerHtml" id="check2">
                        <h3>权益逻辑检验</h3>
                        <ul>
                            <li><label for="">初始权益金额：</label><input type="text" disabled name="initialEquityAmount" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.initialEquityAmount)}' type='number'/>" class="csqyje"></li>
                            <li><label for="">初始权益：</label><textarea name="initialEquity" cols="30" rows="10">${wdApplicationOperatingBalanceSheetCheck.initialEquity }</textarea></li>
                            <li><label for="">期间内的利润金额：</label><input name="periodProfitAmount" type="text" class="qjlr" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.periodProfitAmount)}' type='number'/>"></li>
                            <li><label for="">期间内的利润：</label><textarea name="periodProfit" cols="30" rows="10">${wdApplicationOperatingBalanceSheetCheck.periodProfit }</textarea></li>
                            <li><label for="">期间内资本注入金额：</label><input name="periodCapitalAmount" type="text" class="qjzbzr" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.periodCapitalAmount)}' type='number'/>"></li>
                            <li><label for="">期间内资本注入：</label><textarea name="periodCapital" cols="30" rows="10">${wdApplicationOperatingBalanceSheetCheck.periodCapital }</textarea></li>
                            <li><label for="">期内提取的资金金额：</label><input name="periodFundingAmount" type="text" class="qntqzj" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.periodFundingAmount)}' type='number'/>"></li>
                            <li><label for="">期内提取的资金：</label><textarea name="periodFunding" cols="30" rows="10">${wdApplicationOperatingBalanceSheetCheck.periodFunding }</textarea></li>
                            <li><label for="">折旧/升值金额：</label><input name="deOrAppreciationAmount" type="text" disabled class="zjje" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.deOrAppreciationAmount)}' type='number'/>"></li>
                            <li><label for="">折旧/升值：</label><textarea name="deOrAppreciation" cols="30" rows="10">${wdApplicationOperatingBalanceSheetCheck.deOrAppreciation }</textarea></li>
                            
                            <li class="percent30"><label for="">应有权益：</label><input name="entitlement" type="text" disabled class="yyqy" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.entitlement)}' type='number'/>"></li>
                            <li class="percent30"><label for="">偏差值：</label><input name="deviationValue" type="text" disabled class="pcz" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.deviationValue)}' type='number'/>"></li>
                            <li class="percent30"><label for="">偏差率：</label><input name="deviationRate" type="text" disabled class="pcl" value="<fmt:formatNumber value='${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.deviationRate)}' type='number'/>"></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </form>
            </div>
        </div>
    </div>

<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/vendors/moment/min/moment.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<script type="text/javascript">
var g_curMonth = "${wdApplicationOperatingBalanceSheetCheck.currentPeriodPointTime}";	//资产及负债的资产负债表!本期月份
var g_excel = parseFloat("${fns:toNumber(wdApplicationOperatingBalanceSheetCheck.spendableIncomeAvg)}");	// Excel损益表!平均月可支
var _orgEntitlement = parseFloat("${fns:toNumber(orgEntitlement) }");
</script>

<script src="${imgStatic }/zwy/LBQ/js/dealIn.js"></script>

<script>
$(function(){
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



function save(){
	//所有数据内容去逗号
    $('#check1 ul li input,#check2 ul li input').each(function(){
        if(!$(this).hasClass('primitive')){
            $(this).val(exchange($(this).val()))
        }
    })
    var data = {};
    $("#submitForm :input").each(function(){
    	if ($(this).attr("name")) {
        	data[$(this).attr("name")] = $(this).val();
    	}
    });
    data.deviationRate = exchange($(".pcl").val().replace("%", ""))
    var _success = false;
	$.ajax({
        url: "${ctx}/wd/application/survey/saveRights",
        async: false,
        cache: false,
        type: "POST",
        data: data,
        dataType: "json",
        success: function (result) {
            if (result.success) {
            	_success = true;
            } else {
                NotifyInCurrentPage("error", result.msg, "错误！");
            }
        }
    });
	$('#check1 ul li input,#check2 ul li input').each(function(){
        if(!$(this).hasClass('primitive')){
            $(this).val(ex_reverse($(this).val()))
        }
    });
	return _success;
}

$(function(){
	init_rights();
})

//合计
function amount(_array){
    var _amount = 0
    $.each(_array,function(i,item){
        _amount += exchange(item)
    })
    return ex_reverse(_amount)
}

//减
function subtract(_amount, _array){
	_amount = exchange(_amount);
    $.each(_array,function(i,item){
        _amount -= exchange(item)
    })
    return ex_reverse(_amount)
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
</script>
</body>
</html>