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
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2> 调查照片配置 </h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-element">新增</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <table id="datatable" class="wd-table table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>图片组名称</th>
                            <th>默认照片最大数</th>
                            <th>默认是否允许相册选取</th>
                            <th>Key</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pagination.dataList}" var="photoSetting">
                            <tr listid="${photoSetting.id }">
                                <td>${photoSetting.name }</td>
                                <td>${photoSetting.maxLimit }</td>
                                <td>
                                    <input type="checkbox" ${photoSetting.album == 0 ? 'checked': ''} class="js-switch"  />
                                </td>
                                <td>${photoSetting.code }</td>
                                <td>
                                    <button type="button" class="btn wd-btn-small wd-btn-indigo btn-edit-element" data-id="${photoSetting.id }">编辑</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="dataTables_wrapper">${pagination}</div>
            </div>
        </div>
    </div>
    
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    
    <!-- 弹出层 -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    
    <!-- Switchery -->
    <script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
    <!-- jquery ui -->
    <script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>

    <script>
    	$(function(){
    		//switch初始化
    		if ($(".js-switch")[0]) {
                var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not([data-switchery])'));

                elems.forEach(function (html) {
                    var switchery = new Switchery(html, {
                        color: '#26B99A'
                    });
                });
            }
    		
    		// 子项必选
    	    $("#datatable").on("click", ".switchery", function () {
    	        var currentTr = $(this).closest("tr");
    	        var currentSwitch = $(this).prev(".js-switch");
    	        if (currentTr.length == 1 && currentSwitch.length == 1) {
    	            var itemId = currentTr.attr("listid"); //wd_default_simple_module_setting表的id
    	            var isRequest = currentSwitch.is(':checked') ? "0" : "1" ; //True Or False
    	            $.ajax({
    	                url : "${ctx }/wd/photoSetting/save",
    	                data : {"id" : itemId, "album" : isRequest},
    	                type: "post",
    	                success : function (data) {
    	                }
    	        	});
    	        }
    	    });
    		
    		 //新增模块
            $(document).on("click", "#btn-add-element", function () {
            	$.get("${ctx}/wd/photoSetting/form", null, function(data) {
            		OpenBigLayer("新增", data);
            	})
            });
            //编辑
            $(document).on("click", ".btn-edit-element", function () {
            	$.get("${ctx}/wd/photoSetting/form", {id : $(this).data("id")}, function(data) {
            		OpenBigLayer("编辑", data);
            	})
            });
            
          //排序拖动时的样式
			var fixHelperModified = function(e, tr) {
				var $originals = tr.children();
				var $helper = tr.clone();
				$helper.children().each(function(index) {
					$(this).width($originals.eq(index).width())
					$(this).css("background-color", "#CCCFD6");
				});
				return $helper;
			};
			
			//排序完成后的事件
			var updateIndex = function(e, ui) {
				var photoSettingIds = "";
				$("#datatable tbody tr").each(function(dom, index){
					photoSettingIds += $(this).attr("listid") + ",";
				})
				
				$.ajax({
		            url : "${ctx }/wd/photoSetting/sorts",
		            data : {photoSettingIds: photoSettingIds},
		            type: "post",
		            success : function (data) {
		            	if (data.code == 200) {
		            	}
		            }
		    	});
			};

			$("#datatable tbody").sortable({
				helper: fixHelperModified,
				stop: updateIndex
			}).disableSelection();
    	})
    	
    </script>
</body>
</html>