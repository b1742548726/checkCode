<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<spring:eval expression="@systemService.getGlobalSetting()" var="sysGlobalSetting" />
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${sysGlobalSetting.systemName }-欢迎页</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>
    <div class="wd-content">
        <div class="welcome" style="margin:100px auto;width:100%;text-align: center; color: #000;">
                <c:choose>
                    <c:when test="${not empty sysGlobalSetting.systemLogo}">
                        <img src="${imagesStatic }${fns:choiceImgUrl('240x150',sysGlobalSetting.systemLogo)}">
                    </c:when>
                    <c:otherwise>
                       <%--  <img src="${imagesStatic }"> --%>
                    </c:otherwise>
                </c:choose>
                <div><h1>Welcome，<br />欢迎使用${sysGlobalSetting.systemName }</h1></div>
                <div style="font-size: 16px;padding-top: 1em;">version</div>
                <div style="font-size: 16px;">${sysGlobalSetting.versoinNo }</div>
        </div>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
</body>
</html>