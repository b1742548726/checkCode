<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<tr>
    <c:forEach items="${config }" var="customerCarConfig">
        <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(customerCarConfig.businessElementId)" var="wdBusinessElement"/>
        <td>
            <c:choose>
                <c:when test="${fns:getDataCategory(wdBusinessElement) == 1}">
                    <wd:picList dataList="${personAssetsCar.getJsonData()[wdBusinessElement.key]}" />
                </c:when>
                <c:otherwise>
                    ${personAssetsCar.getJsonData()[wdBusinessElement.key] }
                </c:otherwise>
            </c:choose>
        </td>
    </c:forEach>
<td>
    <span data-id="${personAssetsCar.id}" class="delete del-person_assets_car"></span>
    <span data-id="${personAssetsCar.id}" class="edit edit-person_assets_car"></span>
    </td>
</tr>