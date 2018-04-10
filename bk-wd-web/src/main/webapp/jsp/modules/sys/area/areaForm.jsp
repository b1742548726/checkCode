<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>
    <div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
        <div class="x_panel">
            <div class="x_content">
            	<form:form id="inputForm" modelAttribute="sysArea" action="${ctx}/sys/area/save" method="post" class="form-horizontal">
            		<form:hidden path="id"/>
            		<div class="control-group">
            			<label class="control-label">上级区域:</label>
            			<div class="controls">
            			</div>
            		</div>
            		<div class="control-group">
            			<label class="control-label">区域名称:</label>
            			<div class="controls">
            				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
            				<span class="help-inline"><font color="red">*</font> </span>
            			</div>
            		</div>
            		<div class="control-group">
            			<label class="control-label">区域编码:</label>
            			<div class="controls">
            				<form:input path="code" htmlEscape="false" maxlength="50"/>
            			</div>
            		</div>
            		<div class="control-group">
            			<label class="control-label">区域类型:</label>
            			<div class="controls">
            				<form:select path="type" class="input-medium">
            					<form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            				</form:select>
            			</div>
            		</div>
            		<div class="control-group">
            			<label class="control-label">备注:</label>
            			<div class="controls">
            				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
            			</div>
            		</div>
            		<div class="form-actions">
            			<shiro:hasPermission name="sys:area:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
            			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            		</div>
            	</form:form>
            </div>
        </div>
    </div>    
    <!-- /page content -->
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

    <script src="${imgStatic }/zwy/js/wd-common.js"></script>
    <script src="${imgStatic }/zwy/js/wd-common-bind.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
</body>
</html>