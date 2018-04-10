<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<%@ attribute name="add" type="java.lang.String" required="false" description="添加"%>
<%@ attribute name="remove" type="java.lang.String" required="false" description="删除"%>
<%@ attribute name="edit" type="java.lang.String" required="false" description="编辑"%>
<%@ attribute name="box" type="java.lang.Boolean" required="false" description="勾选"%>
<%@ attribute name="dataList" type="java.util.List" required="true" description="列表"%>
<c:forEach items="${dataList }" var="data">
    <li class="${not empty data.childList ? 'reduce' : ''}">
        <p data-id="${data.id }">
            <span>${data.name }</span>
            <c:if test="${not empty add }">
                <shiro:hasPermission name="${add }">
                    <i class="add"></i>
                </shiro:hasPermission>
            </c:if>
            <c:if test="${not empty remove }">
                <shiro:hasPermission name="${remove }">
                    <i class="remove"></i>
                </shiro:hasPermission>
            </c:if>
            <c:if test="${not empty edit }">
                <shiro:hasPermission name="${edit }">
                    <i class="edit"></i>
                </shiro:hasPermission>
            </c:if>
            <c:if test="${box }">
                <i class="box"></i>
            </c:if>
        </p>
        <c:if test="${not empty data.childList}">
            <ul>
                <sys:tree dataList="${data.childList}" box="${box }" edit="${edit }" add="${add }" remove="${remove }"/>
            </ul>
        </c:if>
    </li>
</c:forEach>