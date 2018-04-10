<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<c:set var="xpsPic" value="${imgStatic }/zwy/img/XPS.png"/>
<c:set var="htmlPic" value="${imgStatic }/zwy/img/HTML.png"/>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>征信资料-详情</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/credit_info.css" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/warning.css" rel="stylesheet">
<style type="text/css">
.txt {
    background: rgba(0, 0, 0, 0.56) !important;
}
</style>
</head>

<body>
    <div class="wd-content">
        <div class="left_info">
            <div class="credit_content">
                <h3>征信主体信息</h3>
                <div class="shop_info">
                    <ul class="credit_info">
                        <li>
                            <label for="">${wdApplicationCreditInvestigation.category eq '个人' ? '姓名' : '企业名称' }：</label>
                            <p>${wdApplicationCreditInvestigation.name}</p>
                        </li>
                        <c:if test="${wdApplicationCreditInvestigation.category eq '个人' }">
                            <li>
                                <label for="">身份证：</label>
                                <p>${wdApplicationCreditInvestigation.idCard}</p>
                            </li>
                        </c:if>
                        <li>
                            <label for="">与借款人关系：</label>
                            <p>${wdApplicationCreditInvestigation.relationType}</p>
                        </li>

                        <c:if test="${wdApplicationCreditInvestigation.remarks eq '征信查询已终止'}">
                            <li style="color: red;">
                                <label for="">终止原因：</label>
                                <p>${lastestComment.reason}${lastestComment.remarks}</p>
                            </li>
                        </c:if>
                        
                    </ul>
                    <div class="clearfix"></div>
                </div>
            </div>

            <div class="credit_content" style="min-height: 300px">
                <h3>征信授权书</h3>
                <div class="shop_info">
                    <ul class="credit_info imgList picbtn">
                        <li>
                            <img data-original="${imagesStatic }${wdApplicationCreditInvestigation.authorization}" src="${imagesStatic }${fns:choiceImgUrl('200X150', wdApplicationCreditInvestigation.authorization)}">
                            <div class="txt">授权书</div>
                        </li>
                        <c:choose>
                            <c:when test="${wdApplicationCreditInvestigation.category eq '个人' }">
                                <li>
                                    <img data-original="${imagesStatic }${wdApplicationCreditInvestigation.idCardFront}" src="${imagesStatic }${fns:choiceImgUrl('200X150', wdApplicationCreditInvestigation.idCardFront)}">
                                    <div class="txt">身份证正面</div>
                                </li>
                                <li>
                                    <img data-original="${imagesStatic }${wdApplicationCreditInvestigation.idCardBack}" src="${imagesStatic }${fns:choiceImgUrl('200X150', wdApplicationCreditInvestigation.idCardBack)}">
                                    <div class="txt">身份证背面</div>
                                </li>
                            </c:when>
                            <c:when test="${wdApplicationCreditInvestigation.category eq '企业' }">
                                <li>
                                    <img data-original="${imagesStatic }${wdApplicationCreditInvestigation.businessLicense}" src="${imagesStatic }${fns:choiceImgUrl('200X150', wdApplicationCreditInvestigation.businessLicense)}">
                                    <div class="txt">营业执照</div>
                                </li>
                            </c:when>
                        </c:choose>
                        <c:forEach items="${wdApplicationCreditInvestigationPhotoList }" var="photo">
                            <li>
                                <img data-original="${imagesStatic }${photo.photoUrl}" src="${imagesStatic }${fns:choiceImgUrl('200X150', photo.photoUrl)}">
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="clearfix"></div>
                </div>
            </div>
                <div class="credit_content">
                    <h3>征信结果</h3>
                    <div class="shop_info">
                        <ul class="credit_info">
                            <c:if test="${wdApplicationCreditInvestigation.category eq '个人' }">
                                <li>
                                    <label for="loanRecord">贷款信用记录：</label>
                                    <p>${wdApplicationCreditInvestigation.loanRecord }</p>
                                </li>
                                <c:forEach items="${configList }" var="wdProductSimpleModuleSetting">
                                   	<spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(wdProductSimpleModuleSetting.businessElementId)" var="wdBusinessElement"/>
                                   	<li>
	                                    <label for="creditCardRecord">${wdBusinessElement.name }：</label>
	                                    <p>${wdApplicationCreditInvestigation.getCreditDetailJson()[wdBusinessElement.key] }</p>
	                                </li>
                                </c:forEach>
                            </c:if>
                            <li>
                                <label for="result">征信结果：</label>
                                <p>${wdApplicationCreditInvestigation.result }</p>
                            </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
    
                <div class="credit_content">
                    <h3>征信结果照片</h3>
                    <div class="shop_info">
                        <ul class="credit_info imgList picbtn">
                            <c:forEach var="resultFile" items="${wdApplicationCreditInvestigation.getResultFileList() }">
                                <c:choose>
                                    <c:when test="${fns:isXpsFile(resultFile) }">
                                        <li class="xpsFile">
                                            <img src="${xpsPic } " class="xpsFile">
                                            <div class="txt">
                                                <a href="${imagesStatic }${resultFile }"><span class="delete">下载</span></a>
                                            </div>
                                        </li>
                                    </c:when>
                                    <c:when test="${fns:isHtmlFile(resultFile) }">
                                        <li class="xpsFile">
                                            <img src="${htmlPic } " class="xpsFile">
                                            <div class="txt">
                                                <a href="${imagesStatic }${resultFile }" target="_blank"><span class="delete" style="float:none;text-align:center;">查看</span></a>
                                            </div>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="_photo">
                                            <img src="${imagesStatic }${fns:choiceImgUrl('400X300', resultFile) }" data-original="${imagesStatic }${resultFile}">
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
              <!--   <ul class="credit_btn">
                    <li><button class="color4" onclick="javascript:history.back();">返回</button></li>
                </ul> -->
        </div>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>

<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script>
$(function(){
    $(".picbtn li img").click(function(){
    	if ($(this).hasClass("xpsFile")) {
    		return false;
    	}
    	var picUl = $(this).closest("ul").clone();
    	picUl.find("li.xpsFile").remove();
    	
		var _html = picUl.html();
		if(!_html.trim()) {
			alert("暂无图片")	
			return false;
		}
		
		var _li = $(this).closest("li");
    	var _index = _li.index("li._photo");
		picPreview(_html, _index);
	});
    
    if('${errorMess}'!=''){
		AlertMessage('${errorMess}');
	}
})

function picPreview(_html, _index) {
	var parentId = $(parent.window.document).find('#dowebok')
    parentId.html(_html)                            //数据传入父页面图片列表
    window.parent.viewInit()                        //调用父页面图片预览注册方法
    parentId.find('li:eq('+_index+') img').click()  //传入参数并触发预览
}
</script>
</body>
</html>