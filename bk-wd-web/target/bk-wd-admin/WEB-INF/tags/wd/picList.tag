<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<%@ attribute name="dataList" type="java.util.List" required="false" description="照片列表"%>
<c:choose>
    <c:when test="${not empty dataList }">
        <P><button class="color1 picbtn">查看照片</button></P>
        <ul class="picList" style="display: none">
            <c:forEach items="${dataList}" var="pic">
               <c:if test="${not empty fns:choiceImgUrl('80X100', pic) }">
                    <li><img data-size="${dataList.size() }" data-original="${imagesStatic }${pic}" src="${imagesStatic }${fns:choiceImgUrl('80X100', pic)}" /></li>
               </c:if>
            </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        <P><button class="color4">无照片</button></P>
    </c:otherwise>
</c:choose>