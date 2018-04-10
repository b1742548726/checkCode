<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<h3>${not empty officeName ? officeName : '全部'}
    <c:if test="${not empty officeName}">
        <shiro:hasPermission name="sys:user:edit">
            <img src="${imgStatic }/zwy/LBQ/images/people.png" onclick="javascript:editUser();">
        </shiro:hasPermission>
    </c:if>
    <input type="text" placeholder="查询姓名" class="search" id="searchName" value="${searchName }" onchange="javascript:changeSearchName()">
</h3>
<div class="shop_info">
    <div class="tb_wrap">
        <table>
            <thead>
                <tr>
                    <th>员工号</th>
                    <th>姓名</th>
                    <th>账号</th>
                    <th>部门</th>
                    <th>职务</th>
                    <th>角色</th>
                    <th>状态</th>
                    <th>&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${pagination.dataList}" var="data">
                    <spring:eval expression="@sysOfficeService.selectByPrimaryKey(data.officeId)" var="office"/>
                    <tr>
                        <td>${data.code }</td>
                        <td>${data.name }</td>
                        <td>${data.loginName }</td>
                        <td>${office.name }</td>
                        <td>${data.station }</td>
                        <td>
                            <spring:eval expression="@sysRoleService.findByUser(data.id)" var="roleLst" />
                            <c:forEach items="${roleLst }" var="role"><c:set var="roleIds" value="${roleIds},${role.id }"/>${role.name }，</c:forEach>
                        </td>
                        <td>
                           ${data.stutus == 1 ? '已启用' : '已禁用'}
                        </td>
                        <td>
                            <shiro:hasPermission name="sys:user:edit">
                                <span class="edit" onclick="javascript:editUser('${data.id}')"></span>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="sys:user:del">
                                <span class="delete" onclick="javascript:delUser('${data.id}','${data.name}')"></span>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="sys:user:callbackpassword">
                                <c:if test="${not empty data.lastPassword}">
                                    <span class="callbackpassword" onclick="javascript:callbackUserPassword(this,'${data.id}')"></span>
                                </c:if>
                            </shiro:hasPermission>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="dataTables_wrapper">${pagination}</div>
    </div>
</div>
<script type="text/javascript">
function changeSearchName(){
	$('.organ_list .cur').removeClass('cur');
	seachTable();
}

function callbackUserPassword(dom, userId) {
	Confirm("确定要回滚密码？", function (){
		$.post("${ctx}/sys/user/callbackpassword", {"userId": userId}, function(data){
			if(data.success) {
				NotifyInfo("回滚密码成功")
				$(dom).hide();
			} else {
				NotifyInfo("回滚密码失败")
			}
	    });	
	});
}

function editUser(userId) {
	var data = {};
	if (userId) {
		data.id = userId;
	} else {
		data.officeId = "${sysOffice.id}";
	}
	$.get("${ctx}/sys/user/userForm", data, function(data){
        $("#user_list_table").html(data);
    });
}

function delUser(userId, userName){
	Confirm("确定要删除用户【" + userName+  "】？", function (){
		$.ajax({
	        url : "${ctx}/sys/user/delete",
	        async : false,
	        cache : false,
	        type : "POST",
	        data : {
	            id : userId,
	            _csrf: "${_csrf}"
	        },
	        dataType : "json",
	        success : function(result) {
	            if (result.success) {
	            	seachTable(null, _user_search_data);
	            } else {
	                NotifyInCurrentPage("error", result.msg, "删除机构错误");
	            }
	        }
	    });
	});
}

function page(n,s) {
    seachTable(n);
    return false;
}
</script>