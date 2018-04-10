<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<c:set var="xpsPic" value="${imgStatic }/zwy/img/XPS.png"/>
<c:set var="htmlPic" value="${imgStatic }/zwy/img/HTML.png"/>
<c:set var="addDefault" value="${imgStatic }/zwy/img/default_add.png"/>
<!DOCTYPE html>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>征信资料-编辑</title>
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

<link href="${imgStatic }/zwy/LBQ/css/credit_info.css" rel="stylesheet">
<link href="${imgStatic }/zwy/LBQ/css/warning.css" rel="stylesheet">
<style type="text/css">
.txt {
    background: rgba(0, 0, 0, 0.56) !important;
}
</style>
</head>

<body>
    <div class="wd-content">
        <div class="left_info">
            <div class="credit_content">
                <h3>征信主体信息
                    <c:if test="${not empty currentDateResult}">
                        <span style="color: red;">该客户今日征信已查询</span>
                    </c:if>
                </h3>
                <div class="shop_info">
                    <ul class="credit_info">
                        <li>
                            <label for="">${wdApplicationCreditInvestigation.category eq '个人' ? '姓名' : '企业名称' }：</label>
                            <p>${wdApplicationCreditInvestigation.name}</p>
                        </li>
                        <c:if test="${wdApplicationCreditInvestigation.category eq '个人' }">
                            <li>
                                <label for="">身份证：</label>
                                <p>${wdApplicationCreditInvestigation.idCard}</p>
                            </li>
                        </c:if>
                        <li>
                            <label for="">与借款人关系：</label>
                            <p>${wdApplicationCreditInvestigation.relationType}</p>
                        </li>
                        <c:if test="${not empty lastestComment}">
                            <li style="color: red;">
                            
                        		<c:choose>
		                            <c:when test="${not empty lastestComment.reason}">
		                                <label for="">上次驳回原因：</label>
		                            </c:when>
                                    <c:otherwise>
                                		<label for="">上次驳回原因：</label>
                                    </c:otherwise>
                               </c:choose>
                                <p>
	                                <c:if test="${lastestComment.reason != '其他'}">
	                                	${lastestComment.reason}
	                                </c:if>
	                                ${lastestComment.remarks}
                                </p>
                            </li>
                        </c:if>
                    </ul>
                    <div class="clearfix"></div>
                </div>
            </div>

            <div class="credit_content" style="min-height: 300px">
                <h3>征信相关照片</h3>
                <div class="shop_info">
                    <ul class="credit_info imgList picbtn">
                        <li>
                            <img data-original="${imagesStatic }${wdApplicationCreditInvestigation.authorization}" src="${imagesStatic }${fns:choiceImgUrl('200X150', wdApplicationCreditInvestigation.authorization)}">
                            <div class="txt">授权书</div>
                        </li>
                        <c:choose>
                            <c:when test="${wdApplicationCreditInvestigation.category eq '个人' }">
                                <li>
                                    <img data-original="${imagesStatic }${wdApplicationCreditInvestigation.idCardFront}" src="${imagesStatic }${fns:choiceImgUrl('200X150', wdApplicationCreditInvestigation.idCardFront)}">
                                    <div class="txt">身份证正面</div>
                                </li>
                                <li>
                                    <img data-original="${imagesStatic }${wdApplicationCreditInvestigation.idCardBack}" src="${imagesStatic }${fns:choiceImgUrl('200X150', wdApplicationCreditInvestigation.idCardBack)}">
                                    <div class="txt">身份证背面</div>
                                </li>
                            </c:when>
                            <c:when test="${wdApplicationCreditInvestigation.category eq '企业' }">
                                <li>
                                    <img data-original="${imagesStatic }${wdApplicationCreditInvestigation.businessLicense}" src="${imagesStatic }${fns:choiceImgUrl('200X150', wdApplicationCreditInvestigation.businessLicense)}">
                                    <div class="txt">营业执照</div>
                                </li>
                            </c:when>
                        </c:choose>
                        <c:forEach items="${wdApplicationCreditInvestigationPhotoList }" var="photo">
                            <li>
                                <img data-original="${imagesStatic }${photo.photoUrl}" src="${imagesStatic }${fns:choiceImgUrl('200X150', photo.photoUrl)}">
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="clearfix"></div>
                </div>
            </div>
            <c:if test="${'征信员' eq wdProductCreditInvestigation.reportSubmitter }">
	            <form name="submitForm" id="submitForm" action="${ctx}/wd/application/credit/save" method="post" enctype="multipart/form-data">
	                <input type="hidden" value="${wdApplicationCreditInvestigation.id }" name="id">
	                <input type="hidden" value="${taskId }" name="taskId">
	                <input type="hidden" name="creditDetail" id="creditDetail">
	                <input type="hidden" value="${wdApplicationCreditInvestigation.applicationId }" name="applicationId">
	                 <div class="credit_content">
	                    <h3>征信报告<span> (仅支持XPS、PNG、JPG、JPEG、HTML文件大小不能超过1MB)</span></h3>
	                    <div class="shop_info">
	                        <ul class="credit_info imgList" id="credit_pic_div">
	                            <li class="news">
	                                <img src="${addDefault }" class="replace">
	                                <input type="file" style="display: none;" name="otherPhotos" onchange="showPreview(this)"/>
	                            </li>
	                        </ul>
	                        <div class="clearfix"></div>
	                    </div>
	                </div>
	                <div class="credit_content">
	                    <h3>征信结果</h3>
	                    <div class="shop_info">
	                        <ul class="credit_info">
	                        	<c:if test="${'征信员' eq wdProductCreditInvestigation.resultSubmitter }">
		                            <c:if test="${wdApplicationCreditInvestigation.category eq '个人' }">
		                                
		                                <li>
		                                    <label for="loanRecord">贷款信用记录：</label>
		                                    <select name="loanRecord" required="required" style="float:left">
		                                        <option value="">请选择</option>
		                                        <option value="非主观不良信用记录">非主观不良信用记录</option>
		                                        <option value="良好信用记录或无信用记录">良好信用记录或无信用记录</option>
		                                        <option value="不良信用记录">不良信用记录</option>
		                                    </select>
		                                    <div class="warning hide" style="width:25%;top:8px">
		                                        <ins class="import"></ins>
		                                        <span class="hide"><i>不能为空</i></span>
		                                    </div>
		                                </li>
		                                
	                                    <c:forEach items="${configList }" var="wdProductSimpleModuleSetting">
	                                   	 	<li class="creditDetail">
		                                        <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(wdProductSimpleModuleSetting.businessElementId)" var="wdBusinessElement"/>
		                                        <wd:baseElement wdBusinessElement="${wdBusinessElement }" required="${wdProductSimpleModuleSetting.required == '1'}" elementSelectListId="${wdProductSimpleModuleSetting.elementSelectListId }" defValue="${wdApplication.getApplyInfoJson()[wdBusinessElement.key] }"/>
	                                    	</li>
	                                    </c:forEach>
		                            </c:if>
		                            
		                            <li>
		                                <label for="result">征信结果：</label>
		                                <input type="hidden" name="result">
		                                <div class="tab">
		                                    <ul class="result">
		                                        <li class="cur">符合</li>
		                                        <li>不符合</li>
		                                    </ul>
		                                </div>
		                            </li>
	                            </c:if>
	                        </ul>
	                        <div class="clearfix"></div>
	                    </div>
	                </div>
	               
	            </form>
	
	            <ul class="credit_btn">
	                <li><button class="color1" id="submit_credit">提交征信</button></li>
	                <li><button class="color3" id="reject_credit">驳回</button></li>
	                <li><button class="color2" id="cancel_credit">终止</button></li>
	                <li><button class="color4" onclick="javascript:history.back();">返回</button></li>
	            </ul>
            </c:if>
        </div>
    </div>
    <div style="display: none;">
        <ul id="clonePreviewPic" >
            <li class="news">
                <img src="${addDefault }" class="replace">
                <input type="file" style="display: none;" name="otherPhotos" onchange="showPreview(this)"/>
            </li>
        </ul>
        <div id="cloneOperateView">
            <div class="txt">
                <span class="replace">替换</span>
                <span class="delete">删除</span>
            </div>
        </div>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>

<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script>
$(function(){
    $('.tab').on('click','ul li',function(){
        $(this).addClass('cur').siblings().removeClass('cur')
    })
    
    $("#submit_credit").click(function (event) {
        event.preventDefault();
         
        var files = [];
        $("#submitForm :input[name=otherPhotos]").each(function(index, dom){
        	if ($(dom).val()) {
        		files.push($(dom).val());
        	}
        });
        if (files.length == 0) {
        	alert("请上传征信报告");
        	return false;
        }

      /*   $("#submitForm :input[name=personalCreditSystem]").val($("#submitForm").find("ul.personalCreditSystem li.cur").text());
        $("#submitForm :input[name=creditRecord]").val($("#submitForm").find("ul.creditRecord li.cur").text());
        $("#submitForm :input[name=creditRecordOurBank]").val($("#submitForm").find("ul.creditRecordOurBank li.cur").text()); */
        $("#submitForm :input[name=result]").val($("#submitForm").find("ul.result li.cur").text());
        
        var _form_select = $('#submitForm').find('select');
        var _haserror = false;
        _form_select.each(function(){
            if($(this).val() == ''){
                $(this).addClass('error')
                $(this).next().removeClass('hide')
                _haserror = true;
            }else{
                $(this).removeClass('error')
                $(this).next().addClass('hide')
            }
        })
        if (_haserror) {
        	return false;
        }
        
        if ($("li.creditDetail").length > 0) {
	        var creditDetail = {};
	        $("li.creditDetail").each(function(index, dom){
	        	creditDetail[$(dom).find(":input").attr("name")] = $(dom).find(":input").val();
	        });
	        $("#creditDetail").val(JSON.stringify(creditDetail));
        }
       
        $("#submitForm").submit();
    });
    
    $("#reject_credit").on("click", function(){
    	OpenIFrame("驳回征信", "${ctx}/wd/application/credit/returnForm?creditId=${wdApplicationCreditInvestigation.id }&taskId=${taskId}", 1000, 350, function(){
    		if (GetLayerData("close_credit_view")) {
        		SetLayerData("close_credit_view", false);
        		StartLoad();
	    		location.href = "${ctx}/wd/application/creditList?repage=1";
    			FinishLoad();
        	}
        });
    });
    
    $("#cancel_credit").on("click", function(){
    	OpenIFrame("终止征信", "${ctx}/wd/application/credit/cancelForm?creditId=${wdApplicationCreditInvestigation.id }&taskId=${taskId}", 1000, 350, function(){
    		if (GetLayerData("close_credit_view")) {
        		SetLayerData("close_credit_view", false);
        		StartLoad();
	    		location.href = "${ctx}/wd/application/creditList?repage=1";
    			FinishLoad();
        	}
        });
    });
    
    $('.warning ins').hover(function(e){
        $(this).siblings('span').removeClass('hide')
    },function(){
        $(this).siblings('span').addClass('hide')
    })
    
    $(".picbtn li img").click(function(){
		var _html = $(this).closest("ul").html();
		if(!_html.trim()) {
			alert("暂无图片")	
			return false;
		}
		var _li = $(this).closest("li");
    	var _index = _li.index();
		picPreview(_html, _index);
	})
	
	/*
     * 图片上传
     * ------------------------------------------------------------------
     */
	$("#credit_pic_div").on("click", ".delete", function(){
		$(this).closest("li").remove();
	});
	$("#credit_pic_div").on("click", ".replace", function(){
		$(this).closest("li").find(":input[type=file]").trigger("click");
	});
	
	if('${errorMess}'!=''){
		AlertMessage('${errorMess}');
	}
})


function showPreview(source) {
	if (!source.value) {
		return false;
	}
	if(!/\.(jpg|jpeg|png|JPG|PNG|xps|XPS|html|HTML)$/.test(source.value)) {
	  source.outerHTML=source.outerHTML; 
      alert("图片类型必须是,jpeg,jpg,png中的一种");
      return false;
    }
	var _img =  $(source).closest("li").find("img");
	if(/\.(xps|XPS)$/.test(source.value)) {
		_img.attr("src", "${xpsPic }");
	} else if(/\.(html|htm|HTML|HTM)$/.test(source.value)) {
		_img.attr("src", "${htmlPic }");
	} else {
		var file = source.files[0];
		if(source.files[0].size/1024/1024 > 1) {
			$(source).val("");
			alert("图片太大");
			return false;
		}
		if(window.FileReader) {
			var fr = new FileReader(); 
			fr.onloadend = function(e) {
				_img.attr("src", e.target.result);
				_img.attr("original-src", e.target.result);
			};
			fr.readAsDataURL(file);
		}else{
			alert("您的浏览器不支持FileReader，图片无法预览！");
		}
	}
	
	if($(source).parent().hasClass("news")) {
		$(source).parent().append($("#cloneOperateView").html())
		$("#credit_pic_div").append($("#clonePreviewPic").html());
	}
	$(source).parent().removeClass("news");
}

function picPreview(_html, _index) {
	var parentId = $(parent.window.document).find('#dowebok')
    parentId.html(_html)                            //数据传入父页面图片列表
    window.parent.viewInit()                        //调用父页面图片预览注册方法
    parentId.find('li:eq('+_index+') img').click()  //传入参数并触发预览
}
</script>
</body>
</html>