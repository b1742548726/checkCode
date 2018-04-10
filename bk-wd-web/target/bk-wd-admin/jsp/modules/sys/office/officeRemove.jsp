<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
    <div class="popupHtml2" >
        <div class="popBottom2 toph">
            <h2>该操作会<span>清除该团队下所有子部门及员工</span>，如您确认本操作，输入密码后点击删除按钮</h2>
        </div>
        <div class="popBottom2">
            <label for="" style="float:left;margin-left:30px">密码：</label>
             <input type="password" placeholder="输入登陆密码" id="password" class="password">
            <div class="warning hide">
                <ins class="import"></ins>
                <span class="hide"><i>不能为空</i></span>
            </div>
        </div>
        <div class="popBottom2">
            <a href="javascript:CloseLayer();" class="cancel">取消</a>
        	<a href="javascript:deleteOffice();" class="clear">删除</a>
        </div>
    </div>

<script>
function deleteOffice(){
	var _password = $("#password").val();
	$.ajax({
        url : "${ctx}/sys/office/delete",
        async : false,
        cache : false,
        type : "POST",
        data : {
            id : "${office.id }",
            _csrf: "${_csrf}",
            password: _password
        },
        dataType : "json",
        success : function(result) {
            if (result.success) {
            	SetLayerData("_office_remove_success", true);
            	CloseLayer();
            } else {
                NotifyInCurrentPage("error", result.msg, "删除机构错误");
            }
        }
    });
}
</script>