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
    <title>回访策略编辑</title>
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
                    <span class="content_txt">贷款金额1</span>
                    <span id="span_amount" class="standardControl_afl">
                        <input id="txt_publishTask" value="${wdPlCallbackPolicy.minAmount }" type="text" name="txt_amount" class="standardTxt_afl" placeholder=" >"> ~
                        <input id="txt_cutTask" value="${wdPlCallbackPolicy.maxAmount }" type="text" name="txt_amount" class="standardTxt_afl" placeholder=" ≥">
                    </span>
                </span>
            </div>
            
            <!--处理规则-->
            <div id="div_rule">
                <div>处理规则</div>
                <div class="div_line"></div>
                
                <!--回访人员-->
                <div id="div_returnPeopleWrap" class="display_block">
                    <span class="content_txt">回访人员</span>
                    <select id="sel_returnPeople" class="standardControl_afl">
                        <option value="management_manager" ${'management_manager' eq wdPlCallbackPolicy.callbackUser ? 'selected' : '' }>管户经理</option>
                        <spring:eval expression='@sysGroupService.selectByCompanyId(currentUser.companyId)' var="groupList" />
                        <c:forEach items="${groupList}" var="sysGroup">
                            <option value="${sysGroup.id}" ${sysGroup.id eq wdPlCallbackPolicy.callbackUser ? 'selected' : '' }>${sysGroup.name }</option>
                        </c:forEach>
                    </select>
                </div>
                
                <!--回访方式-->
                <div id="div_returnMethodWrap" class="display_block">
                    <span class="content_txt">回访方式</span>
                    <span class="returnPopupWrap">
                        <select id="sel_returnMethod"  class="standardControl_afl">
                            <option value="点击查看所选项">点击查看所选项</option>
                        </select>
                        <!--不能用PREVENTDEFAULT，所以加了个假的层-->
                        <span id="returnPopupFake" name="returnPopupFake" class="standardControl_afl returnPopupFake"></span>
                    
                        <!--弹出的多选配置框-->
                        <div name="popupCheckbox">
                            <div id="returnMethodPopup" tabindex="0" class="standardControl_afl popupCheckbox" data-key="请选择产品">
                                <!--<div style="display: flex;justify-content: space-between;">所有方式 <input type="checkbox"></div>-->
                                <div style="display: flex;justify-content: space-between;" data-arg="现场回访">现场回访 <input type="checkbox"></div>
                                <div style="display: flex;justify-content: space-between;" data-arg="短信回访">短信回访 <input type="checkbox"></div>
                                <div style="display: flex;justify-content: space-between;" data-arg="微信回访">微信回访 <input type="checkbox"></div>
                                <div style="display: flex;justify-content: space-between;" data-arg="电话回访">电话回访 <input type="checkbox"></div>
                            </div>
                        </div>
                        
                        <!--结束弹出框-->
                    </span>
                </div>
                
                <c:choose>
                    <c:when test="${wdPlCallbackPolicy.callbackType == 1}">
                        <!--首次回访策略页面需要的控件-->
                        <div id="div_firstVisit">
                            <!--放款后发布任务-->
                            <div id="span_publishWrap1" class="display_block">
                                <span class="content_txt">放款后第</span>
                                <input type="number" value="${wdPlCallbackPolicy.taskReleaseDay }" onkeypress="quotaKeypress(event, this)" id="taskReleaseDay" pattern="\d" class="txt_day standardTxt_afl">日，发布任务
                            </div>
                            
                            <!--放款后截至任务-->
                            <div id="span_CutWrap1" class="display_block">
                                <span class="content_txt">放款后第</span>
                                <input type="number" value="${wdPlCallbackPolicy.taskClosingDay }" onkeypress="quotaKeypress(event, this)" id="taskClosingDay" class="txt_day standardTxt_afl">日，截至任务
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${wdPlCallbackPolicy.callbackType == 2}">
                        <div id="div_start_point" class="display_block">
                            <span class="content_txt">起始日</span>
                            <select id="sel_startPoint" class="standardControl_afl">
                                <option value="2" ${2 eq wdPlCallbackPolicy.startPoint ? 'selected' : '' }>首次回访开始</option>
                                <option value="1"  ${1 eq wdPlCallbackPolicy.startPoint ? 'selected' : '' }>放款日开始</option>
                            </select>
                        </div>
                         <!--定期回访策略页面需要的控件-->
                         <!--回访周期-->
                        <div>
                            <div id="span_returnPeriodWrap" class="display_block">
                                <span class="content_txt">每隔</span>
                                <input type="number" value="${wdPlCallbackPolicy.taskReleaseDay }" onkeypress="quotaKeypress(event, this)" id="taskReleaseDay" class="txt_day standardTxt_afl">天，发布任务
                            </div>
                        </div>
                        <div>
                            <div id="span_returnPeriodWrap" class="display_block">
                                <span class="content_txt">任务发布后</span>
                                <input type="number" value="${wdPlCallbackPolicy.taskClosingDay }" onkeypress="quotaKeypress(event, this)" id="taskClosingDay" class="txt_day standardTxt_afl">天，截止任务
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${wdPlCallbackPolicy.callbackType == 3}">
                        <!--到期回访策略页面需要的控件-->
                        <div id="div_expiredVist">
                            <!--到期前发布任务-->
                            <div id="span_publishWrap2" class="display_block">
                                <span class="content_txt">到期前</span>
                                <input type="number" value="${wdPlCallbackPolicy.taskReleaseDay }" onkeypress="quotaKeypress(event, this)" id="taskReleaseDay" class="txt_day standardTxt_afl">日，发布任务
                            </div>
                            
                            <!--到期前发布任务-->
                            <div id="span_CutWrap2" class="display_block">
                                <span class="content_txt">到期前</span>
                                <input type="number" value="${wdPlCallbackPolicy.taskClosingDay }" onkeypress="quotaKeypress(event, this)" id="taskClosingDay" class="txt_day standardTxt_afl">日，截至任务
                            </div>
                        </div>
                    </c:when>
                </c:choose>
            </div>
            <div id="div_btnArea" class="div_btnArea">
                <span id="btn_save" class="button_black button_middleSize" onclick="save_returnVisit()" >保&nbsp;&nbsp;存</span>
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
		
		//回访策略保存
		var save_returnVisit = function() {
			var json_datas = {};
			var str1, str2;
			//StartLoad();
			
			if (!returnVisit_validate()) {
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
			json_datas.callbackType = "${wdPlCallbackPolicy.callbackType}"
			
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
			
			//选择回访方式，选中就取出KEY
			$("#returnMethodPopup div[data-arg] .icheckbox_flat-blue").each(callback_each);
			json_datas.callbackCategorys = JSON.stringify(save_datas);
			save_datas = [];
			
			//选择有房无房
			json_datas.hasHouse = $("#span_hasHouse span.checked").index();
			
			//选择贷款金额
			json_datas.minAmount = $("#txt_publishTask").val().replace(/,|>| |￥|¥|\s/g, '')
			json_datas.maxAmount = $("#txt_cutTask").val().replace(/,|>| |≥|￥|¥|\s/g, '');
			
			//选择回访人员
			json_datas.callbackUser = $("#sel_returnPeople").val();
			
			//起始点
			json_datas.startPoint = $("#sel_startPoint").val();
			
			//选择放款后第N天 发布任务
			json_datas.taskReleaseDay = $("#taskReleaseDay").val();
			
			//选择放款后第N天 截至任务
			json_datas.taskClosingDay = $("#taskClosingDay").val();
			json_datas.id = "${wdPlCallbackPolicy.id}";
			
			//POST数据
			$.ajax({
	            url: "${ctx}/wdpl/callback/policy/save",
	            async: true,
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
		
		var initReturnVisit = null;
		
		$(document).ready(function() {
			var json_datas = {
				productIds : '${wdPlCallbackPolicy.productIds}' ? JSON.parse('${wdPlCallbackPolicy.productIds}') : null,
				customerTypeIds : '${wdPlCallbackPolicy.customerTypeIds}' ? JSON.parse('${wdPlCallbackPolicy.customerTypeIds}') : null,
				repaymentCategorys : '${wdPlCallbackPolicy.repaymentCategorys}' ? JSON.parse('${wdPlCallbackPolicy.repaymentCategorys}') : null,
				callbackCategorys : '${wdPlCallbackPolicy.callbackCategorys}' ? JSON.parse('${wdPlCallbackPolicy.callbackCategorys}') : null
			};
			console.log(json_datas);
			initReturnVisit(json_datas);
			$("#span_hasHouse span[name=${wdPlCallbackPolicy.getHasHouseDesc() ? wdPlCallbackPolicy.getHasHouseDesc() : '不限'}]").addClass("checked");
		});
	</script>
</body>
</html>