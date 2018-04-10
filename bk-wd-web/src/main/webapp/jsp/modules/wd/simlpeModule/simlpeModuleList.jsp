<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gentelella Alela! | </title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>

<body>
    <!-- page content -->

    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2> 简单组件配置 </h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" data-url="${ctx }/wd/simlpeModule/form" id="btn-add-module">新增简单组件</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                <div class="col-xs-10">
                    <!-- Tab panes -->
                    <div id="tab-content">

                    </div>
                </div>

                <div class="col-xs-2">
                    <!-- required for floating -->
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs tabs-right">
                        <c:forEach items="${list}" var="module">
                            <li class=""><a href="javascript:void(0)" data-code="${module.code}" data-toggle="tab" aria-expanded="false">${module.name}</a></li>
                        </c:forEach>
                    </ul>
                </div>

            </div>
        </div>
    </div>

    <!-- /page content -->
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Switchery -->
    <script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script type="text/javascript">
        var ctx = "${ctx }";
        var ctxStatic = "${ctxStatic }";
    	$(function(){
            $("div.x_content ul.nav-tabs").on("click", "li a", function(){
            	loadElementList($(this).data("code"));
            });
            
            if ($("div.x_content ul.nav-tabs li").length > 0) {
            	if ("${wdDefaultSimpleModule.code}") {
            		$("div.x_content ul.nav-tabs li a[data-code=${wdDefaultSimpleModule.code}]")[0].click();
            	} else {
                    $("div.x_content ul.nav-tabs li a")[0].click();
            	}
            }
    	})
    	
    	function loadElementList(moduleCode) {
    		$.get(ctx + "/wd/simlpeModule/itemList?defaultSimpleModuleCode=" + moduleCode, null, function(data) {
    			$("#tab-content").html(data);
    	        if ($(".js-switch")[0]) {
    	            var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not([data-switchery])'));

    	            elems.forEach(function (html) {
    	                var switchery = new Switchery(html, {
    	                    color: '#26B99A'
    	                });
    	            });
    	        }
    	    })
    	}
    </script>
    <!-- 页面脚本 -->
    <script src="${ctxStatic}/js/module/module.js?111"></script>
</body>
</html>