<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<table class="wd-table table table-striped table-bordered" id="customer-type-setting">
    <thead>
        <tr>
            <th> 业务元件 </th>
            <th style="width:100px;"> 是否必填 </th>
            <th style="width:168px;"> 选择项 </th>
            <th style="width:100px;"></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${customerTypeSettingList}" var="customerTypeSetting">
            <c:if test="${customerTypeSetting.businessElementId eq element.id and customerTypeSetting.defaultSimpleModuleId eq element.moduleId }">
                <c:set var="category" value="${customerTypeSetting.category }"></c:set>
            </c:if>
            <tr settingid="${customerTypeSetting.id }" elementid="${customerTypeSetting.businessElementId }" moduleId="${customerTypeSetting.defaultSimpleModuleId }" itemsort='${customerTypeSetting.sortMobile }'>
                <td>
                    ${customerTypeSetting.elementName }
                </td>
                <td>
                    <input type="checkbox" ${customerTypeSetting.required eq '1' ? 'checked': ''} class="js-switch" />
                </td>
                <td>
                    <spring:eval expression="@wdBusinessElementService.selectByElementId(customerTypeSetting.businessElementId)" var="selectLists"/>
                    <c:if test="${not empty selectLists}">
                        <select class="form-control">
                            <option value="">-- 请选择 --</option>
                            <c:forEach items="${selectLists}" var="selectList">
                                <option value="${selectList.id }" ${customerTypeSetting.elementSelectListId eq selectList.id ? 'selected' : '' }>${selectList.name }</option>
                            </c:forEach>
                        </select>
                    </c:if>
                </td>
                <td class="cursor-default">
                    <button type="button" class="btn wd-btn-small wd-btn-orange btn-del-item" itemid="${customerTypeSetting.id }">删除</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
    <script type="text/javascript">
		var customerTypeSettingList = ${fns:toJsonString(customerTypeSettingList)};
		loadShowList(customerTypeSettingList);
	</script>
</table>
