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
    <link href="${ imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${ imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${ imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <link href="${ imgStatic }/vendors/iCheck/skins/flat/blue.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="${ imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="${ imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${ imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${ imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <link href="${ imgStatic }/zwy/css/afterLoanPolicy.css" rel="stylesheet">
    
    <!-- Custom Theme Style -->
    <link href="${ imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${ imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    <link href="${ imgStatic }/zwy/css/wd-wizard.css" rel="stylesheet">

    <link href="${ imgStatic }/zwy/css/complex-module.css" rel="stylesheet">
</head>

<body>
    
    <div id="div_wrap">
        <div id="div_content" class="div_content">
            <!--适用范围-->
            <div id="div_range">
                <div>适用范围</div>
                <div class="div_line"></div>
                
                <!--选择产品-->
                <span id="span_productWrap" class="span_content">
                    <span class="content_txt">选择产品</span>
                    
                    <span class="returnPopupWrap">
                        <select id="sel_product" class="standardControl_afl">
                            <option value="1">所有产品</option>
                            <option value="点击查看所选项">点击查看所选项</option>
                        </select>
                        
                        <!--不能用PREVENTDEFAULT，所以加了个假的层-->
                        <span id="productPopupFake" name="returnPopupFake" class="standardControl_afl returnPopupFake"></span>
                        
                        <!--弹出的多选配置框-->
                        <div name="popupCheckbox">
                            <spring:eval expression="@wdProductService.selectByRegion(currentUser.companyId)" var="productList"/>
							<div id="praoductPopup" tabindex="0" class="standardControl_afl popupCheckbox" data-key="请选择产品">
								<div style="display: flex;justify-content: space-between;" data-arg="all">
									<div>所有产品（含后期新增）<input type="checkbox"></div>
								</div>
                                <c:if test="${not empty productList}">
                                    <c:forEach items="${productList}" var="product">
                                        <div style="display: flex;justify-content: space-between;" data-arg="${product.id}">${product.name }<input type="checkbox"></div>
                                    </c:forEach>
                                </c:if>
							</div>
                        </div>
                    </span>
                </span>
                
                <!--选择客户类型-->
                <span id="span_customerTypeWrap" class="span_content">
                    <span class="content_txt">选择客户类型</span>
                    
                    <span class="returnPopupWrap">
                        <select id="sel_customerType" class="standardControl_afl">
                            <option value="1">所有客户类型</option>
                            <option value="点击查看所选项">点击查看所选项</option>
                        </select>
                        <!--不能用PREVENTDEFAULT，所以加了个假的层-->
                        <span id="repaymentPopupFake" name="returnPopupFake" class="standardControl_afl returnPopupFake"></span>
                        
                        <!--弹出的多选配置框-->
                        <div name="popupCheckbox">
                            <spring:eval expression="@wdCustomerTypeService.selectByRegion(currentUser.companyId)" var="customerTypeList" />
							<div id="customerPopup" tabindex="0" class="standardControl_afl popupCheckbox" data-key="请选择客户类型">
								<div style="display: flex;justify-content: space-between;" data-arg="all">所有客户类型（含后期新增）<input type="checkbox"></div>
                                <c:if test="${not empty customerTypeList}">
                                    <c:forEach items="${customerTypeList}" var="customerType">
                                        <c:if test="${'1' eq customerType.newable }">
                                            <div style="display: flex;justify-content: space-between;" data-arg="${customerType.id }">${customerType.name }<input type="checkbox"></div>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
							</div>
                        </div>
                    </span>
                </span>
                
                <!--选择还款方式-->
                <span id="span_repaymentWrap" class="span_content">
                    <span class="content_txt">选择还款方式</span>
                    <span class="returnPopupWrap">
                        <select id="sel_repayment" class="standardControl_afl">
                            <option value="1">所有还款方式</option>
                            <option value="点击查看所选项">点击查看所选项</option>
                        </select>
                        <!--不能用PREVENTDEFAULT，所以加了个假的层-->
                        <span id="repaymentPopupFake" name="returnPopupFake" class="standardControl_afl returnPopupFake"></span>
                        
                        <!--弹出的多选配置框-->
                        <div name="popupCheckbox">
                            <spring:eval expression='@wdSelectItemService.selectByListId("5fd36fadaac845408c2e8681e8d98af7")' var="repaymentCategoryList" />
							<div id="repaymentPopup" tabindex="0" class="standardControl_afl popupCheckbox" data-key="请选择还款方式">
								<div style="display: flex;justify-content: space-between;" data-arg="all">所有还款方式（含后期新增）<input type="checkbox"></div>
                                <c:if test="${not empty repaymentCategoryList}">
                                    <c:forEach items="${repaymentCategoryList}" var="repaymentCategory">
                                        <div style="display: flex;justify-content: space-between;" data-arg="${repaymentCategory.name }">${repaymentCategory.name }<input type="checkbox"></div>
                                    </c:forEach>
                                </c:if>
							</div>
                        </div>
                    </span>
                </span>
                
                <!--是否有房-->
                <span id="span_hasHouseWrap" class="span_content">
                    <span class="content_txt">是否有房</span>
                    <span id="span_hasHouse" class="standardControl_afl">
                        <span  name="不限">不限</span>
                        <span name="有房">有房</span>
                        <span name="无房">无房</span>
                    </span>
                </span>
                
                <!--贷款金额-->
                <span id="span_amountWrap" class="span_content">
                    <span class="content_txt">贷款金额</span>
                    <span id="span_amount" class="standardControl_afl">
                        <input id="txt_publishTask" value="${wdPlRiskInquiryPolicy.minAmount }" type="text" name="txt_amount" class="standardTxt_afl" placeholder=" >"> ~
                        <input id="txt_cutTask" value="${wdPlRiskInquiryPolicy.maxAmount }" type="text" name="txt_amount" class="standardTxt_afl" placeholder=" ≥">
                    </span>
                </span>
            </div>
            
            <!--处理规则-->
            <div id="div_rule">
                <div>处理规则</div>
                <div class="div_line"></div>
                
                <!--风险定询表格-->
                <div id="div_table" style="border: 0px solid red;">
                    <!--thead-->
                    <div class="div_thead">
                        <div class="div_td">风险类型</div>
                        <div class="div_td">定询周期</div>
                        <div class="div_td">异常处理</div>
                    </div>
                    <!--tbody-->
                    <div class="div_tbody">
                        <spring:eval expression="@sysConfigurationService.selectByCompanyIdAndType(currentUser.companyId, null)" var="configurationList"/>
                        <c:forEach items="${configurationList }" var="configuration">
                            <div class="div_tr" data-rwriskquerykey="${configuration.key }">
                                <div class="div_td">${configuration.remarks }</div>
                                <div class="div_td">
                                    <select name="sel_period" class="select_middleSize">
                                        <option value="30">30天</option>
                                        <option value="60">60天</option>
                                        <option value="90">90天</option>
                                        <option value="0">无需定询</option>
                                    </select>
                                </div>
                                <div class="div_td">
                                   <!--  <span name="rule_warringHref"><input name="chk_warring" type="checkbox">发布异常预警</span> -->
                                    <span name="rule_publishHref"><input name="chk_publish" type="checkbox">发布回访任务</span>
                                    
                                    <!--弹出的异常处理框-->
                                    <div class="layui-layer layer-anim" tabindex="0" name="div_popupException" >
                                        <div class="layui-layer-title" style="cursor: move;">
                                            被执行人异常处理
                                            <span class="layui-layer-setwin">
                                                <!--关闭按钮-->
                                                <a class="layui-layer-ico layui-layer-close layui-layer-close1" href="javascript:void(0)"></a>
                                            </span>
                                        </div>
                                        <div class="layui-layer-content" style="margin-top:2em">
                                            
                                            <!--回访人员-->
                                            <div id="" class="display_block">
                                                <span class="content_txt">回访人员</span>
                                                <select id="sel_returnPeople" name="sel_returnPeople" class="standardControl_afl">
                                                    <option value="management_manager">管户经理</option>
                                                    <spring:eval expression='@sysGroupService.selectByCompanyId(currentUser.companyId)' var="groupList" />
                                                    <c:forEach items="${groupList}" var="sysGroup">
                                                        <option value="${sysGroup.id}">${sysGroup.name }</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <p></p>
                                            <!--回访方式-->
                                            <div id="" class="display_inlineBlock" data-arg="wrap">
                                                <span class="content_txt">回访方式</span>
                                                <span class="returnPopupWrap">
                                                    <select id="sel_returnMethod"  class="standardControl_afl">
                                                        <option value="点击查看所选项">点击查看所选项</option>
                                                    </select>
                                                    <!--不能用PREVENTDEFAULT，所以加了个假的层-->
                                                    <span name="returnPopupFake" class="standardControl_afl returnPopupFake"></span>
                                                </span>
                                                
                                                <!--弹出的多选配置框-->
                                                <div name="popupCheckbox">
                                                    <div name="returnMethodPopup" style="" tabindex="0" class="standardControl_afl popupCheckbox" >
                                                        <div style="display: flex;justify-content: space-between;" data-arg="电话回访">现场回访 <input type="checkbox"></div>
                                                        <div style="display: flex;justify-content: space-between;" data-arg="短信回访">短信回访 <input type="checkbox"></div>
                                                        <div style="display: flex;justify-content: space-between;" data-arg="微信回访">微信回访 <input type="checkbox"></div>
                                                        <div style="display: flex;justify-content: space-between;" data-arg="电话回访">电话回访 <input type="checkbox"></div>
                                                    </div>
                                                </div>
                                                <!--结束弹出框-->
                                            </div>
                                            <p></p>
                                            
                                            <!--完成时间-->
                                            <div name="finishtime" style="">
                                                <span class="content_txt">完成时间</span>
                                                <span class="standardControl_afl display_inlineBlock align_left">
                                                    即刻起第
                                                    <input type="number" onkeypress="quotaKeypress(event, this)" name="txt_finishTime" pattern="\d" class="txt_day standardTxt_afl"> 
                                                    天完成任务
                                                </span>
                                            </div>
                                            <p></p><p></p>
                                            <!--保存取消按钮-->
                                            <div name="btn_exception" style="">
                                                <span class="button_white button_middleSize" name="btn_cancel">取&nbsp;&nbsp;消</span>
                                                <span class="button_black button_middleSize" name="btn_save"">保&nbsp;&nbsp;存</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div id="div_btnArea" class="div_btnArea">
                <span id="btn_save" class="button_black button_middleSize" onclick="save_riskInquiry()" >保&nbsp;&nbsp;存</span>
            </div>
            
        </div>
    </div>

    <!-- jQuery -->
    <script src="${ imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${ imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="${ imgStatic }/vendors/iCheck/icheck.min.js"></script>
    <!-- Switchery -->
    <script src="${ imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
    <!-- PNotify -->
    <script src="${ imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${ imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${ imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <!-- jQuery UI -->
    <script src="${ imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>
    <script src="${ imgStatic }/zwy/js/wd-common.js"></script>
    <script src="${ imgStatic }/vendors/layer/layer.js"></script>
    <script src="${ imgStatic }/zwy/js/layer-customer.js"></script>
    <script src="${ imgStatic }/zwy/js/pnotify-customer.js"></script>
    <script src="${ imgStatic }/zwy/js/common_bake_jyshen.js"></script>
    <script src="${ imgStatic }/zwy/js/afterLoanPolicy.js"></script>
      
    <script>
        //定询策略保存
        var save_riskInquiry = function() {
            var json_datas = {};
            
            if (!riskInquiry_validate()) {
                return false;
            }
            
          //获取数据全局缓存
			var save_datas = [];
			
			//获取数据回调函数
			var callback_each = function(index, item) {
				if ($(this).hasClass("checked")) {
					save_datas.push($(this).closest("[data-arg]").attr("data-arg"));
				}
			}
			//选择产品，选中就取出产品的ID
			$("#praoductPopup div[data-arg] .icheckbox_flat-blue").each(callback_each);
			json_datas.productIds = JSON.stringify(save_datas);
			save_datas = [];
			
			//选择客户类型，选中就取出KEY
			$("#customerPopup div[data-arg] .icheckbox_flat-blue").each(callback_each);
			json_datas.customerTypeIds = JSON.stringify(save_datas);
			save_datas = [];
			
			//选择还款方式，选中就取出KEY
			$("#repaymentPopup div[data-arg] .icheckbox_flat-blue").each(callback_each);
			json_datas.repaymentCategorys = JSON.stringify(save_datas);
			save_datas = [];
			
			//选择有房无房
			json_datas.hasHouse = $("#span_hasHouse span.checked").index();
			
			//选择贷款金额
			json_datas.minAmount = $("#txt_publishTask").val().replace(/,|>| |￥|¥|\s/g, '')
			json_datas.maxAmount = $("#txt_cutTask").val().replace(/,|>| |≥|￥|¥|\s/g, '');
			
			var policyItemList = [];
            
            //选择回访方式，选中就取出KEY
            $("#div_table .div_tr .div_td [name=div_popupException]").each(function(index, item) {
                var tmp = [];
                //如果发布回访任务 选中
                if ($(this).closest(".div_tr").find("[name=chk_publish]").parent(".icheckbox_flat-blue").hasClass("checked")) {
                    $(this).find("[name=returnMethodPopup]>div[data-arg] .icheckbox_flat-blue").each(function(i, el) {
                        if ($(this).hasClass("checked")) {
                            tmp.push(el.parentNode.dataset.arg);
                        }
                    });
                }
                
                //定询周期
                var period = $(this).closest(".div_tr").find("[name=sel_period]").val();
                //发布异常预警
                var warring = $(this).closest(".div_tr").find("[name=chk_warring]").parent(".icheckbox_flat-blue").hasClass("checked")?true:false;
                //发布任务
                var doCallbackTask = $(this).closest(".div_tr").find("[name=chk_publish]").parent(".icheckbox_flat-blue").hasClass("checked")?true:false;
                
                var returnPeople = $(this).find("[name=sel_returnPeople]").val();
                var finishTime = $(this).find("[name=txt_finishTime]").val();
                
                policyItemList.push({
                	"rwRiskQueryKey" : $(this).closest(".div_tr").data("rwriskquerykey"),
            		"queryCycle": parseInt(period),
            		"doAnomalyWarning":warring ? 1 :0,
            		"doCallbackTask": doCallbackTask ? 1 :0,
            		"callbackCategorys": JSON.stringify(tmp),
            		"callbackUser": returnPeople,
            		"taskClosingDay": finishTime ? parseInt(finishTime) : null
                });
            });
            json_datas.id = "${wdPlRiskInquiryPolicy.id}";
            json_datas.policyItems= JSON.stringify(policyItemList);
            
            console.log(JSON.stringify(json_datas));
            
          //POST数据
			$.ajax({
	            url: "${ctx}/wdpl/riskInquiry/policy/save",
	            cache: false,
	            type: "post",
	            data: json_datas,
	            dataType: "json",
	            success: function (result) {
	                if (result.success) {
	                	SetLayerData("_save_policy", true);
						CloseIFrame();
	                } else {
	                    NotifyInCurrentPage("error", result.msg, "设置策略时出现一个错误");
	                }
	            }
	        });
            
        };
        
        var initRiskInquiry = null;
        
        $(document).ready(function() {
        	var json_datas = {
				productIds : '${wdPlRiskInquiryPolicy.productIds}' ? JSON.parse('${wdPlRiskInquiryPolicy.productIds}') : null,
				customerTypeIds : '${wdPlRiskInquiryPolicy.customerTypeIds}' ? JSON.parse('${wdPlRiskInquiryPolicy.customerTypeIds}') : null,
				repaymentCategorys : '${wdPlRiskInquiryPolicy.repaymentCategorys}' ? JSON.parse('${wdPlRiskInquiryPolicy.repaymentCategorys}') : null,
				policyItemList : ${fns:toJsonString(wdPlRiskInquiryPolicy.getPolicyItemList())}
			};
			console.log(json_datas);
			initRiskInquiry(json_datas);
			$("#span_hasHouse span[name=${wdPlRiskInquiryPolicy.getHasHouseDesc() ? wdPlRiskInquiryPolicy.getHasHouseDesc() : '不限'}]").addClass("checked");
        })
    </script>
</body>
</html>