<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

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

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/complex-module.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/scoreModule.css" rel="stylesheet">
	   <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
</head>
<style>
	
#sub_item [name=div_tabCotent] {
	display: none;
}

#sub_item >div[name=div_tabCotent]:nth-of-type(2) {
	display: block;
}
</style>
<body>
    <div class="wd-content">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <!--<div class="x_title">
                    <h2> 新增或编辑Group </h2>
                    <div class="clearfix"></div>
                </div>-->
                <div class="x_content">
                    <form id="form-add-select" data-parsley-validate class="form-horizontal form-label-left">
                        <input type="hidden" id="hidden-groupId" value="">
                        
                    </form>
                </div>
                
                <!--源模块+子项-->
                <div id="div_configPanel" name="div_configPanel">
                	<!--源模块-->
                	<div id="source_module" style="vertical-align: top;">
                		<div name="div_tabTitle" class="block-title wd-table table table-striped table-bordered">源模块</div>
                		
                		<div name="div_tabCotent">
                			<div moduleid="" elementid="" class="selected">个人信息</div>
                			<div moduleid="" elementid="">辅助信息</div>
                			<div moduleid="" elementid="">年收益损益表</div>
                			<div moduleid="" elementid="">月收益损益表</div>
                			<div moduleid="" elementid="">家庭资产负债表</div>
                		</div>
                	</div>
                	<!--结束源模块-->
                	
                	<!--子项-->
                	<div id="sub_item">
                		<div name="div_tabTitle" class="block-title wd-table table table-striped table-bordered">子项</div>
                	</div>
                	<!--结束子项-->
                	
                </div>
                <!--结束源模块+子项-->
            </div>
        </div>
        
        
        <div class="form-group">
            <div class="col-xs-12 wd-center">
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-white" type="button" id="cancle-add-select">取消</button>
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-viridity" type="submit" id="submit-add-select">确认</button>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Parsley -->
    <script src="${imgStatic }/vendors/parsleyjs-2.6/dist/parsley.min.js"></script>
    <script src="${imgStatic }/vendors/parsleyjs-2.6/dist/i18n/zh_cn.js"></script>
	<!-- PNotify -->
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
	<script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>
	<!-- Layer -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
	<script src="${imgStatic }/zwy/js/scoreModule.js"></script>
	<script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>
	
    <script type="text/javascript">
    
    var currentPageUrl = {
   		 elementListUrl: "${ctx}/sm/element/list", //初始化列表
   		 moduleListUrl : "${ctx}/sm/element/moduleList", 
           pageDataRangeInfo: "${ctx}/sm/element/dataRange", 
           dataRangeAddList:"${ctx}/sm/element/dataRange-add-list",
           dataRangeList:"${ctx}/sm/element/dataRange-list",
           dataRangeAddGroup:"${ctx}/sm/element/dataRange-add-group",
           saveDataRangeInfo:""
       }

        function setSelectGroupValue(elementId, sourceId) {
        	if (elementId) {
        		var addselect = { "elementId": elementId, "sourceId":sourceId };
        	} else {
        		var addselect = { "sourceId":sourceId };
        	}
            
            SetLayerData("AddOneElement", addselect);
        }
    	
    	function initDataRangerAddGroupHtml(json_datas) {
    		if (!json_datas) {
    			return;
    		}
    		
    		if (json_datas.success) {
    			var str_source_module = "";
    			var source_module = document.querySelector("#source_module [name=div_tabCotent]");
    			var sub_item = document.querySelector("#sub_item");
    			var $dataRangeGroup = $(GetLayerData("parentDataRange-group")).find("tbody tr td:nth-of-type(1)");
    			var findkeyFromTable = function(key) {
    				var result = false;
    				$dataRangeGroup.each(function(index, item) {
    					console.log($(item).text().trim(), key);
    					if ($(item).text().trim() === key) {
    						result = true;
    						return false;
    					}
    				});
    				
    				return result;
    			};
    			
    			//初始化源模块
    			json_datas.data.forEach(function(item, index) {
    				var str_subOption = "";
    				
    				if (index === 0) {
    					str_source_module += '<div moduleid="'+item.moduleId+'" class="selected">'+item.moduleName+'</div>'
    				} else {
    					str_source_module += '<div moduleid="'+item.moduleId+'">'+item.moduleName+'</div>'
    				}
    				
    				str_subOption = '<div name="div_tabCotent" data-moduled="'+item.moduleId+'">';
    				
    				item.elementList.forEach(function(el, i) {
    					if (findkeyFromTable($.trim(el.name))) {
    						return;
    					}
    					
    					str_subOption += '<div data-id="'+el.id+'" sourceid="'+el.id+'">'+el.name+'</div>';
    				});
    				
    				str_subOption += '</div>';
    				sub_item.innerHTML += str_subOption;
    			});
    			
    			
    			source_module.innerHTML = str_source_module;
    		}
    	}
    	
    	function initDataRangerAddGroup(json_datas) {
    		$("#cancle-add-select").click(function (event) {
                SetLayerData("AddOneElement", null);
                CloseIFrame();
            });
    
            initDataRangerAddGroupHtml(json_datas);
            
            //绑定选择源模块列表事件
            $("#source_module > div[name=div_tabCotent]>div").on("click", function(e) {
            	$("#source_module > div[name=div_tabCotent]>div").removeClass("selected")
            	$(this).addClass("selected");
            	
            	$("#sub_item >div[name=div_tabCotent]").hide();
            	$("#sub_item >div[name=div_tabCotent][data-moduled="+$(this).attr("moduleid")+"]").show();
            });
            
            //绑定选择子选项列表事件
            $("#sub_item > div[name=div_tabCotent]>div").on("click", function(e) {
            	$("#sub_item > div[name=div_tabCotent]>div").removeClass("checked")
            	$(this).addClass("checked");
            });
    	}

        $(document).ready(function () {
        	//评分元素新增或者编辑
        	$("#submit-add-select").click(function (event) {
        		var id = jyshen.getUrlParam("id");
        		var isNew = id?true:false;
        		
                event.preventDefault();
                
				var elementId = id;
				var sourceId = $("div[sourceid].checked").attr("sourceid");
				
                var formParsley = $('#form-add-select').parsley();
                if (formParsley.validate() && $("div[sourceid].checked").length > 0) {
                	
                    //ajax提交数据，在ajax的成功方法中添加下面语句

                    //实际上ID应该在AJAX提交数据后获得
					
                    setSelectGroupValue(elementId, sourceId);
                    CloseIFrame();
                } else {
                	new PNotify({
				        type: "warning",
				       	title: "",
				       	text: "请至少选择一项！",
				       	styling: 'bootstrap3',
					 });
					    
                }
            });
            
             $.ajax({
                url: currentPageUrl.moduleListUrl,
                type: "GET",
                dataType: "json",
                cache: false,
                async: false,
                success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                    initDataRangerAddGroup(result);
                }
            });
        });

    </script>
</body>
</html>
