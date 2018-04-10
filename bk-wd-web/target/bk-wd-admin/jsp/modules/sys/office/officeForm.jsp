<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="popupHtml2">
    <div class="popBottom2 toph2">
        <label for="" style="float:left;margin-left:30px">名称：</label>
        <input type="text" placeholder="输入名称" class="add_name" style="float:left">

        <div class="warning hide">
            <ins class="import"></ins>
            <span class=""><i>不能为空</i></span>
        </div>
    </div>
    <div class="popBottom2">
        <a href="javascript:CloseLayer();" class="cancel">取消</a>
        <a href="javascript:addOffice();" class="clear">确定</a>
    </div>
</div>
<script>
function addOffice() {
    var _name = $('.add_name').val();
    if (!_name) {
    	$('.add_name').addClass('error');
        $('.add_name').next().removeClass('hide');
        return false;
    }
    StartLoad();
    $.ajax({
        url : "${ctx}/sys/office/save",
        async : false,
        cache : false,
        type : "POST",
        data : {
            name : _name,
            id : "${office.id }",
            _csrf: "${_csrf}",
            parentId : "${office.parentId}"
        },
        dataType : "json",
        success : function(result) {
            if (result.success) {
            	SetLayerData("_office_data", result.data);
            	CloseLayer();
            } else {
                NotifyInCurrentPage("error", result.msg, "添加机构错误");
            }
        },
		complete : function (){
			FinishLoad();
		}
    });
   
}
</script>