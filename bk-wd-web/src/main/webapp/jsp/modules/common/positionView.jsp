<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>基本地图展示</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
    <script src="http://webapi.amap.com/maps?v=1.3&key=5f59e03fa5387535c91aa6ad6984e950"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <style>
    .amap-marker-label{border:none!important;padding:5px!important;border-radius: 5px!important;}
    </style>
</head>
<body>
<div id="container"></div>

<script>
    var map = new AMap.Map('container', {
        resizeEnable: true,
        center: [${lng}, ${lat}],
        zoom: 13
    });
    
    var marker = new AMap.Marker({
        position: map.getCenter()
    });
    marker.setMap(map);

    // 设置label标签
    marker.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
        offset: new AMap.Pixel(-50, -25),//修改label相对于maker的位置
        content: "${position}"
    });
</script>
</body>
</html>