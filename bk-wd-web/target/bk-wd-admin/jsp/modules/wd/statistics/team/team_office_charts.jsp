<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="shop_info">
    <div class="content col-xs-12" style="min-height: 400px" id="div_charts_1"></div>
    <div class="content col-xs-12" style="min-height: 400px" id="div_charts_2"></div>
</div>
<div class="shop_info">
    <table id="export_target_table">
        <thead>
            <tr>
                <th class="">团队</th>
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
                    <td>${ item.get("officeName") }</td>
                    <td style="${ item.get("amount") lt avgAmount ? 'color:red' : '' }">${ item.get("amount") }</td>
                    <td style="${ item.get("visit") lt avgVisit ? 'color:red' : '' }">${ item.get("visit") }</td>
                    <td style="${ item.get("intention") lt avgIntention ? 'color:red' : '' }">${ item.get("intention") }</td>
                    <td style="${ item.get("submit") lt avgSubmit ? 'color:red' : '' }">${ item.get("submit") }</td>
                    <td style="${ item.get("passing") lt avgPassing ? 'color:red' : '' }">${ item.get("passing") }</td>
                    <td style="${ item.get("loan") lt avgLoan ? 'color:red' : '' }">${ item.get("loan") }</td>
                </tr>
            </c:forEach>

        </tbody>

        <tfoot>
            <tr style="background-color:#929089">
                <td style="color:#f2f4f8">平均值</td>
                <td style="color:#f2f4f8">${ avgAmount }</td>
                <td style="color:#f2f4f8">${ avgVisit }</td>
                <td style="color:#f2f4f8">${ avgIntention }</td>
                <td style="color:#f2f4f8">${ avgSubmit }</td>
                <td style="color:#f2f4f8">${ avgPassing }</td>
                <td style="color:#f2f4f8">${ avgLoan }</td>
            </tr>
            <tr class="last">
                <td>总计</td>
                <td>${ totalAmount }</td>
                <td>${ totalVisit }</td>
                <td>${ totalIntention }</td>
                <td>${ totalSubmit }</td>
                <td>${ totalPassing }</td>
                <td>${ totalLoan }</td>
            </tr>
        </tfoot>
    </table>
</div>
<script type="text/javascript">
   //图表初始化
	(function() {
        var myChartPillar = echarts.init(document.getElementById('div_charts_1'));
        var myChartPie = echarts.init(document.getElementById('div_charts_2'));
        var optionPie = {
                title: {
                    text: ''
                },
                tooltip: {
                    show: true
                },
                toolbox: {
                    show: true,
                    feature: {
                        //magicType: { show: true, type: ['stack', 'tiled'] },
                        saveAsImage: { show: true }
                    }
                },
                series: [
                    {
                        name: '授信金额(万)',
                        type: 'pie',
                        radius: '80%',
                        //roseType: 'angle',
                        data: [
    					<c:forEach items="${ data }" var="item">
    						{ value: '${ item.get("amount") }', name: '${ item.get("officeName") }', label: { normal: { show: true, formatter: '{b} {d}%' } } },
    					</c:forEach>
                        ]
                    }
                ]
            };
    	var optionPillar = {
        	    title: {
        	        text: ''
        	    },
                tooltip: {
                    show: true
                },
                toolbox: {
                    show: true,
                    feature: {
                        //magicType: { show: true, type: ['stack', 'tiled'] },
                        saveAsImage: { show: true }
                    }
                },
        	    legend: {
        	        data:['授信金额(万)']
        	    },
        	    xAxis: {
        	        data: [
    					<c:forEach items="${ data }" var="item">
    					'${ item.get("officeName") }',
    					</c:forEach>
                    ]
        	    },
        	    yAxis: {},
        	    series: [{
        	        name: '授信金额(万)',
        	        type: 'bar',
        	        data: [
    					<c:forEach items="${ data }" var="item">
    					'${ item.get("amount") }',
    					</c:forEach>
                    ]
        	    }]
        	};
        myChartPillar.setOption(optionPillar);
        myChartPie.setOption(optionPie);
	})();
	
	// 表格初始化
	(function() {
		if (typeof ($.fn.DataTable) === 'undefined') {
			return;
		}

		var handleDataTableButtons = function() {
			if ($("#export_target_table").length) {
				$("#export_target_table").DataTable({
					dom : "Bfrtip",
					buttons : [ {
						extend : "csv",
						text : "导出"
					//className: "btn-sm"
					}, ],
					scrollY : 580,
					scrollCollapse : true,
					scroller : true,
					"language": {
	                	"search":         "查询:",
	                	"paginate": {
	                        "first":      "第一页",
	                        "last":       "最后一页",
	                        "next":       "下一页",
	                        "previous":   "上一页"
	                    },
	                    "aria": {
	                        "sortAscending":  ": activate to sort column ascending",
	                        "sortDescending": ": activate to sort column descending"
	                    },
	                    "infoEmpty":      "当前共 0 条数据",
	                    "info":           "当前  _START_ / _END_ , 共 _TOTAL_ 条",
	                    "emptyTable":     "暂未查询到相关数据！"
	                }
				});
			}
		};

		TableManageButtons = function() {
			"use strict";
			return {
				init : function() {
					handleDataTableButtons();
				}
			};
		}();

		TableManageButtons.init();
	})();
</script>
