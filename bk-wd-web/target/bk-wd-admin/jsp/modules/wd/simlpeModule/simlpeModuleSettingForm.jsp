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
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>

    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <br />
                    <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="form-group">

                            <table id="datatable" class="wd-table table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th style="width:20%;"> 业务元件 </th>
                                        <th> 描述 </th>
                                        <th style="width:12%;"></th>
                                    </tr>
                                </thead>

                                <tbody>
                                	<c:forEach items="${elementList}" var="businessElement">
                                    <tr>
                                        <td>${businessElement.name }</td>
                                        <td>${businessElement.remarks }</td>
                                        <td>
                                            <input type="checkbox" class="flat" ${not empty businessElement.moduleSettingId ? 'checked': ''} data-checked="${not empty businessElement.moduleSettingId ? '1': '2'}" data-elementid="${businessElement.id }" elementname="${businessElement.id }">
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-xs-12 wd-center">
                <button class="bt wd-btn-normal wd-btn-width-middle wd-btn-white" type="button" id="cancle-add-module">取消</button>
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-viridity" type="submit" id="submit-add-module">确认</button>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="${imgStatic}/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="${imgStatic}/vendors/iCheck/icheck.min.js"></script>
    
    
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script type="text/javascript"> 
        $(document).ready(function () {
            if ($("input.flat")[0]) {
                $('input.flat').iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
            }

            $("#cancle-add-module").click(function (event) {
                CloseIFrame();
            });

            $("#submit-add-module").click(function (event) {
                event.preventDefault();
                
                var delBussinessElementIds = '';
                var newBussinessElementIds = '';
            	$("input.flat").each(function(dom, index){
            		var checked = $(this).is(':checked');
            		if ($(this).data("checked") == 1) {
            			if (!checked) {
            				delBussinessElementIds += $(this).data("elementid") + ",";
                		}
            		} else if($(this).data("checked") == 2) {
            			if (checked) {
            				newBussinessElementIds += $(this).data("elementid") + ",";
                		}
            		}
            	})
                
                var moduleSetting = { "simpleModuleId": "${wdDefaultSimpleModule.id}", "newBussinessElementIds": newBussinessElementIds, "delBussinessElementIds" : delBussinessElementIds};
				
                $.ajax({
                    url : "${ctx }/wd/simlpeModule/saveItem",
                    data : moduleSetting,
                    type: "post",
                    success : function (data) {
                    	if (data.code == 200) {
                    		//ajax提交数据，在ajax的成功方法中添加下面语句
                            CloseIFrame();
                    	}
                    }
            	});		
            });
        });
    </script>
</body>
</html>