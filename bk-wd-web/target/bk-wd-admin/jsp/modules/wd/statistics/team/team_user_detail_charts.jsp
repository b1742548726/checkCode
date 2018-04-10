<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<div class="shop_info">
	<div class="title">${ dateString }</div>
	<div class="content" style="min-height: 400px" id="div_charts"></div>
</div>

<div class="shop_info">
	<table id="export_target_table">
		<thead>
			<tr>
				<th class="">日期</th>
				<th class="">授信金额(万)</th>
				<th class="">扫街笔数</th>
				<th class="">申请笔数</th>
                <th class="">提交审核笔数</th>
                <th class="">审核通过笔数</th>
				<th class="">放款笔数</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${ data }" var="item">
				<tr>
					<td>${ item.get("date") }</td>
					<td>${ item.get("amount") }</td>
					<td>${ item.get("visit") }</td>
					<td>${ item.get("intention") }</td>
                    <td>${ item.get("submit") }</td>
					<td>${ item.get("passing") }</td>
					<td>${ item.get("loan") }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script type="text/javascript">
	(function(){
		function init_MyDataTables() {
		    if (typeof ($.fn.DataTable) === 'undefined') { return; }
	
		    var handleDataTableButtons = function () {
		        if ($("#export_target_table").length) {
		            $("#export_target_table").DataTable({
		                dom: "Bfrtip",
		                buttons: [
		                  {
		                      extend: "csv",
		                      text: "导出"
		                  },
		                ],
						scrollY: 580,
						scrollCollapse: true,
						scroller: true
		            });
		        }
		    };
	
		    TableManageButtons = function () {
		        "use strict";
		        return {
		            init: function () {
		                handleDataTableButtons();
		            }
		        };
		    }();
	
		    TableManageButtons.init();
		}
	})();

	(function(){
		var myChartLine = echarts.init(document.getElementById('div_charts'));

		var optionLine = {
			title : {
				text : ''
			},
			tooltip : {
				trigger : 'axis'
			},
			color : [ '#7CCD7C', '#D15FEE', '#EE0000', '#0000FF', '#FF34B3', '#FFD700', '#00BFFF', '#20B2AA' ],
			legend : {
				data : [ '授信金额', '扫街笔数', '申请笔数', '提交审核笔数', '审核通过笔数', '最终批核数' ],
			},
			toolbox : {
				show : true,
				feature : {
					saveAsImage : {
						show : true
					}
				}
			},
			xAxis : {
				type : 'category',
				boundaryGap : false,
				data : [
					<c:forEach items="${ data }" var="item">
						'${ item.get("date") }',
					</c:forEach>
				]
			},
			yAxis : [ {
				name : '授信金额（万）',
				type : 'value',
				//max: 1000
			}, {
				name : '笔数',
				type : 'value',
				splitLine : {
					show : false,
				},
				//max: 100
			} ],
			series : [{
						name : '授信金额',
						type : 'line',
						smooth : true,
						areaStyle : {
							normal : {}
						},
						data : [
							<c:forEach items="${ data }" var="item">
								'${ item.get("amount") }',
							</c:forEach>
						]
					}, {
						name : '扫街笔数',
						type : 'line',
						smooth : true,
						yAxisIndex : 1,
						data : [
							<c:forEach items="${ data }" var="item">
								'${ item.get("visit") }',
							</c:forEach>
						]
					}, {
						name : '申请笔数',
						type : 'line',
						smooth : true,
						yAxisIndex : 1,
						data : [
							<c:forEach items="${ data }" var="item">
								'${ item.get("intention") }',
							</c:forEach>
						]
					}, {
						name : '提交审核笔数',
						type : 'line',
						smooth : true,
						yAxisIndex : 1,
						data : [
							<c:forEach items="${ data }" var="item">
								'${ item.get("submit") }',
							</c:forEach>
						]
					}, {
						name : '审核通过笔数',
						type : 'line',
						smooth : true,
						yAxisIndex : 1,
						data : [
							<c:forEach items="${ data }" var="item">
								'${ item.get("passing") }',
							</c:forEach>
						]
					}, {
						name : '最终批核数',
						type : 'line',
						smooth : true,
						yAxisIndex : 1,
						data : [
							<c:forEach items="${ data }" var="item">
								'${ item.get("loan") }',
							</c:forEach>
						]
					}]
		};

		myChartLine.setOption(optionLine);
	})();
</script>
