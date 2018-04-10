<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<%@ attribute name="required" type="java.lang.Boolean" required="false" description="是否必选"%>
<%@ attribute name="defValue" type="java.lang.String" required="false" description="默认值"%>
<%@ attribute name="elementSelectListId" type="java.lang.String" required="false" description="选择项"%>
<%@ attribute name="wdBusinessElement" type="com.bk.wd.model.WdBusinessElement" required="true" description="业务原件"%>
<div class="form-group">
    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="${wdBusinessElement.key }">
    	${wdBusinessElement.name }<span class="required"></span>
    </label>
    <div class="col-md-6 col-sm-6 col-xs-12">
        <c:choose>
            <c:when test="${wdBusinessElement.baseElementId eq 'text_field' or wdBusinessElement.baseElementId eq 'stack_text_field' or wdBusinessElement.baseElementId eq 'text_view_and_select'}">
                <input type="text" name="${wdBusinessElement.key }" ${(not empty required and required == true) ? 'required' : ''} value="${defValue }" class="form-control col-md-8 col-xs-12" data-regularexpression="${wdBusinessElement.regularExpression }" data-errormessage="${wdBusinessElement.errorMessage }">
            </c:when>
            <c:when test="${wdBusinessElement.baseElementId eq 'text_view' or wdBusinessElement.baseElementId eq 'stack_text_view'}">
                <textarea style="width:60%" name="${wdBusinessElement.key }" class="form-control2 col-md-8 col-xs-12" rows="10">${defValue }</textarea>
            </c:when>
            <c:when test="${wdBusinessElement.baseElementId eq 'single_select' or wdBusinessElement.baseElementId eq 'stack_single_select'}">
                <spring:eval expression="@wdSelectGroupService.getSelectGroupDefault(wdBusinessElement.selectGroupId)" var="defSelectItemId" />
                <select class="form-control" name="${wdBusinessElement.key }" ${(not empty required and required == true) ? 'required' : ''}>
                    <option value="">请选择</option>
                    <c:set var="selectListId" value="${not empty elementSelectListId ? elementSelectListId : defSelectItemId}" />
                    <c:if test="${not empty selectListId}">
                        <spring:eval expression="@wdSelectItemService.selectByListId(selectListId)" var="itemList" />
                        <c:forEach items="${itemList }" var="item">
                            <option value="${item.name }" ${item.name eq defValue ? 'selected' : ''}>${item.name }</option>
                        </c:forEach>
                    </c:if>
                </select>
            </c:when>
            <c:otherwise>
                <span style="position: absolute;font-size: 13px;margin-top: 9px; color: #aaaaaa;">仅支持手机端录入</span>
                <input type="hidden" name="${wdBusinessElement.key }" value='${defValue }'>
            </c:otherwise>
        </c:choose>
        <c:if test="${(not empty required and required == true) }">
            <div class="warning hide">
                <ins class="import"></ins>
                <span class="hide"><i>不能为空</i></span>
            </div>
        </c:if>
    </div>
</div>
