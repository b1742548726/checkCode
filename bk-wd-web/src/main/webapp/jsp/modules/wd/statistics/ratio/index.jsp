<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>占比统计</title>
<!--统一样式，不删-->
<link href="${ imgStatic }vendors/bootstrap/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link href="${ imgStatic }vendors/font-awesome/css/font-awesome.min.css"
    rel="stylesheet">
<link href="${ imgStatic }build/css/custom.css" rel="stylesheet">

<!-- 重要！样式重写! -->
<link href="${ imgStatic }zwy/css/custom-override.css" rel="stylesheet" />

<link href="${ imgStatic }zwy/LBQ/css/statistical.css" rel="stylesheet">
</head>

<body>
    <div class="wd-content">
        <div class="organization">
            <h2>
                                                        占比统计 
                <select id="dateType" class="select_time">
                    <option value="1">今天</option>
                    <option value="2">近7天</option>
                    <option value="3">近6周</option>
                    <option value="4">近6个月</option>
                    <option value="5">近12个月</option>
                </select>
            </h2>
            <div class="left_wrap">
                <div class="shop_info">
                    <div class="tb_wrap" style="margin-left: 0">
                        <ul class="table_content2">
                            <li ratioType="customer" class="cur">按客户类型统计</li>
                            <li ratioType="guarantee">按担保方式统计</li>
                        </ul>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="right_wrap">
                
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
    
    <script src="${ imgStatic }vendors/echarts-3.5.4/echarts.min.js"></script>
    
    <script>        
        function freshCharts() {
        	var _dateType = $("#dateType").val();
			var _ratioType = $(".table_content2 .cur").attr("ratioType");
			StartLoad();
			$.get("${ctx}/wd/statistics/ratio/charts", {dateType : _dateType, ratioType : _ratioType }, function(data){
				$(".right_wrap").empty().html(data);
				FinishLoad();
			})
        }
        
        $(function() {
        	
        	freshCharts();
        	
            $('.table_content2').on('click', 'li', function() {
                $(this).addClass('cur').siblings().removeClass();
                freshCharts();
            })

            $('.select_time').change(function() {
                if ($(this).val() == '自定义') {
                    alert('调用时间控件')
                }
                
                freshCharts();
            })
        })
    </script>
</body>
</html>