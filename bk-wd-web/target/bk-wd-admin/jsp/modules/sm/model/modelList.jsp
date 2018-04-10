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
</head>
<body>
    <!-- page content -->
<style>

</style>
    <div id="id_scoreModuleList" class="wd-content">

        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title non_bottom_border">
                <h2>  </h2>
            </div>
            
            
            <!--表格标签-->
            <div name="div_headLabel" class="div_headLabel">
                <div class="wd-piece-title"><h2>评分模型列表</h2></div>
                
                <div id="btn_add" class="div_cross div_atferLoanCross"></div>
                
                <div class="div_line_noMargin"></div>
            </div>
            <!--结束表格标签-->
            
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table">
                    <thead>
                        <tr>
                            <th> 名称 </th>
                            <th> 描述 </th>
                            <th> 当前状态 </th>
                            <th> 操作 </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pagination.dataList}" var="data">
                            <tr id="${data.id }">
                                <td> ${data.name } </td>
                                <td> ${data.remarks } </td>
                                <td>
                                    <c:if test="${data.enable eq '0'}">
                                        <button type="button" class="btn wd-btn-small wd-btn-orange wd-btn-round btn-enable-product">已禁用</button>
                                    </c:if>
                                    <c:if test="${data.enable eq '1'}">
                                        <button type="button" class="btn wd-btn-small wd-btn-viridity wd-btn-round btn-disable-product">已启用</button>
                                    </c:if>
                                </td>
                                <td>
                                    <button type="button" name="btn_del" class="btn wd-btn-small btn_newDel"></button>
                                    <button type="button" name="btn_edit" class="btn wd-btn-small btn_newEdit"></button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="dataTables_wrapper">${pagination}</div>
            </div>
        </div>
       <!--  <div name="name_shade">
            <div style="" class="layui-layer layer-anim dom_center" tabindex="0" name="div_addNewPanel">
                <div class="layui-layer-title" style="cursor: move;">
                    请选择
                    <span class="layui-layer-setwin">
                        关闭按钮
                        <a class="layui-layer-ico layui-layer-close layui-layer-close1" href="javascript:void(0)"></a>
                    </span>
                </div>
                <div class="layui-layer-content" style="margin-top:2em">
                    <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn_add_new">直接新增</button>
                    或
                    <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn_cp">拷贝模型</button>
                    
                    <select id="sel_cpModule">
                        <option value="0">请选择想要拷贝的评分模型</option>
                        <option value="asdadf2">模型1</option>
                    </select>
                </div>
            </div>
        </div> -->
    </div>
    <!-- /page content -->
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

    <script src="${imgStatic }/zwy/js/wd-common.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    <script src="${imgStatic }/zwy/js/scoreModule.js"></script>
    <script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>

    <script type="text/javascript">
    	var currentPageUrl = {
            editModelUrl: "${ctx}/sm/model/form", // 编辑回访策略
            delModelUrl : "${ctx}/sm/model/delete",
            enableUrl: "${ctx}/sm/model/enable"
        };
    
        function ReloadData() {
            location.reload();
        }

        function show_addNew() {
            $("[name=name_shade]").show();
        }
        
        function do_del(button) {
            var _tr = $(button).parents("tr[id]");
            var _id = _tr.attr("id");
            Confirm("是否确认删除该产品？", function () {
                $.ajax({
                    url: currentPageUrl.delModelUrl,
                    type: "POST",
                    data : {id : _id},
                    dataType : "json",
                    success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                        if (result.success) {
                            ReloadData();
                        }
                    }
                });
            });
        }
        
        function EnableProduct(button) {
        	 var _tr = $(button).parents("tr[id]");
             var _id = _tr.attr("id");
            var enable = $(button).hasClass("btn-disable-product") ? "0" : "1";
            $.ajax({
                url: currentPageUrl.enableUrl + "?id=" + _id + "&enable=" + enable,
                type: "POST",
                dataType: "json",
                success: function (result) { // result要求返回Json，格式{ "success": false, "msg": "!@#$%^&**&^%^^$#@!" }
                    if (result.success) {
                        if (enable == "0") {
                            $(button).removeClass("wd-btn-viridity btn-disable-product");
                            $(button).addClass("wd-btn-orange btn-enable-product");
                            $(button).html("已禁用");
                        } else {
                            $(button).removeClass("wd-btn-orange btn-enable-product");
                            $(button).addClass("wd-btn-viridity btn-disable-product");
                            $(button).html("已启用");
                        }
                    } else {
                        NotifyError(result.msg, (enable == "0" ? "禁用" : "启用") + "产品【" + productName + "】时出现一个错误");
                    }
                }
            });
        }

        function do_edit(_id) {
            var _params = _id ? "id=" + _id : "1=1";
            OpenFullIFrame(
            		(_id ? "编辑" :"新增") + "评分模型 ",
                currentPageUrl.editModelUrl + "?" + _params + "&r=" + Math.random(),
                function () {
    			    if (GetLayerData("_save_scoreModule")) {
                      	SetLayerData("_save_scoreModule", null);
                        ReloadData();
                  	}
                });
        }

        $(document).ready(function () {
            // 删除产品
            $(".btn_newDel").click(function () {
                do_del(this);
            });


            // 新增产品
            $("#btn_add").click(function () {
                do_edit();
            });

            // 编辑产品
            $(".btn_newEdit").click(function () {
                var _tr = $(this).parents("tr[id]");
                var _id = _tr.attr("id");
                
                do_edit(_id);
            });
            
         	// 禁用产品
            $(".btn-enable-product").click(function () {
                EnableProduct(this);
            });

            // 啟用产品
            $(".btn-disable-product").click(function () {
                EnableProduct(this);
            });
            
            //初始化shade的关闭按钮
            $(".layui-layer-close").on("click", function(e) {
                $(this).closest("[name=name_shade]").hide();
            });
            
        });
    </script>
</body>
</html>