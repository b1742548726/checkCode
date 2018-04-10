<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<title>统计轨迹</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/overview.css" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/statistical_path.css" rel="stylesheet">
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
<body style="height: 100%; width:100%;">
    <a href="javascript:history.back();" class="btn" style="position: absolute; z-index: 99; top: 1em;left: 5em; background-color: #777; min-width: 7em;">返   回</a>
    <div class="wd-content" id="gaodeMaps" style="height: 100%; width:100%;">
    </div>
    <ul id="picList" style="display: none;">
    </ul>
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

<script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
<script src="http://webapi.amap.com/maps?v=1.3&key=5f59e03fa5387535c91aa6ad6984e950&plugin=AMap.MarkerClusterer,AMap.ToolBar,AMap.AdvancedInfoWindow"></script>
<script src="http://cache.amap.com/lbs/static/addToolbar.js" type="text/javascript"></script>
<script>
var markers = [], photoMarkers = [], recordMarkers = [], signMarkers = [], personInfoMarkers = [];
// 调查照片
<c:forEach items="${wdApplicationPhotoList }" var="wdApplicationPhoto">
	if ("${wdApplicationPhoto.positionLongitude}" && "${wdApplicationPhoto.positionLatitude}") {
		photoMarkers.push(new AMap.Marker({
	        position:["${wdApplicationPhoto.positionLongitude}", "${wdApplicationPhoto.positionLatitude}"],
	        content: '<div style="color: #FFFFFF; height: 31px; width: 60px; padding-top: 2px; text-align: center; background-image: url(${imgStatic }/zwy/img/position/rectangle.png)">1张</div>',
        	extData: {
        		"liDom" : '<li><img alt="拍摄时间：<fmt:formatDate value="${wdApplicationPhoto.photoTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;拍摄地点：${wdApplicationPhoto.positionName }" data-original="${imagesStatic }${wdApplicationPhoto.photoUrl}" src="${imagesStatic }${wdApplicationPhoto.photoUrl}"></li>'
        	}
	    }));
	}
</c:forEach>

function createSignMarkers(startPoint, endPoit) {
	var startMaker = new AMap.Marker({
        position:[startPoint.lng, startPoint.lat],
        title: ("签到：" + startPoint.date + startPoint.address),
        icon: new AMap.Icon({
        	image : "${imgStatic }/zwy/img/position/flag.png"
        })
    })
    var endMaker = new AMap.Marker({
    	position:[endPoit.lng, endPoit.lat],
        title: ("签退：" + endPoit.date + endPoit.address),
        icon: new AMap.Icon({
        	image : "${imgStatic }/zwy/img/position/flagout.png"
        })
    })
	
    startMaker.on("click", function (){
    	var infoWindow = new AMap.InfoWindow({
   		 	offset: new AMap.Pixel(0, -30),
   		 	content: ("<b>签到</b><br/>" + startPoint.date + "<br/>" + startPoint.address)
		});
   	 	infoWindow.open(map, startMaker.getPosition());
   	 	
   	 	var polyline = new AMap.Polyline({
             path: [startMaker.getPosition(), endMaker.getPosition()],    //设置线覆盖物路径
             strokeColor: "#555", //线颜色
             strokeOpacity: 1,       //线透明度
             strokeWeight: 2,        //线宽
             strokeStyle: "solid"  //线样式
         });
         polyline.setMap(map);
   	 	
    })
    endMaker.on("click", function (){
    	var infoWindow = new AMap.InfoWindow({
   		 	offset: new AMap.Pixel(0, -30),
   		 	content: ("<b>签退</b><br/>" + endPoit.date + "<br/>" + endPoit.address)
		});
    	
    	var polyline = new AMap.Polyline({
            path: [startMaker.getPosition(), endMaker.getPosition()],    //设置线覆盖物路径
            strokeColor: "#555", //线颜色
            strokeOpacity: 1,       //线透明度
            strokeWeight: 2,        //线宽
            strokeStyle: "solid",   //线样式
        });
        polyline.setMap(map);
   	 	infoWindow.open(map, endMaker.getPosition());
    })
	signMarkers.push(startMaker);
	signMarkers.push(endMaker);
}

function createVoiceMarker(point, voiceUrl, startTime, timeLength) {
	var voiceMarker = new AMap.Marker({
        position: point,
        title: "录音：" + startTime,
        extData: {
        	url : voiceUrl,
        	startTime : startTime,
        	timeLength : timeLength
        },
        icon: new AMap.Icon({
        	image : "${imgStatic }/zwy/img/position/voice.png",
        	size : new AMap.Size(60,31)
        })
    }).on("click", function(e){
    	var url = voiceUrl;
        $('.media-wrapper').show()
        var audio = document.getElementById("player");
        if (audio != null && audio.canPlayType && audio.canPlayType("audio/mpeg")){
            audio.src = url;
            $("#media-time").html(startTime)
            audio.play();
        }
    });
	recordMarkers.push(voiceMarker);
}

 // 现场调查
<c:forEach items="${wdApplicationSurveySiteList }" var="wdApplicationSurveySite">
	createSignMarkers({
		lat: "${wdApplicationSurveySite.startLatitude}",
		lng: "${wdApplicationSurveySite.startLongitude}",
		address: "${wdApplicationSurveySite.startAddress}",
		date : '<fmt:formatDate value="${wdApplicationSurveySite.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
	},{
		lat: "${wdApplicationSurveySite.endLatitude}",
		lng: "${wdApplicationSurveySite.endLongitude}",
		address: "${wdApplicationSurveySite.endAddress}",
		date : '<fmt:formatDate value="${wdApplicationSurveySite.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
	});
	//录音
	<c:forEach items="${wdApplicationSurveySite.recordingList()}" var="recordingInfo">
		if ("${recordingInfo.longitude}" && "${recordingInfo.latitude}") {
    		createVoiceMarker(["${recordingInfo.longitude}", "${recordingInfo.latitude}"], "${imagesStatic }${recordingInfo.url}", "${recordingInfo.date}");
		}
    </c:forEach>
</c:forEach>

function addressConventToLatlng(address, city, callback, type) {
	$.ajax({
	    type: "GET",
	    url: "http://restapi.amap.com/v3/place/text",
	 //   dataType: "jsonp",
	    async: false,
	    data: {key: "8fd670990effe7ab88ab7e3e8f7aac94", keywords: address, output: "JSON", city: city, offset : 1, page :1, extensions: "base", children : 1},
	  //  jsonp: "jsoncallback",
	   // jsonpCallback: "getLatlng",
	    success: function (data) {
	    	if (data.pois && data.status == 1) {
	    		callback([data.pois[0].location.split(",")[0], data.pois[0].location.split(",")[1]], address, type);
	    	}
	    }
	})
}

function crateBaseMarker(data, address, type) {
	var _awesome_marker = new AMap.Marker({
        position: data,
        title: (type + " : " + address)
    }).on("click", function(){
    	 var infoWindow = new AMap.InfoWindow({
    		 offset: new AMap.Pixel(0, -30),
    		 content: type +  "<br />" + address,
		 })
    	 infoWindow.open(map, _awesome_marker.getPosition());
   	});
	personInfoMarkers.push(_awesome_marker);
}

<c:if test="${not empty wdPerson.getJsonData().base_info_shop_addr}">
	addressConventToLatlng("${wdPerson.getJsonData().base_info_shop_addr}", "${cityName}", crateBaseMarker, "门店地址");
</c:if>

<c:if test="${not empty wdPerson.getJsonData().base_info_home_addr}">
	addressConventToLatlng("${wdPerson.getJsonData().base_info_home_addr}", "${cityName}", crateBaseMarker, "家庭地址");
</c:if>

<c:if test="${not empty wdPerson.getJsonData().base_info_company_addr}">
	addressConventToLatlng("${wdPerson.getJsonData().base_info_company_addr}", "${cityName}", crateBaseMarker, "单位地址");
</c:if> 

markers = photoMarkers.concat(signMarkers).concat(recordMarkers).concat(personInfoMarkers);

var _renderCluserMarker = function (context) {
	if (!context) {
		return;
	}
    var count  = markers.length;
    var factor = Math.pow((context.count / count), (1 / 18))
    var div = document.createElement('div');
    var Hue = 180 - factor* 180;
    var bgColor = 'hsla('+Hue+',100%,50%,0.7)';
    var fontColor = 'hsla('+Hue+',100%,20%,1)';
    var borderColor = 'hsla('+Hue+',100%,40%,1)';
    var shadowColor = 'hsla('+Hue+',100%,50%,1)';
    div.style.backgroundColor = bgColor
    var size = Math.round(30 + Math.pow((context.count/count) , (1/5)) * 20);
    div.style.width = div.style.height = size+'px';
    div.style.border = 'solid 1px '+ borderColor;
    div.style.borderRadius = size/2 + 'px';
    div.style.boxShadow = '0 0 1px '+ shadowColor;
    div.innerHTML = context.count;
    div.style.lineHeight = size+'px';
    div.style.color = fontColor;
    div.style.fontSize = '14px';
    div.style.textAlign = 'center';
    context.marker.setOffset(new AMap.Pixel((-size/2),(-size/2)));
    context.marker.setContent(div)
}

var _cluserMarker = function (context) {
	if (!context) {
		return;
	}
	var div = document.createElement('div');
	div.style.backgroundImage = "url(${imgStatic }/zwy/img/position/rectangle.png)";
	div.style.color = "#FFFFFF";
	div.style.width = '60px';
	div.style.height = '31px';
	div.style.paddingTop = '2px';
	div.style.textAlign = 'center';
	div.innerHTML = context.count + "张";
	context.marker.setContent(div);
}

var cluster, map = new AMap.Map("gaodeMaps", {
    resizeEnable: true,
    zoom: 12
})

map.on("zoomchange", function (e) {
	cluster.clearMarkers();
	map.clearMap();
	if (map.getZoom() <= 13) {
		cluster = new AMap.MarkerClusterer(map, markers, {
		    gridSize:80,
		    maxZoom : 13,
		    renderCluserMarker:_renderCluserMarker
		});
	} else {
	    cluster = new AMap.MarkerClusterer(map, photoMarkers, {
		    gridSize:80,
          	renderCluserMarker:_cluserMarker
		}).on("click", function(e){
			//图片预览
			var _$picList = $("#picList").empty();
			$.each(e.markers, function(index, item){
				_$picList.append(item.getExtData().liDom)
			})
			var parentId = $(parent.window.document).find('#dowebok')
            var _html = _$picList.html();
            parentId.html(_html)                            //数据传入父页面图片列表
            window.parent.viewInit()                        //调用父页面图片预览注册方法
            parentId.find('li:eq(0) img').click()  //传入参数并触发预览
		});
		
		$.each(personInfoMarkers, function(index, item){
			item.setMap(map);
		})
		
		$.each(signMarkers, function(index, item){
			item.setMap(map);
		})
		
		$.each(recordMarkers, function(index, item){
			item.setMap(map);
		})
	}
});

$(function(){
	addressConventToLatlng("${cityName}", "${cityName}", function(data){
		map.setCenter(data);
	});
    cluster = new AMap.MarkerClusterer(map, markers, {
	    gridSize:80,
	    maxZoom : 15,
	    renderCluserMarker:_renderCluserMarker
	});
    
    $('.audio_close').on('click',function(){
        $('#player')[0].pause()
        $('.media-wrapper').hide()
        $('#player source').prop('src','')
    })
    
})
</script>
</body>
</html>