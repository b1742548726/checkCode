<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="col-md-12 col-sm-12 col-xs-12 wd-nonpadding">
    <div class="x_panel">
        <div class="x_content">
            <br />
            <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" method="post">
                <input type="hidden" name="id" value="${sysDict.id }">
                <input type="hidden" name="parentId" value="${sysDict.parentId }">
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="label">
                                        标签: <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="label" value="${sysDict.label }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="value">
                                        键值: <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="value" value="${sysDict.value }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="type">
                                        类型: <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="type" value="${sysDict.type }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="description">
                                        描述: <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="description" value="${sysDict.description }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="sort">
                                       排序: <span class="required"></span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text"  name="sort" value="${sysDict.sort }" class="form-control col-md-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selectRemarks">备注:</label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <textarea id="selectRemarks" name="remarks" class="form-control col-md-7 col-xs-12" rows="3">${sysDict.remarks}</textarea>
                    </div>
                </div>
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
        url : "${ctx }/sys/dict/save",
        data : $("#form-add-module").serialize(),
        type: "post",
        success : function (data) {
        	if (data.code == 200) {
        		$("#searchForm", mainFrame.document).submit();
        		CloseLayer();
        	}
        }
	});
}
</script>