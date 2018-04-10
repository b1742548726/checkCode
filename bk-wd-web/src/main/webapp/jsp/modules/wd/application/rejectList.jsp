<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title></title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet" />
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet" />
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet" />
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet" />

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet" />

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet" />

    <style type="text/css">
        table#appliaction-list tbody tr td:first-child {
            text-align: center;
        }

        table#appliaction-list tbody tr td:last-child {
            text-align: center;
        }

        table#appliaction-list tbody tr td:nth-child(3) {
            text-align: center;
        }

        table#appliaction-list tbody tr td:nth-child(5) {
            text-align: center;
        }

        table#appliaction-list tbody tr td:nth-child(6) {
            text-align: center;
        }

        table#appliaction-list tbody tr td:nth-child(7) {
            text-align: center;
        }
    </style>
</head>

<body>
    <!-- page content -->

    <div class="wd-content">

        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <form action="${ctx}/wd/application/rejectList" id="searchForm" method="get">
                <input id="current" name="current" type="hidden" value="1"/>
                <div class="list-page-search-div col-xs-12">
                    <div class="col-md-10 col-sm-10 col-xs-12">
                        <div class="col-xs-3">
                            <span class="col-xs-11"> 客户姓名 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="customerName" value="${params.customerName }" id="search-name" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3">
                            <span class="col-xs-11"> 商户/公司/单位 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="shopCompany" value="${params.shopCompany }" id="search-company" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3">
                            <span class="col-xs-11"> 贷款编号 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="applicationCode" value="${params.applicationCode }" id="search-application" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3">
                            <span class="col-xs-11"> 贷款产品 </span>
                            <div class="col-xs-11">
                                <spring:eval expression="@wdProductService.selectByRegion(currentUser.companyId)" var="productList"/>
                                <select class="form-control" name="productId">
                                    <option value="">全部</option>
                                    <c:if test="${not empty productList}">
                                        <c:forEach items="${productList}" var="product">
                                            <option value="${product.id }" ${product.id eq params.productId ? 'selected' : '' }>${product.name }</option>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                    </div>
    
                    <div class="col-md-2 col-sm-2 col-xs-12">
                        <div class="col-xs-12">
                            <span class="col-xs-12"> 客户类型 </span>
                            <div class="col-xs-12">
                                <spring:eval expression="@wdCustomerTypeService.selectByRegion(currentUser.companyId)" var="customerTypeList"/>
                                <select class="form-control" name="customerTypeId">
                                    <option value="">全部</option>
                                    <c:if test="${not empty customerTypeList}">
                                        <c:forEach items="${customerTypeList}" var="customerType">
                                            <option value="${customerType.id }" ${customerType.id eq params.customerTypeId ? 'selected' : '' }>${customerType.name }</option>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                        </div>
    
                    </div>
                </div>
            </form>
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table" id="appliaction-list">
                    <thead>
                        <tr>
                            <th style="width:120px"> 客户名称 </th>
                            <th> 商户/公司 </th>
                            <th style="width: 88px;"> 客户类型 </th>
                            <th style="width: 148px;"> 贷款产品 </th>
                            <th style="width: 220px;"> 申请时间 </th>
                            <th style="width: 220px;"> 拒绝时间 </th>
                            <th style="width: 160px;"> 贷款编号 </th>
                            <%--<th style="width: 100px;"></th>--%>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pagination.dataList }" var="application">
                            <tr>
                                 <td>
                                    <span class="td-span-block" customerid="${application.customerId}"> ${application.wdPerson.getJsonData().base_info_name} </span>
                                </td>
                                <td>
                                    ${not empty application.wdPerson.getJsonData().base_info_shop_name ? application.wdPerson.getJsonData().base_info_shop_name : application.wdPerson.getJsonData().base_info_company_name}
                                </td>
                                <td> ${application.wdCustomer.customerTypeName} </td>
                                <td> ${application.productName} </td>
                                <td> <fmt:formatDate value="${application.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                <td> <fmt:formatDate value="${application.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                <td>
                                   ${application.code }
                                </td>
                                <%--<td>--%>
                                    <%--<button type="button" class="btn wd-btn-small wd-btn-orange resubmit" applicationid="${application.id }"> 重新提交 </button>--%>
                                <%--</td>--%>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="dataTables_wrapper">${pagination}</div>
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

    <script src="${imgStatic }/zwy/js/wd-common.js"></script>
    <script src="${imgStatic }/zwy/js/wd-common-bind.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>

    <script type="text/javascript">
        var currentPageUrl = {
            customer: "${ctx }/wd/customer/detail", // 客户详情页
            application: "${ctx}/wd/application/detail", // 贷款详情页
            resubmit: "", // 退回的地址
        };

        function SearchApplication() {
        	searchForm.submit();
        }

        function ReloadData() {
        	$("#current").val(n);
        	searchForm.submit();
        }

        $(function () {

        	 // 跳转客户详情
            $("table#appliaction-list").on("click", "span[customerid]", function () {
            	 window.location.href = currentPageUrl.customer + "?customerId=" + $(this).attr("customerid") + "&_r=" + Math.random();
            });

            // 跳转贷款详情
            $("table#appliaction-list").on("click", "span[applicationid]", function () {
                var customerid = $(this).attr("applicationid");
                window.location.href = currentPageUrl.application + "?applicationId=" + customerid + "&_r=" + Math.random();
            });

            // Hi, boy! look at here! this function need you override!
            // 注意！注意！这个方法要你处理的
            // 重新提交
            $("table#appliaction-list").on("click", "button.resubmit", function () {
                var applicationId = $(this).attr("applicationid");
                var applicationTr = $(this).parents("tr");

                Confirm("确定需要重新将该申请转到调查吗？<br /> <span style='color:red; width:100%; text-align:center; display:inline-block;'> <small>该操作不可逆</small> </span>", function () {
                    $.ajax({
                        url: currentPageUrl.resubmit + "?application_id=" + applicationId,
                        type: "POST",
                        dataType: "json",
                        async: false,
                        cache: false,
                        success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                            if (result.result) {
                                applicationTr.fadeOut(512, function () {
                                    applicationTr.remove();
                                });

                                //刷新页面，重新载入数据
                                ReloadData();
                            } else {
                                NotifyError(result.error, "重新提交申请时出现一个错误");
                            }
                        }
                    });
                });
            });


            // Hi, boy! look at here! this function need you override!
            // 注意！注意！这个方法要你处理的
            $("div.list-page-search-div").on("change", "input", function () {
                SearchApplication()
            }).on("change", "select", function () {
                SearchApplication()
            }).on("click", "table.category-table td", function () {
                SearchApplication()
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