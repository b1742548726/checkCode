<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>调查图片</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/investigation.css" rel="stylesheet">
</head>

<body>
    <div class="investwrap">
        <!--  <ul class="picList">
            <li><img src="images/temp/tibet-1.jpg" alt="图片1"></li>
            <li><img src="images/temp/tibet-2.jpg" alt="图片2"></li>
            <li><img src="images/temp/tibet-3.jpg" alt="图片3"></li>
            <li><img src="images/temp/tibet-4.jpg" alt="图片4"></li>
            <li><img src="images/temp/tibet-5.jpg" alt="图片5"></li>
            <li><img src="images/temp/tibet-6.jpg" alt="图片6"></li>
        </ul> -->
        <c:forEach items="${productConfig['FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF']}" var="config">
            <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(config.businessElementId)" var="wdBusinessElement"/>
            <ul class="picList">
                <c:forEach items="${surveyPhotoList}" var="surveyPhoto">
                    <c:if test="${surveyPhoto.category eq wdBusinessElement.key }">
                        <c:if test="${not empty fns:choiceImgUrl('520X390', surveyPhoto.photoUrl) }">
                            <li><img data-original="${imagesStatic }${surveyPhoto.photoUrl}" src="${imagesStatic }${fns:choiceImgUrl('520X390', surveyPhoto.photoUrl)}"></li>
                        </c:if>
                    </c:if>
                </c:forEach>
            </ul>
        </c:forEach>

        <div class="menu">
            <ul>
               <!--  <li><a href="javascript:;"><p>信贷系统及法院执行网</p><span>32</span></a></li> -->
                <c:forEach items="${productConfig['FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF']}" var="config">
                    <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(config.businessElementId)" var="wdBusinessElement"/>
                    <spring:eval expression="@wdApplicationPhotoService.selectByCategory(surveyPhotoList, wdBusinessElement.key)" var="photoList"/>
                    <li><a href="javascript:;"><p>${wdBusinessElement.name }</p><span>${photoList.size() }</span></a></li>
                </c:forEach>
            </ul>
        </div>

        <div class="clearfix"></div>
    </div>

<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/zwy/LBQ/js/iframeFix.js"></script>

<script>
$(function(){
    $('.picList').on('click','li',function(){
        var parentId = $(parent.window.document).find('#dowebok')
        var _index = $(this).index()
        var _html = $(this).parent().html()
        parentId.html(_html)                            //数据传入父页面图片列表
        window.parent.viewInit()                        //调用父页面图片预览注册方法
        parentId.find('li:eq('+_index+') img').click()  //传入参数并触发预览
    })

    //切换图片组
    $('.menu').on('click','ul li',function(){
        $(this).addClass('cur').siblings().removeClass('cur')
        var _index = $(this).index()
        $('.picList').eq(_index).show().siblings('.picList').hide()
    })
     $('.menu ul li:eq(0)').click();
    var _height = $('.menu').height()
    $('.investwrap').css('min-height',_height + 40)
})
</script>
</body>
</html>