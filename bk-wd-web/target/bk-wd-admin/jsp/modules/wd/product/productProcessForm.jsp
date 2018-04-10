<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<link href="${imgStatic }/zwy/css/product_process.css" rel="stylesheet">
<script src="${imgStatic }/zwy/js/ObjTree.js"></script>
<!-- Font Awesome -->
   
<style type="text/css">
    #microCreditProcessSettingDiv .noDrop {
        cursor: no-drop;
    }
</style>
<spring:eval expression="@sysGroupService.selectByCompanyId(currentUser.companyId)" var="groupList"/>

<div style="width:100%; text-align:center;">
<div id="div_processContent" style="" class="obj_center"></div>
<script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>
<script>
//操作DOM的和操作OBJ数据的尽量分离
//定义全局变量，以供父元素使用
var GetProcessSettings = null;
//XML服务端返回的数据存放这里
var XMLText = '${processXml}';

var getNodeByKey = null;

//这里第一个出现的val是设置索引的参数
//设置val可以设置默认索引
var _user_group = [];
<c:forEach items="${groupList }" var="userGroup">
	_user_group.push({txt:"${userGroup.name}" , val: "${userGroup.id}"})
</c:forEach>

var sel_mainNodeDatas = [
	{val:0, datas:[{txt:"自由抢单", val:"0"}, {txt:"随机分配", val:"1"}]},
	{val:0, datas: _user_group}
];

var sel_carloan = [
	{val:0, datas:[{txt:"自由抢单", val:"0"}, {txt:"随机分配", val:"1"}]},
	{val:0, atas:[ {txt:"客户经理", val:"0"}, {txt:"车贷抵押组", val:"1"}]}
];

var sel_mainNodeRefuse = {val:1, visible:true, datas:[ {txt:"无驳回操作", val:"0"}, {txt:"驳回到调查", val:"调查"}, /*"驳回到上一个节点"*/]};

//总行审批的所有担保方式,这里的值会有变化
var guaranteeMethods = {data:[
	{key:"担保", val:""},
	{key:"信用", val:""},
	{key:"抵押", val:""},
	{key:"质押", val:""}
]};

</script>
<script src="${imgStatic }/zwy/js/product_process.js"></script>