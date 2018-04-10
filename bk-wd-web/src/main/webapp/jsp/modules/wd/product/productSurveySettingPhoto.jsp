<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<table class="wd-table table table-striped table-bordered sortable">
    <thead>
        <tr>
            <th> 图片组名称 </th>
            <th style="width:100px;"> 是否必填 </th>
            <th style="width:100px;"> 照片最大数 </th>
            <th style="width:188px;"> 是否允许相册选取 </th>
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
                    <input name="required" type="checkbox" ${element.required eq '1' ? 'disabled' : ''} ${(element.required eq '1' || element.settingRequired eq '1') ? 'checked': ''} class="js-switch" />
                </td>
                <td>
                   <input type="text" class="form-control" value=" ${element.maxLength }" />
                </td>
                <td>
                    <input name="album" type="checkbox" ${element.album eq '1'? 'checked': ''} class="js-switch" />
                </td>
            </tr>
          </c:if>
        </c:forEach>
    </tbody>
</table>