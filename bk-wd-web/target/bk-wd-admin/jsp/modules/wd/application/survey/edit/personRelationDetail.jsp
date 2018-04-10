<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<ul id="new_${wdPersonRelation.id }">
    <li><label>与申请人关系：</label>
        <p>${wdPersonRelation.relationType }
            <span class="delete del_person_relation" data-id="${wdPersonRelation.id }"></span>
            <c:if test="${fns:formatNumber(permission, 2)}">
            	<span class="edit edit_person_relation" data-id="${wdPersonRelation.id }"></span>
            </c:if>
         </p>
    </li>
    <c:forEach items="${config }" var="customerRelationConfig" varStatus="itemStatus">
        <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(customerRelationConfig.businessElementId)" var="wdBusinessElement"/>
        <li>
            <label>${customerRelationConfig.elementName }：</label>
            <c:choose>
                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                    <wd:picList dataList="${wdPersonRelation.wdPerson.getJsonData()[wdBusinessElement.key]}" />
                </c:when>
                <c:otherwise>
                   <p>${wdPersonRelation.wdPerson.getJsonData()[wdBusinessElement.key] }</p>
                </c:otherwise>
            </c:choose>
        </li>
    </c:forEach>
</ul>
<script>
$('#new_${wdPersonRelation.id } > li:nth-of-type(even)').each(function(){
    $(this).prev("li").append($(this).html());
    $(this).remove();
})
</script>