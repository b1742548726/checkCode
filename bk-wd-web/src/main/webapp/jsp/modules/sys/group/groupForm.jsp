<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="popupHtml2">
    <div class="popBottom2 toph2">
        <div>
            <label style="margin-top: 0.6em;" class="control-label col-md-3 col-sm-3 col-xs-12" for="">
                        名称：<span class="required"></span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
                <input type="text" value="${sysGroup.name }" id="groupName" placeholder="输入名称" class="form-control">
            </div>
            <div class="warning hide">
                <ins class="import"></ins>
                <span class=""><i>不能为空</i></span>
            </div>
        </div>
        <div class="popBottom2 toph2">
             <label style="margin-top: 0.6em;" class="control-label col-md-3 col-sm-3 col-xs-12" for="">
                       分类：<span class="required"></span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
               <select class="form-control" id="groupCategory">
                    <option value=""> -- 请选择 -- </option>
                    <c:forEach items="${fns:getDictList('user_group_category')}" var="groupCategory">
                        <option ${groupCategory.value eq sysGroup.category ? 'selected' : ''} value="${groupCategory.value }">${groupCategory.label }</option>
                    </c:forEach>
                </select>
            </div>
            <div class="warning hide">
                <ins class="import"></ins>
                <span class=""><i>不能为空</i></span>
            </div>
        </div>
    </div>
    <div class="popBottom2">
        <a href="javascript:CloseLayer();" class="cancel">取消</a>
        <a href="javascript:addOffice();" class="clear">确定</a>
    </div>
</div>
<script>
function addOffice() {
    var _name = $('#groupName').val();
    if (!_name) {
    	$('#groupName').addClass('error');
        $('#groupName').parent().next().removeClass('hide');
        return false;
    }
    var _category = $('#groupCategory').val();
    if (!_category) {
    	$('#groupCategory').addClass('error');
        $('#groupCategory').parent().next().removeClass('hide');
        return false;
    }
    $.ajax({
        url : "${ctx}/sys/group/save",
        async : false,
        cache : false,
        type : "POST",
        data : {
        	category : _category,
            name : _name,
            id : "${sysGroup.id }"
        },
        dataType : "json",
        success : function(result) {
            if (result.success) {
            	result.data.categoryName = $("#groupCategory").find("option:selected").text();
            	SetLayerData("_office_data", result.data);
            	CloseLayer();
            } else {
                NotifyInCurrentPage("error", result.msg, "添加机构错误");
            }
        }
    });
}
</script>