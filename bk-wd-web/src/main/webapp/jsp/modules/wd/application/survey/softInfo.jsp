<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>软信息不对称偏差</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/soft_info.css" rel="stylesheet">
</head>

<body>
    <div class="wd-content">
        <div class="left_info">
            <div class="tab">
                <ul>
                    <li><a href="${ctx}/wd/application/survey/applicantInfo?applicationId=${wdApplication.id}">申请人信息</a></li>
                    <li class="cur"><a href="javascript:void(0)">软信息不对称偏差</a></li>
                    <li><a href="${ctx}/wd/application/survey/implExcel?applicationId=${wdApplication.id}">导入Excel数据</a></li>
                    <li><a href="${ctx}/wd/application/survey/assets?applicationId=${wdApplication.id}">资产负债表</a></li>
                    <li><a href="${ctx}/wd/application/survey/rights?applicationId=${wdApplication.id}">权益检查</a></li>
                </ul>
            </div>
            <div class="btn4" id="close_applicant">保存退出</div>
            <div class="btn3" id="submit_applicant">提交审核</div>

            <div class="tab_content">
                
                <div class="shop_info">
                    <div class="tb_wrap">
                        <table class="style2" style="position: relative;">
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
                                	<td colspan="7"><textarea id="rationalExplanation" cols="30" rows="10">${applicationInfoDeviationAnalysis.rationalExplanation }</textarea></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="soft_info">
                    <ul class="si_list">
                        <li>
                            <label>私人财产类型</label>
                            <div class="label_content">
                                <ul class="checkbox" id="privatePropertyType">
                                    <li data-content="别墅">别墅</li>
                                    <li data-content="商品房">商品房</li>
                                    <li data-content="宅基地">宅基地</li>
                                    <li data-content="汽车">汽车</li>
                                    <li data-content="其他">其他</li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <label>客户信息收集与核实</label>
                            <div class="label_content">
                                <ul class="checkbox" id="collectionVerification">
                                    <li data-content="营业执照">营业执照</li>
                                    <li data-content="房产证">房产证</li>
                                    <li data-content="租赁合同">租赁合同</li>
                                    <li data-content="账单">账单</li>
                                    <li data-content="存货清单">存货清单</li>
                                    <li data-content="银行存款账户">银行存款账户</li>
                                    <li data-content="现金">现金</li>
                                    <li data-content="供销及采购合同">供销及采购合同</li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <label>借款人履历，附带其资本累计</label>
                            <div class="label_content">
                                <textarea id="customerRecord" cols="30" rows="10">${applicationInfoDeviationAnalysis.customerRecord }</textarea>
                            </div>
                        </li>
                        <li>
                            <label>对现状的评价：经营组织，市场及财务情况</label>
                            <div class="label_content">
                                <textarea id="actualityAssessment" cols="30" rows="10">${applicationInfoDeviationAnalysis.actualityAssessment }</textarea>
                            </div>
                        </li>
                        <li>
                            <label>事业情况</label>
                            <div class="label_content">
                                <select id="careerSituation">
                                    <option value="">请选择</option>
                                    <option value="自有资源自主经营的个体户，当地颇有影响的大户，私营企业，公务员，老师">自有资源自主经营的个体户，当地颇有影响的大户，私营企业，公务员，老师</option>
                                    <option value="事业稳定收入较高，个体户，私营企业">事业稳定收入较高，个体户，私营企业</option>
                                    <option value="稳定的企业员工，一般性经营者">稳定的企业员工，一般性经营者</option>
                                    <option value="一般企业员工、工地做工">一般企业员工、工地做工</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <label>申请贷款的原因</label>
                            <div class="label_content">
                                <textarea id="loanReason" cols="30" rows="10">${applicationInfoDeviationAnalysis.loanReason }</textarea>
                            </div>
                        </li>
                        <li>
                            <label>客户在家庭或在社会经济网中的状况</label>
                            <div class="label_content">
                                <textarea id="customerSituation" cols="30" rows="10">${applicationInfoDeviationAnalysis.customerSituation }</textarea>
                            </div>
                        </li>
                        <li>
                            <label>主要供应商</label>
                            <div class="label_content">
                                <table class="supplier">
                                    <thead>
                                        <tr>
                                            <th>主要供应商</th>
                                            <th>采购比例 (%)</th>
                                            <th>付款条件</th>
                                            <th>往来时间</th>
                                            <th class="add"><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt=""></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${applicationInfoDeviationAnalysis.getMainVendorJson() }" var="mainVendor">
                                             <tr>
                                                <td><input type="text" value="${mainVendor.supplier}"></td>
                                                <td><input type="text" value="${mainVendor.Proportion}"></td>
                                                <td><input type="text" value="${mainVendor.Condition}"></td>
                                                <td><input type="text" value="${mainVendor.time}"></td>
                                                <td><button class="color3">删除</button></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </li>
                        <li>
                            <label>主要客户</label>
                            <div class="label_content">
                                <table class="client">
                                    <thead>
                                        <tr>
                                            <th>主要客户</th>
                                            <th>销售比例 (%)</th>
                                            <th>付款条件</th>
                                            <th>往来时间</th>
                                            <th class="add"><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt=""></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${applicationInfoDeviationAnalysis.getMainCustomerJson() }" var="mainCustomer">
                                            <tr>
                                                <td><input type="text" value="${mainCustomer.client}"></td>
                                                <td><input type="text" value="${mainCustomer.Proportion}"></td>
                                                <td><input type="text" value="${mainCustomer.Condition}"></td>
                                                <td><input type="text" value="${mainCustomer.time}"></td>
                                                <td><button class="color3">删除</button></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </li>
                    </ul>
                </div>

            </div>
        </div>
    </div>
    <div style="display: none;">
        <table>
        <tr id="addTd">
            <td><input type="text" value="黄新国"></td>
            <td><input type="text" value="否"></td>
            <td><input type="text" value="客户为人还不错"></td>
            <td><input type="text" value="在本市买房了，小孩也在本市读书"></td>
            <td><button class="color3">删除</button></td>
        </tr>
        </table>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
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

$(function(){
	if ('${fns:toJsonString(softInfoSheet)}') {
		var softInfoSheet = JSON.parse('${fns:toJsonString(softInfoSheet)}');
		init_softInfo(softInfoSheet);
	} else {
		init_softInfo();
	}

	//数据初始化	
	var privatePropertyType = ${fns:toJsonString(applicationInfoDeviationAnalysis.getPrivatePropertyTypeJson())};
    if (privatePropertyType) {
    	for (var i = 0; i < privatePropertyType.length; i++) {
    		$("#privatePropertyType li[data-content=" +privatePropertyType[i] + "]").addClass("cur");
    	}
    }
    var collectionVerification = ${fns:toJsonString(applicationInfoDeviationAnalysis.getCollectionVerificationJson())};
    if (collectionVerification) {
    	for (var i = 0; i < collectionVerification.length; i++) {
    		$("#collectionVerification li[data-content=" +collectionVerification[i] + "]").addClass("cur");
    	}
    }
    
    $("#careerSituation").val("${applicationInfoDeviationAnalysis.careerSituation}");
	
	$('.checkbox').on('click','li',function(){
        if($(this).hasClass('cur')){
            $(this).removeClass('cur')
        }else{
            $(this).addClass('cur')
        }
    });
	
    $('.color3').on('click',function(){
        $(this).closest('tr').remove()
    })
    
    $('.add').on('click',function(){
        var _html = $("#addTd").clone(true);
        _html.find('input').val('')
        $(this).closest('table').children('tbody').append(_html)
    })
  
})

//数据保存
function save() {
	var supplier,client
	var analysisData = {}; //数据分析
	
    var obj = $('.supplier').find('tbody').children('tr')
    supplier = []
    obj.each(function(){
        supplier.push({
            supplier : $(this).children('td').eq(0).find("input").val(),
            Proportion : $(this).children('td').eq(1).find("input").val(),
            Condition : $(this).children('td').eq(2).find("input").val(),
            time : $(this).children('td').eq(3).find("input").val(),
        })
    })
    analysisData.mainVendor = JSON.stringify(supplier)
    
    client = []
    obj = $('.client').find('tbody').children('tr')
    obj.each(function(){
        client.push({
            client : $(this).children('td').eq(0).find("input").val(),
            Proportion : $(this).children('td').eq(1).find("input").val(),
            Condition : $(this).children('td').eq(2).find("input").val(),
            time : $(this).children('td').eq(3).find("input").val(),
        })
    })
    analysisData.mainCustomer = JSON.stringify(client)

    
    analysisData.id = "${applicationInfoDeviationAnalysis.id}";
    analysisData.applicationId = "${wdApplication.id}";
	
    analysisData.rationalExplanation = $("#rationalExplanation").val();
    analysisData.customerRecord = $("#customerRecord").val();
    analysisData.actualityAssessment = $("#actualityAssessment").val();
    analysisData.careerSituation = $("#careerSituation").val();
    analysisData.loanReason = $("#loanReason").val();
    analysisData.customerSituation = $("#customerSituation").val();
	var privatePropertyType = [];
	$("#privatePropertyType li.cur").each(function(index, dom){
		privatePropertyType.push($(dom).text());
	});
	analysisData.privatePropertyType = JSON.stringify(privatePropertyType);
	var collectionVerification = [];
	$("#collectionVerification li.cur").each(function(index, dom){
		collectionVerification.push($(dom).text());
	});
	analysisData.collectionVerification = JSON.stringify(collectionVerification);
	
	var _success = false;
	$.ajax({
        url: "${ctx}/wd/application/survey/saveSoftInfo",
        async: false,
        cache: false,
        type: "POST",
        data: analysisData,
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
</script>
</body>
</html>