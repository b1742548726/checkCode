<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE HTML>
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
<style type="text/css">
.wa-se-st-single-video-zhanzhang-play {
    position: absolute;
    height: 40px;
    width: 40px;
    top: 77px;
    left: 100px;
    margin: -20px 0 0 -20px;
    background: url(${imgStatic }/zwy/img/play.png) no-repeat;
    background-size: 40px 40px;
}
li {
    position: relative;
}
</style>
</head>

<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2> 签约双录 </h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-white wd-btn-width-middle btn-back" id="btn-add-element">返回</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <c:set var="LastDualNote" value="${dualNoteList.get(dualNoteList.size()-1) }"/>
                <spring:eval expression="@sysUserService.selectByPrimaryKey(LastDualNote.createBy)" var="createBy"/>
                <p>签约时间：<fmt:formatDate value="${LastDualNote.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                <p>操作人:${createBy.name }</p>
                <div class="investwrap">
                     <ul class="picList" style="width: 100%;">
                        <c:forEach items="${dualNoteList }" var="data">
                                <c:choose>
                                    <c:when test="${not empty data.fileFristPhoto }">
                                        <li class="_voice" data-videourl="${data.fileUrl}" data-firsturl="${data.fileFristPhoto}">
                                            <img class="_voice" src="${imagesStatic }${fns:choiceImgUrl('520X390', data.fileFristPhoto)}" data-original="${imagesStatic }${data.fileFristPhoto}" >
                                            <span class="wa-se-st-single-video-zhanzhang-play"></span>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="_img">
                                            <img src="${imagesStatic }${fns:choiceImgUrl('520X390', data.fileUrl)}" data-original="${imagesStatic }${data.fileUrl}">
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                        </c:forEach>
                    </ul>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    

<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/zwy/LBQ/js/iframeFix.js"></script>
 <!-- Layer -->
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script>
$(function(){
	$('.picList').on('click','li._voice',function(){
		window.open("${ctx}/wd/customer/videoPlay?videoUrl=" + $(this).data("videourl"));   
		//OpenFullIFrame("查看录像", "${ctx}/wd/customer/videoPlay?videoUrl=" + $(this).data("videourl"));
	});
	
    $('.picList').on('click','li._img',function(){
        var parentId = $(parent.window.document).find('#dowebok')
        var _index = $(this).index()
        var _html = $(this).parent().find("li._img").clone();
        parentId.html(_html)                            //数据传入父页面图片列表
        window.parent.viewInit()                        //调用父页面图片预览注册方法
        parentId.find('li:eq(0) img').click()  //传入参数并触发预览
    })

    //切换图片组
    $('.menu').on('click','ul li',function(){
        $(this).addClass('cur').siblings().removeClass('cur')
        var _index = $(this).index()
        $('.picList').eq(_index).show().siblings('.picList').hide()
    })
     $('.menu ul li:eq(0)').click();
    var _height = $('.menu').height()
    $('.investwrap').css('min-height',_height + 40);
    
    $(".btn-back").on("click", function(){
    	history.back();
    });
})
</script>
</body>
</html>