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

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>

<body>
    <!-- page content -->
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title non_bottom_border">
                <h2> 产品列表 </h2>
                <!-- <input id="customer-type-id" name="customer-type-id" type="hidden" value="00000000-0000-0000-0000-000000000000" /> -->
                <!-- <input id="customer-type-version" name="customer-type-version" type="hidden" value="" /> -->
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-product" style="margin-right:0px;">
                            新增
                        </button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table">
                    <thead>
                        <tr>
                            <th> 编号 </th>
                            <th style="width:120px"> 产品大类 </th>
                            <th style="width:240px"> 产品名称 </th>
                            <th> 英文简称 </th>
                            <th> 产品描述 </th>
                            <th style="width:80px"> 状态 </th>
                            <th style="width:220px"> 最后更新时间 </th>
                            <th style="width:160px"> </th>
                        </tr>
                    </thead>
                    
                    <tbody>
                        <c:forEach items="${pagination.dataList}" var="data">
                            <tr productid="${data.id }">
                                <td>${data.code }</td>
                                <td>${data.category }</td>
                                <td>${data.name }</td>
                                <td>${data.nameEn }</td>
                                <td>${data.remarks }</td>
                                <td>
                                    <c:if test="${data.enable eq '0'}">
                                        <button type="button" class="btn wd-btn-small wd-btn-orange wd-btn-round btn-enable-product">已禁用</button>
                                    </c:if>
                                    <c:if test="${data.enable eq '1'}">
                                        <button type="button" class="btn wd-btn-small wd-btn-viridity wd-btn-round btn-disable-product">已启用</button>
                                    </c:if>
                                </td>
                                <td><fmt:formatDate value="${data.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <button type="button" class="btn wd-btn-small wd-btn-orange btn-del-product">删除</button>
                                    <button type="button" class="btn wd-btn-small wd-btn-gray btn-edit-product">编辑</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
               <%--  <div class="dataTables_wrapper">${pagination}</div> --%>
            </div>
        </div>
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

   <!--  <script src="${imgStatic }/zwy/js/wd-common.js"></script> -->

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    <script type="text/javascript">

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        // 写上真是的地址
        var currentPageUrl = {
            delProduct: "${ctx}/wd/product/delete", // 删除产品的地址，参数：product_id，请求方式：GET，返回值：Json，格式{ "result": false, "error": "xxxxxxxxxxxxxxxxxxx" }
            enableProduct: "${ctx}/wd/product/disable", // 启用禁用产品的地址，参数：product_id、enable（1/0），请求方式：GET，返回值：Json，格式{ "result": false, "error": "xxxxxxxxxxxxxxxxxxx" }
            editProduct: "${ctx}/wd/product/form", // 编辑产品的地址，参数：product_id（无表示新增），请求方式：GET，返回值：Page }
        };

        function ReloadData() {
			location.reload();
        }

        function EnableProduct(button) {

            var productTr = $(button).parents("tr[productid]");
            var productId = productTr.attr("productid");
            var productName = productTr.children("td:eq(1)").html().trim();

            var enable = $(button).hasClass("btn-disable-product") ? "0" : "1";

            $.ajax({
                url: currentPageUrl.enableProduct + "?id=" + productId + "&enable=" + enable,
                type: "GET",
                dataType: "json",
                async: false,
                cache: false,
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

        function DelProduct(button) {

            var productTr = $(button).parents("tr[productid]");
            var productId = productTr.attr("productid");
            var productName = productTr.children("td:eq(1)").html().trim();

            Confirm("是否确认删除该产品？", function () {
                $.ajax({
                    url: currentPageUrl.delProduct + "?id=" + productId,
                    type: "GET",
                    dataType: "json",
                    async: false,
                    cache: false,
                    success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                        if (result.success) {
                            productTr.fadeOut(512, function () {
                                productTr.remove();
                            });
                            //刷新页面，重新载入数据
                            ReloadData();
                        } else {
                            NotifyError(result.msg, "删除产品【" + productName + "】时出现一个错误");
                        }
                    }
                });
            });
        }

        function EditProduct(productId) {
            OpenFullIFrame(
                "产品配置",
                currentPageUrl.editProduct + "?id=" + productId + "&r=" + Math.random(),
                function () {
                	if (GetLayerData("_save_product")) {
                    	SetLayerData("_save_product", null);
                        ReloadData();
                	}
                });
        }

        $(document).ready(function () {
            // 删除产品
            $(".btn-del-product").click(function () {
                DelProduct(this);
            });

            // 禁用产品
            $(".btn-enable-product").click(function () {
                EnableProduct(this);
            });

            // 啟用产品
            $(".btn-disable-product").click(function () {
                EnableProduct(this);
            });

            // 新增产品
            $("#btn-add-product").click(function () {
                EditProduct();
            });

            // 编辑产品
            $(".btn-edit-product").click(function () {
                var productTr = $(this).parents("tr[productid]");
                var productId = productTr.attr("productid");

                EditProduct(productId);
            });
        });
        function page(n,s){
			$("#current").val(n);
			$("#searchForm").submit();
        	return false;
        }
    </script>
</body>
</html>