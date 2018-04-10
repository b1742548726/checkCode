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
                <th class="">成员</th>
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
                <tr userid="${ item.get("user_id") }">
                    <td>${ item.get("user_name") }</td>
                    <td style="${ item.get("amount") < avgAmount ? 'color:red' : '' }">${ item.get("amount") }</td>
                    <td style="${ item.get("visit") < avgVisit ? 'color:red' : '' }">${ item.get("visit") }</td>
                    <td style="${ item.get("intention") < avgIntention ? 'color:red' : '' }">${ item.get("intention") }</td>
                    <td style="${ item.get("submit") < avgSubmit ? 'color:red' : '' }">${ item.get("submit") }</td>
                    <td style="${ item.get("passing") < avgPassing ? 'color:red' : '' }">${ item.get("passing") }</td>
                    <td style="${ item.get("loan") < avgLoan ? 'color:red' : '' }">${ item.get("loan") }</td>
                </tr>
            </c:forEach>
        </tbody>

        <tfoot>
            <tr style="background-color: #decf90">
                <td>平均值</td>
                <td>${ avgAmount }</td>
                <td>${ avgVisit }</td>
                <td>${ avgIntention }</td>
                <td>${ avgSubmit }</td>
                <td>${ avgPassing }</td>
                <td>${ avgLoan }</td>
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

        TableManageButtons = function () {
            "use strict";
            return {
                init: function () {
                    handleDataTableButtons();
                }
            };
        }();

        TableManageButtons.init();
    })();
        
    (function(){
    	var myChartLine1 = echarts.init(document.getElementById('div_charts_1'));
        var myChartLine2 = echarts.init(document.getElementById('div_charts_2'));

        var optionLine1 = {
            title : {
                text : ''
            },
            tooltip : {},
            // color : [ '#7CCD7C', '#D15FEE', '#EE0000', '#0000FF', '#FF34B3', '#FFD700', '#00BFFF', '#20B2AA' ],
            legend : {
                show: false,
                width: '80%',
                data : [
                <c:forEach items="${ data }" var="item">
                    '${ item.get("user_name") }',
                </c:forEach>
                ],
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
                data: ['授信金额'],
                position: 'bottom',
            },
            yAxis : {
                name : '授信金额',
                type : 'value',
                //max: 1000
            },
            series : [
                <c:forEach items="${ data }" var="item">
                {
                    name: '${ item.get("user_name") }',
                    type: 'bar',
                    yAxisIndex: 0,
                    data: ['${ item.get("amount") }']
                },
                </c:forEach>            
            ]
        };
        var optionLine2 = {
                title : {
                    text : ''
                },
                tooltip : {},
                // color : [ '#7CCD7C', '#D15FEE', '#EE0000', '#0000FF', '#FF34B3', '#FFD700', '#00BFFF', '#20B2AA' ],
                legend : {
                    data : [
                    <c:forEach items="${ data }" var="item">
                        '${ item.get("user_name") }',
                    </c:forEach>
                    ],
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
                    data: [' 扫街笔数', '申请笔数', '提交审核笔数', '审核通过笔数', '最终批核数'],
                    position: 'bottom',
                },
                yAxis : {
                    name : '笔数',
                    type : 'value',
                    //max: 1000
                },
                series : [
                    <c:forEach items="${ data }" var="item">
                    {
                        name: '${ item.get("user_name") }',
                        type: 'bar',
                        yAxisIndex: 0,
                        data: ['${ item.get("visit") }', '${ item.get("intention") }', '${ item.get("submit") }', '${ item.get("passing") }', '${ item.get("loan") }']
                    },
                    </c:forEach>            
                ]
            };

        myChartLine1.setOption(optionLine1);
        myChartLine2.setOption(optionLine2);
    })();
</script>