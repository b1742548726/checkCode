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
				<h2>审查报告打印</h2>
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
				<div id="resolution" style="margin:8px 32px; font-size:14px;">
					<div class="center bold large height">罗山农商银行小微贷中心贷款审查报告</div>
					<div  style="line-height:32px; font-size:16px;">一、借款人基本信息</div>
					<table>
						<colgroup></colgroup>
						<tbody>
							<tr>
								<td colspan="6">姓名</td>
								<td colspan="11">${reviewReport.borrower.name}</td>
								<td colspan="6">性别</td>
								<td colspan="10">${reviewReport.borrower.gender}</td>
								<td colspan="6">年龄</td>
								<td colspan="11">${reviewReport.borrower.age}</td>
							</tr>
							<tr>
								<td colspan="6">婚姻状况</td>
								<td colspan="11">${reviewReport.borrower.marriage}</td>
								<td colspan="6">户籍</td>
								<td colspan="10">${reviewReport.borrower.census}</td>
								<td colspan="6"></td>
								<td colspan="11"></td>
							</tr>
							<tr>
								<td colspan="6">身份证号</td>
								<td colspan="44">${reviewReport.borrower.idCardNo}</td>
							</tr>
							<tr>
								<td colspan="6">申请金额</td>
								<td colspan="27">
									<span class="itsMoney">${reviewReport.applyAmount}</span>
								</td>
								<td colspan="6">贷款期限</td>
								<td colspan="11">${reviewReport.applyLimit}</td>
							</tr>
							<tr>
								<td colspan="6">月利率</td>
								<td colspan="11">${reviewReport.applyRate}</td>
								<td colspan="6">担保方式</td>
								<td colspan="10">${reviewReport.guaranteeMode}</td>
								<td colspan="6">还款方式</td>
								<td colspan="11">${reviewReport.applyRepayment}</td>
							</tr>
							<tr>
								<td colspan="6">贷款用途</td>
								<td colspan="44">${reviewReport.use}</td>
							</tr>
						</tbody>
					</table>
					<br />
					
					<div style="line-height:32px; font-size:16px;">二、担保人基本信息</div>

					<c:forEach items="${reviewReport.recognizors}" var="recognizor">
						<table>
							<colgroup></colgroup>
							<tbody>
								<tr>
									<td colspan="6">姓名</td>
									<td colspan="11">${ recognizor.name }</td>
									<td colspan="6">性别</td>
									<td colspan="10">${ recognizor.gender }</td>
									<td colspan="6">年龄</td>
									<td colspan="11">${ recognizor.age }</td>
								</tr>
								<tr>
									<td colspan="6">婚姻状况</td>
									<td colspan="11">${ recognizor.marriage }</td>
									<td colspan="6">户籍</td>
									<td colspan="10">${ recognizor.census }</td>
									<td colspan="6">职务</td>
									<td colspan="11">${ recognizor.post }</td>
								</tr>
								<tr>
									<td colspan="6">身份证号</td>
									<td colspan="44">${ recognizor.idCardNo }</td>
								</tr>
								<tr>
									<td colspan="6">家庭住址</td>
									<td colspan="44">${ recognizor.address }</td>
								</tr>
							</tbody>
						</table>
						<br />
					</c:forEach>
					
					<div style="line-height:32px; font-size:16px;">三、风险提示</div>
					<p style="font-size:16px;">&emsp;&emsp;基本资料审查：借款人及财产共有人资料信息齐全，信贷业务内部运作资料齐全，符合信贷条件。</p>
					<br /> <br />
					<p style="font-size:16px;">&emsp;&emsp;主体资格审查：借款人及财产共有人主题资格已核实，生意权属已核实，证明材料合法、真实、有效，且无不良记录，具备借款资格。</p>
					<br /> <br />
					<p style="font-size:16px;">&emsp;&emsp;借款政策审查：借款人申请借款用途符合国家金融政策和农商行的信贷政策。</p>
					<br /> <br />
					<p style="font-size:16px;">&emsp;&emsp;信贷风险审查：借款人又较好的经济收入来源，到期偿还贷款有保障，信贷风险较低，但姚做好贷后跟踪调查。</p>
					<br /> <br /> <br />
					
					<div  style="line-height:32px; font-size:16px;">四、审查结论</div>
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
				location.href = "${ctx}/wd/application/print/review_report_excel_export?applicationId=${applicationId}";
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