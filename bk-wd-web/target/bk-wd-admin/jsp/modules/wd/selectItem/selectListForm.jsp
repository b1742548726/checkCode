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
    <style type="text/css">
        ul.parsley-errors-list {
            position: absolute;
            top: .5em;
            right: -3em;
        }
    </style>
</head>
<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <br />
                    <form id="form-add-select" data-parsley-validate class="form-horizontal form-label-left">
                        <input type="hidden" id="hidden-listId" name="id" value="${wdSelectList.id }">
                        <input type="hidden" id="hidden-groupId" name='selectGroupId' value="${wdSelectList.selectGroupId }">
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selectName">
                                名称 <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" id="selectName" name="name" value="${wdSelectList.name }" required="required" class="form-control col-md-7 col-xs-12">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selectCode">
                                代码 <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" id="selectCode" name="code" value="${wdSelectList.code }" required="required" class="form-control col-md-7 col-xs-12" value="Gender">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selectRemarks">说明 </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <textarea id="selectRemarks" name="remarks" class="form-control col-md-7 col-xs-12" rows="4">${wdSelectList.remarks }</textarea>
                            </div>
                        </div>
                    </form>
                </div>
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

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script type="text/javascript">
        function setSelectListValue(id) {
            var addselect = { "name": $("#selectName").val(), "code": $("#selectCode").val(), "groupId": $("#hidden-groupId").val(), "id": id };
            SetLayerData("AddOneSelectList", addselect);
        }

        $(document).ready(function () {
            $("#cancle-add-select").click(function (event) {
                SetLayerData("AddOneSelectList", null);
                CloseIFrame();
            });

            $("#submit-add-select").click(function (event) {
                event.preventDefault();

                var formParsley = $('#form-add-select').parsley();
                if (formParsley.validate()) {
                    //ajax提交数据，在ajax的成功方法中添加下面语句
                    $.ajax({
        				url : "${ctx}/wd/selectItem/editSelectList",
        				data : $("#form-add-select").serialize(),
        				type: "post",
        				success : function (data){
        					if (data.code == 200) {
        						setSelectListValue(data.data.id);
    		                    CloseIFrame();
        					}
        				}
        			})
                }
            });

            if ("${wdSelectList.id }") {
                $("#selectCode").attr("readonly", "readonly");
            }
        });
    </script>
</body>
</html>