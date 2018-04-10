<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<!--统一样式，不删-->
<link href="${imgStatic}/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic}/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic}/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic}/zwy/css/custom-override.css?timer=0.32323323" rel="stylesheet">
<link href="${imgStatic}/zwy/LBQ/css/overview.css" rel="stylesheet">

<link href="${imgStatic}/zwy/LBQ/css/assets.css" rel="stylesheet">
<!-- iCheck -->
<link href="${imgStatic}/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<link href="${imgStatic}/vendors/iCheck/skins/flat/blue.css" rel="stylesheet">

<style>
    * {
        margin: 0;
        padding: 0;
    }
    
    input.wd-btn-small {
        height: 20px;
        line-height: 20px;
        margin-left: 16px;
    }
</style>
</head>
<body>
    <div class="wd-content wd-content1" id="applicationPrintArea">
        <div class="left_info">
            <div class="tab_content">
                <div class="shop_info index_relation">
                    <div class="shop_info index_relation" id="div_detail_table">
                        <div class="tb_wrap">
                            <table class="cells2">
                                <tr>
                                    <td rowspan="99">注册详情</td>
                                    <td>注册时间</td>
                                    <td>平台代码</td>
                                </tr>
                                <c:if test="${not empty wdRwEmaySinowayCredit.getJsonData().RESULTS[0].DATA }">
                                    <c:forEach items="${wdRwEmaySinowayCredit.getJsonData().RESULTS[0].DATA}" var="data">
                                        <tr>
                                            <td>${data.REGISTERTIME }</td>
                                            <td>${data.PLATFORMCODE }</td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </table>
                        </div>
                        
                        
                        <div class="tb_wrap">
                            <table class="cells4">
                                <tr>
                                    <td rowspan="99">申请详情</td>
                                    <td>申请时间</td>
                                    <td>平台代码</td>
                                    <td>申请金额</td>
                                    <td>批复结果</td>
                                </tr>
                                <c:if test="${not empty wdRwEmaySinowayCredit.getJsonData().RESULTS[1].DATA }">
                                    <c:forEach items="${wdRwEmaySinowayCredit.getJsonData().RESULTS[1].DATA}" var="data">
                                        <tr>
                                            <td>${data.APPLICATIONTIME }</td>
                                            <td>${data.PLATFORMCODE }</td>
                                            <td>${data.APPLICATIONAMOUNT }</td>
                                            <td>${data.APPLICATIONRESULT }</td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </table>
                        </div>
                        
                        <div class="tb_wrap">
                            <table class="cells3">
                                <tr>
                                    <td rowspan="99">放款详情</td>
                                    <td>放款时间</td>
                                    <td>平台代码</td>
                                    <td>放款金额</td>
                                </tr>
                                <c:if test="${not empty wdRwEmaySinowayCredit.getJsonData().RESULTS[2].DATA }">
                                    <c:forEach items="${wdRwEmaySinowayCredit.getJsonData().RESULTS[2].DATA}" var="data">
                                        <tr>
                                            <td>${data.LOANLENDERSTIME }</td>
                                            <td>${data.PLATFORMCODE }</td>
                                            <td>${data.LOANLENDERSAMOUNT }</td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </table>
                        </div>
                        
                        <div class="tb_wrap">
                            <table class="cells2">
                                    <tr>
                                        <td rowspan="99">驳回详情</td>
                                        <td>平台代码</td>
                                        <td>驳回时间</td>
                                    </tr>
                                    <c:if test="${not empty wdRwEmaySinowayCredit.getJsonData().RESULTS[3].DATA }">
                                        <c:forEach items="${wdRwEmaySinowayCredit.getJsonData().RESULTS[3].DATA}" var="data">
                                            <tr>
                                                <td>${data.PLATFORMCODE }</td>
                                                <td>${data.REJECTIONTIME }</td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                            </table>
                        </div>
                        
                        <div class="tb_wrap">
                            <table class="cells4">
                                    <tr>
                                        <td rowspan="99">逾期详情</td>
                                        <td>平台代码</td>
                                        <td>逾期金额</td>
                                        <td>逾期次数</td>
                                        <td>最近逾期</td>
                                    </tr>
                                    <c:if test="${not empty wdRwEmaySinowayCredit.getJsonData().RESULTS[4].DATA }">
                                        <c:forEach items="${wdRwEmaySinowayCredit.getJsonData().RESULTS[4].DATA}" var="data">
                                            <tr>
                                                <td>${data.PLATFORM }</td>
                                                <td>${data.MONEY }</td>
                                                <td>${data.COUNTS }</td>
                                                <td>${data.D_TIME }</td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                            </table>
                        </div>
                        
                        <div class="tb_wrap">
                            <table class="cells2">
                                    <tr>
                                        <td rowspan="99">欠款详情</td>
                                        <td>平台代码</td>
                                        <td>欠款区间</td>
                                    </tr>
                                    <c:if test="${not empty wdRwEmaySinowayCredit.getJsonData().RESULTS[5].DATA }">
                                        <c:forEach items="${wdRwEmaySinowayCredit.getJsonData().RESULTS[5].DATA}" var="data">
                                            <tr>
                                                <td>${data.PLATFORM }</td>
                                                <td>${data.MONEY }</td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 统一js，不删 -->
    <script src="${imgStatic}/vendors/jquery/dist/jquery.min.js"></script>
    <script src="${imgStatic}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="${imgStatic}/build/js/custom.js"></script>
    <script src="${imgStatic}/zwy/LBQ/js/iframeFix.js"></script>
    <!-- Layer -->
    <script src="${imgStatic}/vendors/layer/layer.js"></script>
    <script src="${imgStatic}/zwy/js/layer-customer.js"></script>
    <!-- PrintArea -->
    <script src="${imgStatic}/vendors/RitsC-PrintArea-2cc7234/demo/jquery.PrintArea.js"></script>
    
    <script src="${imgStatic}/zwy/LBQ/js/dealIn.js"></script>
    <script src="${imgStatic}/zwy/LBQ/js/overview.js"></script>
    <!-- iCheck -->
    <script src="${imgStatic}/vendors/iCheck/icheck.min.js"></script>
</body>
</html>