<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="shop_info">
	<div class="title">${ dateString }</div>
	<div class="content" style="min-height: 400px" id="div_charts"></div>
</div>
<div class="shop_info">
	<!-- <div class="tb_wrap"> -->
	<!-- <table class="product_table" id="export_target_table"> -->
		<table id="export_target_table">
			<thead>
				<tr>
					<th> 时间 </th>
					<th> 授信金额(万) </th>
					<th> 进件数 </th>
					<th> 初审通过数 </th>
					<th> 放款数 </th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${ data }" var="item">
					<tr>
						<td>${ item.get("date") }</td>
						<td>${ item.get("amount") }</td>
						<td>${ item.get("intention") }</td>
						<td>${ item.get("passing") }</td>
						<td>${ item.get("loan") }</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr class="last">
					<td>总计</td>
					<td>${ totalAmount }</td>
					<td>${ totalIntention }</td>
					<td>${ totalPassing }</td>
					<td>${ totalLoan }</td>
				</tr>
			</tfoot>
		</table>
	<!-- </div> -->
</div>
<script type="text/javascript">
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
            data : [ '授信金额', '进件数', '初审通过数', '最终批核数' ],
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
                    name : '进件数',
                    type : 'line',
                    smooth : true,
                    yAxisIndex : 1,
                    data : [
                        <c:forEach items="${ data }" var="item">
                            '${ item.get("intention") }',
                        </c:forEach>
                    ]
                }, {
                    name : '初审通过数',
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

(function() {
    if (typeof ($.fn.DataTable) === 'undefined') { return; }

    var handleDataTableButtons = function () {
        if ($("#export_target_table").length) {
            $("#export_target_table").DataTable({
                dom: "Bfrtip",
                buttons: [
                  {
                      extend: "csv",
                      text: "导出"
                  }
                ],
                scrollY: 580,
                scrollCollapse: true,
                scroller: true,
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
    handleDataTableButtons();
   /*  
    TableManageButtons = function () {
        "use strict";
        return {
            init: function () {
                handleDataTableButtons();
            }
        };
    }

    TableManageButtons.init(); */
})();
</script>