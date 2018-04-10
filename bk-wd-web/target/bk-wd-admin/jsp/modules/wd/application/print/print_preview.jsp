<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>闪亮萤</title>
<!-- Bootstrap -->
<link href="${ imgStatic }vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
<!-- Font Awesome -->
<link href="${ imgStatic }vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
</head>
<body>
    <ul style="padding-left: 3em; padding-top: 3em;">
        <li class="_resolution_luoshan" style="float: left; cursor: pointer; margin: 2em; list-style: none; text-align: center;">
            <img src="${imgStatic }/zwy/img/print_table.png" width="60px" />
            <p>决议表</p>
        </li>
            <li class="_review_report" style="float: left; cursor: pointer; margin: 2em; list-style: none; text-align: center;">
                <img src="${imgStatic }/zwy/img/print_table.png" width="60px" />
                <p>审查报告</p>
        </li>
            <li class="_meeting" style="float: left; cursor: pointer; margin: 2em; list-style: none; text-align: center;"><img
                src="${imgStatic }/zwy/img/print_table.png" width="60px" />
                <p>会议记录</p></li>
    </ul>
    <!-- jQuery -->
    <script src="${ imgStatic }vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${ imgStatic }vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- PrintArea -->
    <script src="${ imgStatic }vendors/RitsC-PrintArea-2cc7234/demo/jquery.PrintArea.js"></script>
    
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    <script type="text/javascript">
		$(function() {
			// 决议表
			$("ul").on("click","._resolution",function() {
				OpenFullIFrame("闪亮萤 - 决议表", "${ctx}/wd/application/print/resolution?applicationId=${applicationId }" );
			});
			$("ul").on("click","._resolution_luoshan",function() {
				OpenFullIFrame("闪亮萤 - 决议表", "${ctx}/wd/application/print/resolutionLuosan?applicationId=${applicationId }" );
			});
			$("ul").on("click","._review_report",function() {
				OpenFullIFrame("闪亮萤 - 审查报告", "${ctx}/wd/application/print/review_report?applicationId=${applicationId }" );
			});
			$("ul").on("click","._meeting",function() {
				OpenFullIFrame("闪亮萤 - 会议记录", "${ctx}/wd/application/print/meeting?applicationId=${applicationId }" );
			});
		});
	</script>
</body>
</html>
