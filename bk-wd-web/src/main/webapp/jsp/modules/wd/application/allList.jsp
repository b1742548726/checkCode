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
            text-align: right;
        }

        table#appliaction-list tbody tr td:nth-child(6) {
            text-align: center;
        }

        table#appliaction-list tbody tr td:nth-child(7) {
            text-align: center;
        }


        div.list-page-search-div table.category-table td {
            height: 40px;
        }

            div.list-page-search-div table.category-table td span {
                margin: 0px;
                padding: 0px;
                display: inline-block;
                width: 80px;
                height: 22px;
                line-height: 24px;
            }

            div.list-page-search-div table.category-table td i {
                margin: 0px;
                padding: 0px;
                text-align: center;
                vertical-align: middle;
                display: block;
                height: 16px;
                line-height: 16px;
            }
    </style>
</head>

<body style="min-width:880px;">
    <!-- page content -->

    <div class="wd-content">

        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="list-page-search-div col-xs-12">
                <form action="${ctx}/wd/application/allList" id="searchForm" method="get">
                    <div class="col-md-12 col-sm-12 col-xs-12" style="margin-bottom: 1em;">
                        <div class="col-xs-3">
                            <span class="col-xs-12"> 客户姓名 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="customerName" value="${params.customerName }" id="search-name" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3" style="display:none">
                            <span class="col-xs-12"> 商户/公司/单位 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="shopCompany" value="${params.shopCompany }" id="search-company" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3">
                            <span class="col-xs-12"> 贷款编号 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="applicationCode" value="${params.applicationCode }" id="search-application" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3">
                            <span class="col-xs-12"> 客户经理 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="ownerName" value="${params.ownerName }" />
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
                    <input id="current" name="current" type="hidden" value="1"/>
                    <input type="hidden" id="search-application-status" name="status" for="application-status" value="${params.status}" />
                </form>
             
                <table class="category-table" name="application-status" id="category-status-table">
                    <tbody>
                        <tr>
                            <td data-status="all"> <span> 全部 </span><i>${analyzeData.all }</i> </td>
                            <td value="1"> <span> 待分配 </span><i>${analyzeData.assigned }</i> </td>
                            <td value="2"> <span> 调查中 </span><i>${analyzeData.survey }</i> </td>
                            <td value="8"> <span> 线下资料审核 </span><i>${analyzeData.offlineReview }</i> </td>
                            <td value="16"> <span> 表格资料审核 </span><i>${analyzeData.tableReview }</i> </td>
                            <td value="32"> <span> 风控审核 </span><i>${analyzeData.riskControl }</i> </td>
                            <td value="256"> <span> 超额审核 </span><i>${analyzeData.extendReview }</i> </td>
                            <td value="512"> <span> 放款待批 </span><i>${analyzeData.loanReview }</i> </td>
                           <%--  <td value="16384"> <span> 被拒绝 </span><i>${analyzeData.rejected }</i> </td> --%>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table" id="appliaction-list">
                    <thead>
                        <tr>
                            <th style="width:120px"> 客户名称 </th>
                            <th style="width: 88px;"> 客户类型 </th>
                            <th style="width: 148px;"> 贷款产品 </th>
                            <th style="width: 132px;"> 贷款金额 </th>
                            <th style="width: 132px;"> 利率 </th>
                            <th> 申请时间 </th>
                            <th style="width: 132px;"> 当前状态 </th>
                            <th style="width: 132px;"> 客户经理</th>
                            <th style="width: 160px;"> 贷款编号 </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pagination.dataList }" var="application">
                            <tr>
                                 <td>
                                    <span class="td-span-block" customerid="${application.customerId}"> ${application.wdPerson.getJsonData().base_info_name} </span>
                                </td>
                                <td> ${application.wdCustomer.customerTypeName} </td>
                                <td> ${application.productName} </td>
                                <td> ${not empty application.getFinalConclusionJson()["loan_check_fund"] ? application.getFinalConclusionJson()["loan_check_fund"] : application.getApplyInfoJson()["loan_check_fund"]} </td>
                                <td> ${not empty application.getFinalConclusionJson()["loan_check_interest_rate"] ? application.getFinalConclusionJson()["loan_check_interest_rate"] : application.getApplyInfoJson()["loan_check_interest_rate"]} </td>
                                <td> <fmt:formatDate value="${application.createDate}" pattern="yyyy-MM-dd"/> </td>
                                <td>${application.status}</td>
                                <td>${application.ownerName}</td>
                                <td>
                                    <span class="td-span-block-gray" applicationid="${application.id }">
                                       ${application.code }
                                    </span>
                                </td>
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
            application: "${ctx}/wd/application/detail" // 贷款详情页
        };

        function SearchApplication() {
        	$("#searchForm").submit();
        }

        $(function () {
        	if ("${params.status}") {
        		$("#category-status-table").find("td[value=${params.status}]").attr("checked", "checked");
        		$("#search-application-status").val("${params.status}");
        	} else {
        		$("#category-status-table").find("td[data-status=all]").attr("checked", "checked");
        	}
        	
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
                SearchApplication()
            }).on("change", "select", function () {
                SearchApplication()
            }).on("click", "table.category-table td", function () {
                SearchApplication()
            });

            //金额财务显示
            $("table#appliaction-list tbody tr").each(function () {
                var amount = $(this).children("td:eq(3)").html().trim();
                if (!isNaN(amount)) {
                    $(this).children("td:eq(3)").html(Number(amount).formatAsMoney());
                }
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