<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>数据导入</title>
    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css"
          rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css"
          rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <link href="../css/custom-override.css" rel="stylesheet">
</head>
<body>
<div class="wd-content">
    <form id="sn_form" enctype="multipart/form-data"></form>
    <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
        <div class="x_title">
            <h3>数据导入</h3>
        </div>
    </div>
    <div class="data-import">
        <div class="header">
            <div class="header-title">放款数据</div>
            <div class="header-text">上传时间:
                <span class="time">
                    <c:choose>
                        <c:when test="${!empty upTime}">
                            ${upTime}
                        </c:when>
                        <c:otherwise>
                            未知
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
        <div class="data-import-main">
            <c:if test="${!empty resultSuccess}">
                <div class="import-status">
                    <c:if test="${resultSuccess == true}">
                        导入成功！
                    </c:if>
                    <c:if test="${resultSuccess == false}">
                        导入出错！
                    </c:if>
                </div>
                <c:if test="${!empty inputResult}">
                    <c:if test="${!empty inputResult.resultErrorMap}">
                        <div class="error">
                            <div class="error-title">下列合同号找到多笔相同贷款</div>
                            <ul class="error-list">
                                <c:forEach items="${inputResult.resultErrorMap}" var="m">
                                    <li>${m.key}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${!empty inputResult.notInMap}">
                        <div class="error">
                            <div class="error-title">下列合同号未找到对应的贷款</div>
                            <ul class="error-list">
                                <c:forEach items="${inputResult.notInMap}" var="m">
                                    <li>${m.contractCode}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </c:if>
            </c:if>
        </div>
        <div class="footer-btn">导入</div>
        <input id="excelFile" type="file" style="display:none;"  name="excelFile"/>
    </div>
</div>
<!-- jQuery -->
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

<script>
    $(function() {
        $("div.footer-btn").on("click", function (event) {
            $(this).siblings(":input[name=excelFile]").click();
        });
    })

    // 上传文件
    $(document).on("change", "input[name=excelFile]", function() {
        if (!/\.(xlsx|xls)$/.test(this.value)) {
            this.value = "";
            alert("图片类型必须是.xlsx,.xls中的一种");
            return false;
        }
        // 上传文件
        if (!$(this).val()) {
            return false;
        }
        StartLoad();
        $.ajaxFileUpload({
            url : "${ctx}/wdpl/originaldataluoyang/implExcelData", // 需要链接到服务器地址
            secureuri : false,
            fileElementId : 'excelFile', // 文件选择框的id属性
            dataType : 'json', // 服务器返回的格式，可以是json
            success : function(data, status){// 相当于java中try语句块的用法
                FinishLoad();
                location.reload();
            },
            error : function(data, status){// 相当于java中try语句块的用法
                location.reload();
            },
            complete : function (){
                FinishLoad();
            }
        });
    })


</script>
</body>
</html>