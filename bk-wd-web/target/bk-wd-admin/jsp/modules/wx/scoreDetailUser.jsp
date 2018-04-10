<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<span style="font-size:14px;font-weight:600;display:inline-block;margin-bottom:8px;">${ userName } 评分详情</span>
<table class="table table-striped table-bordered wd-table">
	<thead>
		<tr>
			<th>月份</th>
			<th>服务均分</th>
			<th>效率均分</th>
			<th>廉洁均分</th>
			<th>综合均分</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ list }" var="data">
			<tr>
				<td>${ data.get("month") }</td>
				<td>${ data.get("scoreService") }</td>
				<td>${ data.get("scoreEfficiency") }</td>
				<td>${ data.get("scoreProbity") }</td>
				<td>${ data.get("scoreAvg") }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>