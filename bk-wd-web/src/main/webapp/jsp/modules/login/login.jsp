<%@page import="java.security.SecureRandom"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<%
SecureRandom random = new SecureRandom();
random.setSeed(8738);
Double _csrf = random.nextDouble();
session.setAttribute("_csrf", _csrf.toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${sysGlobalSetting.systemName }-登录</title>
<link rel="icon" href="${imagesStatic }${sysGlobalSetting.systemIco}" type="image/x-icon" />
    <link rel="shortcut icon" href="${imagesStatic }${sysGlobalSetting.systemIco}" type="image/x-icon" />
<link href="${ctxStatic }/modules/login/login.css" rel="stylesheet" />
</head>
<c:choose>
    <c:when test="${not empty sysGlobalSetting.systemLogo}">
        <body style="background-image: url('${imagesStatic }${sysGlobalSetting.loginPhoto}');">
    </c:when>
    <c:otherwise>
        <body style="background-image: url('${imgStatic }/zwy/img/bg-3.jpg');">
    </c:otherwise>
</c:choose>
	<form id="loginForm" class="form-horizontal" action="${ctx}/login"
		method="post">
        <input type="hidden" name="_csrf" value="<%=_csrf %>" />
		<div class="center-in-center">
			<!-- 有错误信息时使用【error-message-show】类名 -->
			<div
				class='${empty message ? "error-message-hide":"error-message-show" }'>
				${message} <span id="messageBox"></span>
			</div>

			<div class="system-logo">
                <c:if test="${not empty sysGlobalSetting.systemLogo}">
                    <img style="vertical-align: middle;" src="${imagesStatic }${fns:choiceImgUrl('160x100',sysGlobalSetting.systemLogo)}" >
                </c:if>
                <span class="name"> ${sysGlobalSetting.systemName } </span>
			</div>
			<div class="login-content">
				<div class="login-input">
					<label> 登录名 </label> <input type="text" class="form-control required" name="username" placeholder="请输入手机号" value="${username}" />
				</div>
				<div class="login-input">
					<label> 密&emsp;码 </label> <input type="password"
						class="form-control required" name="password" placeholder="请输入密码" />
				</div>

				<c:if test="${isValidateCodeLogin}">
					<div class="login-input">
						<label> 验证码 </label>
						<sys:validateCode name="validateCode"
							inputCssStyle="margin-bottom:0;" />
					</div>
				</c:if>
			</div>
			<div class="login-submit">
				<div>
					<input type="submit" value="登&emsp;录" />
                    <%-- <span class="remember-me">
					   <input type="checkbox" value="remember_me" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''} /> 记住我（公共场所慎用）
					</span> --%>
				</div>
			</div>
		</div>
	</form>
	<div
		style="position: fixed; bottom: 0px; padding-bottom: 4%; width: 100%; color: white;">
		<div style="text-align: center;">
			<span> 本系统在Chrome下运行更加流畅，请安装并使用Chrome </span> <br /> <br /> <a
				href="${imgStatic }/zwy/chrome/ChromeStandaloneSetup64.exe"
				target="blank"> <img src="${imgStatic }/zwy/img/chrome.png"
				style="width: 250px; height: 38px;">
			</a>

		</div>
	</div>
</body>
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"
	charset="utf-8"></script>
<script
	src="${ctxStatic }/jquery-validation/1.11.0/jquery.validate.min.js"></script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#loginForm")
								.validate(
										{
											rules : {
												validateCode : {
													remote : "${pageContext.request.contextPath}/servlet/validateCodeServlet"
												}
											},
											messages : {
												username : {
													required : "请填写用户名."
												},
												password : {
													required : "请填写密码."
												},
												validateCode : {
													remote : "验证码不正确.",
													required : "请填写验证码."
												}
											},
											errorLabelContainer : "#messageBox",
											errorPlacement : function(error,
													element) {
												console.log(error);
												error
														.appendTo($("#messageBox"));
											}
										});
					});

	// 如果在框架或在对话框中，则弹出提示并跳转到首页
	if (self.frameElement && self.frameElement.tagName == "IFRAME"
			|| $('#left').length > 0 || $('.jbox').length > 0) {
		alert('未登录或登录超时。请重新登录，谢谢！');
		top.location = "${ctx}";
	}
</script>
</html>