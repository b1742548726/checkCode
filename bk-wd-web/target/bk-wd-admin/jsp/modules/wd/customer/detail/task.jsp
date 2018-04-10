<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>客户详情</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/client_detail.css" rel="stylesheet">
<link rel="stylesheet" href="${imgStatic }/zwy/LBQ/css/viewer.min.css">
<style>
* { margin: 0; padding: 0;}
</style>
</head>

<body>
    <div class="wd-content">
        <div class="left_info">
            <div class="client_deatil_top">
                <a href="javascript:;" class="back">返&nbsp;&nbsp;回</a>
                <c:set var="hasRisk" value="false"/>
                <div class="risk_notice">
                    <spring:eval expression="@wdPersonService.hasRisk(wdCustomer.personId, 'zhixin')" var="hasZhixin" />
                    <spring:eval expression="@wdPersonService.hasRisk(wdCustomer.personId, 'shixin')" var="hasShixin" />
                    <spring:eval expression="@wdCustomerBacklistService.selectBackByCustomerId(wdCustomer.id)" var="backlist"/>
                    <c:choose>
                        <c:when test="${hasZhixin or hasShixin or not empty backlist }">
                            <img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png" alt="">
                            <c:set var="hasRisk" value="true"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${imgStatic }/zwy/LBQ/images/icn_gray_s_risk.png" alt="">
                        </c:otherwise>
                    </c:choose>
                    <p>
                        <c:choose>
                            <c:when test="${hasZhixin or hasShixin or not empty backlist }">
                                <span >风险提示：</span>
                                <c:if test="${not empty backlist }">
                                                                 黑名单客户，
                                </c:if>
                                <c:if test="${hasZhixin }">
                                                                被执行人，
                                </c:if>
                                <c:if test="${hasShixin }">
                                                                失信被执行人，
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <span style="color:#ccc">风险提示：</span>无风险
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>

            <ul class="client_detail_tab">
                <li><a href="${ctx }/wd/customer/detail/index?customerId=${wdCustomer.id}">客户信息</a></li>
                <li><a href="${ctx }/wd/customer/riskWarning?customerId=${wdCustomer.id}">
                    <c:if test="${hasRisk}">
                        <img src="${imgStatic }/zwy/LBQ/images/icn_red_risk.png" alt="" class="tab_risk">
                    </c:if>风险提示</a></li>
                <li class="cur"><a href="javascript:void(0);">客户动态</a></li>
            </ul>
        </div>

        <div class="right_list">
            <ul>
                <c:forEach items="${wdCustomerTrackList}" var="wdCustomerTrack">
                    <li>
                        <div class="list_info">
                            <span class="date" style="padding:0"><fmt:formatDate value="${wdCustomerTrack.createDate}" pattern="MM-dd"/></span>
                            <spring:eval expression="@sysUserService.selectByPrimaryKey(wdCustomerTrack.createBy)" var="user"/>
                            <p>${user.name}</p>
                        </div>
                        <i class="timePoint"></i>
                        <div class="list_content">
                            <h3>${wdCustomerTrack.title}</h3>
                            <c:if test="${not empty wdCustomerTrack.contactWay }">
                                <pre>跟进方式：${wdCustomerTrack.contactWay }</pre>
                            </c:if>
                            <c:if test="${not empty wdCustomerTrack.tag }">
                                <pre>跟进结果：${wdCustomerTrack.tag }</pre>
                            </c:if>
                            <pre class="content">${wdCustomerTrack.content}</pre>
                            <c:if test="${not empty wdCustomerTrack.photoList()}">
                                <ul class="stark_picList">
                                    <c:forEach items="${wdCustomerTrack.photoList()}" var="pic" varStatus="picStatus">
                                       <c:if test="${not empty fns:choiceImgUrl('200X150', pic) }">
                                            <li data-prop="${picStatus.index }"><img data-original="${imagesStatic }${pic}" src="${imagesStatic }${fns:choiceImgUrl('200X150', pic)}"></li>
                                       </c:if>
                                    </c:forEach>
                                </ul>
                            </c:if>
                            <c:if test="${not empty wdCustomerTrack.recording}">
                                <div class="loudspeaker"  style="margin:0 0 20px 0" >
                                    <p>${wdCustomerTrack.recordingLength }</p>
                                    <img src="${imgStatic }/zwy/LBQ/images/voice.jpg" alt="" class="voice">
                                    <audio>
                                       <source src="${imagesStatic }${wdCustomerTrack.recording}" />
                                       <source src="${imgStatic }/zwy/LBQ/images/music.ogg" />
                                                                        你的浏览器不支持video标签。
                                    </audio>
                                </div>
                            </c:if>
                            <c:if test="${not empty wdCustomerTrack.positionName}">
                                <div class="position" data-position="${wdCustomerTrack.positionName}" data-lat="${wdCustomerTrack.positionLatitude}" data-lng="${wdCustomerTrack.positionLongitude}">
                                    <img src="${imgStatic }/zwy/LBQ/images/position.png" alt="">
                                    <p>${wdCustomerTrack.positionName}</p>
                                </div>
                            </c:if>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <div class="clearfix"></div>
        </div>

        <div class="clearfix"></div>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script src="${imgStatic }/zwy/LBQ/js/viewer-jquery.min.js"></script>
<script>
$(function() {
	$(".back").on("click", function(){
		location.href = "${customer_detail_back_url}";
	})
	$(".stark_picList img").click(function(){
		var _picList = $(this).closest("ul.stark_picList");
		var _html = _picList.html();
		if(!_html || !_html.trim()) {
			return false;
		}
		var _li = _picList.find("li[data-prop="+ $(this).parent().data("prop") + "]");
		var _index = _li.index();
		picPreview(_html, _index);
	});
	$(".position").click(function(){
		var _position = $(this).data("position");
		var _lng = $(this).data("lng");
		var _lat = $(this).data("lat");
		OpenIFrame("查看地址","${ctx}/wd/customer/positionView?lng=" + _lng + "&lat=" + _lat + "&position=" + _position, 1000, 600);
	});
	
	function picPreview(_html, _index) {
		var parentId = $(parent.window.document).find('#dowebok')
        parentId.html(_html)                            //数据传入父页面图片列表
        window.parent.viewInit()                        //调用父页面图片预览注册方法
        parentId.find('li:eq('+_index+') img').click()  //传入参数并触发预览
	}
	
    //计算个人信息和图片栏目高度
    var _amount = $('.personal_top').height(),
    _clientInfo = $('#client_info_list').height(),
    _idCard = $('#id_card').height()

    if(_idCard > _clientInfo){
        $('.personal_top').height(_idCard)
        $('#client_info .innerHtml').height(_idCard)
    }else{
        $('.personal_top').height(_clientInfo + 60)
        $('#client_info_list').parent('.innerHtml').css('height',_clientInfo + 60)
        $('#id_card .innerHtml').height(_clientInfo + 60)
    }

    //计算iframe内部高度
    var list_height = $('.right_list').height()
    var content_height = $('.wd-content').height()
    if(list_height > content_height){
        $('.wd-content').css('height',list_height + 20)
    }

    //mp3播放控制
    $('.loudspeaker').on('click',function(){
        if($(this).find('audio')[0].paused){
            $('audio').each(function(){
                $(this)[0].pause()
                $(this).prev().prop('src','${imgStatic }/zwy/LBQ/images/voice.jpg')
            })
            $(this).find('audio')[0].play()
            $(this).find('audio').prev().prop('src','${imgStatic }/zwy/LBQ/images/play.gif')
        }else{
            $(this).find('audio')[0].pause()
            $(this).find('audio').prev().prop('src','${imgStatic }/zwy/LBQ/images/voice.jpg')
        }
    })
    $('audio').on('ended',function(){
        flag = true
        $(this).prev().prop('src','${imgStatic }/zwy/LBQ/images/voice.jpg')
    })
});
</script>
</body>
</html>