<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="x_span x_content">
<form id="inputForm" action="${ctx }/sys/menu/save" action="${ctx}/sys/menu/save" method="post" class="form-horizontal form-label-left">
	<input type="hidden" name="id" value="${menu.id }">
    <input type="hidden" name="parentId" value="${menu.parentId }">
    <input type="hidden" name="_csrf" value="${_csrf }">
	<%-- <div class="control-group">
		<label class="control-label">上级菜单:</label>
		<div class="controls">
             <input type="text" name="parentId" value="${menu.parentId }">
               <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
				title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="required"/>
		</div>
	</div> --%>
	<div class="item form-group">
      <label for="name" class="control-label col-md-3 col-sm-3 col-xs-12">名称:</label>
      <div class="col-md-6 col-sm-6 col-xs-12">
        <input type="text" name="name" value="${menu.name }" class="form-control col-md-7 col-xs-12" required="required">
      </div>
    </div>
    <div class="item form-group">
      <label for="href" class="control-label col-md-3 col-sm-3 col-xs-12">链接:</label>
      <div class="col-md-6 col-sm-6 col-xs-12">
        <input type="text" name="href" value="${menu.href }" class="form-control col-md-7 col-xs-12" placeholder="点击菜单跳转的页面">
      </div>
    </div>
    <div class="item form-group">
      <label for="href" class="control-label col-md-3 col-sm-3 col-xs-12">图标:</label>
      <div class="col-md-6 col-sm-6 col-xs-12">
        <input type="text" name="icon" value="${menu.icon }" class="form-control col-md-7 col-xs-12">
		<%-- <sys:iconselect id="icon" name="icon" value="${menu.icon}"/> --%>
      </div>
    </div>
    <div class="item form-group">
      <label for="sort" class="control-label col-md-3 col-sm-3 col-xs-12">排序:</label>
      <div class="col-md-6 col-sm-6 col-xs-12">
		<input type="text" name="sort" class="form-control col-md-2" value="${menu.sort }" required="required" placeholder="排列顺序，升序">
      </div>
    </div>
    <div class="item form-group">
      <label for="show" class="control-label col-md-3 col-sm-3 col-xs-12">可见:</label>
      <div class="col-md-6 col-sm-6 col-xs-12">
           <input type="checkbox" name="show" class="flat" checked="checked" value="1">
      </div>
    </div>
    <div class="item form-group">
      <label for="sort" class="control-label col-md-3 col-sm-3 col-xs-12">权限标识:</label>
      <div class="col-md-6 col-sm-6 col-xs-12">
		<input type="text" name="permission" value="${menu.permission }" class="form-control col-md-7 col-xs-12" placeholder='控制器中定义的权限标识'>
      </div>
    </div>
    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-6">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <button class="btn" type="button" onclick="javascript:CloseLayer();">关 闭</button>
      </div>
    </div>
</form>
</div>
<script>
$(function(){
	$("#inputForm").on("submit", function(event) {
		event.preventDefault();
		$.ajax({
            url : this.action,
            data : $(this).serialize(),
            type: "post",
            success : function (data) {
            	if (data.code == 200) {
            		SetLayerData("_save_menu_data", true);
            		CloseLayer();
            	}
            }
		});
	});
})

</script>

