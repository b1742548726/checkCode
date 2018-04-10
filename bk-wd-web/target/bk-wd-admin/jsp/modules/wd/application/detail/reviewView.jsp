<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gentelella Alela! | </title>

    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/warning.css" rel="stylesheet">
    
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/LBQ/css/layer.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/LBQ/css/popup_style.css" rel="stylesheet">
    
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <style type="text/css">
        textarea:focus {
          outline-style: solid;
          outline-width: 2px;
          outline-color: #ccc;
        }
    </style>
</head>
<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left">
                        <c:set var="jsonData" value="${wdApplicationTask.status == 32 ? wdApplication.getAuditConclusionJson() : wdApplication.getFinalConclusionJson()}"></c:set>
                        <c:if test="${action eq 'Pass' }">
                            <c:if test="${wdApplicationTask.status != 8 and wdApplicationTask.status != 512 }">
                                <c:forEach items="${applyAuditInfoConfig }" var="simpleModuleSetting">
                                    <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(simpleModuleSetting.businessElementId)" var="wdBusinessElement"/>
                                    <wd:baseElement wdBusinessElement="${wdBusinessElement }" required="${simpleModuleSetting.required == '1'}" defValue="${jsonData[wdBusinessElement.key] }"/>
                                </c:forEach>
                            </c:if>
                            <c:if test="${wdApplicationTask.status == 512 }">
                            	<div class="form-group">
	                                <label class="control-label col-md-3 col-xs-12" for="moduleCode">
	                                                                                                                          外部编号
	                                </label>
	                                <div class="col-md-6 col-xs-12" style="width:60%">
	                                     <input type="text" name="extContrantCode" class="form-control col-md-8 col-xs-12">
	                                </div>
                                </div>
                            </c:if>
                            <c:forEach items="${configList }" var="wdProductSimpleModuleSetting">
                                <spring:eval expression="@wdBusinessElementService.selectByPrimaryKey(wdProductSimpleModuleSetting.businessElementId)" var="wdBusinessElement"/>
                                <wd:baseElement wdBusinessElement="${wdBusinessElement }" required="${wdProductSimpleModuleSetting.required == '1'}" defValue="${jsonData[wdBusinessElement.key] }" elementSelectListId="${wdProductSimpleModuleSetting.elementSelectListId }" />
                            </c:forEach>
                        </c:if>
                        <c:if test="${action eq 'Cancel' }">
                            <c:if test="${wdApplicationTask.status == 512 }">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-xs-12" for="moduleCode">
                                                                                                                        终止原因
                                </label>
                                <div class="col-md-6 col-xs-12" style="width:60%">
                                    <select class="form-control" id="stopCause" name="stopCause" required}>
                                        <option value="">请选择</option>
                                        <option value="申请人暂无资金需求">申请人暂无资金需求</option>
                                        <option value="申请人暂无资金需求">决议超过有效期</option>
                                        <option value="其他">其他</option>
                                    </select>
                                </div>
                               </div>
                            </c:if>
                        </c:if>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-xs-12" for="moduleCode">
                                                      备注 <span class="required"></span>
                            </label>
                            <div class="col-md-6 col-xs-12" style="width:60%">
                                <textarea style="width:60%" id="comment" ${(action eq 'Return') or (action eq 'Reject') ? 'required' : ''} class="form-control2 col-md-8 col-xs-12" rows="10"></textarea>
                                <div class="warning hide">
                                    <ins class="import"></ins>
                                    <span class="hide"><i>不能为空</i></span>
                                </div>
                            </div>
                        </div>
                        <c:if test="${action eq 'Reject' }">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-xs-12" for="moduleCode" style="margin-top: -.4em;">
                                     	同时进入黑名单：
                                </label>
                                <div class="col-md-6 col-xs-12" style="width:60%">
                                    <input type="checkbox" class="flat" id="addBlank" value="1">
                                </div>
                            </div>
                        </c:if>
<%-- 
                        <div class="examine_img">
                            <c:choose>
                                <c:when test="${action eq 'Pass'}">
                                    <img src="${imgStatic }/zwy/LBQ/images/pass.png" alt="">
                                </c:when>
                                <c:when test="${action eq 'Return'}">
                                    <img src="${imgStatic }/zwy/LBQ/images/return.png" alt="">
                                </c:when>
                                <c:when test="${action eq 'Reject'}">
                                    <img src="${imgStatic }/zwy/LBQ/images/reject.png" width="100px" alt="">
                                </c:when>
                            </c:choose>
                        </div> --%>
                    </form>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-xs-12 wd-center">
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-white" type="button" id="cancle-add-module">取消</button>
                <button class="btn wd-btn-normal wd-btn-width-middle wd-btn-viridity" type="submit" id="submit-add-module">确认</button>
            </div>
        </div>
    </div>
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Parsley -->
    <script src="${imgStatic }/vendors/parsleyjs-2.6/dist/parsley.min.js"></script>
    <script src="${imgStatic }/vendors/parsleyjs-2.6/dist/i18n/zh_cn.js"></script>

    <!-- Layer -->
    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    
    <!-- iCheck -->
    <script src="${imgStatic }/vendors/iCheck/icheck.min.js"></script>
    
    <script src="${imgStatic }/zwy/LBQ/js/dealIn.js"></script>
    <script type="text/javascript">
        function setModuleValue() {
            var addmodule = { "name": $("#moduleName").val(), "code": $("#moduleCode").val() };
            SetLayerData("AddOneModule", addmodule);
        }

        $(document).ready(function () {
        	$(document).on("click", "[data-regularexpression]", function(e) {
        		$(this).removeClass("error");
        	});
        	
            //待选项样式
            if ($("#addBlank")[0]) {
            	$("#addBlank").iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
            }
        	
            $("#cancle-add-module").click(function (event) {
                SetLayerData("AddOneModule", null);
                CloseIFrame();
            });
            
            $('.warning ins').hover(function(e){
                $(this).siblings('span').removeClass('hide')
            },function(){
                $(this).siblings('span').addClass('hide')
            })

            $("#submit-add-module").click(function (event) {
                event.preventDefault();
                
                var _form = $('#form-add-module').find('input[required],textarea[required]');
                var _haserror = false;
                _form.each(function(){
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
                
                var data = {};
            	$("#form-add-module :input").each(function(){
                	if ($(this).attr("name")) {
                		data[$(this).attr("name")] = $(this).val();
                	}
                });
            	
            	if (!validataFormRegularexpression()) {
            		return false;
            	}
            	
            	$.ajax({
                    url: "${ctx}/wd/application/detail/submitReview",
                    async: false,
                    cache: false,
                    type: "POST",
                    data: {
                    	applicationId : "${applicationId}",
                    	taskId : "${taskId}",
                    	action : "${action}",
                    	addBlank : $("#addBlank").val(),
                    	comment : $("#comment").val(),
                    	data : JSON.stringify(data),
                    	stopCause : $("#stopCause").val(),
                    	extContrantCode : $("#extContrantCode").val()
                    },
                    dataType: "json",
                    success: function (result) {
                        if (result.success) {
                        	SetLayerData("close_review_view", true);
                        	CloseIFrame();
                        } else {
                        	AlertMessage(result.msg);
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>