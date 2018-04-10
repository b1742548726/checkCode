<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="shop_info">
	<div class="title">${ dateString }</div>
	<div class="content" style="min-height: 450px" id="div_charts"></div>
</div>
<h3>
	详细数据
</h3>
<div class="shop_info">
	<div class="tb_wrap">
		<table>
			<thead>
				<tr>
					<th>${ ratioType eq "customer" ? "客户类型" : "担保方式" }</th>
					<th>授信金额（万）</th>
					<th>授信占比</th>
				</tr>
			</thead>
			<tbody>
				
				<c:forEach items="${ data }" var="item">
					<tr>
						<td>${ item.get("name") }</td>
						<td>${ item.get("amount") }</td>
						<td>${ item.get("percentage") }</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
	</div>
</div>

<script>
(function(){
	var myChartPie = echarts.init(document.getElementById('div_charts'));
	var optionPie = {
	        title: {
	            text: '${ ratioType eq "customer" ? "客户类型" : "担保方式" }'
	        },
	        tooltip: {
	            show: true
	        },
	        toolbox: {
	            show: true,
	            feature: {
	                saveAsImage: { show: true }
	            }
	        },
	        series: [
	            {
	                name: '访问来源',
	                type: 'pie',
	                radius: '80%',
	                data: [
					<c:forEach items="${ data }" var="item">
						{ value: '${ item.get("amount") }', name: '${ item.get("name") }', label: { normal: { show: true, formatter: '{b} {d}%' } } },
					</c:forEach>
	                ]
	            }
	        ]
	    };
	myChartPie.setOption(optionPie);
})();
</script>