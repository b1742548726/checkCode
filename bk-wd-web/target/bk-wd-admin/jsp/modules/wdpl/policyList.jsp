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

    <title>贷后-回访策略</title>

    <!-- Bootstrap -->
    <link href="${ imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${ imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${ imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="${ imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${ imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${ imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

    <link href="${imgStatic}/zwy/LBQ/css/popup_style.css" rel="stylesheet">
    
    <!-- Custom Theme Style -->
    <link href="${ imgStatic }/build/css/custom.css" rel="stylesheet">
    
    <link href="${ imgStatic }/zwy/css/afterLoanPolicy.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${ imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<body>
    <!-- page content -->

    <div id="afterLoanList" class="wd-content">

        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <!--表格标签-->
            <div name="div_headLabel" class="div_headLabel">
                <!--标签加了个URL的属性，到时候只要查找选中标签的URL就可以了-->
                <span class="span_label" data-type="1">首次回访策略</span>
                <span class="span_label" data-type="2">定期回访策略</span>
                <span class="span_label" data-type="3">到期回访策略</span>
                <span class="span_label" data-type="4">风险定询策略</span>
                
                <div id="btn-add-product" class="div_cross div_atferLoanCross"></div>
                
                <div class="div_line_noMargin"></div>
            </div>
            <!--结束表格标签-->
            
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table">
                    <thead>
                        <tr>
                            <th> 策略应用产品 </th>
                            <th> 策略应用客户类型 </th>
                            <th> 策略应用还款方式 </th>
                            <th> 策略应用金额 </th>
                            <th> 是否有房 </th>
                            <th> 是否启用</th>
                            <th> 操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${policyList }" var="policy">
                            <tr productid="${policy.id }">
                                <td>
                                    <c:choose>
                                        <c:when test="${policy.isAllProduct() }">
                                            所有产品
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${policy.getProductIdList() }" var="productId">
                                                <spring:eval expression="@wdProductService.selectByPrimaryKey(productId)" var="product"/>
                                                ${product.name }，
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${policy.isAllCustomerType() }">
                                            所有客户类型
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${policy.getCustomerTypeIdList() }" var="customerTypeId">
                                                <spring:eval expression="@wdCustomerTypeService.selectByPrimaryKey(customerTypeId)" var="customerType"/>
                                                ${customerType.name }，
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${policy.isAllRepaymentCategory() }">
                                            所有还款方式
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${policy.getRepaymentCategoryList() }" var="repaymentCategory">
                                                ${repaymentCategory }，
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${policy.minAmount } ~ ${policy.maxAmount }</td>
                                <td>${policy.getHasHouseDesc() }</td>
                                <td>
                                    <c:if test="${policy.enable eq '0'}">
                                        <button type="button" class="btn wd-btn-small wd-btn-orange wd-btn-round btn-enable-product">已禁用</button>
                                    </c:if>
                                    <c:if test="${policy.enable eq '1'}">
                                        <button type="button" class="btn wd-btn-small wd-btn-viridity wd-btn-round btn-disable-product">已启用</button>
                                    </c:if>
                                </td>
                                <td>
                                    <button type="button" name="btn_del" class="btn wd-btn-small btn_newDel btn-del-product"></button>
                                    <button type="button" name="btn_edit" class="btn wd-btn-small btn_newEdit btn-edit-product"></button>
                                </td>
                            </tr>
                        </c:forEach>
                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- /page content -->
    <!-- jQuery -->
    <script src="${ imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${ imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- PNotify -->
    <script src="${ imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${ imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${ imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

    <script src="${ imgStatic }/zwy/js/wd-common.js"></script>

    <script src="${ imgStatic }/vendors/layer/layer.js"></script>
    <script src="${ imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${ imgStatic }/zwy/js/pnotify-customer.js"></script>

    <script type="text/javascript">

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        // 写上真是的地址
        var currentPageUrl = {
            editCallbackPolicy: "${ctx}/wdpl/callback/policy/form", // 编辑回访策略
            editCallbackPolicy: "${ctx}/wdpl/riskInquiry/policy/form", // 编辑风险定询策略
        };

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        // 刷新页面，重新载入数据
        function ReloadData() {
			location.reload();
        }

        function EnableProduct(button) {
            var productTr = $(button).parents("tr[productid]");
            var productId = productTr.attr("productid");

            var enable = $(button).hasClass("btn-disable-product") ? "0" : "1";
            
            var url = "${ctx}/wdpl/callback/policy/enable";
        	if ("${policyType}" == "4") {
        		url = "${ctx}/wdpl/riskInquiry/policy/enable";
        	}

            $.ajax({
                url: url + "?id=" + productId + "&enable=" + enable,
                type: "GET",
                dataType: "json",
                cache: false,
                success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
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
                        NotifyError(result.msg, (enable == "0" ? "禁用" : "启用") + "时出现一个错误");
                    }
                }
            });
        }

        function DelProduct(button) {
            var url = "${ctx}/wdpl/callback/policy/del";
        	if ("${policyType}" == "4") {
        		url = "${ctx}/wdpl/riskInquiry/policy/del";
        	}
        	var productTr = $(button).parents("tr[productid]");
        	var productId = productTr.attr("productid");
            Confirm("是否确认删除该策略？", function () {
                $.ajax({
                    url: url + "?id=" + productId,
                    type: "GET",
                    dataType: "json",
                    cache: false,
                    success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                        if (result.success) {
                            productTr.fadeOut(512, function () {
                                productTr.remove();
                            });

                            //刷新页面，重新载入数据
                            ReloadData();
                        } else {
                            NotifyError(result.msg, "删除" + "时出现一个错误");
                        }
                    }
                });
            });
        }

        function EditProduct(productId) {
        	var url = "${ctx}/wdpl/callback/policy/form?callbackType=${policyType}";
        	if ("${policyType}" == "4") {
        		url = "${ctx}/wdpl/riskInquiry/policy/form?a=1";
        	}
        	var title = $(".span_label[data-type=${policyType}]").text();
        	if (productId) {
        		url += "&id=" + productId;
        		title = "编辑" + title;
        	}  else {
        		title = "新增" + title;
        	}
            OpenFullIFrame(title, url  + "&r=" + Math.random(), function(){
            	if (GetLayerData("_save_policy")) {
                	SetLayerData("_save_policy", null);
                    ReloadData();
            	}
            });
        }

        $(document).ready(function () {
            // 删除产品
            $(".btn-del-product").click(function () {
                DelProduct(this);
            });

            // 已禁用产品
            $(".btn-enable-product").click(function () {
                EnableProduct(this);
            });

            // 已禁用产品
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
            
            //点击LABEL按钮时切换状态
            $(".span_label").on("click", function() {
               location.href = "${ctx}/wdpl/policy/list?policyType=" + $(this).attr("data-type");
            });
            
            $(".span_label[data-type=${policyType}]").addClass("checked");
        });
    </script>
</body>
</html>