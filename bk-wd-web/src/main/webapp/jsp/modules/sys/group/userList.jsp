<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<table>
    <thead>
        <tr>
            <th>姓名</th>
            <th>账号</th>
            <th>职务</th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${pagination.dataList}" var="data">
            <tr>
                <td>${data.name }</td>
                <td>${data.loginName }</td>
                <td>${data.station }</td>
                <td>
                    <shiro:hasPermission name="sys:group:assignment">
                        <span class="delete" onclick="javascript:delUser('${data.id}', '${data.name}')"></span>
                    </shiro:hasPermission>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="dataTables_wrapper">${pagination}</div>
<script>
function delUser(userId, userName){
	var _groupId = $(".role_list p.cur").data("id");
	Confirm("确定要删除用户【" + userName+  "】？", function (){
		$.ajax({
	        url : "${ctx}/sys/group/deleteGroupUser",
	        async : false,
	        cache : false,
	        type : "POST",
	        data : {
	            id : _groupId,
	            userId : userId
	        },
	        dataType : "json",
	        success : function(result) {
	            if (result.success) {
	            	seachTable();
	            } else {
	                NotifyInCurrentPage("error", result.msg, "删除用户错误");
	            }
	        }
	    });
	});
}
</script>