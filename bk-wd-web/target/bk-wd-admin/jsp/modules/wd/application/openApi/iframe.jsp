<!DOCTYPE html>
<html lang="en">
<head style="background-color:rgb(240,240,240)">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title></title>
    <link rel="icon" href="http://dev-images.bakejinfu.com/group1/M00/00/59/ZSVO_VnmybiAMBWIAAAVHON29-Q643.png" type="image/x-icon" />
    <link rel="shortcut icon" href="http://dev-images.bakejinfu.com/group1/M00/00/59/ZSVO_VnmybiAMBWIAAAVHON29-Q643.png" type="image/x-icon" />
    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${imgStatic }/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
   
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
   
    <link href="${imgStatic }/zwy/LBQ/css/layer.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/popup_style.css" rel="stylesheet">
   
    <!--图片预览样式-->
    <link rel="stylesheet" href="${imgStatic }/zwy/LBQ/css/viewer.min.css">
   
</head>
<style>
	body, html {
		height: 100%;	
		margin: 0 auto;
	}
	
	div {
		position:relative;
	}
	
	#div_shade {
		background: #ccc;
		top:0;
		min-height: 100%;
		min-width: 100%;
		position:relative;
		background: rgba(0, 0, 0, .2);
		filter:progid:DXImageTransform.Microsoft.Alpha(opacity=10);
	}
	
	#div_imgWrap {
		color:black;
		height: 600px;
	}
	
	#div_removeShade {
		position:fixed;
		width: 50px;
		height: 50px;
		left:auto;
		right: 0;
		top:0;
		cursor: pointer;
		z-index: 1;
	}
	
	#div_removeShade img {
		height: 100%;
		width: 100%;
	}
	
	#div_imgContent {
		max-width:80%;
		max-height: 80%;
		width:300px;
		height: 500px;
		position: fixed;
		left:50%;
		margin-left: -150px;
		right: 0;
		cursor: crosshair;
	}
	
	#div_imgContent img.leftRotate {
		/*filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1);*/
	}
	
	#div_imgContent img, #div_imgSmallContent img {
		height: 100%;
		width: 100%;
		position: relative;
		vertical-align: bottom;
	}
	
	#div_imgSmallWrap {
		overflow: hidden;
		margin: 10px auto 0 auto;
		max-width:80%;
		max-height: 20%;
		width:270px;
		height: 45px;
		top:500px;
		left:0;
		right: 0;
	}
	
	#div_imgSmallContent {
		height: 100%;
		width:100%;
		letter-spacing: -100px;
		white-space: nowrap;
		transition: all .5s;
	}
	
	#div_imgSmallContent > span {
		display: inline-block;
		padding:0 2px 0 2px;
		position:relative;
		width:33.33%;
		height: 100%;
		text-align: center;
		cursor: pointer;
		letter-spacing: 0;
		filter:progid:DXImageTransform.Microsoft.Alpha(opacity=20);
		opacity: .3;
	}
	
	#div_imgSmallContent > span.current {
		filter:progid:DXImageTransform.Microsoft.Alpha(opacity=100);
		opacity: 1;
	}
	
	#div_buttonWrap {
		overflow: hidden;
		margin: 10px auto 0 auto;
		text-align:center;
		max-width:80%;
		max-height: 20%;
		width:300px;
		height: 50px;
		top:500px;
		left:0;
		right: 0;
	}
	
	#div_buttonWrap > span {
		display:inline-block;
		width:30px;
		height:30px;
		line-height:30px;
		text-align:center;
		color:#ffffff;
		cursor:pointer;
		font-weight: bold;
	}
	
	#div_buttonWrap > span img {
		height: 100%;
		width: 100%;
	}
</style>
<body>
	
	<div id="div_shade">
		<div id="div_removeShade"><img src="${imgStatic }/zwy/LBQ//images/close3.png"></div>
		<div id="div_imgWrap">
			<div id="div_imgContent">
				<img id="imgContent" src="" data-rotate="0" onclick="func_imgZoom(this)" style="">
			</div>
			<div style="height: 0;">&nbsp;</div>
			<!--small img review-->
			<div id="div_imgSmallWrap">
				<div id="div_imgSmallContent"></div>
			</div>
			<!--end small img review-->
			
			<!--button-->
			<div id="div_buttonWrap">
				<span id="div_leftButton"><img src="${imgStatic }/zwy/LBQ//images/arrow_left.png"></span>
				<span id="div_rightButton"><img src="${imgStatic }/zwy/LBQ//images/arrow_right.png"></span>
				<span id="div_leftRotate"><img src="${imgStatic }/zwy/LBQ//images/rotate_left.png"></span>
				<span id="div_rightRotate"><img src="${imgStatic }/zwy/LBQ//images/rotate_right.png"></span>
			</div>
			<!--end button-->
			
		</div>
	</div>
</body>

<script>
window.HTMLElement = window.HTMLElement || window.Element;

//同JQUERY nexAll方法
HTMLElement.prototype.nexAll = function(){
	var flag = false;
	var parent = this.parentNode;
	var cs = parent.children;
	var arr = [];
	
	for (var i=0;i<cs.length;i++) {
		if (cs[i] !== this && !flag) {
			continue;
		} else if (cs[i] === this) {
			flag = true;
		} else {
			arr.push(cs[i]);
		}
	}
	
	return arr;
}  

//同JQUERY prevAll方法
HTMLElement.prototype.prevAll = function(){
	var parent = this.parentNode;
	var cs = parent.children;
	var arr = [];
	
	for (var i=0;i<cs.length;i++) {
		if (cs[i] === this) {
			break
		}
		
		arr.push(cs[i]);
	}
	
	return arr;
}  

//同JQUERY index方法
HTMLElement.prototype.index = function() {
	return this.prevAll().length;
};

function func_imgZoom(o) {
	if (o.style.width === "100%" || o.style.width.length === 0) {
		o.style.width = "50%";
		o.style.height = "50%";
		o.style.left = "50%";
		o.style.marginLeft = "-"+o.offsetWidth/2+"px";
		o.style.top = "50%";
		o.style.marginTop = "-"+o.offsetHeight/2+"px";
	} else {
		o.style.width = "100%";
		o.style.height = "100%";
		o.style.left = "";
		o.style.marginLeft = "";
		o.style.top = "";
		o.style.marginTop = "";
	}
	
}

window.onload = function() {
	var imgs = top.g_imgs;
	var json_datas = {
		data:{
			imgs:imgs
		}
	};
	
	window.focus();
	
	window.onkeydown = function(e) {
		e = e || window.event;
		var div_removeShade = document.getElementById("div_removeShade");
		
		if (e.keyCode === 27) {
			div_removeShade.click();
		}
	}
	
	//添加图片的SHADE事件
	var addImgShadeEvent = function() {
		var div_shade = document.getElementById("div_shade");
		var div_removeShade = document.getElementById("div_removeShade");
		var div_imgContent = document.getElementById("div_imgContent");
		var imgContent = document.getElementById("imgContent");
		var div_imgSmallContent = document.getElementById("div_imgSmallContent");
		var div_leftButton = document.getElementById("div_leftButton");
		var nn = 0, peiord = 33.33;
		
		div_removeShade.onclick =  function(e) {
			//div_shade.parentNode.removeChild(div_shade);
			var layerIframe1 = top.document.getElementById("layerIframe1");
			//layerIframe1.style.display = "none";
			layerIframe1.parentNode.removeChild(layerIframe1);
		};
		
		//点击缩略图
		div_imgSmallContent.onclick = function(e) {
			var e = e?e:window.event;
			var e_obj = e.srcElement ? e.srcElement:e.target;
			var objs = document.querySelectorAll("[name=span_smallImg]");
			var cur_spanimg = document.querySelector("#div_imgSmallContent > span.current");
			
			if (!cur_spanimg || e_obj.parentNode === cur_spanimg) return;
			
			if (e_obj.tagName.toLowerCase() === "img") {
				if (e_obj.parentNode.index() < cur_spanimg.index()) {
					div_rightButton.click();
				} else if (e_obj.parentNode.index() > cur_spanimg.index()) {
					div_leftButton.click();
				}
				
				if (div_imgContent.firstChild) {
					imgContent.src = e_obj.src;
					
					for (var i=0;i<objs.length;i++) {
						objs[i].className = "";
					}
					
					e_obj.parentNode.className = "current";
				}
			}
		};
		
		//点击左按钮
		div_leftButton.onclick = function(e) {
			var cur_spanimg = document.querySelector("#div_imgSmallContent > span.current");
			var e = e?e:window.event;
			var target = e.srcElement ? e.srcElement:e.target;
			var nextSibling = cur_spanimg.nextSibling;
			var imgCounts = document.querySelectorAll("[name=span_smallImg]").length;
			
			if (!cur_spanimg || !nextSibling) return;
			
			cur_spanimg.className = "";
			nextSibling.className = "current";
			imgContent.src = nextSibling.children[0].src;
			div_imgSmallContent.style.left = (--nn*peiord) + "%";
		}
		
		//点击右按钮
		div_rightButton.onclick = function(e) {
			var cur_spanimg = document.querySelector("#div_imgSmallContent > span.current");
			var e = e?e:window.event;
			var target = e.srcElement ? e.srcElement:e.target;
			var previousSibling = cur_spanimg.previousSibling;
			var imgCounts = document.querySelectorAll("[name=span_smallImg]").length;
			
			if (!previousSibling || !cur_spanimg) return;
			
			cur_spanimg.className = "";
			previousSibling.className = "current";
			imgContent.src = previousSibling.children[0].src;
			div_imgSmallContent.style.left = (++nn*peiord) + "%";
		}
		
		//点击左选择按钮
		div_leftRotate.onclick = function(e) {
			var isWindow = e ? false:true;
			var n = (imgContent.getAttribute("data-rotate")) % 4 + 1;
			e = e || window.event;
			
			if (isWindow) {
				imgContent.style.filter = "progid:DXImageTransform.Microsoft.BasicImage(rotation="+(n)+")";
			} else {
				imgContent.style.transform = "rotate("+(n)*90+"deg)";
			}
			
			imgContent.setAttribute("data-rotate", n);
		};
		
		//点击左选择按钮
		div_rightRotate.onclick = function(e) {
			var isWindow = e ? false:true;
			var n = (imgContent.getAttribute("data-rotate")) % 4-1;
			n = n < 0 ? n+4:n;
			e = e || window.event;
			
			if (isWindow) {
				imgContent.style.filter = "progid:DXImageTransform.Microsoft.BasicImage(rotation="+(n)+")";
			} else {
				imgContent.style.transform = "rotate("+(n)*90+"deg)";
			}
			
			imgContent.setAttribute("data-rotate", n);
		};
		
		try {
			div_imgContent.style.top = (window.innerHeight-div_imgContent.offsetHeight - div_imgSmallContent.offsetHeight - div_buttonWrap.offsetHeight) / 3 + "px";
			if (parseInt(div_imgContent.style.top) > 0 ) div_imgSmallWrap.style.marginTop = (parseInt(div_imgContent.style.top) + 30) + "px";
		} catch (ee) {
        	window.innerHeight = document.body.clientHeight;  
			div_imgContent.style.top = 0;//(window.innerHeight-div_imgContent.offsetHeight) / 4 + "px";
			div_imgSmallWrap.style.marginTop = 0;
		}
	};
	
	
	addImgShadeEvent();
	
	//初始化图片加载
	var init_load = function(json_datas) {
		var str = '';
		var imgs = null;
		var cur_spanimg = null;
		
		if (!json_datas || !json_datas.data || !json_datas.data.imgs) return;
		
		imgs = json_datas.data.imgs;
		
		for (var i=0;i<imgs.length;i++) {
			str += i === (imgs.length === 1?0:1) ?  '<span name="span_smallImg" class="current"><img src="'+ imgs[i] +'"></span>':'<span name="span_smallImg"><img src="'+ imgs[i] +'"></span>';
		}
		
		div_imgSmallContent.innerHTML = str;
		cur_spanimg = document.querySelector("#div_imgSmallContent > span.current");
		
		if (!cur_spanimg) return;
		
		imgContent.src = cur_spanimg.children[0].src;
	};
	
	init_load(json_datas);
	
	//增加图片拖动事件;
	var func_drag = function(e) {
		e = e || window.event;
		
		switch (e.type) {
			case "dragstart":
			this.style.margin = "0";
			break;
			case "drag":
			this.style.left = (e.clientX-this.offsetWidth/2) + "px";
			this.style.top = (e.clientY-this.offsetHeight/2) + "px";
			//if (console) console.log("this.style.left:%s this.style.top:%s", this.style.left, this.style.top);
			break;
			case "dragover":
			if ("preventDefault" in e) {
				e.preventDefault();
			}
			break;
			case "dragend":
			//this.style.margin = "0 auto";
			break;
			
		}
	}
	
	div_imgContent.ondragstart = div_imgContent.ondrag = document.ondragover = div_imgContent.ondragend = func_drag;
};
	
</script>

</html>