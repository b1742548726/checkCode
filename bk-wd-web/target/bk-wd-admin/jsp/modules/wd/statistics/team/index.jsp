<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>团队统计</title>
<!--统一样式，不删-->
<link href="${ imgStatic }vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${ imgStatic }vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="${ imgStatic }build/css/custom.css" rel="stylesheet">
<!-- Datatables -->
<link
	href="${ imgStatic }vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${ imgStatic }vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${ imgStatic }vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${ imgStatic }vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${ imgStatic }vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"
	rel="stylesheet">

<!-- 重要！样式重写! -->
<link href="${ imgStatic }zwy/css/custom-override.css" rel="stylesheet" />

<link href="${ imgStatic }zwy/LBQ/css/statistical.css" rel="stylesheet">
<style type="text/css">
div#export_target_table_wrapper div.dt-buttons.btn-group a {
	color: #334421;
}
</style>
</head>

<body>
	<div class="wd-content">
		<div class="organization">
			<h2>
				团队统计 <select id="dateType" class="select_time">
					<option selected="selected" value="1">今天</option>
					<option value="2">近7天</option>
					<option value="3">近6周</option>
					<option value="4">近6个月</option>
					<option value="5">近12个月</option>
				</select>
			</h2>
			<div class="left_wrap">
				<div class="organ_list">
					<c:forEach items="${officeList }" var="office">
						<h3 class="root cur" data-id="${office.id }" >
							<span>${office.name }</span>
						</h3>
						<ul>
							<c:if test="${not empty office.childList}">
								<sys:officeUser dataList="${office.childList }" />
							</c:if>
						</ul>
					</c:forEach>
				</div>

				<div class="clearfix"></div>
			</div>

			<div class="right_wrap" id="teamCharts">
			</div>
			<div class="clearfix"></div>
		</div>
	</div>

	<!-- 统一js，不删 -->
	<script src="${ imgStatic }vendors/jquery/dist/jquery.min.js"></script>
	<script src="${ imgStatic }vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="${ imgStatic }vendors/layer/layer.js"></script>
	<script src="${ imgStatic }zwy/js/layer-customer.js"></script>
	<script src="${ imgStatic }build/js/custom.js"></script>
	<!-- Datatables -->
	<script
		src="${ imgStatic }vendors/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
	<script
		src="${ imgStatic }vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
	<script src="${ imgStatic }vendors/jszip/dist/jszip.min.js"></script>
	<script src="${ imgStatic }vendors/pdfmake/build/pdfmake.min.js"></script>
	<script src="${ imgStatic }vendors/pdfmake/build/vfs_fonts.js"></script>

	<script src="${ imgStatic }vendors/echarts-3.5.4/echarts.min.js"></script>

	<script>
		function freshChartsAndTables() {
			var _dateType = $("#dateType").val();
			var _officeId = $(".organ_list .cur").data("id");
			var _type =  $(".organ_list .cur").data("type");
			
			var _url = "${ctx}/wd/statistics/team_charts";
			var _data = {dateType : _dateType, officeId : _officeId };
			if ("user" == _type) {
				_url = "${ctx}/wd/statistics/team_user_detail";
				_data.userId =  $(".organ_list .cur").data("id");
			}
			
			StartLoad();
			$.get(_url, _data, function(data){
				$("#teamCharts").empty().html(data);
				FinishLoad();
			})
			
		}

		$(function() {
    		freshChartsAndTables();
    		
			$('.select_item').on('click', 'li', function() {
				var num = 0
				$('.select_item li').each(function() {
					if ($(this).hasClass('cur'))
						num++
				})
				if ($(this).hasClass('cur')) {
					if (num > 1) {
						$(this).removeClass('cur')
					} else {
						alert('至少选择一列进行统计')
					}
				} else {
					$(this).addClass('cur')
				}
			})

			$('#dateType').change(function() {
				if ($(this).val() == '自定义') {
					alert('调用时间控件')
				}
				freshChartsAndTables();
			})

			var Module = {
				init : function() {
					$('.organ_list ul').each(function() {
						if ($(this).parent().hasClass('plus')) {
							$(this).hide()
						}
					})
					this.click();
					this.selected();
				},

				click : function() {
					$('.organ_list').off().on('click', 'ul li', function(e) {
						e.stopPropagation();
						if ($(this).hasClass('reduce')) {
							$(this).children('ul').hide(50)
							$(this).removeClass('reduce').addClass('plus')
						} else if ($(this).hasClass('plus')) {
							$(this).children('ul').show(50)
							$(this).removeClass('plus').addClass('reduce')
						}
					})
				},
				selected : function() {
					$('.organ_list').on('click', 'ul li p', function(e) {
						e.stopPropagation();
						$('.organ_list li p,.root').removeClass('cur')
						$(this).addClass('cur')
						freshChartsAndTables();
					})
					$('.root').on('click', function(e) {
						e.stopPropagation();
						$('.organ_list li p').removeClass('cur')
						$(this).addClass('cur')
						freshChartsAndTables();
					})
				},

			}
			Module.init();
			
			//added by jyshen
			if ($(".left_wrap").height() > $(".organization").height()) {
			 	$(".organization").css("height", ($(".left_wrap").height() +100) + "px");
			}
			//end jyshen
		})
	</script>
</body>
</html>