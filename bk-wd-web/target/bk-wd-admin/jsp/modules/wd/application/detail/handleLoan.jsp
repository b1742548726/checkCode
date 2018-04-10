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
        <li class="_submit" style="float: left; cursor: pointer; margin: 3em; list-style: none; text-align: center;">
            <img src="${imgStatic }/zwy/img/loan.png" width="45px" />
            <p style="padding-top: 1em; color:#26293D;font-size: 15px;">放款</p>
        </li>
     <%--    <li class="_cancle" style="float: left; cursor: pointer; margin: 3em; list-style: none; text-align: center;"><img
                src="${imgStatic }/zwy/img/shape.png" width="45px" />
                <p style="padding-top: 1em; color:#26293D;font-size: 15px;">终止</p></li> --%>
        <shiro:hasPermission name="wd:application:return">
            <li class="_return
            " style="float: left; cursor: pointer; margin: 3em; list-style: none; text-align: center;">
                    <img src="${imgStatic }/zwy/img/back.png" width="45px" />
                    <p style="padding-top: 1em; color:#26293D;font-size: 15px;">退回</p>
            </li>
        </shiro:hasPermission>
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
    	var currentPageUrl = {
            customer: "${ctx }/wd/customer/detail", // 客户详情页
            application: "${ctx}/wd/application/detail", // 贷款详情页
            loan: "${ctx}/wd/application/detail/reviewView", // 贷款审批页面
        };
    
		$(function() {
			 // 放款
            $("._submit").on("click", "", function () {
                OpenIFrame("放款完成", currentPageUrl.loan + "?action=Pass&applicationId=${applicationId}&taskId=${taskId}", 1000, 300, function () { 
                	if (GetLayerData("close_review_view")) {
                		CloseIFrame();
                    }
            	});
            });
			 
         	// 终止
            $("._cancle").on("click", function () {

                OpenIFrame("终止", currentPageUrl.loan + "?action=Cancel&applicationId=${applicationId}&taskId=${taskId}", 1000, 300, function () { 
                	if (GetLayerData("close_review_view")) {
                		CloseIFrame();
                    }
                });
            }); 
            
            // 退回
            $("._return").on("click", function () {
                OpenIFrame("退回", currentPageUrl.loan + "?action=Return&applicationId=${applicationId}&taskId=${taskId}", 1000, 300, function () { 
                	if (GetLayerData("close_review_view")) {
                		CloseIFrame();
                    }
            	});
            }); 
		});
	</script>
</body>
</html>
