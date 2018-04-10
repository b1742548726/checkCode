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
        table#blacklist-list tbody tr td:first-child {
            text-align: center;
        }

        table#blacklist-list tbody tr td:last-child {
            text-align: center;
        }

        table#blacklist-list tbody tr td:nth-child(2) {
            text-align: center;
        }
    </style>
</head>

<body>
    <!-- page content -->
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
         <form action="${ctx}/wd/customer/customerBackList" id="searchForm" method="get">
         <input id="current" name="current" type="hidden" value="1"/>
            <div class="list-page-search-div col-xs-12">
                <!-- 左边搜索条件 -->
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="col-xs-3">
                        <span class="col-xs-11"> 客户姓名 </span>
                        <div class="col-xs-11">
                            <div class="auto-clear-input">
                                <input type="text" class="form-control" name="name" value="${params.name }"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-3">
                        <span class="col-xs-11"> 身份证 </span>
                        <div class="col-xs-11">
                            <div class="auto-clear-input">
                                <input type="text" class="form-control" name="idcard"
                                    value="${params.idcard }" />
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-3">
                        <span class="col-xs-11"> 客户经理 </span>
                        <div class="col-xs-11">
                            <div class="auto-clear-input">
                                <input type="text" class="form-control" name="userName" value="${params.userName }"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-3">
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
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table" id="blacklist-list">
                    <thead>
                        <tr>
                            <th style="width:120px"> 客户名称 </th>
                            <th style="width:100px"> 客户类型 </th>
                            <th style="width:256px"> 商户/公司 </th>
                            <th style="width:120px"> 客户经理 </th>
                            <th> 被拒原因 </th>
                            <th style="width:160px"> 被拒时间 </th>
                            <th> </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pagination.dataList}" var="data">
                            <tr>
                                <td>
                                    <span class="td-span-block" customerid="${data.id }"> ${not empty data.wdPerson.getJsonData().base_info_name ? data.wdPerson.getJsonData().base_info_name : '未知'} </span>
                                </td>
                                <td> ${data.customerTypeName} </td>
                                <td>
                                     ${not empty data.wdPerson.getJsonData().base_info_shop_name ? data.wdPerson.getJsonData().base_info_shop_name : data.wdPerson.getJsonData().base_info_company_name} 
                                 </td>
                                <td> ${data.wdCustomerRelation.sysUser.name }</td>
                                <td> ${data.wdCustomerBacklist.remarks }</td>
                                <td> <fmt:formatDate value="${data.wdCustomerBacklist.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                <td>
                                    <shiro:hasPermission name="wd:customer:trustblacker">
                                        <button type="button" class="btn wd-btn-small wd-btn-orange" blacklistid="${data.wdCustomerBacklist.id}"> 信任 </button>
                                    </shiro:hasPermission>
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
            rebelieve: "${ctx}/wd/customer/trustBlacker" //信任
        };

        function SearchCustomer() {
        	$("#searchForm").submit();
        }

        function ReloadData() {
        	$("#current").val("${pagination.current}");
        	$("#searchForm").submit();
        }

        $(function () {
        	// 跳转客户详情
            $("table#blacklist-list").on("click", "span[customerid]", function () {
                var customerid = $(this).attr("customerid");
                window.location.href = currentPageUrl.customer + "?customerId=" + customerid + "&_r=" + Math.random();
            });

            $("div.list-page-search-div").on("change", "input", function () {
                SearchCustomer()
            }).on("change", "select", function () {
                SearchCustomer()
            }).on("click", "table.category-table td", function () {
                SearchCustomer()
            });

            // 信任
            $("table#blacklist-list").on("click", "button[blacklistid]", function () {
                var blackListId = $(this).attr("blacklistid");
                var blackListTr = $(this).parents("tr");

                Confirm("确定将该客户移除黑名单列表吗？<br /> <span style='color:red; width:100%; text-align:center; display:inline-block;'> <small>该操作不可逆</small> </span>", function () {
                    $.ajax({
                        url: currentPageUrl.rebelieve + "?blackListId=" + blackListId,
                        type: "POST",
                        dataType: "json",
                        async: false,
                        cache: false,
                        success: function (result) { // result要求返回Json，格式{ "result": false, "error": "!@#$%^&**&^%^^$#@!" }
                            if (result.success) {
                                //刷新页面，重新载入数据
                                ReloadData();
                            } else {
                                NotifyError(result.msg, "撤销黑名单时出现一个错误");
                            }
                        }
                    });
                });
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