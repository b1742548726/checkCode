<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gentelella Alela! | </title>

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
    
    <style type="text/css">
        ul.parsley-errors-list {
            position: absolute;
            top: .5em;
            right: -3em;
        }
    </style>
</head>
<body>
<div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
    <div class="x_panel">
        <div class="x_content">
            <br />
            <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" method="post">
                <input type="hidden" name="id" value="${wdBusinessElement.id }">
                <input type="hidden" name="defaultSimpleModuleId" value="${defaultSimpleModuleId }">
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="baseElementId">
                                    组件类型 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <select class="form-control" name="baseElementId" required="required" class="form-control col-md-7 col-xs-12">
                            <spring:eval expression="@wdBaseElementService.queryAll()" var="elementList"/>
                            <option> -- 请选择 -- </option>
                            <c:forEach items="${elementList}" var="baseElement">
                                <option value="${baseElement.id }" ${wdBusinessElement.baseElementId eq baseElement.id ? 'selected' : '' }>${baseElement.name }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                                        标题 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="name" value="${wdBusinessElement.name }" required="required" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="placeholder">
                                        占位符 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="placeholder" value="${wdBusinessElement.placeholder }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="key">
                        Key <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="key" value="${wdBusinessElement.key }" required="required" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="height">
                                        高度 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="height" value="${wdBusinessElement.height }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selectGroupId">
                                        选择项 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <select class="form-control" name="selectGroupId" class="form-control col-md-7 col-xs-12">
                            <spring:eval expression="@wdSelectGroupService.selectAll()" var="selectGroupList"/>
                            <option></option>
                            <c:forEach items="${selectGroupList}" var="selectGroup">
                                <option value="${selectGroup.id }" ${wdBusinessElement.selectGroupId eq selectGroup.id ? 'selected' : '' }>${selectGroup.name }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="keyboardType">
                                        键盘类型 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <select class="form-control" name="keyboardType" class="form-control col-md-7 col-xs-12">
                            <option></option>
                            <c:forEach items="${fns:getDictList('keyboard_type')}" var="keyboardType">
                                <option value="${keyboardType.value }" ${wdBusinessElement.keyboardType eq keyboardType.value ? 'selected' : '' }>${keyboardType.label }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="regularExpression">
                                        正则 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="regularExpression" value="${wdBusinessElement.regularExpression }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="regularExpression">
                                        公式 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="formula" value="${wdBusinessElement.formula }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="errorMessage">
                                        错误提示 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="errorMessage" value="${wdBusinessElement.errorMessage }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="accessorialFunction">
                                        辅助功能 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <select class="form-control" name="accessorialFunction" class="form-control col-md-7 col-xs-12">
                            <option></option>
                            <c:forEach
								items="${fns:getDictList('accessorial_function')}"
								var="accessorialFunction">
								<option value="${accessorialFunction.value }"
									${wdBusinessElement.accessorialFunction eq accessorialFunction.value ? 'selected' : '' }>${accessorialFunction.label }</option>
							</c:forEach>
						</select>
                    </div>
                </div> 
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="specialType">
                                        特殊类型 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <select class="form-control" name="specialType" class="form-control col-md-7 col-xs-12">
                            <option></option>
                            <c:forEach
								items="${fns:getDictList('special_type')}"
								var="specialType">
								<option value="${specialType.value }"
									${wdBusinessElement.specialType eq specialType.value ? 'selected' : '' }>${specialType.label }</option>
							</c:forEach>
						</select>
                    </div>
                </div> 
                <div class="ln_solid"></div>
                <div class="form-group">
                    <div class="col-md-9 col-sm-9 col-xs-9 col-xs-offset-3">
                        <button class="btn btn-primary" type="button" onclick="javascript:CloseIFrame();">取消</button>
                        <button class="btn btn-success" type="button" onclick="javascript:save();" id="submit-add-module">确认</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- jQuery -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- Parsley -->
<script src="${imgStatic }/vendors/parsleyjs-2.6/dist/parsley.min.js"></script>
<script src="${imgStatic }/vendors/parsleyjs-2.6/dist/i18n/zh_cn.js"></script>
<!-- Switchery -->
<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>

<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script>
function save(){
	var formParsley = $("#form-add-module").parsley();
    if (formParsley.validate()) {
    	$.ajax({
            url : "${ctx }/wd/element/save",
            data : $("#form-add-module").serialize(),
            type: "post",
            success : function (data) {
            	if (data.code == 200) {
            		CloseIFrame();
            	}
            }
    	});
    }
}
</script>
</body>
</html>