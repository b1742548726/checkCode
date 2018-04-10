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

<title></title>

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
						<button id="btnPrint" class="btn wd-btn-normal wd-btn-gray">打印</button>
					</li>
                    <li>
                        <button id="btnWrodExport" class="btn wd-btn-normal wd-btn-gray">导出word</button>
                    </li>
				</ul>
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<div id="resolution">
					<div class="center bold large height">小企业专营中心贷审会决议表</div>
					<div class="col-xs-12">编号：清远农商小企业专营审批【${ resolution.currentYear }】${ resolution.applicationNo }号</div>
					<table>
						<colgroup></colgroup>
						<tbody>
							<tr>
								<td colspan="6">上报单位</td>
								<td colspan="29" class="center">小企业专营中心</td>
								<td colspan="6">客户经理</td>
								<td colspan="9">${ resolution.loanOfficer }</td>
							</tr>
							<tr>
								<td colspan="6">贷款号</td>
								<td colspan="14">${ resolution.applicationNo }</td>
								<td colspan="6">贷款申请人</td>
								<td colspan="9">${ resolution.borrower }</td>
								<td colspan="6">身份证</td>
								<td colspan="9">${ resolution.borrowerIdCardNo }</td>
							</tr>
							<tr>
								<td colspan="6" rowspan="${ customerManagerCommentRowSpan + 7 }" class="bold">客户经理意见</td>
								<td colspan="6">贷款品种</td>
								<td colspan="8">${ resolution.product }</td>
								<td colspan="6">会计科目</td>
								<td colspan="9">${ resolution.accountantSubject }</td>
								<td colspan="6">授信额度/贷款金额</td>
								<td colspan="9" class="itsMoney">${ resolution.applyAmount }</td>
							</tr>
							<tr>
								<td colspan="6">贷款期限</td>
								<td colspan="8">${ resolution.loanOfficerLimit }</td>
								<td colspan="6">年利率/费率</td>
								<td colspan="9">${ resolution.loanOfficerRate }</td>
								<td colspan="6">担保方式</td>
								<td colspan="9">${ resolution.loanOfficerGuaranteeCategory }</td>
							</tr>
							<tr>
								<td colspan="6">担保人姓名</td>
								<td colspan="38">
									<c:forEach items="${ resolution.recognizors }" begin="0" var="recognizor">
										${ recognizor.name }&nbsp;&nbsp;&nbsp;&nbsp;
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td colspan="8" class="center">抵(质)押物名称</td>
								<td colspan="8" class="center">所有权人</td>
								<td colspan="7" class="center">评估机构</td>
								<td colspan="7" class="center">产权证号</td>
								<td colspan="7" class="center">评估价值</td>
								<td colspan="7" class="center">抵(质)押率</td>
							</tr>
							<c:if test="${ resolution.getMortgages().size() == 0 }">
								<tr>
									<td colspan="8"></td>
									<td colspan="8"></td>
									<td colspan="7"></td>
									<td colspan="7"></td>
									<td colspan="7"></td>
									<td colspan="7"></td>
								</tr>
							</c:if>
							<c:if test="${ resolution.getMortgages().size() > 0 }">
								<tr>
									<td colspan="8">${ resolution.getMortgages().get(0).getCategory() }</td>
									<td colspan="8">${ resolution.getMortgages().get(0).getOwner() }</td>
									<td colspan="7">${ resolution.getMortgages().get(0).getAppraisalAgency() }</td>
									<td colspan="7">${ resolution.getMortgages().get(0).getLicense() }</td>
									<td colspan="7">${ resolution.getMortgages().get(0).getValuation() }</td>
									<td colspan="7">${ resolution.getMortgages().get(0).getDiyalv1() } %</td>
								</tr>
								<c:forEach items="${ resolution.mortgages }" begin="1" var="mortgage">
									<tr>
										<td colspan="8">${ mortgage.getCategory() }</td>
										<td colspan="8">${ mortgage.getOwner() }</td>
										<td colspan="7">${ mortgage.getAppraisalAgency() }</td>
										<td colspan="7">${ mortgage.getLicense() }</td>
										<td colspan="7">${ mortgage.getValuation() }</td>
										<td colspan="7">${ mortgage.getDiyalv1() } %</td>
									</tr>
								</c:forEach>
							</c:if>
							<tr>
								<td colspan="6">评估总价</td>
								<td colspan="23" class="itsMoney">${ resolution.totalMortgages }</td>
								<td colspan="6">抵(质)押率</td>
								<td colspan="9">${ resolution.diyalv1 } %</td>
							</tr>
							<tr>
								<td colspan="6">还款方式</td>
								<td colspan="38">${ resolution.loanOfficerRepayment }</td>
							</tr>
							<tr>
								<td colspan="6">贷款用途</td>
								<td colspan="38">${ resolution.use }</td>
							</tr>
							<tr>
								<td colspan="44">客户经理签名：</td>
							</tr>
							
							<tr>
								<td colspan="6" rowspan="4" class="bold">审查意见</td>
								<td colspan="13">提交资料及法律文件是否齐备</td>
								<td colspan="9"> □ 是 &nbsp;&nbsp;&nbsp;□ 否 </td>
								<td colspan="13">借款人主体资格是否合规合法</td>
								<td colspan="9"> □ 是 &nbsp;&nbsp;&nbsp;□ 否 </td>
							</tr>
							<tr>
								<td colspan="13">调查人员调查工作是否合规</td>
								<td colspan="9"> □ 是 &nbsp;&nbsp;&nbsp;□ 否 </td>
								<td colspan="13">客户经理在调查中有无执行交叉检验</td>
								<td colspan="9"> □ 是 &nbsp;&nbsp;&nbsp;□ 否 </td>
							</tr>
							<tr>
								<td colspan="13">还款来源是否可靠</td>
								<td colspan="9"> □ 是 &nbsp;&nbsp;&nbsp;□ 否 </td>
								<td colspan="13">本授信业务发展前景、综合效益是否可行</td>
								<td colspan="9"> □ 是 &nbsp;&nbsp;&nbsp;□ 否 </td>
							</tr>
							<tr>
								<td colspan="44">
									${ resolution.zhiliaoComment }
									<br />
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									审查人：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									日期：&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;月&nbsp;&nbsp;日
								</td>
							</tr>
							<tr>
								<td colspan="50">
									<span class="bold">审贷会决议：</span>
									□ 批准贷款申请无改动 &nbsp;&nbsp;&nbsp;&nbsp;
									□ 批准贷款申请有变更 &nbsp;&nbsp;&nbsp;&nbsp;
									□ 拒绝贷款申请 &nbsp;&nbsp;&nbsp;&nbsp;
									□ 缓议 &nbsp;&nbsp;&nbsp;&nbsp;
									□ 其他待议内容
								</td>
							</tr>
							<tr>
								<td colspan="6" rowspan="${ approvedInfoRowSpan + 6 }" class="bold">批准贷款申请</td>
								<td colspan="7" rowspan="${ resolution.getBorrowers().size() == 0 ? 2 : (resolution.getBorrowers().size() + 1) }"
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
									<td colspan="7" rowspan="${ resolution.getCoborrowers().size() }" class="bold">共同借款人</td>
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
								<td colspan="8" class="center">抵(质)押物名称</td>
								<td colspan="8" class="center">所有权人</td>
								<td colspan="7" class="center">评估机构</td>
								<td colspan="7" class="center">产权证号</td>
								<td colspan="7" class="center">评估价值</td>
								<td colspan="7" class="center">抵(质)押率</td>
							</tr>
							<c:if test="${ resolution.getMortgages().size() == 0 }">
								<tr>
									<td colspan="8"></td>
									<td colspan="8"></td>
									<td colspan="7"></td>
									<td colspan="7"></td>
									<td colspan="7"></td>
									<td colspan="7"></td>
								</tr>
							</c:if>
							<c:if test="${ resolution.getMortgages().size() > 0 }">
								<tr>
									<td colspan="8">${ resolution.getMortgages().get(0).getCategory() }</td>
									<td colspan="8">${ resolution.getMortgages().get(0).getOwner() }</td>
									<td colspan="7">${ resolution.getMortgages().get(0).getAppraisalAgency() }</td>
									<td colspan="7">${ resolution.getMortgages().get(0).getLicense() }</td>
									<td colspan="7">${ resolution.getMortgages().get(0).getValuation() }</td>
									<td colspan="7">${ resolution.getMortgages().get(0).getDiyalv2() } %</td>
								</tr>
								<c:forEach items="${ resolution.mortgages }" begin="1" var="mortgage">
									<tr>
										<td colspan="8">${ mortgage.getCategory() }</td>
										<td colspan="8">${ mortgage.getOwner() }</td>
										<td colspan="7">${ mortgage.getAppraisalAgency() }</td>
										<td colspan="7">${ mortgage.getLicense() }</td>
										<td colspan="7">${ mortgage.getValuation() }</td>
										<td colspan="7">${ mortgage.getDiyalv2() } %</td>
									</tr>
								</c:forEach>
							</c:if>
							<tr>
								<td colspan="6">评估总价</td>
								<td colspan="23" class="itsMoney">${ resolution.totalMortgages }</td>
								<td colspan="6">抵(质)押率</td>
								<td colspan="9">${ resolution.diyalv2 } %</td>
							</tr>
							<tr>
								<td colspan="6">批准金额(元)：</td>
								<td colspan="9">
									<span class="itsMoney">${ resolution.finalAmount }</span>
								</td>
								<td colspan="6">期限(月)</td>
								<td colspan="8">${ resolution.finalLimit }</td>
								<td colspan="6">利率(年)</td>
								<td colspan="9">${ resolution.finalRate }</td>
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
								<td colspan="6">放款前提条件</td>
								<td colspan="38">${ resolution.loanCondition }</td>
							</tr>
							<tr>
								<td colspan="6">贷后监控措施</td>
								<td colspan="38">${ resolution.monitoringCondition }</td>
							</tr>

							<tr>
								<td colspan="6" class="bold">拒绝贷款申请</td>
								<td colspan="6">拒绝原因</td>
								<td colspan="38"></td>
							</tr>
							<tr>
								<td colspan="6" class="bold">其它</td>
								<td colspan="44"></td>
							</tr>
							<tr>
								<td colspan="6" class="bold">审贷会成员签名</td>
								<td colspan="44">
									<br />
									<br />
									<br />
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									日期：&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;月&nbsp;&nbsp;日
								</td>
							</tr>
							<tr>
								<td colspan="6" class="bold">中心盖章确认</td>
								<td colspan="44">
									<br />
									<br />
									<br />
									<br />
								</td>
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
	<script
		src="${ imgStatic }vendors/RitsC-PrintArea-2cc7234/demo/jquery.PrintArea.js"></script>

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
					popTitle : "&emsp;&emsp;"
				};
				$("#resolution").printArea(options);
			});
			
			$("#btnWrodExport").click(function() {
				location.href = "${ctx}/wd/application/print/resolutionQingyuanWordExport?applicationId=${applicationId}";
			});
		});

		Number.prototype.formatMoneyDisplayWithoutSymbol = function(places,
				thousand, decimal) {
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