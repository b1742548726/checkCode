<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<%@ attribute name="dataList" type="java.util.List" required="true" description="列表"%>
<c:forEach items="${dataList }" var="data">
    <li class="${not empty data.childList ? 'reduce' : ''}">
        <p data-id="${data.id }"> >${data.name } </p>
        <c:if test="${not empty data.childList}">
            <ul>
                <sys:treestatistcs dataList="${data.childList}" >
            </ul>
        </c:if>
    </li>
</c:forEach>