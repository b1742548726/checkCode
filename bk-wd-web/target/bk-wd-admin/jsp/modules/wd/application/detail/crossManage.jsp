<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>统计轨迹</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/overview.css" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/statistical_path.css" rel="stylesheet">
</head>
<body>
    <div class="wd-content" style="min-height:500px;">
        <div class="left_info">
            <div class="tab_content">
                <div class="shop_info">
                    <div class="content_top">
                        <div class="title">交叉管理</div>
                        <a href="${ctx}/wd/application/detail/crossManageMapModel?applicationId=${applicationId}" class="go_map">地图模式</a>
                    </div>
                    <ul>
                        <c:forEach items="${wdCustomerTrackList }" var="wdCustomerTrack">
                            <c:if test="${not empty wdCustomerTrack.photo}">
                                <li>
                                    <div class="list_info">
                                        <span class="date"></span>
                                    </div>
                                    <div class="list_content">
                                        <div class="picture">
                                            <h4>调查照片
                                                <c:if test="${ wdCustomerTrack.tag eq '1'}">
                                                    <img style="width:16px" src="${imgStatic }/zwy/LBQ/images/import8.png">
                                                </c:if>
                                            </h4>
                                            <ul class="pic_list">
                                                <c:forEach items="${productConfig['FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF']}" var="config">
                                                    <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(config.businessElementId)" var="wdBusinessElement"/>
                                                    <spring:eval expression="@wdApplicationPhotoService.selectByCategory(wdCustomerTrack.photo, wdBusinessElement.key)" var="photoList"/>
                                                    <c:if test="${photoList.size() > 0}">
                                                        <li>
                                                            <span class="name">${wdBusinessElement.name }</span>
                                                            <span class="num">${photoList.size() }</span>
                                                            <ul style="display: none;">
                                                                <c:forEach items="${photoList }" var="photo">
                                                                    <li><img alt="拍摄时间：<fmt:formatDate value="${photo.photoTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;拍摄地点：${photo.positionName }" data-original="${imagesStatic }${photo.photoUrl}" src="${imagesStatic }${fns:choiceImgUrl('520X390', photo.photoUrl)}"></li>
                                                                </c:forEach>
                                                            </ul>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                            </c:if>
                            <c:if test="${not empty wdCustomerTrack.createDate }">
                                <li>
                                    <div class="list_info">
                                        <span class="date"><fmt:formatDate value="${wdCustomerTrack.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                    </div>
                                    <i class="timePoint"></i>
                                    <div class="list_content">
                                        <h3>${wdCustomerTrack.title}</h3>
                                        <div class="content_r">
                                            <c:if test="${not empty wdCustomerTrack.content}">
                                                <pre style="margin-top: .1em">${wdCustomerTrack.content}</pre>
                                            </c:if>
                                            <c:if test="${not empty wdCustomerTrack.positionName}">
                                                <div class="position" data-position="${wdCustomerTrack.positionName}" data-lat="${wdCustomerTrack.positionLatitude}" data-lng="${wdCustomerTrack.positionLongitude}">
                                                    <img src="${imgStatic }/zwy/LBQ/images/position.png" alt="">
                                                    <p>${wdCustomerTrack.positionName}</p>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </li>
                            </c:if>
                            <c:if test="${not empty wdCustomerTrack.recordingList() }">
                                <c:forEach items="${wdCustomerTrack.recordingList()}" var="recordingInfo">
                                    <li>
                                        <div class="list_info">
                                            <span class="date">${recordingInfo.date}</span>
                                        </div>
                                        <i class="timePoint"></i>
                                        <div class="list_content">
                                            <h3>现场录音</h3>
                                            <div class="content_r">
                                                <div class="loudspeaker" data-time="${recordingInfo.date }">
                                                    <p>${recordingInfo.duration}</p>
                                                    <img src="${imgStatic }/zwy/LBQ/images/voice.jpg" alt="" class="voice">
                                                    <audio>
                                                       <source src="${imagesStatic }${recordingInfo.url}" />
                                                       <source src="${imgStatic }/zwy/LBQ/images/music.ogg" />
                                                                                                    你的浏览器不支持video标签。
                                                    </audio>
                                                </div>
                                                <div class="position" data-position="${recordingInfo.address}" data-lat="${recordingInfo.latitude}" data-lng="${recordingInfo.longitude}">
                                                    <img src="${imgStatic }/zwy/LBQ/images/position.png" alt="">
                                                    <p>${recordingInfo.address}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <!-- <div class="clearfix"></div> -->
    </div>

    <div class="media-wrapper">
        <h2>录音时间：<span id="media-time">2017月1月1日 12:23:44</span> <i class="audio_close"></i></h2>
        <audio id="player" preload="load" controls>
            <source src="">
        </audio>
    </div>

<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/zwy/LBQ/js/iframeFix.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script>
$(function(){
	//图片预览
	$('ul.pic_list').on('click','li',function(){
        var parentId = $(parent.window.document).find('#dowebok')
        var _html = $(this).find("ul").html();
        parentId.html(_html)                            //数据传入父页面图片列表
        window.parent.viewInit()                        //调用父页面图片预览注册方法
        parentId.find('li:eq(0) img').click()  //传入参数并触发预览
    })
	
	// 地图展示
	$(".position").click(function(){
		var _position = $(this).data("position");
		var _lng = $(this).data("lng");
		var _lat = $(this).data("lat");
		OpenIFrame("查看地址","${ctx}/wd/customer/positionView?lng=" + _lng + "&lat=" + _lat + "&position=" + _position, 1000, 600);
	});
    
    //mp3播放控制
    $('.loudspeaker').on('click',function(){
        var url = $(this).find('audio').find('source').prop('src')
        $('.media-wrapper').show()
        var audio = document.getElementById("player");
        if (audio != null && audio.canPlayType && audio.canPlayType("audio/mpeg")){
            audio.src = url;
            $("#media-time").html($(this).data("time"))
            audio.play();
        }
    })
    $('.audio_close').on('click',function(){
        $('#player')[0].pause()
        $('.media-wrapper').hide()
        $('#player source').prop('src','')
    })

    //关闭、驳回、审批
    $("#closeCurrentWindow").on("click", function(){
        location.href = "${app_detail_back_url}";
    })
    $("#pass_btn").on("click", function(){
        OpenIFrame("通过审批", "${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Pass", 1000, 500, function(){
            if (GetLayerData("close_review_view")) {
                SetLayerData("close_review_view", false);
                location.href = "${app_detail_back_url}";
            }
        });
    });
    $("#reject_btn").on("click", function(){
        OpenIFrame("审批拒绝", "${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Reject", 1000, 500, function(){
            if (GetLayerData("close_review_view")) {
                SetLayerData("close_review_view", false);
                location.href = "${app_detail_back_url}";
            }
        });
    });
    $("#return_btn").on("click", function(){
        OpenIFrame("审批驳回", "${ctx}/wd/application/detail/reviewView?applicationId=${applicationId}&taskId=${appTaskId}&action=Return", 1000, 500, function(){
            if (GetLayerData("close_review_view")) {
                SetLayerData("close_review_view", false);
                location.href = "${app_detail_back_url}";
            }
        });
    });
})
</script>
</body>
</html>