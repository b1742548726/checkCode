<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>导入excel数据</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/excel.css" rel="stylesheet">
</head>

<body>
    <div class="wd-content">
        <div class="left_info">
            <div class="tab">
                <ul>
                    <li><a href="${ctx}/wd/application/survey/applicantInfo?applicationId=${wdApplication.id}">申请人信息</a></li>
                    <li><a href="${ctx}/wd/application/survey/softInfo?applicationId=${wdApplication.id}">软信息不对称偏差</a></li>
                    <li class="cur"><a href="javascript:void(0);">导入Excel数据</a></li>
                    <li><a href="${ctx}/wd/application/survey/assets?applicationId=${wdApplication.id}">资产负债表</a></li>
                    <li><a href="${ctx}/wd/application/survey/rights?applicationId=${wdApplication.id}">权益检查</a></li>
                </ul>
            </div>
            <div class="btn4" id="close_applicant">保存退出</div>
            <div class="btn3" id="submit_applicant">提交审核</div>

            <div class="tab_content">
                <c:if test="${empty wdApplication.excelFile }">
                    <input type="file" style="display:none;" id="excelFile" name="excelFile" />
                    <div class="appraisal">
                        <div class="draw">
                            <div class="icon uploadBtn">
                                <img src="${imgStatic }/zwy/LBQ/images/upload.png" alt="">
                                <p>点我上传</p>
                            </div>
                        </div>
                        <div class="download">
                            <a href="${imgStatic }/zwy/download/survey_template3.0.xlsx">模版下载</a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty wdApplication.excelFile}">
                    <div class="appraisal">
                        <div class="draw">
                            <div class="icon">
                                <i id="clearExcel"></i>
                                <a href="${imagesStatic }${wdApplication.excelFile}">
                                    <img src="${imgStatic }/zwy/LBQ/images/excel.png" alt="">
                                    <p>点我下载</p>
                                </a>
                            </div>
                        </div>
                        <div class="download">
                            <a href="${imgStatic }/zwy/download/survey_template3.0.xlsx">模版下载</a>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/zwy/js/ajaxfileupload.js" type="text/javascript"></script>
<script>
$(function(){
    //提交申请
    $(document).on("click", "#submit_applicant", function () {
        OpenIFrame("提交审核", "${ctx}/wd/application/survey/submitSurvey?applicationId=${wdApplication.id}", 800, 480, function(){
        	if (GetLayerData("close_survey")) {
        		SetLayerData("close_survey", false);
    			location.href = "${survey_back_url}";
        	}
        });
    });
    $(document).on("click", "#close_applicant", function () {
    	location.href = "${survey_back_url}";
    });
})

$(function(){
    // 删除文件上次
    $("#clearExcel").click(function(){
    	$.ajax({
            url: "${ctx}/wd/application/survey/delExcelFile",
            async: false,
            cache: false,
            type: "POST",
            data: {applicationId : "${wdApplication.id}"},
            dataType: "json",
            success: function (result) {
                if (result.success) {
                	location.reload();
                } else {
                    NotifyInCurrentPage("error", result.msg, "错误！");
                }
            }
        });
    });
    
    $(".uploadBtn").click(function() {
		$("#excelFile").click();
	});
    
    // 上传文件
    
    $(document).on("change","#excelFile", function(){
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
		var url="${ctx}/wd/application/survey/implExcelFile?method=uploadAjax&applicationId=${wdApplication.id}"; 
		$.ajaxFileUpload({ 
			url : url, // 需要链接到服务器地址 
			secureuri : false,
			fileElementId : 'excelFile', // 文件选择框的id属性 
			dataType : 'json', // 服务器返回的格式，可以是json 
			success : function(data, status){// 相当于java中try语句块的用法
				FinishLoad();
				if(data.success) {
					location.reload();
				} else {
					alert(data.msg);
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