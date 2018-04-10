<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<ul id="new_${wdPersonRelation.id }">
    <li><label>与申请人关系：</label>
        <p>${wdPersonRelation.relationType }
            <span class="delete del_application_recognizor" data-id="${wdApplicationRecognizor.id }"></span>
            <span class="edit edit_application_recognizor" data-id="${wdApplicationRecognizor.id }"></span>
         </p>
    </li>
    <c:forEach items="${customerRelationConfigList }" var="customerRelationConfig" varStatus="itemStatus">
        <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(customerRelationConfig.businessElementId)" var="wdBusinessElement"/>
        <li>
            <label>${customerRelationConfig.elementName }：</label>
            <c:choose>
                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                    <wd:picList dataList="${wdPerson.getJsonData()[wdBusinessElement.key]}" />
                </c:when>
                <c:otherwise>
                   <p>${wdPerson.getJsonData()[wdBusinessElement.key] }</p>
                </c:otherwise>
            </c:choose>
        </li>
    </c:forEach>
    <c:forEach items="${config}" var="productConfig">
        <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(productConfig.businessElementId)" var="wdBusinessElement"/>
         <li>
            <label>${wdBusinessElement.name }：</label>
            <c:choose>
                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                   <wd:picList dataList="${wdApplicationRecognizor.getJsonData()[wdBusinessElement.key]}" />
                </c:when>
                <c:otherwise>
                    <p>${wdApplicationRecognizor.getJsonData()[wdBusinessElement.key] }</p>
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