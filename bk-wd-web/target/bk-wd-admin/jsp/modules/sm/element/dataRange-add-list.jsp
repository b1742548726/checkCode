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

    <title></title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/css/scoreModule.css" rel="stylesheet">
</head>
<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <!--<div class="x_title">
                    <h2> 新增或编辑List </h2>
                    <div class="clearfix"></div>
                </div>-->
                <div class="x_content">
                    <br />
                    <form id="form-add-select" data-parsley-validate class="form-horizontal form-label-left">
                        <input type="hidden" id="hidden-listId" value="">
                        <input type="hidden" id="hidden-groupId" value="">
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selectName">
                                名称 <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" id="selectName" name="selectName" required="required" class="form-control col-md-7 col-xs-12">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="form-group subItem_buttonWrap">
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

	<!-- Layer -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    <script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>

    <script type="text/javascript">
		
		
        
        function init_dataRangeAddList() {
        	var g_id = jyshen.getUrlParam("sourceid");
			var g_type = jyshen.getUrlParam("type");
			
        	$("#cancle-add-select").click(function (event) {
                SetLayerData("AddOneSelectList", null);
                CloseIFrame();
            });
			
			
			//新增区间保存
            $("#submit-add-select").click(function (event) {
                event.preventDefault();
                var dataconfigid = jyshen.getUrlParam("dataconfigid");
                var isnew = dataconfigid?false:true;

				var formParsley = $('#form-add-select').parsley();
                if (formParsley.validate()) {
                    //ajax提交数据，在ajax的成功方法中添加下面语句

                    //实际上ID应该在AJAX提交数据后获得
                    var id = $("#hidden_souceid").val();
                    if (id == "") {
                        id = "xxxxxxxxxxxxx";
                    }
					
					if (isnew) {	//新增	
                    	SetLayerData("AddOneSelectList", {id:g_id, type:g_type, name:$("#selectName").val()});
 	                } else {	//编辑	
 	                	
 	                	SetLayerData("AddOneSelectList", {name:$("#selectName").val(), code:$("#selectKey").val()});
    	            }
                   
                    CloseIFrame();
                }
            });
        }

        $(document).ready(function () {
            init_dataRangeAddList();
        });

    </script>
</body>
</html>
