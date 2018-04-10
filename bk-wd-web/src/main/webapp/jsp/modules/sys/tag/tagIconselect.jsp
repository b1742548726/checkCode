<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<html>
<head>
<title>图标选择</title>
<meta name="decorator" content="default" />
<style type="text/css">
.page-header {
	clear: both;
	margin: 0 20px;
	padding-top: 20px;
}.the-icons {
	padding: 25px 10px 15px;
	list-style: none;
}.the-icons li {
	float: left;
	width: 30%;
	line-height: 25px;
	margin: 2px 5px;
	cursor: pointer;
}.the-icons i {
	margin: 1px 5px;
	font-size: 16px;
}.the-icons li:hover {
	background-color: #efefef;
}.the-icons li.active {
	background-color: #0088CC;
	color: #ffffff;
}.the-icons li:hover i {
	font-size: 16px;
}
</style>
<script type="text/javascript">
	    $(document).ready(function(){
	    	$("#icons li").click(function(){
	    		$("#icons li").removeClass("active");
	    		$("#icons li i").removeClass("icon-white");
	    		$(this).addClass("active");
	    		$(this).children("i").addClass("icon-white");
	    		$("#icon").val($(this).text());
	    	});
	    	$("#icons li").each(function(){
	    		if ("${value}" && $(this).hasClass("${value}")){
	    			$(this).click();
	    		}
	    	});
	    	$("#icons li").dblclick(function(){
	    		top.$.jBox.getBox().find("button[value='ok']").trigger("click");
	    	});
	    });
    </script>
</head>
<body>
	<input type="hidden" id="icon" value="${value}" />
	<div id="icons">
<!-- 		<h2 class="page-header">Web Application Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-adjust"></i> fa-adjust</li>
			<li><i class="fa fa-anchor"></i> fa-anchor</li>
			<li><i class="fa fa-archive"></i> fa-archive</li>
			<li><i class="fa fa-area-chart"></i> fa-area-chart</li>
			<li><i class="fa fa-arrows"></i> fa-arrows</li>
			<li><i class="fa fa-arrows-h"></i> fa-arrows-h</li>
			<li><i class="fa fa-arrows-v"></i> fa-arrows-v</li>
			<li><i class="fa fa-asterisk"></i> fa-asterisk</li>
			<li><i class="fa fa-at"></i> fa-at</li>
			<li><i class="fa fa-automobile"></i> fa-automobile <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-ban"></i> fa-ban</li>
			<li><i class="fa fa-bank"></i> fa-bank <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-bar-chart"></i> fa-bar-chart</li>
			<li><i class="fa fa-barcode"></i> fa-barcode</li>
			<li><i class="fa fa-bars"></i> fa-bars</li>
			<li><i class="fa fa-beer"></i> fa-beer</li>
			<li><i class="fa fa-bell"></i> fa-bell</li>
			<li><i class="fa fa-bell-o"></i> fa-bell-o</li>
            <li><i class="fa fa-bell-slash"></i> fa-bell-slash</li>
			<li><i class="fa fa-bell-slash-o"></i> fa-bell-slash-o</li>
			<li><i class="fa fa-bicycle"></i> fa-bicycle</li>
			<li><i class="fa fa-binoculars"></i> fa-binoculars</li>
			<li><i class="fa fa-birthday-cake"></i> fa-birthday-cake</li>
			<li><i class="fa fa-bolt"></i> fa-bolt</li>
			<li><i class="fa fa-bomb"></i> fa-bomb</li>
			<li><i class="fa fa-book"></i> fa-book</li>
			<li><i class="fa fa-bookmark"></i> fa-bookmark</li>
			<li><i class="fa fa-bookmark-o"></i> fa-bookmark-o</li>
			<li><i class="fa fa-briefcase"></i> fa-briefcase</li>
			<li><i class="fa fa-bug"></i> fa-bug</li>
			<li><i class="fa fa-building"></i> fa-building</li>
			<li><i class="fa fa-building-o"></i> fa-building-o</li>
			<li><i class="fa fa-bullhorn"></i> fa-bullhorn</li>
			<li><i class="fa fa-bullseye"></i> fa-bullseye</li>
			<li><i class="fa fa-bus"></i> fa-bus</li>
			<li><i class="fa fa-cab"></i> fa-cab <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-calculator"></i> fa-calculator</li>
			<li><i class="fa fa-calendar"></i> fa-calendar</li>
			<li><i class="fa fa-calendar-o"></i> fa-calendar-o</li>
			<li><i class="fa fa-camera"></i> fa-camera</li>
			<li><i class="fa fa-camera-retro"></i> fa-camera-retro</li>
			<li><i class="fa fa-car"></i> fa-car</li>
			<li><i class="fa fa-caret-square-o-down"></i> fa-caret-square-o-down</li>
			<li><i class="fa fa-caret-square-o-left"></i> fa-caret-square-o-left</li>
			<li><i class="fa fa-caret-square-o-right"></i> fa-caret-square-o-right</li>
			<li><i class="fa fa-caret-square-o-up"></i> fa-caret-square-o-up</li>
			<li><i class="fa fa-cc"></i> fa-cc</li>
			<li><i class="fa fa-certificate"></i> fa-certificate</li>
			<li><i class="fa fa-check"></i> fa-check</li>
			<li><i class="fa fa-check-circle"></i> fa-check-circle</li>
			<li><i class="fa fa-check-circle-o"></i> fa-check-circle-o</li>
			<li><i class="fa fa-check-square"></i> fa-check-square</li>
			<li><i class="fa fa-check-square-o"></i> fa-check-square-o</li>
			<li><i class="fa fa-child"></i> fa-child</li>
			<li><i class="fa fa-circle"></i> fa-circle</li>
			<li><i class="fa fa-circle-o"></i> fa-circle-o</li>
			<li><i class="fa fa-circle-o-notch"></i> fa-circle-o-notch</li>
			<li><i class="fa fa-circle-thin"></i> fa-circle-thin</li>
			<li><i class="fa fa-clock-o"></i> fa-clock-o</li>
			<li><i class="fa fa-close"></i> fa-close <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-cloud"></i> fa-cloud</li>
			<li><i class="fa fa-cloud-download"></i> fa-cloud-download</li>
			<li><i class="fa fa-cloud-upload"></i> fa-cloud-upload</li>
			<li><i class="fa fa-code"></i> fa-code</li>
			<li><i class="fa fa-code-fork"></i> fa-code-fork</li>
			<li><i class="fa fa-coffee"></i> fa-coffee</li>
			<li><i class="fa fa-cog"></i> fa-cog</li>
			<li><i class="fa fa-cogs"></i> fa-cogs</li>
			<li><i class="fa fa-comment"></i> fa-comment</li>
			<li><i class="fa fa-comment-o"></i> fa-comment-o</li>
			<li><i class="fa fa-comments"></i> fa-comments</li>
			<li><i class="fa fa-comments-o"></i> fa-comments-o</li>
			<li><i class="fa fa-compass"></i> fa-compass</li>
			<li><i class="fa fa-copyright"></i> fa-copyright</li>
			<li><i class="fa fa-credit-card"></i> fa-credit-card</li>
			<li><i class="fa fa-crop"></i> fa-crop</li>
			<li><i class="fa fa-crosshairs"></i> fa-crosshairs</li>
			<li><i class="fa fa-cube"></i> fa-cube</li>
			<li><i class="fa fa-cubes"></i> fa-cubes</li>
			<li><i class="fa fa-cutlery"></i> fa-cutlery</li>
			<li><i class="fa fa-dashboard"></i> fa-dashboard <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-database"></i> fa-database</li>
			<li><i class="fa fa-desktop"></i> fa-desktop</li>
			<li><i class="fa fa-dot-circle-o"></i> fa-dot-circle-o</li>
			<li><i class="fa fa-download"></i> fa-download</li>
			<li><i class="fa fa-edit"></i> fa-edit <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-ellipsis-h"></i> fa-ellipsis-h</li>
			<li><i class="fa fa-ellipsis-v"></i> fa-ellipsis-v</li>
			<li><i class="fa fa-envelope"></i> fa-envelope</li>
			<li><i class="fa fa-envelope-o"></i> fa-envelope-o</li>
			<li><i class="fa fa-envelope-square"></i> fa-envelope-square</li>
			<li><i class="fa fa-eraser"></i> fa-eraser</li>
			<li><i class="fa fa-exchange"></i> fa-exchange</li>
			<li><i class="fa fa-exclamation"></i> fa-exclamation</li>
			<li><i class="fa fa-exclamation-circle"></i> fa-exclamation-circle</li>
			<li><i class="fa fa-exclamation-triangle"></i> fa-exclamation-triangle</li>
			<li><i class="fa fa-external-link"></i> fa-external-link</li>
			<li><i class="fa fa-external-link-square"></i> fa-external-link-square</li>
			<li><i class="fa fa-eye"></i> fa-eye</li>
			<li><i class="fa fa-eye-slash"></i> fa-eye-slash</li>
			<li><i class="fa fa-eyedropper"></i> fa-eyedropper</li>
			<li><i class="fa fa-fax"></i> fa-fax</li>
			<li><i class="fa fa-female"></i> fa-female</li>
			<li><i class="fa fa-fighter-jet"></i> fa-fighter-jet</li>
			<li><i class="fa fa-file-archive-o"></i> fa-file-archive-o</li>
			<li><i class="fa fa-file-audio-o"></i> fa-file-audio-o</li>
			<li><i class="fa fa-file-code-o"></i> fa-file-code-o</li>
			<li><i class="fa fa-file-excel-o"></i> fa-file-excel-o</li>
			<li><i class="fa fa-file-image-o"></i> fa-file-image-o</li>
			<li><i class="fa fa-file-movie-o"></i> fa-file-movie-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-file-pdf-o"></i> fa-file-pdf-o</li>
			<li><i class="fa fa-file-photo-o"></i> fa-file-photo-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-file-picture-o"></i> fa-file-picture-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-file-powerpoint-o"></i> fa-file-powerpoint-o</li>
			<li><i class="fa fa-file-sound-o"></i> fa-file-sound-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-file-video-o"></i> fa-file-video-o</li>
			<li><i class="fa fa-file-word-o"></i> fa-file-word-o</li>
			<li><i class="fa fa-file-zip-o"></i> fa-file-zip-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-film"></i> fa-film</li>
			<li><i class="fa fa-filter"></i> fa-filter</li>
			<li><i class="fa fa-fire"></i> fa-fire</li>
			<li><i class="fa fa-fire-extinguisher"></i> fa-fire-extinguisher</li>
			<li><i class="fa fa-flag"></i> fa-flag</li>
			<li><i class="fa fa-flag-checkered"></i> fa-flag-checkered</li>
			<li><i class="fa fa-flag-o"></i> fa-flag-o</li>
			<li><i class="fa fa-flash"></i> fa-flash <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-flask"></i> fa-flask</li>
			<li><i class="fa fa-folder"></i> fa-folder</li>
			<li><i class="fa fa-folder-o"></i> fa-folder-o</li>
			<li><i class="fa fa-folder-open"></i> fa-folder-open</li>
			<li><i class="fa fa-folder-open-o"></i> fa-folder-open-o</li>
			<li><i class="fa fa-frown-o"></i> fa-frown-o</li>
			<li><i class="fa fa-futbol-o"></i> fa-futbol-o</li>
			<li><i class="fa fa-gamepad"></i> fa-gamepad</li>
			<li><i class="fa fa-gavel"></i> fa-gavel</li>
			<li><i class="fa fa-gear"></i> fa-gear <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-gears"></i> fa-gears <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-gift"></i> fa-gift</li>
			<li><i class="fa fa-glass"></i> fa-glass</li>
			<li><i class="fa fa-globe"></i> fa-globe</li>
			<li><i class="fa fa-graduation-cap"></i> fa-graduation-cap</li>
			<li><i class="fa fa-group"></i> fa-group <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-hdd-o"></i> fa-hdd-o</li>
			<li><i class="fa fa-headphones"></i> fa-headphones</li>
			<li><i class="fa fa-heart"></i> fa-heart</li>
			<li><i class="fa fa-heart-o"></i> fa-heart-o</li>
			<li><i class="fa fa-history"></i> fa-history</li>
			<li><i class="fa fa-home"></i> fa-home</li>
			<li><i class="fa fa-image"></i> fa-image <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-inbox"></i> fa-inbox</li>
			<li><i class="fa fa-info"></i> fa-info</li>
			<li><i class="fa fa-info-circle"></i> fa-info-circle</li>
			<li><i class="fa fa-institution"></i> fa-institution <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-key"></i> fa-key</li>
			<li><i class="fa fa-keyboard-o"></i> fa-keyboard-o</li>
			<li><i class="fa fa-language"></i> fa-language</li>
			<li><i class="fa fa-laptop"></i> fa-laptop</li>
			<li><i class="fa fa-leaf"></i> fa-leaf</li>
			<li><i class="fa fa-legal"></i> fa-legal <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-lemon-o"></i> fa-lemon-o</li>
			<li><i class="fa fa-level-down"></i> fa-level-down</li>
			<li><i class="fa fa-level-up"></i> fa-level-up</li>
			<li><i class="fa fa-life-bouy"></i> fa-life-bouy <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-life-buoy"></i> fa-life-buoy <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-life-ring"></i> fa-life-ring</li>
			<li><i class="fa fa-life-saver"></i> fa-life-saver <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-lightbulb-o"></i> fa-lightbulb-o</li>
			<li><i class="fa fa-line-chart"></i> fa-line-chart</li>
			<li><i class="fa fa-location-arrow"></i> fa-location-arrow</li>
			<li><i class="fa fa-lock"></i> fa-lock</li>
			<li><i class="fa fa-magic"></i> fa-magic</li>
			<li><i class="fa fa-magnet"></i> fa-magnet</li>
			<li><i class="fa fa-mail-forward"></i> fa-mail-forward <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-mail-reply"></i> fa-mail-reply <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-mail-reply-all"></i> fa-mail-reply-all <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-male"></i> fa-male</li>
			<li><i class="fa fa-map-marker"></i> fa-map-marker</li>
			<li><i class="fa fa-meh-o"></i> fa-meh-o</li>
			<li><i class="fa fa-microphone"></i> fa-microphone</li>
			<li><i class="fa fa-microphone-slash"></i> fa-microphone-slash</li>
			<li><i class="fa fa-minus"></i> fa-minus</li>
			<li><i class="fa fa-minus-circle"></i> fa-minus-circle</li>
			<li><i class="fa fa-minus-square"></i> fa-minus-square</li>
			<li><i class="fa fa-minus-square-o"></i> fa-minus-square-o</li>
			<li><i class="fa fa-mobile"></i> fa-mobile</li>
			<li><i class="fa fa-mobile-phone"></i> fa-mobile-phone <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-money"></i> fa-money</li>
			<li><i class="fa fa-moon-o"></i> fa-moon-o</li>
			<li><i class="fa fa-mortar-board"></i> fa-mortar-board <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-music"></i> fa-music</li>
			<li><i class="fa fa-navicon"></i> fa-navicon <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-newspaper-o"></i> fa-newspaper-o</li>
			<li><i class="fa fa-paint-brush"></i> fa-paint-brush</li>
			<li><i class="fa fa-paper-plane"></i> fa-paper-plane</li>
			<li><i class="fa fa-paper-plane-o"></i> fa-paper-plane-o</li>
			<li><i class="fa fa-paw"></i> fa-paw</li>
			<li><i class="fa fa-pencil"></i> fa-pencil</li>
			<li><i class="fa fa-pencil-square"></i> fa-pencil-square</li>
			<li><i class="fa fa-pencil-square-o"></i> fa-pencil-square-o</li>
			<li><i class="fa fa-phone"></i> fa-phone</li>
			<li><i class="fa fa-phone-square"></i> fa-phone-square</li>
			<li><i class="fa fa-photo"></i> fa-photo <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-picture-o"></i> fa-picture-o</li>
			<li><i class="fa fa-pie-chart"></i> fa-pie-chart</li>
			<li><i class="fa fa-plane"></i> fa-plane</li>
			<li><i class="fa fa-plug"></i> fa-plug</li>
			<li><i class="fa fa-plus"></i> fa-plus</li>
			<li><i class="fa fa-plus-circle"></i> fa-plus-circle</li>
			<li><i class="fa fa-plus-square"></i> fa-plus-square</li>
			<li><i class="fa fa-plus-square-o"></i> fa-plus-square-o</li>
			<li><i class="fa fa-power-off"></i> fa-power-off</li>
			<li><i class="fa fa-print"></i> fa-print</li>
			<li><i class="fa fa-puzzle-piece"></i> fa-puzzle-piece</li>
			<li><i class="fa fa-qrcode"></i> fa-qrcode</li>
			<li><i class="fa fa-question"></i> fa-question</li>
			<li><i class="fa fa-question-circle"></i> fa-question-circle</li>
			<li><i class="fa fa-quote-left"></i> fa-quote-left</li>
			<li><i class="fa fa-quote-right"></i> fa-quote-right</li>
			<li><i class="fa fa-random"></i> fa-random</li>
			<li><i class="fa fa-recycle"></i> fa-recycle</li>
			<li><i class="fa fa-refresh"></i> fa-refresh</li>
			<li><i class="fa fa-remove"></i> fa-remove <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-reorder"></i> fa-reorder <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-reply"></i> fa-reply</li>
			<li><i class="fa fa-reply-all"></i> fa-reply-all</li>
			<li><i class="fa fa-retweet"></i> fa-retweet</li>
			<li><i class="fa fa-road"></i> fa-road</li>
			<li><i class="fa fa-rocket"></i> fa-rocket</li>
			<li><i class="fa fa-rss"></i> fa-rss</li>
			<li><i class="fa fa-rss-square"></i> fa-rss-square</li>
			<li><i class="fa fa-search"></i> fa-search</li>
			<li><i class="fa fa-search-minus"></i> fa-search-minus</li>
			<li><i class="fa fa-search-plus"></i> fa-search-plus</li>
			<li><i class="fa fa-send"></i> fa-send <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-send-o"></i> fa-send-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-share"></i> fa-share</li>
			<li><i class="fa fa-share-alt"></i> fa-share-alt</li>
			<li><i class="fa fa-share-alt-square"></i> fa-share-alt-square</li>
			<li><i class="fa fa-share-square"></i> fa-share-square</li>
			<li><i class="fa fa-share-square-o"></i> fa-share-square-o</li>
			<li><i class="fa fa-shield"></i> fa-shield</li>
			<li><i class="fa fa-shopping-cart"></i> fa-shopping-cart</li>
			<li><i class="fa fa-sign-in"></i> fa-sign-in</li>
			<li><i class="fa fa-sign-out"></i> fa-sign-out</li>
			<li><i class="fa fa-signal"></i> fa-signal</li>
			<li><i class="fa fa-sitemap"></i> fa-sitemap</li>
			<li><i class="fa fa-sliders"></i> fa-sliders</li>
			<li><i class="fa fa-smile-o"></i> fa-smile-o</li>
			<li><i class="fa fa-soccer-ball-o"></i> fa-soccer-ball-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-sort"></i> fa-sort</li>
			<li><i class="fa fa-sort-alpha-asc"></i> fa-sort-alpha-asc</li>
			<li><i class="fa fa-sort-alpha-desc"></i> fa-sort-alpha-desc</li>
			<li><i class="fa fa-sort-amount-asc"></i> fa-sort-amount-asc</li>
			<li><i class="fa fa-sort-amount-desc"></i> fa-sort-amount-desc</li>
			<li><i class="fa fa-sort-asc"></i> fa-sort-asc</li>
			<li><i class="fa fa-sort-desc"></i> fa-sort-desc</li>
			<li><i class="fa fa-sort-down"></i> fa-sort-down <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-sort-numeric-asc"></i> fa-sort-numeric-asc</li>
			<li><i class="fa fa-sort-numeric-desc"></i> fa-sort-numeric-desc</li>
			<li><i class="fa fa-sort-up"></i> fa-sort-up <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-space-shuttle"></i> fa-space-shuttle</li>
			<li><i class="fa fa-spinner"></i> fa-spinner</li>
			<li><i class="fa fa-spoon"></i> fa-spoon</li>
			<li><i class="fa fa-square"></i> fa-square</li>
			<li><i class="fa fa-square-o"></i> fa-square-o</li>
			<li><i class="fa fa-star"></i> fa-star</li>
			<li><i class="fa fa-star-half"></i> fa-star-half</li>
			<li><i class="fa fa-star-half-empty"></i> fa-star-half-empty <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-star-half-full"></i> fa-star-half-full <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-star-half-o"></i> fa-star-half-o</li>
			<li><i class="fa fa-star-o"></i> fa-star-o</li>
			<li><i class="fa fa-suitcase"></i> fa-suitcase</li>
			<li><i class="fa fa-sun-o"></i> fa-sun-o</li>
			<li><i class="fa fa-support"></i> fa-support <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-tablet"></i> fa-tablet</li>
			<li><i class="fa fa-tachometer"></i> fa-tachometer</li>
			<li><i class="fa fa-tag"></i> fa-tag</li>
			<li><i class="fa fa-tags"></i> fa-tags</li>
			<li><i class="fa fa-tasks"></i> fa-tasks</li>
			<li><i class="fa fa-taxi"></i> fa-taxi</li>
			<li><i class="fa fa-terminal"></i> fa-terminal</li>
			<li><i class="fa fa-thumb-tack"></i> fa-thumb-tack</li>
			<li><i class="fa fa-thumbs-down"></i> fa-thumbs-down</li>
			<li><i class="fa fa-thumbs-o-down"></i> fa-thumbs-o-down</li>
			<li><i class="fa fa-thumbs-o-up"></i> fa-thumbs-o-up</li>
			<li><i class="fa fa-thumbs-up"></i> fa-thumbs-up</li>
			<li><i class="fa fa-ticket"></i> fa-ticket</li>
			<li><i class="fa fa-times"></i> fa-times</li>
			<li><i class="fa fa-times-circle"></i> fa-times-circle</li>
			<li><i class="fa fa-times-circle-o"></i> fa-times-circle-o</li>
			<li><i class="fa fa-tint"></i> fa-tint</li>
			<li><i class="fa fa-toggle-down"></i> fa-toggle-down <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-toggle-left"></i> fa-toggle-left <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-toggle-off"></i> fa-toggle-off</li>
			<li><i class="fa fa-toggle-on"></i> fa-toggle-on</li>
			<li><i class="fa fa-toggle-right"></i> fa-toggle-right <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-toggle-up"></i> fa-toggle-up <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-trash"></i> fa-trash</li>
			<li><i class="fa fa-trash-o"></i> fa-trash-o</li>
			<li><i class="fa fa-tree"></i> fa-tree</li>
			<li><i class="fa fa-trophy"></i> fa-trophy</li>
			<li><i class="fa fa-truck"></i> fa-truck</li>
			<li><i class="fa fa-tty"></i> fa-tty</li>
			<li><i class="fa fa-umbrella"></i> fa-umbrella</li>
			<li><i class="fa fa-university"></i> fa-university</li>
			<li><i class="fa fa-unlock"></i> fa-unlock</li>
			<li><i class="fa fa-unlock-alt"></i> fa-unlock-alt</li>
			<li><i class="fa fa-unsorted"></i> fa-unsorted <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-upload"></i> fa-upload</li>
			<li><i class="fa fa-user"></i> fa-user</li>
			<li><i class="fa fa-users"></i> fa-users</li>
			<li><i class="fa fa-video-camera"></i> fa-video-camera</li>
			<li><i class="fa fa-volume-down"></i> fa-volume-down</li>
			<li><i class="fa fa-volume-off"></i> fa-volume-off</li>
			<li><i class="fa fa-volume-up"></i> fa-volume-up</li>
			<li><i class="fa fa-warning"></i> fa-warning <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-wheelchair"></i> fa-wheelchair</li>
			<li><i class="fa fa-wifi"></i> fa-wifi</li>
			<li><i class="fa fa-wrench"></i> fa-wrench</li>
		</ul>
 -->		<h2 class="page-header">File Type Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-file"></i> fa-file</li>
			<li><i class="fa fa-file-archive-o"></i> fa-file-archive-o</li>
			<li><i class="fa fa-file-audio-o"></i> fa-file-audio-o</li>
			<li><i class="fa fa-file-code-o"></i> fa-file-code-o</li>
			<li><i class="fa fa-file-excel-o"></i> fa-file-excel-o</li>
			<li><i class="fa fa-file-image-o"></i> fa-file-image-o</li>
			<li><i class="fa fa-file-movie-o"></i> fa-file-movie-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-file-o"></i> fa-file-o</li>
			<li><i class="fa fa-file-pdf-o"></i> fa-file-pdf-o</li>
			<li><i class="fa fa-file-photo-o"></i> fa-file-photo-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-file-picture-o"></i> fa-file-picture-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-file-powerpoint-o"></i> fa-file-powerpoint-o</li>
			<li><i class="fa fa-file-sound-o"></i> fa-file-sound-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-file-text"></i> fa-file-text</li>
			<li><i class="fa fa-file-text-o"></i> fa-file-text-o</li>
			<li><i class="fa fa-file-video-o"></i> fa-file-video-o</li>
			<li><i class="fa fa-file-word-o"></i> fa-file-word-o</li>
			<li><i class="fa fa-file-zip-o"></i> fa-file-zip-o <span class="text-muted">(alias)</span></li>
		</ul>
		<h2 class="page-header">Spinner Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-circle-o-notch"></i> fa-circle-o-notch</li>
			<li><i class="fa fa-cog"></i> fa-cog</li>
			<li><i class="fa fa-gear"></i> fa-gear <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-refresh"></i> fa-refresh</li>
			<li><i class="fa fa-spinner"></i> fa-spinner</li>
		</ul>
		<h2 class="page-header">Form Control Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-check-square"></i> fa-check-square</li>
			<li><i class="fa fa-check-square-o"></i> fa-check-square-o</li>
			<li><i class="fa fa-circle"></i> fa-circle</li>
			<li><i class="fa fa-circle-o"></i> fa-circle-o</li>
			<li><i class="fa fa-dot-circle-o"></i> fa-dot-circle-o</li>
			<li><i class="fa fa-minus-square"></i> fa-minus-square</li>
			<li><i class="fa fa-minus-square-o"></i> fa-minus-square-o</li>
			<li><i class="fa fa-plus-square"></i> fa-plus-square</li>
			<li><i class="fa fa-plus-square-o"></i> fa-plus-square-o</li>
			<li><i class="fa fa-square"></i> fa-square</li>
			<li><i class="fa fa-square-o"></i> fa-square-o</li>
        </ul>
		<h2 class="page-header">Payment Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-cc-amex"></i> fa-cc-amex</li>
			<li><i class="fa fa-cc-discover"></i> fa-cc-discover</li>
			<li><i class="fa fa-cc-mastercard"></i> fa-cc-mastercard</li>
			<li><i class="fa fa-cc-paypal"></i> fa-cc-paypal</li>
			<li><i class="fa fa-cc-stripe"></i> fa-cc-stripe</li>
			<li><i class="fa fa-cc-visa"></i> fa-cc-visa</li>
			<li><i class="fa fa-credit-card"></i> fa-credit-card</li>
			<li><i class="fa fa-google-wallet"></i> fa-google-wallet</li>
			<li><i class="fa fa-paypal"></i> fa-paypal</li>
		</ul>
		<h2 class="page-header">Chart Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-area-chart"></i> fa-area-chart</li>
			<li><i class="fa fa-bar-chart"></i> fa-bar-chart</li>
			<li><i class="fa fa-bar-chart-o"></i> fa-bar-chart-o <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-line-chart"></i> fa-line-chart</li>
			<li><i class="fa fa-pie-chart"></i> fa-pie-chart</li>
		</ul>
		<h2 class="page-header">Currency Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-bitcoin"></i> fa-bitcoin <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-btc"></i> fa-btc</li>
			<li><i class="fa fa-cny"></i> fa-cny <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-dollar"></i> fa-dollar <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-eur"></i> fa-eur</li>
			<li><i class="fa fa-euro"></i> fa-euro <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-gbp"></i> fa-gbp</li>
			<li><i class="fa fa-ils"></i> fa-ils</li>
			<li><i class="fa fa-inr"></i> fa-inr</li>
			<li><i class="fa fa-jpy"></i> fa-jpy</li>
			<li><i class="fa fa-krw"></i> fa-krw</li>
			<li><i class="fa fa-money"></i> fa-money</li>
			<li><i class="fa fa-rmb"></i> fa-rmb <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-rouble"></i> fa-rouble <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-rub"></i> fa-rub</li>
			<li><i class="fa fa-ruble"></i> fa-ruble <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-rupee"></i> fa-rupee <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-shekel"></i> fa-shekel <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-sheqel"></i> fa-sheqel <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-try"></i> fa-try</li>
			<li><i class="fa fa-turkish-lira"></i> fa-turkish-lira <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-usd"></i> fa-usd</li>
			<li><i class="fa fa-won"></i> fa-won <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-yen"></i> fa-yen <span class="text-muted">(alias)</span></li>		</ul>
		<h2 class="page-header">Text Editor Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-align-center"></i> fa-align-center</li>
			<li><i class="fa fa-align-justify"></i> fa-align-justify</li>
			<li><i class="fa fa-align-left"></i> fa-align-left</li>
			<li><i class="fa fa-align-right"></i> fa-align-right</li>
			<li><i class="fa fa-bold"></i> fa-bold</li>
			<li><i class="fa fa-chain"></i> fa-chain <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-chain-broken"></i> fa-chain-broken</li>
			<li><i class="fa fa-clipboard"></i> fa-clipboard</li>
			<li><i class="fa fa-columns"></i> fa-columns</li>
			<li><i class="fa fa-copy"></i> fa-copy <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-cut"></i> fa-cut <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-dedent"></i> fa-dedent <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-eraser"></i> fa-eraser</li>
			<li><i class="fa fa-file"></i> fa-file</li>
			<li><i class="fa fa-file-o"></i> fa-file-o</li>
			<li><i class="fa fa-file-text"></i> fa-file-text</li>
			<li><i class="fa fa-file-text-o"></i> fa-file-text-o</li>
			<li><i class="fa fa-files-o"></i> fa-files-o</li>
			<li><i class="fa fa-floppy-o"></i> fa-floppy-o</li>
			<li><i class="fa fa-font"></i> fa-font</li>
			<li><i class="fa fa-header"></i> fa-header</li>
			<li><i class="fa fa-indent"></i> fa-indent</li>
			<li><i class="fa fa-italic"></i> fa-italic</li>
			<li><i class="fa fa-link"></i> fa-link</li>
			<li><i class="fa fa-list"></i> fa-list</li>
			<li><i class="fa fa-list-alt"></i> fa-list-alt</li>
			<li><i class="fa fa-list-ol"></i> fa-list-ol</li>
			<li><i class="fa fa-list-ul"></i> fa-list-ul</li>
			<li><i class="fa fa-outdent"></i> fa-outdent</li>
			<li><i class="fa fa-paperclip"></i> fa-paperclip</li>
			<li><i class="fa fa-paragraph"></i> fa-paragraph</li>
			<li><i class="fa fa-paste"></i> fa-paste <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-repeat"></i> fa-repeat</li>
			<li><i class="fa fa-rotate-left"></i> fa-rotate-left <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-rotate-right"></i> fa-rotate-right <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-save"></i> fa-save <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-scissors"></i> fa-scissors</li>
			<li><i class="fa fa-strikethrough"></i> fa-strikethrough</li>
			<li><i class="fa fa-subscript"></i> fa-subscript</li>
			<li><i class="fa fa-superscript"></i> fa-superscript</li>
			<li><i class="fa fa-table"></i> fa-table</li>
			<li><i class="fa fa-text-height"></i> fa-text-height</li>
			<li><i class="fa fa-text-width"></i> fa-text-width</li>
			<li><i class="fa fa-th"></i> fa-th</li>
			<li><i class="fa fa-th-large"></i> fa-th-large</li>
			<li><i class="fa fa-th-list"></i> fa-th-list</li>
			<li><i class="fa fa-underline"></i> fa-underline</li>
			<li><i class="fa fa-undo"></i> fa-undo</li>
			<li><i class="fa fa-unlink"></i> fa-unlink <span class="text-muted">(alias)</span></li>		</ul>
		<h2 class="page-header">Directional Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-angle-double-down"></i> fa-angle-double-down</li>
			<li><i class="fa fa-angle-double-left"></i> fa-angle-double-left</li>
			<li><i class="fa fa-angle-double-right"></i> fa-angle-double-right</li>
			<li><i class="fa fa-angle-double-up"></i> fa-angle-double-up</li>
			<li><i class="fa fa-angle-down"></i> fa-angle-down</li>
			<li><i class="fa fa-angle-left"></i> fa-angle-left</li>
			<li><i class="fa fa-angle-right"></i> fa-angle-right</li>
			<li><i class="fa fa-angle-up"></i> fa-angle-up</li>
			<li><i class="fa fa-arrow-circle-down"></i> fa-arrow-circle-down</li>
			<li><i class="fa fa-arrow-circle-left"></i> fa-arrow-circle-left</li>
			<li><i class="fa fa-arrow-circle-o-down"></i> fa-arrow-circle-o-down</li>
			<li><i class="fa fa-arrow-circle-o-left"></i> fa-arrow-circle-o-left</li>
			<li><i class="fa fa-arrow-circle-o-right"></i> fa-arrow-circle-o-right</li>
			<li><i class="fa fa-arrow-circle-o-up"></i> fa-arrow-circle-o-up</li>
			<li><i class="fa fa-arrow-circle-right"></i> fa-arrow-circle-right</li>
			<li><i class="fa fa-arrow-circle-up"></i> fa-arrow-circle-up</li>
			<li><i class="fa fa-arrow-down"></i> fa-arrow-down</li>
			<li><i class="fa fa-arrow-left"></i> fa-arrow-left</li>
			<li><i class="fa fa-arrow-right"></i> fa-arrow-right</li>
			<li><i class="fa fa-arrow-up"></i> fa-arrow-up</li>
			<li><i class="fa fa-arrows"></i> fa-arrows</li>
			<li><i class="fa fa-arrows-alt"></i> fa-arrows-alt</li>
			<li><i class="fa fa-arrows-h"></i> fa-arrows-h</li>
			<li><i class="fa fa-arrows-v"></i> fa-arrows-v</li>
			<li><i class="fa fa-caret-down"></i> fa-caret-down</li>
			<li><i class="fa fa-caret-left"></i> fa-caret-left</li>
			<li><i class="fa fa-caret-right"></i> fa-caret-right</li>
			<li><i class="fa fa-caret-square-o-down"></i> fa-caret-square-o-down</li>
			<li><i class="fa fa-caret-square-o-left"></i> fa-caret-square-o-left</li>
			<li><i class="fa fa-caret-square-o-right"></i> fa-caret-square-o-right</li>
			<li><i class="fa fa-caret-square-o-up"></i> fa-caret-square-o-up</li>
			<li><i class="fa fa-caret-up"></i> fa-caret-up</li>
			<li><i class="fa fa-chevron-circle-down"></i> fa-chevron-circle-down</li>
			<li><i class="fa fa-chevron-circle-left"></i> fa-chevron-circle-left</li>
			<li><i class="fa fa-chevron-circle-right"></i> fa-chevron-circle-right</li>
			<li><i class="fa fa-chevron-circle-up"></i> fa-chevron-circle-up</li>
			<li><i class="fa fa-chevron-down"></i> fa-chevron-down</li>
			<li><i class="fa fa-chevron-left"></i> fa-chevron-left</li>
			<li><i class="fa fa-chevron-right"></i> fa-chevron-right</li>
			<li><i class="fa fa-chevron-up"></i> fa-chevron-up</li>
			<li><i class="fa fa-hand-o-down"></i> fa-hand-o-down</li>
			<li><i class="fa fa-hand-o-left"></i> fa-hand-o-left</li>
			<li><i class="fa fa-hand-o-right"></i> fa-hand-o-right</li>
			<li><i class="fa fa-hand-o-up"></i> fa-hand-o-up</li>
			<li><i class="fa fa-long-arrow-down"></i> fa-long-arrow-down</li>
			<li><i class="fa fa-long-arrow-left"></i> fa-long-arrow-left</li>
			<li><i class="fa fa-long-arrow-right"></i> fa-long-arrow-right</li>
			<li><i class="fa fa-long-arrow-up"></i> fa-long-arrow-up</li>
			<li><i class="fa fa-toggle-down"></i> fa-toggle-down <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-toggle-left"></i> fa-toggle-left <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-toggle-right"></i> fa-toggle-right <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-toggle-up"></i> fa-toggle-up <span class="text-muted">(alias)</span></li>		</ul>
		<h2 class="page-header">Video Player Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-arrows-alt"></i> fa-arrows-alt</li>
			<li><i class="fa fa-backward"></i> fa-backward</li>
			<li><i class="fa fa-compress"></i> fa-compress</li>
			<li><i class="fa fa-eject"></i> fa-eject</li>
			<li><i class="fa fa-expand"></i> fa-expand</li>
			<li><i class="fa fa-fast-backward"></i> fa-fast-backward</li>
			<li><i class="fa fa-fast-forward"></i> fa-fast-forward</li>
			<li><i class="fa fa-forward"></i> fa-forward</li>
			<li><i class="fa fa-pause"></i> fa-pause</li>
			<li><i class="fa fa-play"></i> fa-play</li>
			<li><i class="fa fa-play-circle"></i> fa-play-circle</li>
			<li><i class="fa fa-play-circle-o"></i> fa-play-circle-o</li>
			<li><i class="fa fa-step-backward"></i> fa-step-backward</li>
			<li><i class="fa fa-step-forward"></i> fa-step-forward</li>
			<li><i class="fa fa-stop"></i> fa-stop</li>
			<li><i class="fa fa-youtube-play"></i> fa-youtube-play</li>
		</ul>
		<h2 class="page-header">Brand Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-adn"></i> fa-adn</li>
			<li><i class="fa fa-android"></i> fa-android</li>
			<li><i class="fa fa-angellist"></i> fa-angellist</li>
			<li><i class="fa fa-apple"></i> fa-apple</li>
			<li><i class="fa fa-behance"></i> fa-behance</li>
			<li><i class="fa fa-behance-square"></i> fa-behance-square</li>
			<li><i class="fa fa-bitbucket"></i> fa-bitbucket</li>
			<li><i class="fa fa-bitbucket-square"></i> fa-bitbucket-square</li>
			<li><i class="fa fa-bitcoin"></i> fa-bitcoin <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-btc"></i> fa-btc</li>
			<li><i class="fa fa-cc-amex"></i> fa-cc-amex</li>
			<li><i class="fa fa-cc-discover"></i> fa-cc-discover</li>
			<li><i class="fa fa-cc-mastercard"></i> fa-cc-mastercard</li>
			<li><i class="fa fa-cc-paypal"></i> fa-cc-paypal</li>
			<li><i class="fa fa-cc-stripe"></i> fa-cc-stripe</li>
			<li><i class="fa fa-cc-visa"></i> fa-cc-visa</li>
			<li><i class="fa fa-codepen"></i> fa-codepen</li>
			<li><i class="fa fa-css3"></i> fa-css3</li>
			<li><i class="fa fa-delicious"></i> fa-delicious</li>
			<li><i class="fa fa-deviantart"></i> fa-deviantart</li>
			<li><i class="fa fa-digg"></i> fa-digg</li>
			<li><i class="fa fa-dribbble"></i> fa-dribbble</li>
			<li><i class="fa fa-dropbox"></i> fa-dropbox</li>
			<li><i class="fa fa-drupal"></i> fa-drupal</li>
			<li><i class="fa fa-empire"></i> fa-empire</li>
			<li><i class="fa fa-facebook"></i> fa-facebook</li>
			<li><i class="fa fa-facebook-square"></i> fa-facebook-square</li>
			<li><i class="fa fa-flickr"></i> fa-flickr</li>
			<li><i class="fa fa-foursquare"></i> fa-foursquare</li>
			<li><i class="fa fa-ge"></i> fa-ge <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-git"></i> fa-git</li>
			<li><i class="fa fa-git-square"></i> fa-git-square</li>
			<li><i class="fa fa-github"></i> fa-github</li>
			<li><i class="fa fa-github-alt"></i> fa-github-alt</li>
			<li><i class="fa fa-github-square"></i> fa-github-square</li>
			<li><i class="fa fa-gittip"></i> fa-gittip</li>
			<li><i class="fa fa-google"></i> fa-google</li>
			<li><i class="fa fa-google-plus"></i> fa-google-plus</li>
			<li><i class="fa fa-google-plus-square"></i> fa-google-plus-square</li>
			<li><i class="fa fa-google-wallet"></i> fa-google-wallet</li>
			<li><i class="fa fa-hacker-news"></i> fa-hacker-news</li>
			<li><i class="fa fa-html5"></i> fa-html5</li>
			<li><i class="fa fa-instagram"></i> fa-instagram</li>
			<li><i class="fa fa-ioxhost"></i> fa-ioxhost</li>
			<li><i class="fa fa-joomla"></i> fa-joomla</li>
			<li><i class="fa fa-jsfiddle"></i> fa-jsfiddle</li>
			<li><i class="fa fa-lastfm"></i> fa-lastfm</li>
			<li><i class="fa fa-lastfm-square"></i> fa-lastfm-square</li>
			<li><i class="fa fa-linkedin"></i> fa-linkedin</li>
			<li><i class="fa fa-linkedin-square"></i> fa-linkedin-square</li>
			<li><i class="fa fa-linux"></i> fa-linux</li>
			<li><i class="fa fa-maxcdn"></i> fa-maxcdn</li>
			<li><i class="fa fa-meanpath"></i> fa-meanpath</li>
			<li><i class="fa fa-openid"></i> fa-openid</li>
			<li><i class="fa fa-pagelines"></i> fa-pagelines</li>
			<li><i class="fa fa-paypal"></i> fa-paypal</li>
			<li><i class="fa fa-pied-piper"></i> fa-pied-piper</li>
			<li><i class="fa fa-pied-piper-alt"></i> fa-pied-piper-alt</li>
			<li><i class="fa fa-pinterest"></i> fa-pinterest</li>
			<li><i class="fa fa-pinterest-square"></i> fa-pinterest-square</li>
			<li><i class="fa fa-qq"></i> fa-qq</li>
			<li><i class="fa fa-ra"></i> fa-ra <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-rebel"></i> fa-rebel</li>
			<li><i class="fa fa-reddit"></i> fa-reddit</li>
			<li><i class="fa fa-reddit-square"></i> fa-reddit-square</li>
			<li><i class="fa fa-renren"></i> fa-renren</li>
			<li><i class="fa fa-share-alt"></i> fa-share-alt</li>
			<li><i class="fa fa-share-alt-square"></i> fa-share-alt-square</li>
			<li><i class="fa fa-skype"></i> fa-skype</li>
			<li><i class="fa fa-slack"></i> fa-slack</li>
			<li><i class="fa fa-slideshare"></i> fa-slideshare</li>
			<li><i class="fa fa-soundcloud"></i> fa-soundcloud</li>
			<li><i class="fa fa-spotify"></i> fa-spotify</li>
			<li><i class="fa fa-stack-exchange"></i> fa-stack-exchange</li>
			<li><i class="fa fa-stack-overflow"></i> fa-stack-overflow</li>
			<li><i class="fa fa-steam"></i> fa-steam</li>
			<li><i class="fa fa-steam-square"></i> fa-steam-square</li>
			<li><i class="fa fa-stumbleupon"></i> fa-stumbleupon</li>
			<li><i class="fa fa-stumbleupon-circle"></i> fa-stumbleupon-circle</li>
			<li><i class="fa fa-tencent-weibo"></i> fa-tencent-weibo</li>
			<li><i class="fa fa-trello"></i> fa-trello</li>
			<li><i class="fa fa-tumblr"></i> fa-tumblr</li>
			<li><i class="fa fa-tumblr-square"></i> fa-tumblr-square</li>
			<li><i class="fa fa-twitch"></i> fa-twitch</li>
			<li><i class="fa fa-twitter"></i> fa-twitter</li>
			<li><i class="fa fa-twitter-square"></i> fa-twitter-square</li>
			<li><i class="fa fa-vimeo-square"></i> fa-vimeo-square</li>
			<li><i class="fa fa-vine"></i> fa-vine</li>
			<li><i class="fa fa-vk"></i> fa-vk</li>
			<li><i class="fa fa-wechat"></i> fa-wechat <span class="text-muted">(alias)</span></li>
			<li><i class="fa fa-weibo"></i> fa-weibo</li>
			<li><i class="fa fa-weixin"></i> fa-weixin</li>
			<li><i class="fa fa-windows"></i> fa-windows</li>
			<li><i class="fa fa-wordpress"></i> fa-wordpress</li>
			<li><i class="fa fa-xing"></i> fa-xing</li>
			<li><i class="fa fa-xing-square"></i> fa-xing-square</li>
			<li><i class="fa fa-yahoo"></i> fa-yahoo</li>
			<li><i class="fa fa-yelp"></i> fa-yelp</li>
			<li><i class="fa fa-youtube"></i> fa-youtube</li>
			<li><i class="fa fa-youtube-play"></i> fa-youtube-play</li>
			<li><i class="fa fa-youtube-square"></i> fa-youtube-square</li>
		</ul>
		<h2 class="page-header">Medical Icons</h2>
		<ul class="the-icons">
			<li><i class="fa fa-ambulance"></i> fa-ambulance</li>
			<li><i class="fa fa-h-square"></i> fa-h-square</li>
			<li><i class="fa fa-hospital-o"></i> fa-hospital-o</li>
			<li><i class="fa fa-medkit"></i> fa-medkit</li>
			<li><i class="fa fa-plus-square"></i> fa-plus-square</li>
			<li><i class="fa fa-stethoscope"></i> fa-stethoscope</li>
			<li><i class="fa fa-user-md"></i> fa-user-md</li>
			<li><i class="fa fa-wheelchair"></i> fa-wheelchair</li>
		</ul>
	</div>
</body>