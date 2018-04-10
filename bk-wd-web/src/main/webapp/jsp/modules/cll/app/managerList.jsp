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
                <form action="${ctx}/cll/application/list" id="searchForm" method="get">
                    <div class="col-md-12 col-sm-12 col-xs-12" style="margin-bottom: 1em;">
                        <div class="col-xs-2">
                            <span class="col-xs-12"> 客户姓名 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="customerName" value="${cllApplication.customerName }" id="search-name" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-2">
                            <span class="col-xs-12"> 贷款编号 </span>
                            <div class="col-xs-11">
                                <div class="auto-clear-input">
                                    <input type="text" class="form-control" name="code" value="${cllApplication.code }" id="search-company" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <input id="current" name="current" type="hidden" value="1"/>
                    <input type="hidden" id="search-application-status" name="status" for="application-status" value="${cllApplication.status}" />
                </form>
             
                <table class="category-table" name="application-status" id="category-status-table">
                    <tbody>
                        <tr>
                            <td data-status="all"> <span> 全部 </span><i>${statusCount.all }</i> </td>
                            <td value="2"> <span> 预审中 </span><i>${statusCount.preview }</i> </td>
                            <td value="4"> <span> 征信中 </span><i>${statusCount.credit }</i> </td>
                            <td value="8"> <span> 调查中</span><i>${statusCount.survey }</i> </td>
                            <td value="16"> <span> 审批中 </span><i>${statusCount.review }</i> </td>
                            <td value="32"> <span> 待签约 </span><i>${statusCount.preSign }</i> </td>
                            <td value="64"> <span> 待放款 </span><i>${statusCount.preLoan }</i> </td>
                            <td value="128"> <span> 还款中 </span><i>${statusCount.repayments }</i> </td>
                            <td value="4096"> <span> 已结清 </span><i>${statusCount.closeAcount }</i> </td>
                            <td value="8192"> <span> 已拒绝 </span><i>${statusCount.reject }</i> </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table" id="appliaction-list">
                    <thead>
                        <tr>
                            <th style=""> 客户名称 </th>
                            <th style="width: 88px;"> 申请时间 </th>
                            <th style="width: 148px;"> 本节点已花费时间 </th>
                            <th style="width: 88px;"> 签约时间 </th>
                            <th style="width: 120px;"> 当前状态 </th>
                            <th style="width:160px;"> 贷款编号 </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pagination.dataList }" var="application">
                            <tr>
                                 <td>
                                    <span class="td-span-block" customerid="${application.customerId}"> ${application.customerName} </span>
                                </td>
                                <td>  <fmt:formatDate value="${application.applyTime}" pattern="yyyy-MM-dd"/> </td>
                                <td>${application.getUpdateTime()}</td>
                                <td>  <fmt:formatDate value="${application.signingDate}" pattern="yyyy-MM-dd"/> </td>
                                <td>${application.statusName} </td>
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
            customer: "${ctx }/cll/customer/detail", // 客户详情页
            application: "${ctx}/cll/application/detail" // 贷款详情页
        };

        function SearchApplication() {
        	$("#searchForm").submit();
        }

        $(function () {
        	if ("${cllApplication.status}") {
        		$("#category-status-table").find("td[value=${cllApplication.status}]").attr("checked", "checked");
        		$("#search-application-status").val("${cllApplication.status}");
        	} else {
        		$("#category-status-table").find("td[data-status=all]").attr("checked", "checked");
        	}
        	
        	$("table").on("click", "span[customerid]", function () {
                window.location.href = currentPageUrl.customer + "?customerId=" + $(this).attr("customerid") + "&_r=" + Math.random();
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