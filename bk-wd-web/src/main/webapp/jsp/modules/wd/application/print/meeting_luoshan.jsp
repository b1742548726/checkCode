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
				<h2>会议记录打印</h2>
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
				<div id="resolution" style="margin:10px 60px; line-height:30px; font-size:18px;">
					<div class="center bold" style="font-size:24px; margin-bottom:40px;">会议记录</div>
					<div class="">会议时间：<u>&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; </u></div>
					<div class="">会议地点：<u>&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; </u></div>
					<div class="">贷审会成员：<u> &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; </u></div>
					<div class="">客户经理：${ meeting.loanOfficer }
						&emsp;&emsp;记录人：<u>&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &ensp;</u></div>
					<div class="">会议内容：<u>&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; </u></div>
					<br />
					<p>
						&emsp;&emsp; 
						${ meeting.borrower.name }， 
						${ meeting.borrower.gender }，
						现年${ meeting.borrower.age }岁，
						<c:if test="${ not empty meeting.borrower.marriage }">
							${ meeting.borrower.marriage }， 
						</c:if>
						居住于
						<c:choose>
							<c:when test="${ not empty meeting.borrower.address }">
								${ meeting.borrower.address }，
							</c:when>
							<c:otherwise>
								<u>&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; </u>
							</c:otherwise>
						</c:choose>
						目前
						<c:if test="${ not empty meeting.borrower.shopAddr }">
							在 ${ meeting.borrower.shopAddr }
						</c:if>
						<c:if test="${ not empty meeting.borrower.shopName }">
							经营 ${ meeting.borrower.shopName }，
						</c:if>
						<c:if test="${ not empty meeting.borrower.companyName }">
							供职于 ${ meeting.borrower.companyName }，
						</c:if>
						身份证号 ${ meeting.borrower.idCardNo } ， 家庭人口
						<c:choose>
							<c:when test="${ not empty meeting.familyNum }">
								${ meeting.familyNum }
							</c:when>
							<c:otherwise>
								<u>&emsp; &emsp; </u>
							</c:otherwise>
						</c:choose>
						人， 供养人口
						<c:choose>
							<c:when test="${ not empty meeting.fosterNum }">
							 ${ meeting.fosterNum }
							</c:when>
							<c:otherwise>
								<u>&emsp; &emsp; </u>
							</c:otherwise>
						</c:choose>
						人。
						
						<c:if test="${ not empty meeting.spouse }">
						配偶 ${ meeting.spouse.name } ，身份证号 ${ meeting.spouse.idCardNo } 。
						</c:if>
						家庭年收入 <u> &emsp; &emsp; &emsp; &emsp; </u> 元。
						申请贷款 <span class="itsMoney">${ meeting.applyAmount }</span> 元，
						期限 ${ meeting.applyLimit } 个月，
						月利率 ${ meeting.applyRate }，
						${ meeting.applyRepayment }，
						用于 ${ meeting.use }。
					</p>

					<c:forEach items="${meeting.recognizors}" var="recognizor">
						<p>
							&emsp;&emsp;担保人 ${ recognizor.name }，
							${ recognizor.gender }，
							<c:if test="${ not empty recognizor.marriage }">
								${ recognizor.marriage }， 
							</c:if>
							身份证号 ${ recognizor.idCardNo } ，
							居住于
							<c:choose>
								<c:when test="${ not empty recognizor.address }">
									${ recognizor.address }
								</c:when>
								<c:otherwise>
									<u>&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; </u>
								</c:otherwise>
							</c:choose>
							，
							目前
							<c:if test="${ not empty recognizor.shopAddr }">
								在 ${ recognizor.shopAddr }
							</c:if>
							<c:if test="${ not empty recognizor.shopName }">
								经营 ${ recognizor.shopName }。
							</c:if>
							<c:if test="${ not empty recognizor.companyName }">
								供职于 ${ recognizor.companyName }。
							</c:if>
							家庭年收入 <u> &emsp; &emsp; &emsp; &emsp; </u> 元。
						</p>
					</c:forEach>
					<p>
						&emsp;&emsp;结论：客户身份信息真实有效，借款用途护额国家规定，资质良好，<u>&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; </u> 。
					</p>
					<br /> <br />
					<p>与会人员签名：</p>
					<br /> <br />
					<p>贷审会组长签名：</p>
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
				var moneyTxt=$(this).html(); if (!isNaN(moneyTxt)) {
					var money=Number(moneyTxt);
					$(this).html(money.formatMoneyDisplayWithoutSymbol());
				}
			});

			$("#btnPrint").click(function() {
				var options={
					popTitle : "&emsp;&emsp;"
				};
				$("#resolution").printArea(options);
			});

			$("#btnWrodExport").click(function() {
				location.href="${ctx}/wd/application/print/meetingLuoshanExport?applicationId=${applicationId}";
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