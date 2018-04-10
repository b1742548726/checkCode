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
    
    <link href="${imgStatic }/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet" />

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet" />
    
    <link href="${imgStatic }/zwy/css/afterLoanPolicy.css" rel="stylesheet">

    <style type="text/css">
        table#appliaction-list tbody tr td:nth-child(1) {
            text-align: center;
        }
        
        table#appliaction-list tbody tr td:nth-child(2) {
            text-align: center;
        }
        
        table#appliaction-list tbody tr td:nth-child(3) {
            text-align: center;
        }

        table#appliaction-list tbody tr td:nth-child(4) {
            text-align: left;
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

        table#appliaction-list tbody tr td:nth-child(8) {
            text-align: center;
        }

        table#appliaction-list tbody tr td:nth-child(9) {
            text-align: center;
        }
        i.time_icon_tools {
            position: absolute;
            bottom: 9px;
            right: 9px;
            top: auto;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <!-- page content -->

    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
        <form action="${ctx}/wd/application/loaned/managerList" id="searchForm" method="get">
            <input id="current" name="current" type="hidden" value="1"/>
            <div class="list-page-search-div col-xs-12">
                <div class="col-xs-2">
                    <span class="col-xs-11"> 贷款编号 </span>
                    <div class="col-xs-11">
                        <div class="auto-clear-input">
                            <input type="text" class="form-control" name="applicationCode" value="${params.applicationCode }"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-2">
                    <span class="col-xs-11"> 合同编号 </span>
                    <div class="col-xs-11">
                        <div class="auto-clear-input">
                            <input type="text" class="form-control" name="contractCode" value="${params.contractCode }"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-2">
                    <span class="col-xs-11"> 客户姓名 </span>
                    <div class="col-xs-11">
                        <div class="auto-clear-input">
                            <input type="text" class="form-control" name="customerName" value="${params.customerName }"/>
                        </div>
                    </div>
                </div>
                
                <div class="col-xs-3">
                    <span class="col-xs-11"> 放款时间跨度 </span>
                    <div class="col-xs-11">
                        <div class="auto-clear-input" style="float:left;width: 80%">
                            <input type="text" id="dateTimeRange" class="form-control" readonly style="cursor:pointer;">
                            <i class="glyphicon glyphicon-calendar fa fa-calendar time_icon_tools" ></i>
                            <input type="hidden" name="loanBeginDate" id="beginTime" value='<fmt:formatDate value="${params.loanBeginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>' />
                            <input type="hidden" name="loanEndDate" id="endTime" value='<fmt:formatDate value="${params.loanEndDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'/>
                        </div>
                        <div style="float:left;width: 20%;padding-left: .5em; line-height: 2em;">
                            <a href="javascript:;" onclick="begin_end_time_clear();">清除</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-2 col-sm-2 col-xs-12">
                	<shiro:hasPermission name="wdpl:originaldatafuzhou:implExcelData">
	                    <button type="button" style="margin-top: 1.4em;" class="btn wd-btn-gray uploadBtnFuzhou"> 上传台账数据 </button>
                	</shiro:hasPermission>
                	<shiro:hasPermission name="wdpl:originaldataluoyang:implExcelData">
	                    <button type="button" style="margin-top: 1.4em;" class="btn wd-btn-gray uploadBtnLuoyang"> 上传台账数据 </button>
                	</shiro:hasPermission>
                    <input type="file" style="display:none;" id="excelFile" name="excelFile"/>
                    <shiro:hasPermission name="wd:application:loaned:manager:resetAllArchiveFile">
                        <button type="button" style="margin-top: 1.4em;" class="btn wd-btn-gray resetAllArchiveFile"> 重新归档 </button>
                    </shiro:hasPermission>
                </div>
                
                <div class="col-xs-1">
                    <img id="download_archive_file" src="${imgStatic }/zwy/img/download.png" alt="归档资料下载" style="padding-top: 1.8em; width: 28px;cursor: pointer;"/>
                </div>
            </div>
            <div class="x_content">
                <input type="hidden" id="status" name="status" for="credit-category" value="${params.status }" />
                <div name="div_headLabel" class="div_headLabel">
                    <!--标签加了个URL的属性，到时候只要查找选中标签的URL就可以了-->
                    <span class="span_label" data-status="1111" >全部</span>
                    <span class="span_label" data-status="2048" >还款中</span>
                    <span class="span_label" data-status="4096">已结清</span>
                    <span class="span_label" data-status="32768">逾期</span>
                    <span class="span_label" data-status="65536">不良</span>
                    <div class="div_line_noMargin"></div>
                </div>
                <table class="table table-striped table-bordered wd-table" id="appliaction-list">
                    <thead>
                        <tr>
                            <th style="width:200px;" > 贷款编号 </th>
                            <th style="width:190px;"> 合同编号 </th>
                            <th style="width:190px;"> 客户姓名 </th>
                            <th style="width:190px;"> 贷款产品 </th>
                            <th style="width:auto;"> 贷款金额 </th>
                           <!--  <th> 放款时间 </th> -->
                            <c:choose>
                                <c:when test="${params.status == 2048}">
                                    <th style="width:220px;"> </th>
                                </c:when>
                                <c:when test="${params.status == 4096}">
                                    <th style="width:220px;"> 结清时间 </th>
                                </c:when>
                            </c:choose>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pagination.dataList }" var="application">
                            <tr>
                                <td>
                                    <span class="td-span-block-gray" applicationid="${application.id }" data-task-id="${application.wdApplicationTask.id }">
                                       ${application.code }
                                    </span>
                                </td>
                                <td>
                                    ${application.contractCode }
                                </td>
                                <td>
                                    <span class="td-span-block" customerid="${application.customerId}"> ${application.wdPerson.getJsonData().base_info_name} </span>
                                </td>
                                <td> ${application.productName} </td>
                                <td> ${application.getApplyInfoJson()["loan_check_fund"]} </td>
                               <%--  <td> <fmt:formatDate value="${application.loanedDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td> --%>
                                <c:choose>
                                    <c:when test="${params.status == 2048}">
                                        <td>
                                        	<%-- <button type="button" class="btn wd-btn-small wd-btn-indigo all_square_d" data-code="${application.code}" data-customername="${application.wdPerson.getJsonData().base_info_name}" applicationid="${application.id }"> 已结清 </button> --%>
                                        </td>
                                    </c:when>
                                    <c:when test="${params.status == 4096}">
                                       <td> <fmt:formatDate value="${application.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                    </c:when>
                                </c:choose>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="dataTables_wrapper">${pagination}</div>
            </div>
        </div>
    </div>

    <div class="tab_content">
    <div class="content_top">
        <div class="title">交叉管理</div>
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
    
    <script src="${imgStatic }/vendors/moment/min/moment.min.js"></script>
    <script src="${imgStatic }/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="${imgStatic }/zwy/js/ajaxfileupload.js" type="text/javascript"></script>

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
        	$("#current").val("${pagination.current}");
        	searchForm.submit();
        }
        
        $(function () {
        	
        	$(".span_label[data-status=${params.status }]").addClass("checked");
        	
			$("#download_archive_file").on("click", function(){
				Confirm("即将下载查询结果，数据可能较大，请保持网络畅通！", function (){
					location.href="${ctx }/wd/application/loaned/downloadAllArchiveFile?" + $("#searchForm").serialize();
        		});
			})
			$(".resetAllArchiveFile").on("click", function(){
				location.href="${ctx }/wd/application/loaned/resetAllArchiveFile?" + $("#searchForm").serialize();
			});
        	
        	$(".all_square_d").on("click", function(){
        		var _customer_name = $(this).data("customername");
        		var _code = $(this).data("code");
        		Confirm("请确认“" + _customer_name + "”的单号“"+ _code +"”已全部结清!", function (){
        		});
        	})
        	
        	$(".span_label").on("click", function(){
        		$("#status").val($(this).data("status"));
        		SearchApplication();
        	})
				        	
            // 跳转客户详情
            $("table#appliaction-list").on("click", "span[customerid]", function () {
                var customerid = $(this).attr("customerid");
                window.location.href = currentPageUrl.customer + "?customerId=" + customerid + "&_r=" + Math.random();
            });
            
            // 跳转贷款详情
            $("table#appliaction-list").on("click", "span[applicationid]", function () {
                var customerid = $(this).attr("applicationid");
                window.location.href = currentPageUrl.application + "?applicationId=" + customerid + "&_r=" + Math.random();
            });

            // 搜索事件
            $("div.list-page-search-div").on("change", "input", function () {
                SearchApplication()
            }).on("change", "select", function () {
                SearchApplication()
            }).on("click", "table.category-table td", function () {
                SearchApplication()
            });

            //金额财务显示
            $("table#appliaction-list tbody tr").each(function () {
                var amount = $(this).children("td:eq(4)").html().trim();
                if (!isNaN(amount)) {
                    $(this).children("td:eq(4)").html(Number(amount).formatAsMoney());
                }
            });
            
            <c:if test="${not empty params.loanBeginDate}">
                $("#dateTimeRange").val('<fmt:formatDate value="${params.loanBeginDate}" pattern="yyyy-MM-dd"/>' + " - " + '<fmt:formatDate value="${params.loanEndDate}" pattern="yyyy-MM-dd"/>')
            </c:if>
            
            $('#dateTimeRange').daterangepicker({
                singleClasses: "picker_4",
                locale: {
                    format: 'YYYY-MM-DD',
                    applyLabel: '确认',
                    cancelLabel: '取消',
                    fromLabel: '从',
                    toLabel: '到',
                    weekLabel: 'W',
                    customRangeLabel: 'Custom Range',
                    daysOfWeek: ["日", "一", "二", "三", "四", "五", "六"],
                    monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                },
            	autoUpdateInput: false
            });
            
            $('#dateTimeRange').on('apply.daterangepicker', function(ev, picker) {
                $(this).val(picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD'));
                $('#beginTime').val(picker.startDate.format('YYYY-MM-DD') + " 00:00:00");
                $('#endTime').val(picker.endDate.format('YYYY-MM-DD') + " 23:59:59");
                ReloadData();
            });

        });
        
        /**
         * 清除时间
         */
        function begin_end_time_clear() {
            $('#dateTimeRange').val('');
            $('#beginTime').val('');
            $('#endTime').val('');
            ReloadData();
        }
        
        function page(n,s){
			$("#current").val(n);
			$("#searchForm").submit();
        	return false;
        }
        
        

        $(function(){
        	var url = "";
            $(".uploadBtnLuoyang").click(function() {
            	url = "${ctx}/wdpl/originaldataluoyang/implExcelData"; 
        		$("#excelFile").click();
        	});
            $(".uploadBtnFuzhou").click(function() {
            	url = "${ctx}/wdpl/originaldatafuzhou/implExcelData"; 
        		$("#excelFile").click();
        	});
            
            // 上传文件
            $("#excelFile").change(function(){
        		if(!/\.(xlsx|xls)$/.test(this.value)) {
        			this.value = "";
        			$("#completeUploadFileBox").hide();
        			$("#uploadFileBox").show();
        	        alert("图片类型必须是.xlsx,.xls中的一种");
        			return false;
        	    }
        		
        		// 上传文件
        		if (!$("#excelFile").val()) {
        			return false;
        		}
            	StartLoad();
        		$.ajaxFileUpload({ 
        			url : url, // 需要链接到服务器地址 
        			secureuri : false,
        			fileElementId : 'excelFile', // 文件选择框的id属性 
        			dataType : 'json', // 服务器返回的格式，可以是json 
        			success : function(data, status){// 相当于java中try语句块的用法
        				FinishLoad();
        				if(data.success) {
                            alertx(data.msg);
        					location.reload();
        				} else {
        				    var msgInfo = "<span class=\"col-xs-11\">导入错误！<br/>";
        				    if(data.data.resultErrorMap!=null&&data.data.resultErrorMap.length>0){
        				        msgInfo+="下列合同号找到多笔相同的贷款<br/>";
                            }

        				    for (var i=0;i<data.data.resultErrorMap.length;i++){
        				        msgInfo+=data.data.resultErrorMap[i].key+"<br/>";
                            }

                            if(data.data.notInMap!=null&&data.data.notInMap.length>0){
                                msgInfo+="<br/>下列合同号未找到对应的贷款<br/>";
                            }
                            for (var i=0;i<data.data.notInMap.length;i++){
                                msgInfo+=data.data.notInMap[i].contractCode+"<br/>";
                            }
                            msgInfo+="</span>"
                            OpenLayer("导入结果",msgInfo,300,400,function (){
                                location.reload();
                            });
        					alertx(data.msg);
        				}
        			},
        			error : function(data, status){// 相当于java中try语句块的用法 
        			},
        			complete : function (){
        				FinishLoad();
        			}
        		});
        	});
        })
    </script>
</body>
</html>