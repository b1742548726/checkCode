<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<title>闪亮萤</title>

<!-- Bootstrap -->
<link href="${ imgStatic }vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Font Awesome -->
<link href="${ imgStatic }vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />

<!-- Custom Theme Style -->
<link href="${ imgStatic }build/css/custom.css" rel="stylesheet" />

<!-- 重要！样式重写! -->
<link href="${ imgStatic }zwy/css/custom-override.css" rel="stylesheet">

<link href="${ imgStatic }zwy/_resolution/resolution.css"
	rel="stylesheet" />
<link href="${ imgStatic }zwy/_resolution/resolution-print.css"
	rel="stylesheet" type="text/css" media="print" />

</head>
<body>

	<div class="wd-content">

		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<div class="x_title non_bottom_border">
				<h2>决议表打印</h2>
				<!-- <input id="customer-type-id" name="customer-type-id" type="hidden" value="00000000-0000-0000-0000-000000000000" /> -->
				<!-- <input id="customer-type-version" name="customer-type-version" type="hidden" value="" /> -->
				<ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button id="btnWrodExport" class="btn wd-btn-normal wd-btn-gray">导出word</button>
                    </li>
					<li>
						<button id="btnPrint" class="btn wd-btn-normal wd-btn-gray">打印</button>
					</li>
				</ul>
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<div id="resolution">

					<table>
						<colgroup></colgroup>
						<tbody>
							<tr>
								<td colspan="50" class="center bold large height">小微信贷工厂审贷会决议表
								</td>
							</tr>

							<tr>
								<td colspan="6">团队</td>
								<td colspan="11">小微信贷工厂${ resolution.post }</td>
								<td colspan="7">信贷员</td>
								<td colspan="9">${ resolution.loanOfficer }</td>
								<td colspan="6">合同编号</td>
								<td colspan="11">${ resolution.contractNo }</td>
							</tr>
							<tr>
								<td colspan="6">申贷编号</td>
								<td colspan="11">${ resolution.applicationNo }</td>
								<td colspan="7">借款人</td>
								<td colspan="9">${ resolution.borrower }</td>
								<td colspan="6">身份证</td>
								<td colspan="11">${ resolution.borrowerIdCardNo }</td>
							</tr>
							<tr>
								<td colspan="6">贷款种类</td>
								<td colspan="11">${ resolution.product }</td>
								<td colspan="7">申请金额(元)</td>
								<td colspan="9" class="itsMoney">${ resolution.applyAmount }</td>
								<td colspan="6">期限(月)</td>
								<td colspan="11">${ resolution.applyLimit }</td>
							</tr>
							<tr>
								<td colspan="6">信贷员意见</td>
								<td colspan="44">□ 建议放款&nbsp;&nbsp; 金额(元)：<span class="itsMoney">${ resolution.loanOfficerAmount }</span>&nbsp;&nbsp;
									期限(月)：${ resolution.loanOfficerLimit }&nbsp;&nbsp; 年利率：${ resolution.loanOfficerRate }&nbsp;&nbsp;
									还款方式：${ resolution.loanOfficerRepayment }</td>
							</tr>
							<tr>
								<td colspan="6" class="bold">审贷会决议</td>
								<td colspan="44">□ 批准贷款申请无改动&nbsp;&nbsp; □
									批准贷款申请有变更&nbsp;&nbsp; □ 拒绝贷款申请&nbsp;&nbsp; □ 暂时拒绝贷款申请</td>
							</tr>
							<tr>
								<td colspan="6" rowspan="${ approvedInfoRowSpan }" class="bold">批准贷款申请</td>
								<td colspan="7"
									rowspan="${ resolution.getBorrowers().size() == 0 ? 2 : (resolution.getBorrowers().size() + 1) }"
									class="bold">借款人</td>
								<td colspan="10" class="center">姓名</td>
								<td colspan="27" class="center">身份证号码</td>
							</tr>
							<c:if test="${ resolution.getBorrowers().size() == 0 }">
								<tr>
									<td colspan="10"></td>
									<td colspan="27"></td>
								</tr>
							</c:if>
							<c:forEach items="${ resolution.borrowers }" var="borrowerInfo">
								<tr>
									<td colspan="10">${ borrowerInfo.name }</td>
									<td colspan="27">${ borrowerInfo.idCardNo }</td>
								</tr>
							</c:forEach>
							<c:if test="${ resolution.getCoborrowers().size() == 0 }">
								<tr>
									<td colspan="7" class="bold">共同借款人</td>
									<td colspan="10"></td>
									<td colspan="27"></td>
								</tr>
							</c:if>
							<c:if test="${ resolution.getCoborrowers().size() > 0 }">
								<tr>
									<td colspan="7"
										rowspan="${ resolution.getCoborrowers().size() }" class="bold">共同借款人</td>
									<td colspan="10">${ resolution.getCoborrowers().get(0).getName() }</td>
									<td colspan="27">${ resolution.getCoborrowers().get(0).getIdCardNo() }</td>
								</tr>
								<c:forEach items="${ resolution.coborrowers }" begin="1"
									var="coborrower">
									<tr>
										<td colspan="10">${ coborrower.name }</td>
										<td colspan="27">${ coborrower.idCardNo }</td>
									</tr>
								</c:forEach>
							</c:if>

							<c:if test="${ resolution.getRecognizors().size() == 0 }">
								<tr>
									<td colspan="7" class="bold">担保人</td>
									<td colspan="10"></td>
									<td colspan="27"></td>
								</tr>
							</c:if>
							<c:if test="${ resolution.getRecognizors().size() > 0 }">
								<tr>
									<td colspan="7"
										rowspan="${ resolution.getRecognizors().size() }" class="bold">担保人</td>
									<td colspan="10">${ resolution.getRecognizors().get(0).getName() }</td>
									<td colspan="27">${ resolution.getRecognizors().get(0).getIdCardNo() }</td>
								</tr>
								<c:forEach items="${ resolution.recognizors }" begin="1"
									var="recognizor">
									<tr>
										<td colspan="10">${ recognizor.name }</td>
										<td colspan="27">${ recognizor.idCardNo }</td>
									</tr>
								</c:forEach>
							</c:if>

							<tr>
								<td colspan="4"
									rowspan="${ resolution.getMortgages().size() == 0 ? 2 : (resolution.getMortgages().size() + 1) }"
									class="bold">抵押品</td>
								<td colspan="3" class="center">物品</td>
								<td colspan="5" class="center">所有权人</td>
								<td colspan="14" class="center">位置</td>
								<td colspan="9" class="center">估价(元)</td>
								<td colspan="9" class="center">抵押(元)</td>
							</tr>
							<c:if test="${ resolution.getMortgages().size() == 0 }">
								<tr>
									<td colspan="3" class="center"></td>
									<td colspan="5"></td>
									<td colspan="14"></td>
									<td colspan="9"></td>
									<td colspan="9"></td>
								</tr>
							</c:if>
							<c:if test="${ resolution.getMortgages().size() > 0 }">
								<tr>
									<td colspan="3" class="center">${ resolution.getMortgages().get(0).getCategory() }</td>
									<td colspan="5">${ resolution.getMortgages().get(0).getOwner() }</td>
									<td colspan="14">${ resolution.getMortgages().get(0).getAddress() }</td>
									<td colspan="9" class="itsMoney">${ resolution.getMortgages().get(0).getValuation() }</td>
									<td colspan="9" rowspan="${ resolution.getMortgages().size() }" class="itsMoney">${ resolution.finalAmount }</td>
								</tr>
								<c:forEach items="${ resolution.mortgages }" begin="1"
									var="mortgage">
									<tr>
										<td colspan="3" class="center">${ mortgage.category }</td>
										<td colspan="5">${ mortgage.owner }</td>
										<td colspan="14">${ mortgage.address }</td>
										<td colspan="9" class="itsMoney">${ mortgage.valuation }</td>
									</tr>
								</c:forEach>
							</c:if>

							<tr>
								<td colspan="8">批准金额(元)</td>
								<td colspan="14" class="itsMoney">${ resolution.finalAmount }</td>
								<td colspan="8">期限(月)</td>
								<td colspan="14">${ resolution.finalLimit }</td>
							</tr>
							<tr>
								<td colspan="6">年利率</td>
								<td colspan="38">${ resolution.finalRate }</td>
							</tr>
							<tr>
								<td colspan="6">还款方式</td>
								<td colspan="38">${ resolution.finalRepayment }</td>
							</tr>
							<tr>
								<td colspan="6">贷款用途</td>
								<td colspan="38">${ resolution.use }</td>
							</tr>
							<tr>
								<td colspan="6">放款条件</td>
								<td colspan="38">${ resolution.loanCondition }</td>
							</tr>
							<tr>
								<td colspan="6">监控条件</td>
								<td colspan="38">${ resolution.monitoringCondition }</td>
							</tr>
							<tr>
								<td colspan="6">备注</td>
								<td colspan="38">${ resolution.remark }</td>
							</tr>

							<tr>
								<td colspan="8" class="bold">拒绝贷款申请</td>
								<td colspan="6">拒绝原因</td>
								<td colspan="36"></td>
							</tr>
							<tr>
								<td colspan="8" class="bold">其它议题</td>
								<td colspan="42"></td>
							</tr>
							<tr>
								<td colspan="8" class="bold">风险分类</td>
								<td colspan="42">□ 正常&nbsp;&nbsp; □ 关注&nbsp;&nbsp; □
									次级&nbsp;&nbsp; □ 可疑&nbsp;&nbsp; □ 损失&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td colspan="8" class="bold">分类原因</td>
								<td colspan="42"></td>
							</tr>
							<tr>
								<td colspan="8" class="bold">审贷会成员签名</td>
								<td colspan="42">${ resolution.managers }</td>
							</tr>
							<tr>
								<td colspan="8">日期</td>
								<td colspan="42"><fmt:formatDate
										value="${ resolution.approvedDate }"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
							<tr>
								<td colspan="50">注: * 其它待议内容：贷款条件更改，还款计划更改，贷款展期等</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery -->
	<script src="${ imgStatic }vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${ imgStatic }vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- PrintArea -->
	<script src="${ imgStatic }vendors/RitsC-PrintArea-2cc7234/demo/jquery.PrintArea.js"></script>

	<script type="text/javascript">
		$(function() {
			for (var i = 0; i < 50; i++) {
				$("table colgroup").append("<col />");
			}
			
			$(".itsMoney").each(function() {
				var moneyTxt = $(this).html();
				if (!isNaN(moneyTxt)) {
					var money = Number(moneyTxt);
					$(this).html(money.formatMoneyDisplayWithoutSymbol());
				}
			});

			$("#btnPrint").click(function() {
				var options = {
					popTitle : "    "
				};
				$("#resolution").printArea(options);
			});
			
			$("#btnWrodExport").click(function() {
				location.href = "${ctx}/wd/application/detail/resolutionWordExport?applicationId=${applicationId}";
			});
			
		});

		Number.prototype.formatMoneyDisplayWithoutSymbol = function(places, thousand, decimal) {
			places = !isNaN(places = Math.abs(places)) ? places : 2;
			thousand = thousand || ",";
			decimal = decimal || ".";
			var number = this, negative = number < 0 ? "-" : "", i = parseInt(
					number = Math.abs(+number || 0).toFixed(places), 10)
					+ "", j = (j = i.length) > 3 ? j % 3 : 0;
			return negative
					+ (j ? i.substr(0, j) + thousand : "")
					+ i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand)
					+ (places ? decimal
							+ Math.abs(number - i).toFixed(places).slice(2)
							: "");
		};
	</script>
</body>
</html>