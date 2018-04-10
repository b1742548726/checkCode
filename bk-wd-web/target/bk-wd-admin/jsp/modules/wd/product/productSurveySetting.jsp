<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<table class="wd-table table table-striped table-bordered sortable">
    <thead>
        <tr>
            <th> 名称 </th>
            <th style="width:100px;"> 是否必填 </th>
            <th style="width:188px;"> 选择项  </th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${elementList }" var="element">
           <c:if test="${element.required eq '1' || not empty element.settingId }">
             <tr elementid="${element.id }" itemsort="0">
                <td>
                    ${not empty element.elementName ? element.elementName: element.name }
                    <c:if test="${not empty element.remarks }">
                        - ${element.remarks}
                    </c:if>
                </td>
                <td>
                    <input type="checkbox" ${element.required eq '1' ? 'disabled' : ''} ${(element.required eq '1' || element.settingRequired eq '1') ? 'checked': ''} class="js-switch" />
                </td>
                <td>
                    <spring:eval expression="@wdBusinessElementService.selectByElementId(element.businessElementId)" var="selectLists"/>
                    <c:if test="${not empty selectLists}">
                        <select class="form-control">
                            <c:forEach items="${selectLists}" var="selectList">
                                <option value="${selectList.id }" ${element.elementSelectListId eq selectList.id ? 'selected' : '' }>${selectList.name }</option>
                            </c:forEach>
                        </select>
                    </c:if>
                </td>
            </tr>
          </c:if>
        </c:forEach>
    </tbody>
</table>