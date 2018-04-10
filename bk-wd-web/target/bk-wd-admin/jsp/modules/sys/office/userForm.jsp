<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/include/taglib.jsp"%>
<h3>新增用户
    <a href="javascript:btn_save_user();" class="btn_col2">保存</a>
    <a href="javascript:btn_back_user_list();" class="btn_col1">返回</a>
</h3>
<form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" method="post">
    <input type="hidden" name="_csrf" value="${_csrf }">
    <input type="hidden" name="id" value="${sysUser.id }">
    <input type="hidden" name="officeId" value="${sysUser.officeId }">
    <input type="hidden" name="companyId" value="${sysUser.companyId }">
    <div class="r_list">
        <label for="loginName">账号<span>*</span></label>
        <input type="text" class="user_name" name="loginName" value="${sysUser.loginName }">
        <div class="warning hide">
            <ins class="import"></ins>
            <span class="hide"><i>请输入6位以上字符</i></span>
        </div>
    </div>
    
    <div class="r_list">
        <label for="">密码</label>
        <input type="password" id="pwd" name="newPassword">
        <!-- <input type="checkbox" id="first_pwd">
        <p class="pwd">首次登陆修改初始密码</p> -->
    </div>
    
    <div class="r_list">
        <label for="">密码确认</label>
        <input type="password" id="pwdAg">
        <div class="warning hide">
            <ins class="import"></ins>
            <span class="hide"><i>两次密码输入不相符</i></span>
        </div>
    </div>

    <div class="r_list">
        <label for="">姓名<span>*</span></label>
        <input type="text" class="name" name="name" value="${sysUser.name }">
        <div class="warning hide">
            <ins class="import"></ins>
            <span class="hide"><i>不能为空</i></span>
        </div>
    </div>
    <div class="r_list">
        <label for="">员工号<span>*</span></label>
        <input type="text" class="code" name="code" value="${sysUser.code }">
        <div class="warning hide">
            <ins class="import"></ins>
            <span class="hide"><i>不能为空</i></span>
        </div>
    </div>
    <div class="r_list">
        <label for="">联系电话</label>
        <input type="text" class="mobile" name="telephone" value="${sysUser.telephone }">
        <div class="warning hide">
            <ins class="import"></ins>
            <span class="hide"><i>手机号码不正确</i></span>
        </div>
    </div>
    <div class="r_list">
        <label for="">职务</label>
        <input type="text" name="station" value="${sysUser.station }">
    </div>
    <div class="r_list">
        <label for="">邮箱</label>
        <input type="text" class="mail" name="email" value="${sysUser.email }">
        <div class="warning hide">
            <ins class="import"></ins>
            <span class="hide"><i>请输入正确的邮箱</i></span>
        </div>
    </div>
    <div class="r_list">
        <label for="">性别：</label>
        <div class="tab">
            <ul id="_user_sex">
                <li class="${(empty sysUser.sex or sysUser.sex eq '男') ? 'cur' : ''}">男</li>
                <li class="${sysUser.sex eq '女' ? 'cur' : ''}">女</li>
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>
    
    <h4>权限相关</h4>
    
    <div class="r_list">
        <label for="">账号是否启用：</label>
        <div class="tab">
            <ul id="_user_status">
                <li class="${(empty sysUser.stutus or sysUser.stutus eq 1) ? 'cur' : ''}" data-value="1">已启用</li>
                <li class="${(sysUser.stutus eq 2) ? 'cur' : ''}" data-value="2">已禁用</li>
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>
    
    <div class="r_list">
        <label for="">归属 <i id="ownership" onclick="javascript:selectOwership();"></i></label>
        <p id="gsnr">${sysUser.office.name }</p>
    </div>
    
    <div class="r_list">
        <label for="">权限 <i id="permission_edit" onclick="selectOffice();"></i></label>
        <c:set var="officeIds" value=""/>
        <p id="qxnr">
            <c:forEach items="${officeList }" var="data">
                <c:set var="officeIds" value="${officeIds},${data.id }"/>
                ${data.name }，
            </c:forEach>
        </p>
        <input type="hidden" name="officeIds" id="officeIds" value="${officeIds}">
    </div>
    
    <div class="r_list">
        <label for="">角色 <i id="role_edit" onclick="selectRole();"></i></label>
        <p id="jsnr">
            <c:set var="roleIds" value=""/>
            <c:forEach items="${roleLst }" var="data">
                <c:set var="roleIds" value="${roleIds},${data.id }"/>
                ${data.name }，
            </c:forEach>
        </p>
        <input type="hidden" name="roleIds" id="roleIds" value="${roleIds}">
    </div>
</form>
<script type="text/javascript">
//手机验证
function mobile(){
    var obj = $('.mobile')
    var reg = /^1[0-9]{10}$/
    if(obj.val() != ''){
        if(!reg.exec(obj.val())){
            obj.addClass('error')
            obj.next().removeClass('hide')
        }else{
            obj.removeClass('error')
            obj.next().addClass('hide')
        }
    }else{
        obj.removeClass('error')
        obj.next().addClass('hide')
    }
}

//mail验证
function mail(){
    var obj = $('.mail')
    var reg = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
    if(obj.val() != ''){
        if(!reg.exec(obj.val())){
            obj.addClass('error')
            obj.next().removeClass('hide')
        }else{
            obj.removeClass('error')
            obj.next().addClass('hide')
        }
    }else{
        obj.removeClass('error')
        obj.next().addClass('hide')
    }
}

//姓名验证
function name(){
    var obj = $('.name')
    if(obj.val() == ''){
        obj.addClass('error')
        obj.next().removeClass('hide')
    }else{
        obj.removeClass('error')
        obj.next().addClass('hide')
    }
}

//密码验证
function pwd(){
    var obj = $('#pwdAg')
    if($('#pwd').val() != $('#pwdAg').val()){
        obj.addClass('error')
        obj.next().removeClass('hide')
    }else{
        obj.removeClass('error')
        obj.next().addClass('hide')
    }
}

//账号验证
function user_name(){
    var obj = $('.user_name')
    var reg = /[a-zA-Z0-9]{6,}/
    if(!reg.exec(obj.val())){
        obj.addClass('error')
        obj.next().removeClass('hide')
    }else{
        obj.removeClass('error')
        obj.next().addClass('hide')
    }
}

$('.warning ins').hover(function(e){
    $(this).siblings('span').removeClass('hide')
},function(){
    $(this).siblings('span').addClass('hide')
})

function selectOffice(){
	OpenIFrame("分配权限", "${ctx}/sys/office/selectOffice?officeIds="+ $("#officeIds").val(), 900, 580, function() {
		if (GetLayerData("_user_office_save")) {
			SetLayerData("_user_office_save", false);
    		var _html = "";
    		var _ids = "";
    		if (GetLayerData("_office_list_data")) {
    			var _office_list_data = GetLayerData("_office_list_data");
    			_html = _office_list_data._names.join('，');
    			_ids = _office_list_data._ids.join(',');
    			SetLayerData("_office_list_data", null);
    		}
    		$("#qxnr").html(_html);
    		$("#officeIds").val(_ids);
		}
    });
}

function selectRole(){
	OpenIFrame("分配角色", "${ctx}/sys/office/selectRole?roleIds="+ $("#roleIds").val(), 900, 580, function() {
		if (GetLayerData("_user_role_save")) {
			SetLayerData("_user_role_save", false);
    		var _html = "";
    		var _ids = "";
    		if (GetLayerData("_role_list_data")) {
    			var _role_list_data = GetLayerData("_role_list_data");
    			_html = _role_list_data._name.join('，');
    			_ids = _role_list_data._id.join(',');
    			SetLayerData("_role_list_data", null);
    		}
    		$("#jsnr").html(_html);
    		$("#roleIds").val(_ids);
		}
    });
}
function selectOwership(){
	var _officeIdDom = $("#form-add-module :input[name=officeId]");
	OpenIFrame("选择归属", "${ctx}/sys/user/userOfficeSelect?officeId="+ _officeIdDom.val(), 900, 580, function() {
		if (GetLayerData("_user_office_id_select")) {
			var _user_office_select = GetLayerData("_user_office_id_select");
			$("#gsnr").text(_user_office_select.name)
			_officeIdDom.val(_user_office_select.id);
			SetLayerData("_user_office_id_select", null);
		}
    });
}

function btn_back_user_list() {
	seachTable(null, _user_search_data);
}

function btn_save_user() {
	user_name()
	pwd()
	name()
	mobile()
	mail()
	
	if ($("#form-add-module :input.error").length > 0) {
		return;
	}

	var data = {};
	$("#form-add-module :input").each(function(){
    	if ($(this).attr("name")) {
    		data[$(this).attr("name")] = $(this).val();
    	}
    });
	data.sex = $("#_user_sex li.cur").html();
	data.stutus = $("#_user_status li.cur").data("value");
	
	StartLoad();
	$.ajax({
        url : "${ctx}/sys/user/save",
        async : false,
        cache : false,
        type : "POST",
        data : data,
        dataType : "json",
        success : function(result) {
            if (result.success) {
                seachTable(null, _user_search_data);
            	CloseIFrame();
            } else {
                NotifyInCurrentPage("error", result.msg, "删除机构错误");
            }
        },
    	complete : function (){
    		FinishLoad();
    	}
    });
}

$('.tab').on('click','li',function(){
    $(this).addClass('cur').siblings().removeClass('cur')
})
</script>