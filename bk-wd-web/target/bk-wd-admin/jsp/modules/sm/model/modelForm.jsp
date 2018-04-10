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
    <title></title>
    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/iCheck/skins/flat/blue.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
	
	<link href="${imgStatic }/zwy/css/afterLoanPolicy.css" rel="stylesheet">
	
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/wd-wizard.css" rel="stylesheet">

    <link href="${imgStatic }/zwy/css/complex-module.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/css/scoreModule.css" rel="stylesheet">
</head>
<body>
	<div id="div_ScoreModuleWrap">
		<div id="div_content" class="div_content">
			<!--适用范围-->
			<div id="div_scoreModule">
				
				<span class="span_btnWrap">
					<button id="btn_save" class="button_black button_middleSize" onclick="saveScoreModule()">保&nbsp;存</button>
				</span>
				
				<span id="span_moduleName"  class="span_content">
					<span class="content_txt">模型名称</span>
					<input type="text" id="txt_moduleName" class="standardTxt_control"/>
				</span>
				<span id="span_moduleKey"  class="span_content">
					<span class="content_txt">模型Key</span>
					<input type="text" id="txt_moduleKey" class="standardTxt_control"/>
				</span>
				<p></p>
				<span id="span_moduleRemarks"  class="span_content">
					<span class="content_txt">模型描述</span>
					<textarea id="txt_moduleRemarks" class="standardTxt_control"></textarea>
				</span>
				
				<div class="div_line"></div>
				
				<div id="scoreBackupOption" style="vertical-align: top;">
	    		<div name="div_tabTitle" class="block-title wd-table table table-striped table-bordered">评分备选项</div>
	    		<div name="div_tabCotent"></div>
	    	</div>
			
				<div name="vertical_line" class="vertical_line" style=""></div>
				<div id="dataConfigWrap" style="">
					<!--数值区间type1-->
					<div id="scoreConfigWrap" name="scoreTable" style="display: ;"></div>
			   	<!--结束数值区间-->
			   
			   	<!--选择项type2--> 
					<div id="optionConfigWrap" name="scoreTable" style="display: ;"></div>
			   	<!--结束选择项-->
		   	</div>
			</div>	
		</div>
	</div>

	<!-- jQuery -->
	<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script src="${imgStatic }/vendors/iCheck/icheck.min.js"></script>
	<!-- Switchery -->
	<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
	<!-- PNotify -->
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>
	<!-- jQuery UI -->
	<script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	<script src="${imgStatic }/zwy/js/wd-common.js"></script>
	<script src="${imgStatic }/vendors/layer/layer.js"></script>
	<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
	<script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
	<script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>
	<script src="${imgStatic }/zwy/js/scoreModule.js"></script>
	
	<script>
	var currentPageUrl = {
        elementListUrl: "${ctx}/sm/element/list", //初始化列表
    	modelDetailUrl : "${ctx}/sm/model/detail",
        saveUrl:"${ctx}/sm/model/save"
    };
	
	$(document).ready(function() {
		$.ajax({
            url: currentPageUrl.elementListUrl,
            type: "GET",
            dataType: "json",
            cache: false,
            success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
        		var json_datasConfig = result;
        		jyshen.consoleLog(JSON.stringify(json_datasConfig));
            	if (result.success) {
            		if ("${id}") {
            			$.ajax({
                            url: currentPageUrl.modelDetailUrl + "?modelId=${id}",
                            type: "GET",
                            dataType: "json",
                            cache: false,
                            success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                            	jyshen.consoleLog(JSON.stringify(result));
                            	if (result.success) {
                            		initScoreModule(json_datasConfig, result);
                                }
                            }
                        });
            		} else {
            			initScoreModule(json_datasConfig);
            		}
                }
            }
        });
	});
	</script>
</body>