<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<!-- Switchery -->
<link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
<!-- Switchery -->
<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>

<div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
    <div class="x_panel">
        <div class="x_content">
            <br />
            <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" method="post">
                <input type="hidden" name="id" value="${wdCommonSimpleModule.id }">
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                                        默认容器 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <spring:eval expression="@wdDefaultSimpleModuleService.selectAll()" var="moduleList"/>
                        <c:if test="${not empty moduleList}">
                            <select class="form-control" name='defaultSimpleModuleId'>
                                <option value="">-- 请选择 --</option>
                                <c:forEach items="${moduleList}" var="module">
                                    <option value="${module.id }" ${module.id eq wdCommonSimpleModule.defaultSimpleModuleId ? 'selected' : '' }>${module.name }</option>
                                </c:forEach>
                            </select>
                        </c:if>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                                        名称 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="moduleName" value="${wdCommonSimpleModule.moduleName }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <%-- <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="remarks">
                                        描述 <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <textarea name="remarks" class="form-control col-md-7 col-xs-12" rows="3">${wdCommonSimpleModule.remarks}</textarea>
                    </div>
                </div> --%>
                <div class="ln_solid"></div>
                <div class="form-group">
                    <div class="col-md-9 col-sm-9 col-xs-9 col-xs-offset-3">
                        <button class="btn btn-primary" type="button" onclick="javascript:CloseLayer();">取消</button>
                        <button class="btn btn-success" type="button" onclick="javascript:save();" id="submit-add-module">确认</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
function save() {
	$.ajax({
        url : "${ctx }/wd/commonModule/save",
        data : $("#form-add-module").serialize(),
        type: "post",
        success : function (data) {
        	if (data.code == 200) {
        		SetLayerData("_save_common_module_data", true);
        		CloseLayer();
        	}
        }
	});
}
</script>