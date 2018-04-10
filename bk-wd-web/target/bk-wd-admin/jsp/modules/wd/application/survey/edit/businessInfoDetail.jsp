<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<ul id="new_${wdApplicationBusiness.id }">
    <c:forEach items="${config }" var="productConfig" varStatus="itemStatus">
        <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(productConfig.businessElementId)" var="wdBusinessElement"/>
        <li>
            <label for="">${wdBusinessElement.name }：</label>
            <p>
                ${wdApplicationBusiness.getJsonData()[wdBusinessElement.key] }
                <c:if test="${itemStatus.index == 0 }">
                    <span class="delete delBusinessInfo" data-id="${wdApplicationBusiness.id }"></span>
                    <span class="edit editBusinessInfo" data-id="${wdApplicationBusiness.id }"></span>
                </c:if>
            </p>
        </li>
    </c:forEach>
</ul>
<script>
$('#new_${wdApplicationBusiness.id } > li:nth-of-type(even)').each(function(){
    $(this).prev("li").append($(this).html());
    $(this).remove();
})
</script>