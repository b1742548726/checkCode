<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<tr>
    <c:forEach items="${config }" var="customerBuildingConfig">
        <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(customerBuildingConfig.businessElementId)" var="wdBusinessElement"/>
        <td>
            <c:choose>
                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                    <wd:picList dataList="${personAssetsBuilding.getJsonData()[wdBusinessElement.key]}" />
                </c:when>
                <c:otherwise>
                    ${personAssetsBuilding.getJsonData()[wdBusinessElement.key] }
                </c:otherwise>
            </c:choose>
        </td>
    </c:forEach>
    <td>
        <span data-id="${personAssetsBuilding.id}" class="delete del-person_assets_building"></span>
        <span data-id="${personAssetsBuilding.id}" class="edit edit-person_assets_building"></span>
    </td>
</tr>