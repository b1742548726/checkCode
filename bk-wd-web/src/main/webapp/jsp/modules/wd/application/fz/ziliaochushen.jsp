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
    </style>
</head>

<body style="min-width:880px;">
    <!-- page content -->
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table" id="appliaction-list">
                    <thead>
                        <tr>
                            <th style="width:120px"> 客户名称 </th>
                            <th style="width: 180px;"> 贷款产品 </th>
                            <th style="width: 132px;"> 申贷金额 </th>
                            <th style="width: 220px;"> 申请时间 </th>
                            <th style="width: 180px;"> 贷款编号 </th>
                            <th style="width: 80px;"> </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${ data }" var="application">
                            <tr>
                            	<td>
                                    <span class="td-span-block" customerid="${application.customerId}"> ${application.customerName} </span>
                                </td>
                                <td> ${application.productName} </td>
                                <td> ${application.getApplyInfoJson()["loan_check_fund"]} </td>
                                <td> <fmt:formatDate value="${application.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                <td>
                                   ${application.code }
                                </td>
                                <td>
                                    <button type="button" class="btn wd-btn-small wd-btn-gray" applicationid="${application.id }" data-taskId="${application.wdApplicationTask.id }"> 处理 </button>
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
            comment: "${ctx }/wd/application/fz/comment?taskId=", // 贷款分配
        };

        function ReloadData() {
        	location.reload();
        }

        $(function () {

            // 跳转客户详情
            $("table#appliaction-list").on("click", "span[customerid]", function () {
            	 window.location.href = currentPageUrl.customer + "?customerId=" + $(this).attr("customerid") + "&_r=" + Math.random();
            });

            $("div.list-page-search-div").on("change", "input", function () {
                SearchApplication()
            }).on("change", "select", function () {
                SearchApplication()
            }).on("click", "table.category-table td", function () {
                SearchApplication()
            });
            
            // 风险调查
            $("table#appliaction-list").on("click", "button[applicationid]", function () {
                var taskId = $(this).data("taskid");
                var applicationTr = $(this).parents("tr");
                OpenIFrame("处理", currentPageUrl.comment + taskId, 640, 500, function () {
                	if (GetLayerData("close_deal_page")) {
                		SetLayerData("close_deal_page", false);
                		ReloadData();
                	}
                });
            });

            //金额财务显示
            $("table#appliaction-list tbody tr").each(function () {
                var amount = $(this).children("td:eq(2)").html().trim();
                if (!isNaN(amount)) {
                    $(this).children("td:eq(2)").html(Number(amount).formatAsMoney());
                }
            });

        });
        
    </script>
</body>
</html>