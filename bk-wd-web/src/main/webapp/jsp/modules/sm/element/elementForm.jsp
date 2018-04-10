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

    <title>数据区间设置</title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

    <link href="${imgStatic }/zwy/LBQ/css/popup_style.css" rel="stylesheet">
    
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/css/afterLoanPolicy.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/css/scoreModule.css" rel="stylesheet">

    <style type="text/css">
        
    </style>
</head>

<body>
    <!-- page content -->

    <div class="wd-content">
        <div class="wd-piece-title">
            <h2> 评分源配置 </h2>
        </div>
        <div class="div_line"></div>
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12" id="wd-piece-content">
            <div class="col-md-6 col-sm-6 col-xs-12 wd-nonmargin" style="border-right:1px solid rgb(204,204,204); padding:10px 15px;">
                <div class="form-group">
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-group">新增</button>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="form-group" id="dataRange">
                </div>
            </div>

        </div>
    </div>
    <!-- /page content -->
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
    <script src="${imgStatic }/zwy/js/afterLoanPolicy.js"></script>
    
    <script type="text/javascript">
        var currentPageUrl = {
    		 elementListUrl: "${ctx}/sm/element/list", //初始化列表
    		 moduleListUrl : "${ctx}/sm/element/moduleList", 
            pageDataRangeInfo: "${ctx}/sm/element/dataRange", 
            dataRangeAddList:"${ctx}/sm/element/dataRange-add-list",
            dataRangeList:"${ctx}/sm/element/dataRange-list",
            dataRangeAddGroup:"${ctx}/sm/element/dataRange-add-group",
            saveDataRangeInfo:"",
            saveDataConfig : "${ctx}/sm/element/saveDataConfig",
            deleteDataConfig : "${ctx}/sm/element/deleteDataConfig",
            saveSmElement: "${ctx}/sm/element/saveSmElement",
            deleteSmElement: "${ctx}/sm/element/deleteSmElement",
            saveSelectItems : "${ctx}/sm/element/saveSelectItems",
            saveDataConfigItems : "${ctx}/sm/element/saveDataConfigItems",
            pngGreatThan:"${imgStatic }/zwy/img/greatThan.png",
            pngGreat:"${imgStatic }/zwy/img/great.png",
            pngLessThan:"${imgStatic }/zwy/img/lessThan.png",
            pngLess:"${imgStatic }/zwy/img/less.png"
        }
    </script>
    
    <script src="${imgStatic }/zwy/js/scoreModule.js"></script>
        
    <script type="text/javascript">
        //新增和修改评分元素
        function AddOrEditGroup() {
            var json_datas = GetLayerData("AddOneElement");
            console.log(json_datas)
            if (json_datas) {   //新增
            	SetLayerData("AddOneElement", null)
            	$.ajax({
                    url: currentPageUrl.saveSmElement,
                    type: "POST",
                    data : json_datas,
                    dataType: "json",
                    success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                        if (result.success) {
                         	location.reload();   
                        }
                    }
                });
            }
            //ajax 后回调RELOAD
        }
        
        //这里是新增区间方法
        function saveSelectListValue(obj, dataConfigId) {
            var json_datas = {}, str_thead = "";
            
            json_datas.success = true; 
            json_datas.name = obj.name;
            json_datas.elementId = obj.id;
            
            SetLayerData("AddOneSelectList", json_datas);
            obj.elementId = obj.id;
            delete obj.id;
            var data = obj;
            
            //ajax的回调函数APPEND列表项
            appendDataRangeList(data, dataConfigId);
            //结束AJAX
            if (obj.type === 1) {       //数值区间
                $(".x_panel[data-sourceid="+obj.id+"] table[data-sourceid] tbody").append("");
            }
        }
        
        $(document).ready(function () {
        	 //评分元素列表
        	 $.ajax({
                url: currentPageUrl.elementListUrl,
                type: "GET",
                dataType: "json",
                cache: false,
                success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                	if (result.success) {
                		//这里的JSON是评分元素列表
                        init_DataRange(result);
                    }
                }
            });
        	 
            // 删除Group
            $(document).on("click", ".btn-del-group", function () {
                var currentTr = $(this).parents("tr");
                Confirm("是否确认删除该项？", function() {
                    var json_datas = {elementId:currentTr.attr("data-id")};
                    if (currentTr.length == 1) {
                        var groupId = currentTr.attr("data-id"); //wd_select_group表的id
                        $.ajax({
                            url: currentPageUrl.deleteSmElement,
                            type: "POST",
                            data : {elementId : groupId},
                            dataType: "json",
                            success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                                if (result.success) {
                                	currentTr.fadeOut(512, function () {
                                        currentTr.remove();
                                    });
                                }
                            }
                        });
                    }
                });
                
            });

            //新增dataConfig
            $(document).on("click", ".btn-add-group-item", function () {
                var currentTr = $(this).parents("tr");
                var groupId = $(this).attr("data-id");
                var type = $(this).closest("tr").attr("data-elementtype");
                
                OpenIFrame("新增区间", currentPageUrl.dataRangeAddList + "?sourceid=" + groupId + "&type=" + type, "1000px", "300px", function () {
                    var obj = GetLayerData("AddOneSelectList");
                    console.log(obj)
                    if (obj) {
                        $(currentTr.children("td")[0]).click();
                        //ajax
                        var json_datas = {name:obj.name, elementId:groupId};
                        $.ajax({
                            url: currentPageUrl.saveDataConfig,
                            type: "POST",
                            data: json_datas,
                            dataType: "json",
                            success: function (result) {
                            	if (result.success) {
                                     saveSelectListValue(obj, result.data.id);
                                     init_dataRangeList();
                            	}
                            }
                        });
                    }
                });
            });

            //修改dataConfig
            $(document).on("click", ".btn-edit-list", function () {
                var listId = $(this).data("id");
                var listTitle = $(this).parents(".x_title").children("h2");

                console.log(listTitle);
                
                OpenIFrame("编辑区间", currentPageUrl.dataRangeAddList+ "?dataconfigid=" + listId, "1000px", "300px", function () {
                    var addlist = GetLayerData("AddOneSelectList");
                    if (addlist) {
                        $(listTitle).html(addlist.name);
                        //ajax
                        var json_datas = {dataConfigId:listId, name:addlist.name};
                        $.ajax({
                            url: currentPageUrl.saveDataConfig,
                            type: "POST",
                            data: json_datas,
                            dataType: "json",
                            success: function (result) {}
                        });
                    }
                });
            });

            // 删除dataConfig
            $(document).on("click", ".btn-del-list", function () {
                var listId = $(this).attr("data-id"); //wd_select_list表的id
                
                Confirm("是否确认删除该项？", function() {
                    //ajax请求删除对应的item
                    var json_datas = {dataConfigId:listId};
                    //……
                    console.log(listId);
                    $.ajax({
                        url: currentPageUrl.deleteDataConfig,
                        type: "POST",
                        data: json_datas,
                        dataType: "json",
                        success: function (result) {
                        	if (result.success) {
                        		 var currentPanl = $(".x_panel[data-id=" + listId + "]");
                                 currentPanl.fadeOut(512, function () {
                                     currentPanl.remove();
                                 });
                        	}
                        }
                    });
                });
            });

            // 删除Item
            $(document).on("click", ".btn-del-item", function () {
                var currentTr = $(this).parents("tr");
                
                Confirm("是否确认删除该项？", function() {
                    if (currentTr.length == 1) {
                        var itemId = currentTr.attr("itemid"); //wd_select_item表的id
    
                        //ajax请求删除对应的item
                        //……
                        var json_datas = {dataConfigId:$(this).attr("data-id")};
                        
                        console.log(json_datas);
                        
                        currentTr.fadeOut(512, function () {
                            currentTr.remove();
                        });
                    }
                });
            });
            
           //保存多个items
            $(document).on("click", "[name=btn_saveItems]", function () {
            	var dataConfigId = $(this).attr("data-id");
                var currentTr = $(this).parents("tr");
                var $tr = $(this).closest(".x_content").find("table[data-id="+dataConfigId+"] tbody tr");
                var _data = []
                var _url = currentPageUrl.saveDataConfigItems;
                if ($tr.length > 0 ) {
                	$tr.each(function(index, item) {
                		var obj = {};
                		obj.minValue = $(item).find("[name=txt_great]").val();
                		obj.maxValue = $(item).find("[name=txt_less]").val();
                		obj.score = $(item).find("[name=txt_score]").val();
                		obj.id = item.getAttribute("data-id");
                		_data.push(obj);
                        
                        if (obj.minValue === undefined) {
                         	_url = currentPageUrl.saveSelectItems;
                        } 
                	});
                	if (validate_dateRangeList(this)) {
                    	$.ajax({
                            url: _url,
                            type: "POST",
                            data: {itemData : JSON.stringify(_data), dataConfigId: dataConfigId},
                            dataType: "json",
                            success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                            	if (result.success) {
                            		new PNotify({
                				        type: "info",
                				       	title: "",
                				       	text: "保存成功！",
                				       	styling: 'bootstrap3',
                					 });
                                }
                            }
                        });
                	}
                }
                
            });
            
        });
    </script>
</body>
</html>