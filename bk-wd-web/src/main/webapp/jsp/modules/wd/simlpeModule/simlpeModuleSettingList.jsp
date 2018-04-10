<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
    <div class="x_title">
        <h2> 业务元件 </h2>
        <ul class="nav navbar-right panel_toolbox">
            <li>
                <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle btn-add-element" onclick="javascript:newElement('${wdDefaultSimpleModule.id }')">新增</button>
            </li>
        </ul>
        <div class="clearfix"></div>
    </div>
    <div class="x_content">
        <table id="datatable" class="wd-table table table-striped table-bordered">
            <thead>
                <tr>
                    <th style="width:160px">标题</th>
                    <th style="width:140px">组件类型</th>
                    <!-- <th>占位符</th> -->
                    <th>Key</th>
                    <th style="width:120px">高度</th>
                    <th>选择项</th>
                    <!-- <th>键盘类型</th> -->
                    <!-- <th>正则</th> -->
                    <!-- <th>错误提示</th> -->
                    <!-- <th>辅助功能</th> -->
                    <td style="width:120px">是否必选</td>
                    <th style="width:160px"></th>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${dataList}" var="businessElement">
                    <tr itemid="${businessElement.moduleSettingId }">
                        <td>${businessElement.name }</td>
                        <td>
                             <spring:eval expression="@wdBaseElementService.selectByPrimaryKey(businessElement.baseElementId)" var="baseElement"/>
                             ${baseElement.name }
                        </td>
                        <%-- <td>${businessElement.placeholder }</td> --%>
                        <td>${businessElement.key }</td>
                        <td>${businessElement.height }</td>
                        <td>
                            <spring:eval expression="@wdSelectGroupService.selectByPrimaryKey(businessElement.selectGroupId)" var="selectGroup"/>
                            ${selectGroup.name }
                        </td>
                        <%-- <td>${fns:getDictLabel(businessElement.keyboardType , 'keyboard_type', '')}</td> --%>
                        <%-- <td>${businessElement.regularExpression }</td> --%>
                        <%-- <td>${businessElement.errorMessage }</td> --%>
                        <%-- <td>${fns:getDictLabel(businessElement.accessorialFunction , 'accessorial_function', '')}</td> --%>
                        <td class="wd-center">
                            <input type="checkbox" class="js-switch" ${businessElement.required == '1' ? 'checked': ''}/>
                        </td>
                        <td class="cursor-default">
                            <button type="button" class="btn wd-btn-small wd-btn-indigo btn-edit-element" onclick="javascript:editElement('${businessElement.id }', '${wdDefaultSimpleModule.id }')">编辑</button>
                            <button type="button" class="btn wd-btn-small wd-btn-orange btn-del-element" onclick="javascript:delElement('${businessElement.moduleSettingId }')">删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    //新增模块
    function newElement(defaultSimpleModuleId) {
		OpenIFrame("新增", "${ctx}/wd/element/form?defaultSimpleModuleId=" + defaultSimpleModuleId, 1000, 700, function(){
			$("div.x_content ul.nav-tabs li.active a").trigger("click");
		});
    	return false;
    }
    //编辑
    function editElement(elementId, defaultSimpleModuleId) {
		OpenIFrame("编辑", "${ctx}/wd/element/form?defaultSimpleModuleId=" + defaultSimpleModuleId + "&id=" + elementId, 1000, 700, function(){
			$("div.x_content ul.nav-tabs li.active a").trigger("click");
		});
    	return false;
    }
    
 	// 删除子项
 	function delElement(defaultSimpleModuleId) {
 		Confirm("确定要删除当前数据？", function (){
            $.ajax({
                url : ctx + "/wd/simlpeModule/deleteItem",
                data : {moduleSettingId : defaultSimpleModuleId},
                type: "post",
                success : function (data) {
                	if (data.success) {
                		$("div.x_content ul.nav-tabs li.active a").trigger("click");
                	}
                }
        	});
 		});
 	}
</script>