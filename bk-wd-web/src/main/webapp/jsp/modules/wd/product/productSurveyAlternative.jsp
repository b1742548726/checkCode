<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<c:forEach items="${elementList }" var="element">
    <li moduleid="${element.id}" elementid="${element.id}">
        <span> 
            ${element.name} 
            <c:if test="${not empty element.remarks }">
               - ${element.remarks}
            </c:if>
         </span>
        <div style="float:right!important;">
            <input type="checkbox" ${element.required eq '1' ? 'disabled' : ''} ${(element.required eq '1' || not empty element.settingId)  ? 'checked' : ''} class="flat" />
        </div>
        <spring:eval expression="@wdBusinessElementService.selectByElementId(element.businessElementId)" var="selectLists"/>
        <c:if test="${not empty selectLists}">
            <div class="div-element-select-list">
                <select class="form-control">
                    <c:forEach items="${selectLists}" var="selectList">
                        <option value="${selectList.id }">${selectList.name }</option>
                    </c:forEach>
                </select>
            </div>
        </c:if>
    </li>
</c:forEach>