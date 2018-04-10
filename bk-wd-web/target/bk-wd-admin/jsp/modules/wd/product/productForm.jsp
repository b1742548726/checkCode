<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title></title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <link href="${imgStatic }/zwy/css/wd-wizard.css" rel="stylesheet">

    <link href="${imgStatic }/zwy/css/complex-module.css" rel="stylesheet">

</head>

<body >
    <!-- page content -->
	
    <div class="wd-content">

        <input type="hidden" id="product-id" value="${wdProduct.id}" />
		<input type="hidden" id="product-version" value="${newVersion}" />

        <div id="wizard" class="form_wizard wizard_horizontal wizard_horizontal2" >
            <ul class="wizard_steps" >
            	<li style="z-index:2;">
                	
                    <a href="#step-1" class="selected">
                    	<svg width="348" height="58" viewBox="0 0 348 58" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    						
    					<defs>
        					<polygon id="path-1" points="314 0 641.407407 0 654 25.5102041 641.407407 50 314 50"></polygon>
        					<mask id="mask-2" maskContentUnits="userSpaceOnUse" maskUnits="objectBoundingBox" x="-4" y="-4" width="348" height="58">
            					<rect x="310" y="-4" width="348" height="58" fill="white"></rect>
            					<use xlink:href="#path-1" fill="black"></use>
        					</mask>
    					</defs>
    					<g id="总览" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        					<g id="流程图" transform="translate(-491.000000, -76.000000)">
            					<g id="Group-5" transform="translate(181.000000, 80.000000)">
                					<g>
                    					<use fill="#cccccc" id="wizard_steps_menu" fill-rule="evenodd" xlink:href="#path-1"></use>
                    					<use stroke="#FFFFFF" mask="url(#mask-2)" stroke-width="8" xlink:href="#path-1"></use>
          	    	  				</g>
            					</g>
        					</g>
    					</g>
					</svg>          
                        <span class="step_descr" >
                        	
                            产品信息
                        </span>
                    </a>
                </li>
            	
               
                <li style="z-index:1;">
                	
                    <a href="#step-2" class="disabled">
                    	<svg width="348" height="58" viewBox="0 0 348 58" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    						
    					<defs>
        					<polygon id="path-1" points="314 0 641.407407 0 654 25.5102041 641.407407 50 314 50"></polygon>
        					<mask id="mask-2" maskContentUnits="userSpaceOnUse" maskUnits="objectBoundingBox" x="-4" y="-4" width="348" height="58">
            					<rect x="310" y="-4" width="348" height="58" fill="white"></rect>
            					<use xlink:href="#path-1" fill="black"></use>
        					</mask>
    					</defs>
    					<g id="总览" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        					<g id="流程图" transform="translate(-491.000000, -76.000000)">
            					<g id="Group-5" transform="translate(181.000000, 80.000000)">
                					<g>
                    					<use fill="#cccccc" id="wizard_steps_menu" fill-rule="evenodd" xlink:href="#path-1"></use>
                    					<use stroke="#FFFFFF" mask="url(#mask-2)" stroke-width="8" xlink:href="#path-1"></use>
          	    	  				</g>
            					</g>
        					</g>
    					</g>
					</svg>           
                        <span class="step_descr" >
                            流程配置
                        </span>
                    </a>
                </li>
                <li style="z-index:0;">
                	
                    <a href="#step-3" class="disabled">
                    	<svg width="348" height="58" viewBox="0 0 348 58" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    						
    					<defs>
        					<polygon id="path-1" points="314 0 641.407407 0 654 25.5102041 641.407407 50 314 50"></polygon>
        					<mask id="mask-2" maskContentUnits="userSpaceOnUse" maskUnits="objectBoundingBox" x="-4" y="-4" width="348" height="58">
            					<rect x="310" y="-4" width="348" height="58" fill="white"></rect>
            					<use xlink:href="#path-1" fill="black"></use>
        					</mask>
    					</defs>
    					<g id="总览" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        					<g id="流程图" transform="translate(-491.000000, -76.000000)">
            					<g id="Group-5" transform="translate(181.000000, 80.000000)">
                					<g>
                    					<use fill="#cccccc" id="wizard_steps_menu" fill-rule="evenodd" xlink:href="#path-1"></use>
                    					<use stroke="#FFFFFF" mask="url(#mask-2)" stroke-width="8" xlink:href="#path-1"></use>
          	    	  				</g>
            					</g>
        					</g>
    					</g>
					</svg>           
                        <span class="step_descr" >
                            调查配置
                        </span>
                    </a>
                </li>
                <li class="Rectangle">
                    <a href="javascript:void(0);"  onclick="SubmitCurrentForm()">
                    	
                        <span class="step_descr">
                           保存
                        </span>
                    </a>
                </li>
         
            </ul>
            
            <div id="div_line" style=""></div>
        </div>
		
		
		<div style="margin-top:110px;"></div>
        <div class="wd-piece-content col-xs-12" >
            <div id="step-1" class="wizard-step-content"> 产品信息页 </div>
            <div id="step-2" class="wizard-step-content"> 流程配置页 </div>
            <div id="step-3" class="wizard-step-content"> 调查模块页 </div>
            <div id="step-4" class="wizard-step-content"> 审核模块页 </div>
            <div id="step-5" class="wizard-step-content"> 贷后配置页 </div>
        </div>
	
    </div>

    <!-- /page content -->

    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="${imgStatic }/vendors/iCheck/icheck.min.js"></script>
    <!-- Switchery -->
    <script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <!-- jQuery UI -->
    <script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>

    <script src="${imgStatic }/zwy/js/wd-common.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    <script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>

    <script type="text/javascript">
    	var newVersion = "${newVersion}";
    	
		/*add by jyshen*/
       	var g_isNew = ${empty wdProduct.id}, g_canJump = false;
        /*end jyshen*/
       
        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        // 写上真是的地址
        var currentPageUrl = {
			pageProductInfo : "${ctx}/wd/product/form_info", // 产品信息页面，参数：product_id、version，请求方式：GET，返回值：Page
			saveProductInfo : "${ctx}/wd/product/save_info", // 产品信息保存，参数：product_id、version、Json，请求方式：POST，返回值：Json，格式{ "result": false, "product_id":"xxxxxxxxxx", "version":"temp_201703290001", "error": "xxxxxxxxxxxxxxxxxxx" }

			pageProductProcess : "${ctx}/wd/product/form_process", // 产品流程页面，参数：product_id、version，请求方式：GET，返回值：Page
			saveProductProcess : "${ctx}/wd/product/save_process", // 产品流程保存，参数：product_id、version、Json，请求方式：POST，返回值：Json，格式{ "result": false, "error": "xxxxxxxxxxxxxxxxxxx" }

			pageProductSurvey : "${ctx}/wd/product/form_survey", // 调查模块页面，参数：product_id、version，请求方式：GET，返回值：Page
			saveProductSurvey : "${ctx}/wd/product/save_survey", // 调查模块保存，参数：product_id、version、Json，请求方式：POST，返回值：Json，格式{ "result": false, "error": "xxxxxxxxxxxxxxxxxxx" }

			pageProductAudit : "${ctx}/wd/product/form_audit", // 审核模块页面，参数：product_id、version，请求方式：GET，返回值：Page
			saveProductAudit : "${ctx}/wd/product/save_audit", // 审核模块保存，参数：product_id、version、Json，请求方式：POST，返回值：Json，格式{ "result": false, "error": "xxxxxxxxxxxxxxxxxxx" }
 			
			saveProduct : "${ctx}/wd/product/save_product" // 产品使用新版本配置，参数：product_id、version，请求方式：POST，返回值：Json，格式{ "result": false, "error": "xxxxxxxxxxxxxxxxxxx" }
		};

        function RefreshWizardSteps() {
        	if ($("#copy_product_id").val() != _copy_product_id) {
            	_copy_product_id = $("#copy_product_id").val();
            	$("#product-id").val(_copy_product_id);
            	$("#step-2").load(currentPageUrl.pageProductProcess + "?productId=" + _copy_product_id  + "&r=" + Math.random());
                $("#step-3").load(currentPageUrl.pageProductSurvey + "?productId=" + _copy_product_id + "&r=" + Math.random());
                $("#step-4").load(currentPageUrl.pageProductAudit + "?productId=" + _copy_product_id  + "&r=" + Math.random());
                $("#product-id").val("");
            }
        	
            var currentA = $("ul.wizard_steps li a.selected");
            var lis = $("ul.wizard_steps li:not(.Rectangle)");	//获取非BUTTON的LI元素
            var currentLi = currentA.parent("li");
            //var a = $("ul.wizard_steps li a");
            
            currentA.find("#wizard_steps_menu").attr("fill", "#ff661b");

            var prevLi = currentLi.prev("li");
            var nextLi = currentLi.next("li");
            
            //如果是新增并且操作到最后一步，显示按钮，并且可以跳转
            if (g_isNew && currentLi.index() === lis.length-1) {
            	g_canJump = true;
            	$("li.Rectangle").css("opacity", "1");
            }
            
			//先解绑再绑定
			lis.off("click");
		
			//新增的话一步步点
			if (g_isNew && !g_canJump) {
				prevLi.on("click", function(){
					WizardPrev();
				});
				
				if (currentLi.index() !== lis.length - 1) {
					
					nextLi.on("click", function(){
						WizardNext();
					});
				}
				
				currentLi.on("click", function(){});
			} else {	//编辑的话可以跳跃
				lis.on("click", function() {
					wizardJump($(this).index());
				});
				
			}
			
            if (prevLi.length == 1) {
                var prevStep = prevLi.find("span.step_descr").html().trim();
                $("#btn-prev").removeClass("wd-btn-dead");
                $("#btn-prev").removeAttr("disabled");
                $("#btn-prev").children("span").html(prevStep);
            } else {
                $("#btn-prev").addClass("wd-btn-dead");
                $("#btn-prev").attr("disabled", "disabled");
                $("#btn-prev").children("span").html("上一步");
            }

            if (nextLi.length == 1) {
                var nextStep = nextLi.find("span.step_descr").html().trim();
                $("#btn-next").removeAttr("wizardover");
                $("#btn-next").children("span").html(nextStep);
            } else {
                $("#btn-next").attr("wizardover", "wizardover");
                $("#btn-next").children("span").html("保存");
            }
			
			
            var contentid = currentA.attr("href");
            $(".wizard-step-content").hide();
            $(contentid).show();
            setTimeout(function() {window.scrollTo(0, 0);}, 0)
            //$("#step-4").show();
        }
        
        //验证必填数据是否为空
        function validate_productInfo() {
        	var currentA = $("ul.wizard_steps li a.selected");
        //	return true;	//方便调试，到时需要去掉
        	if (currentA.index() === 0) {
            	if (product_category.value === "") {
            		$(product_category).addClass("parsley-error");
            		return false;
            	}
            	
            	requireds = document.querySelectorAll("input[required]");
            	
            	//nodelist不支持SOME，转换为ARRAY
            	if ([].some.call(requireds, function(item, index) {
            		if (item.value === "") {
            			//直接用focus不行，将操作插入到队列尾可以，不知道为什么？
            			setTimeout(function() {$(item).focus();}, 0);
            			
            			$(item).addClass("parsley-error");
            		}
            		return item.value === "";
            	}) || product_category.value === "") {
            		
            		return false;
            	}
            }
        	
        	return true;
        }
        
        function wizardJump(index) {
        	if (!validate_productInfo()) {
      			return;
      		}
        	
            StartLoad();
			
			var lis = document.querySelectorAll("ul.wizard_steps li:not(.Rectangle)");	//获取非BUTTON的LI元素

			$(lis).find("#wizard_steps_menu").attr("fill", "#b8e986");
			$(lis[index]).find("#wizard_steps_menu").attr("fill", "#ff661b");
			$(lis).children("a").removeClass("selected").addClass("disabled");
			$(lis[index]).children("a").removeClass("selected done disabled").addClass("selected");
			RefreshWizardSteps();
			FinishLoad();
			return;
        }

        function WizardPrev() {
            StartLoad();

            var currentA = $("ul.wizard_steps li a.selected");
            var currentLi = currentA.parent("li");
            var prevLi = currentLi.prev("li");

            currentA.removeClass("selected done disabled").addClass("done");
            prevLi.children("a").removeClass("selected done disabled").addClass("selected");
            currentA.find("#wizard_steps_menu").attr("fill", "#b8e986");	//绿色
			//prevLi.children("a").find("#wizard_steps_menu").attr("fill", "#ff661b");	//橘色
			
            RefreshWizardSteps();
            FinishLoad();
        }
        
        var _copy_product_id = $("#copy_product_id").val();

        function WizardNext() {
            var currentA = $("ul.wizard_steps li a.selected");
            var currentLi = currentA.parent("li");
            var nextLi = currentLi.next("li");
            var requireds = null;
            
            //如果是产品信息按钮，需要有必填项
      		if (!validate_productInfo()) {
      			return;
      		}
   			
   			StartLoad();
            currentA.removeClass("selected done disabled").addClass("done");
            nextLi.children("a").removeClass("selected done disabled").addClass("selected");
          	currentA.find("#wizard_steps_menu").attr("fill", "#b8e986");
			nextLi.children("a").find("#wizard_steps_menu").attr("fill", "#ff661b");
           	RefreshWizardSteps();
                
            FinishLoad();
            setTimeout(function() {window.scrollTo(0, 0);}, 0)
        }

        function html_encode(str)  
        {  
          var s = "";  
          if (str.length == 0) return "";  
          s = str.replace(/&/g, "&gt;");  
          s = s.replace(/</g, "&lt;");  
          s = s.replace(/>/g, "&gt;");  
          s = s.replace(/ /g, "&nbsp;");  
          s = s.replace(/\'/g, "&#39;");  
          s = s.replace(/\"/g, "&quot;");  
          s = s.replace(/\n/g, "<br>");  
          return s;  
        } 
        
        function SubmitCurrentForm() {
            var _data = $.extend( GetProductInfo(), {
            	surveySimpleModules:  GetSurveyData().simpleModules,
            	surveyComplexModules: GetSurveyData().complexModules,
            	wdProductCreditInvestigation: GetSurveyData().wdProductCreditInvestigation,
            	auditSimpleModules: GetAuditData().simpleModules,
            	productProcessXml : html_encode(GetProcessSettings())
            });
            StartLoad();
            $.ajax({
                url: currentPageUrl.saveProduct,
                async: true,
                cache: false,
                type: "post",
                data: _data,
                dataType: "json",
                success: function (result) {
                	FinishLoad();
                    if (result.success) {
                    	SetLayerData("_save_product", true);
						CloseIFrame();
                    } else {
                        NotifyInCurrentPage("error", result.msg, "设置产品时出现一个错误");
                    }
                }
            });
			
        }

        function LoadWizardContent() {
            var productId = $("#product-id").val();
            var productVersion = $("#product-version").val();

            $("#step-1").load(currentPageUrl.pageProductInfo + "?productId=" + productId + "&r=" + Math.random());
            $("#step-2").load(currentPageUrl.pageProductProcess + "?productId=" + productId + "&r=" + Math.random());
            $("#step-3").load(currentPageUrl.pageProductSurvey + "?productId=" + productId + "&r=" + Math.random());
            $("#step-4").load(currentPageUrl.pageProductAudit + "?productId=" + productId + "&r=" + Math.random());
        }

        $(document).ready(function () {
            LoadWizardContent();
            RefreshWizardSteps();
            
            /*add by jyshen*/
            //如果是编辑状态
            if (!g_isNew) {
       			var obj = document.querySelectorAll("#wizard_steps_menu");
       			
            	$(obj).attr("fill", "#b8e986");
            	$(obj).eq(0).attr("fill", "#ff661b");
            	$("li.Rectangle").css("opacity", "1");
            }
          	/*end jyshen*/
        });
    </script>
</body>
</html>