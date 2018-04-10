<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="x_panel">
    <div class="x_content" style="height:512px;">
        <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left">
            <div class="form-group" style="padding:32px 32px;">
                <input type="checkbox" class="flat" id="loan_car" />
                <span style="margin-left:4px;"> 车贷抵押 </span>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    function GetProductLoan() {
    
        var complexModules = new Array();
    
        if ($("#loan_car").is(":checked")) {
            var complexModule = {
                "default_complex_module_id": "22222222-2222-2222-2222-222222222222",
                "module_name": "车贷抵押"
            };
            complexModules.push(complexModule);
        }
    
        var info = {
            "complexModules": JSON.stringify(complexModules)
        };
    
        return info;
    }

    $(function () {
		var complexModuleList = ${fns:toJsonString(complexModuleList)};
		if (complexModuleList && complexModuleList.length > 0) {
			$("#loan_car").attr("checked", "checked");
    	}
		
        $("#loan_car").iCheck({
            checkboxClass: 'icheckbox_flat-green',
            radioClass: 'iradio_flat-green'
        });
    });
</script>