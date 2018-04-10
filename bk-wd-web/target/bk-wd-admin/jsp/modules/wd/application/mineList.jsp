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
        table tbody tr td:first-child {
            text-align: center;
        }

        table tbody tr td:last-child {
            text-align: center;
        }

        table tbody tr td:nth-child(3) {
            text-align: center;
        }

        table tbody tr td:nth-child(5) {
            text-align: right;
        }

        table tbody tr td:nth-child(6) {
            text-align: center;
        }

        table tbody tr td:nth-child(7) {
            text-align: center;
        }
    </style>
</head>

<body>
    <!-- page content -->
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <form action="${ctx}/wd/application/mineList" id="searchForm" method="get">
                <div class="list-page-search-div col-xs-12">
                    <div class="col-xs-3">
                        <span class="col-xs-11"> 客户姓名 </span>
                        <div class="col-xs-11">
                            <div class="auto-clear-input">
                                <input type="text" class="form-control" name="customerName" value="${params.customerName }" id="search-name" />
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-3">
                        <span class="col-xs-11"> 身份证号码 </span>
                        <div class="col-xs-11">
                            <div class="auto-clear-input">
                                <input type="text" class="form-control" name="idcard" value="${params.idcard }" id="search-company" />
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
                        <span class="col-xs-12"> 贷款产品 </span>
                        <div class="col-xs-12">
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
            </form>
            <div class="x_content">
                <div class="col-xs-12" style="border:1px solid #ddd; min-height:36px;border-radius:4px;margin-bottom: 4px;">
                    <span class="col-md-1 col-sm-1 col-xs-2" style="margin:0px;height:36px;line-height:36px;color:#666;">调查中</span>
                    <span class="col-md-1 col-sm-1 col-xs-2 pull-right" style="margin:0px;height:36px;line-height:36px;color:#666; text-align:right;">${auditList.size()}</span>
                </div>
                <c:choose>
                    <c:when test="${auditList.size() > 0}">
                        <table class="table table-striped table-bordered wd-table" survey="survey">
                            <thead>
                                <tr>
                                    <th style="width:120px"> 客户名称 </th>
                                    <th> 商户/公司 </th>
                                    <th style="width: 88px;"> 客户类型 </th>
                                    <th style="width: 148px;"> 贷款产品 </th>
                                    <th style="width: 132px;"> 申贷金额 </th>
                                    <th style="width: 220px;"> 申请时间 </th>
                                    <th style="width: 168px;"> 贷款编号 </th>
                                    <th style="width: 100px;"> 操作 </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${auditList }" var="application">
                                    <tr>
                                         <td>
                                            <span class="td-span-block" customerid="${application.customerId}"> ${application.wdPerson.getJsonData().base_info_name} </span>
                                        </td>
                                        <td>
                                            ${not empty application.wdPerson.getJsonData().base_info_shop_name ? application.wdPerson.getJsonData().base_info_shop_name : application.wdPerson.getJsonData().base_info_company_name}
                                        </td>
                                        <td> ${application.wdCustomer.customerTypeName} </td>
                                        <td> ${application.productName} </td>
                                        <td> ${application.getApplyInfoJson()["loan_check_fund"]} </td>
                                        <td> <fmt:formatDate value="${application.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                        <td>
                                            <span class="td-span-block-gray" applicationid="${application.id }">
                                               ${application.code }
                                            </span>
                                        </td>
                                        <td>
                                            <button type="button" class="btn wd-btn-small wd-btn-orange survey" applicationid="${application.id }"> 调查 </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-12" style="border:1px dashed #ddd; min-height:36px;border-radius:4px;margin-bottom:40px;">
                            &ensp;
                        </div>
                    </c:otherwise>
                </c:choose>

                <br />
                <div class="col-xs-12" style="border:1px solid #ddd; min-height:36px;border-radius:4px;margin-bottom: 4px;">
                    <span class="col-md-1 col-sm-1 col-xs-2" style="margin:0px;height:36px;line-height:36px;color:#666;">审核中</span>
                    <span class="col-md-1 col-sm-1 col-xs-2 pull-right" style="margin:0px;height:36px;line-height:36px;color:#666; text-align:right;">${reviewList.size()}</span>
                </div>
                <c:choose>
                    <c:when test="${reviewList.size() > 0}">
                        <table class="table table-striped table-bordered wd-table" survey="survey">
                            <thead>
                                <tr>
                                    <th style="width:120px"> 客户名称 </th>
                                    <th> 商户/公司 </th>
                                    <th style="width: 88px;"> 客户类型 </th>
                                    <th style="width: 148px;"> 贷款产品 </th>
                                    <th style="width: 132px;"> 申贷金额 </th>
                                    <th style="width: 220px;"> 申请时间 </th>
                                    <th style="width: 168px;"> 贷款编号 </th>
                                   <!--  <th style="width: 100px;"> 操作 </th> -->
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${reviewList }" var="application">
                                    <tr>
                                        <td>
                                            <span class="td-span-block" customerid="${application.customerId}"> ${application.wdPerson.getJsonData().base_info_name} </span>
                                        </td>
                                        <td>
                                            ${not empty application.wdPerson.getJsonData().base_info_shop_name ? application.wdPerson.getJsonData().base_info_shop_name : application.wdPerson.getJsonData().base_info_company_name}
                                        </td>
                                        <td> ${application.wdCustomer.customerTypeName} </td>
                                        <td> ${application.productName} </td>
                                        <td> ${application.getApplyInfoJson()["loan_check_fund"]} </td>
                                        <td> <fmt:formatDate value="${application.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                        <td>
                                            <span class="td-span-block-gray" applicationid="${application.id }">
                                               ${application.code }
                                            </span>
                                        </td>
                                       <!--  <td>
                                        </td> -->
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-12" style="border:1px dashed #ddd; min-height:36px;border-radius:4px;margin-bottom:40px;">
                            &ensp;
                        </div>
                    </c:otherwise>
                </c:choose>

                <br />
                <div class="col-xs-12" style="border:1px solid #ddd; min-height:36px;border-radius:4px;margin-bottom: 4px;">
                    <span class="col-md-1 col-sm-1 col-xs-2" style="margin:0px;height:36px;line-height:36px;color:#666;">放款审批</span>
                    <span class="col-md-1 col-sm-1 col-xs-2 pull-right" style="margin:0px;height:36px;line-height:36px;color:#666; text-align:right;">${laonList.size()}</span>
                </div>
                <c:choose>
                    <c:when test="${laonList.size() > 0}">
                        <table class="table table-striped table-bordered wd-table" survey="survey">
                            <thead>
                                <tr>
                                    <th style="width:120px"> 客户名称 </th>
                                    <th> 商户/公司 </th>
                                    <th style="width: 88px;"> 客户类型 </th>
                                    <th style="width: 148px;"> 贷款产品 </th>
                                    <th style="width: 132px;"> 申贷金额 </th>
                                    <th style="width: 128px;"> 申请时间 </th>
                                    <th style="width: 168px;"> 合同编号 </th>
                                    <th style="width: 168px;"> 贷款编号 </th>
                                   <!--  <th style="width: 100px;"> 操作 </th> -->
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${laonList }" var="application">
                                    <tr>
                                         <td>
                                            <span class="td-span-block" customerid="${application.customerId}"> ${application.wdPerson.getJsonData().base_info_name} </span>
                                        </td>
                                        <td>
                                            ${not empty application.wdPerson.getJsonData().base_info_shop_name ? application.wdPerson.getJsonData().base_info_shop_name : application.wdPerson.getJsonData().base_info_company_name}
                                        </td>
                                        <td> ${application.wdCustomer.customerTypeName} </td>
                                        <td> ${application.productName} </td>
                                        <td> ${application.getApplyInfoJson()["loan_check_fund"]} </td>
                                        <td> <fmt:formatDate value="${application.createDate}" pattern="yyyy-MM-dd"/> </td>
                                        <td> ${application.contractCode } </td>
                                        <td>
                                            <span class="td-span-block-gray" applicationid="${application.id }">
                                               ${application.code }
                                            </span>
                                        </td>
                                        <%-- <td>
                                            <button type="button" class="btn wd-btn-small wd-btn-indigo btn-resolution" applicationId="${application.id }">决议表</button>
                                        </td> --%>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-12" style="border:1px dashed #ddd; min-height:36px;border-radius:4px;margin-bottom:40px;">
                            &ensp;
                        </div>
                    </c:otherwise>
                </c:choose>
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
            survey: "${ctx}/wd/application/survey", // 贷款调查编辑页
        };

        function SearchApplication() {
        	searchForm.submit();
        }

        $(function () {

            $("table").on("click", "span[customerid]", function () {
                window.location.href = currentPageUrl.customer + "?customerId=" + $(this).attr("customerid") + "&_r=" + Math.random();
            });
            
            $("table").on("click", "button.survey", function(){
            	window.location.href = currentPageUrl.survey +"?applicationId=" + $(this).attr("applicationid");
            });

            $("table").on("click", "span[applicationid]", function () {
                var applicationid = $(this).attr("applicationid");
                window.location.href = currentPageUrl.application + "?applicationId=" + applicationid + "&_r=" + Math.random();
            });

            $("div.list-page-search-div").on("change", "input", function () {
                SearchApplication();
            }).on("change", "select", function () {
                SearchApplication();
            }).on("click", "table.category-table td", function () {
                SearchApplication();
            });

            //金额财务显示
            $("table tbody tr").each(function () {
                var amount = $(this).children("td:eq(4)").html().trim();
                if (!isNaN(amount)) {
                    $(this).children("td:eq(4)").html(Number(amount).formatAsMoney());
                }
            });

        });
    </script>
</body>
</html>