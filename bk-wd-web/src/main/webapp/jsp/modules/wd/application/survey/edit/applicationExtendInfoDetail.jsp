<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<ul class="new_view" id="application_extend_info_view">
    <c:forEach items="${config}" var="productConfig">
        <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(productConfig.businessElementId)" var="wdBusinessElement"/>
        <li><label for="">${wdBusinessElement.name }：</label><p>${wdApplicationExtendInfo.getJsonData()[wdBusinessElement.key] }</p></li>
    </c:forEach>
</ul>
<script>
$('ul.new_view > li:nth-of-type(even)').each(function(){
    $(this).prev("li").append($(this).html());
    $(this).remove();
})
</script>