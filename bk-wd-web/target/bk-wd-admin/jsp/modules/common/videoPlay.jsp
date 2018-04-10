<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
    <link href="${imgStatic }/vendors/video6.2.5.js/css/video-js.css" rel="stylesheet">
    <script src="${imgStatic }/vendors/video6.2.5.js/js/video.min.js"></script>
    <style>
        body{background-color: #191919}
        .m{ width: 740px; height: 400px; margin-left: auto; margin-right: auto; margin-top: 100px; }
    </style>
</head>
<body>
    <div class="m">
        <video id="my-video" class="video-js" controls preload="auto" width="740" height="400" poster="${imagesStatic }${firstUrl}" data-setup="{}">
            <source src="${imagesStatic }${videoUrl}" type="video/mp4">
        </video>
            
          <script type="text/javascript">
            var myPlayer = videojs('my-video');
            videojs("my-video").ready(function(){
                var myPlayer = this;
                myPlayer.play();
            });
        </script>
    </div>
</body>
</html>