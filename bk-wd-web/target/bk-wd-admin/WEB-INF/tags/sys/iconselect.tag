<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<i id="${id}Icon" class="icon-${not empty value?value:' hide'}"></i>&nbsp;<label class="control-label" id="${id}IconLabel">${not empty value?value:'无'}</label>&nbsp;
<input id="${id}" name="${name}" type="hidden" value="${value}"/><a id="${id}Button" href="javascript:" style="margin-bottom: 2px;margin-left: 10px;" class="btn btn-default btn-sm">选择</a>&nbsp;&nbsp;
<script type="text/javascript">
	$("#${id}Button").click(function(){
		var url = "01.html";
        OpenIFrame("选择图标", "${ctx}/sys/tag/iconselect?value="+$("#${id}").val(), 700, $(top.document).height()-360, function () { console.log("close iframe");});
		/* OpenLayer("", strHtml, 360, 250, function () { CloseLayer(); }); */
		/* top.$.jBox.open(, , 700, $(top.document).height()-180, {
            buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                	var icon = h.find("iframe")[0].contentWindow.$("#icon").val();
                	$("#${id}Icon").attr("class", "icon-"+icon);
	                $("#${id}IconLabel").text(icon);
	                $("#${id}").val(icon);
                }else if (v=="clear"){
	                $("#${id}Icon").attr("class", "icon- hide");
	                $("#${id}IconLabel").text("无");
	                $("#${id}").val("");
                }
            }, loaded:function(h){
                $(".jbox-content", top.document).css("overflow-y","hidden");
            }
        }); */
	});
</script>