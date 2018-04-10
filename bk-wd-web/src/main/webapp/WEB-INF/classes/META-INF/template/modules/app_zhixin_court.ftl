<html lang="en">
<head style="background-color: rgb(240,240,240)">
<title>总览</title>
<style type="text/css">
html body {
	width:100%;	
	font-size:12px;
	box-sizing:content-box;
	overflow-x:hidden;
    font-family:SimHei !important;
}
.table_center td {
	text-align:center;	
}
table {
	border-collapse:collapse;
	width:100%;
    font-size: 12px;
	margin:0 auto;
	left:0;
	right:0;
}
table td, table th {
	border:1px solid #ddd;	
	padding:10px;
}
.td_padding {
	border:2px solid #103050;
}
table td {
	color : #103050;
}
table.soft_info_table td {
	color : #708090;
}

table th {
	font-weight : 100;
	color : #000000;
}

.width48p {
	width: 48%;
	float: left;
}
.clear_both {
	clear: both;
}
</style>
</head>
<body>
    <#list zhixinList as wdCourtQuery>
        <#if wdCourtQuery.getJsonListData()?size gt 0>
            <table cellspacing="0">
                <tr>
                    <td colspan="4" class="td_padding">
                    </td>
                </tr>
                <tr>
                    <th width="12%">查询时间</th>
                    <th width="25%">${(wdCourtQuery.createDate)?string("yyyy-MM-dd HH:mm:ss")}</th>
                    <th width="12%">查询信息</th>
                    <th>${wdCourtQuery.targetName }（${wdCourtQuery.targetIdcard }）</th>
                </tr>
            </table>
            <#list wdCourtQuery.getJsonListData() as data>
    			<table cellspacing="0">
    				<tr>
						<td colspan="2" class="td_padding">
						</td>
					</tr>
					<tr>
                        <th>立案时间</th>
                        <td>${data.publishDate }</td>
                    </tr>
                    <tr>
                        <th>执行法院</th>
                        <td>${data.courtName }</td>
                    </tr>
                    <tr>
                        <th>案号</th>
                        <td>${data.areaName }</td>
                    </tr>
                    <tr>
                        <th>执行标的</th>
                        <td>${data.gistId }</td>
                    </tr>
    			</table>
    		</#list>
    		<br></br>
        </#if>
    </#list>
</body>
</html>