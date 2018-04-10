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

    <title>Gentelella Alela! | </title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">

    <style type="text/css">
        table#select-group > tbody > tr {
            cursor: pointer;
        }

        table#select-group > tbody > tr[selected=selected] {
            background-color: rgba(52, 64, 92, 0.25);
        }

        .table > tbody > tr > td,
        .table > tbody > tr > th,
        .table > tfoot > tr > td,
        .table > tfoot > tr > th,
        .table > thead > tr > td,
        .table > thead > tr > th {
            vertical-align: middle;
        }

        .cursor-default {
            cursor: default;
        }
    </style>
</head>

<body>
    <!-- page content -->

    <div class="wd-content">
        <div class="wd-piece-title col-md-12 col-sm-12 col-xs-12">
            <h2> 选择项设置 </h2>
        </div>

        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="col-md-6 col-sm-6 col-xs-12 wd-nonmargin" style="border-right:1px solid rgb(204,204,204); padding:10px 15px;">
                <div class="form-group">
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-group">新增</button>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="form-group">
                    <table id="select-group" class="table table-striped table-bordered wd-table">
                        <thead>
                            <tr>
                                <th style="width:38%;"> CODE </th>
                                <th> NAME </th>
                                <th style="width:256px;"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <!-- groupid是wd_select_group的id -->
                            <c:forEach items="${ dataList }" var="group">
                                <tr groupid="${group.id}">
                                    <td> ${group.code} </td>
                                    <td> ${group.name} </td>
                                    <td class="cursor-default">
                                        <button type="button" class="btn wd-btn-small wd-btn-indigo btn-edit-group" groupid="${group.id}">编辑</button>
                                        <button type="button" class="btn wd-btn-small wd-btn-orange btn-del-group" groupid="${group.id}">删除</button>
                                        <button type="button" class="btn wd-btn-small wd-btn-gray btn-add-group-item" groupid="${group.id}">新增子项</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="div-select-list" class="col-md-6 col-sm-6 col-xs-12 wd-nonmargin" style="border-left:1px solid rgb(204,204,204); margin-left:-1px; padding:10px 15px;">
            </div>

        </div>
    </div>
    <!-- /page content -->
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="${imgStatic }/vendors/iCheck/icheck.min.js"></script>
    <!-- jQuery UI -->
    <script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script type="text/javascript">
        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        function UpdateItemSort(tbodyObj) {
            var itemsNewSort = [];
            $(tbodyObj).children("tr").each(function () {
                var thisItemSort = {
                    "id": $(this).attr("itemid"),
                    "sort": $(this).attr("itemsort")
                };

                itemsNewSort.push(thisItemSort);
            });

            //ajax请求删除对应的item
            $.ajax({
				url : "${ctx}/wd/selectItem/itemSort",
				data : {itemData : JSON.stringify(itemsNewSort)},
				type: "post",
				success : function (data){
				}
			})
        }


        function AddOrEditGroup() {
            var addgroup = GetLayerData("AddOneSelectGroup");

            if (addgroup) {
                var targetTr = $("table#select-group tbody tr[groupid=" + addgroup.id + "]");
                if (targetTr.length == 0) { // 新增
                    var trHtml = '<tr groupid="' + addgroup.id + '"> \r\n';
                    trHtml += '<td> ' + addgroup.code + ' </td> \r\n <td> ' + addgroup.name + ' </td> \r\n';
                    trHtml += '<td class="cursor-default"> \r\n';
                    trHtml += '<button type="button" class="btn wd-btn-small wd-btn-indigo btn-edit-group" groupid="' + addgroup.id + '">编辑</button> \r\n';
                    trHtml += '<button type="button" class="btn wd-btn-small wd-btn-orange btn-del-group" groupid="' + addgroup.id + '">删除</button> \r\n';
                    trHtml += '<button type="button" class="btn wd-btn-small wd-btn-gray btn-add-group-item" groupid="' + addgroup.id + '">新增子项</button> \r\n';
                    trHtml += '</td> \r\n </tr>';

                    $("table#select-group tbody").append(trHtml);
                } else { // 修改
                    $(targetTr.children("td")[0]).text(addgroup.code);
                    $(targetTr.children("td")[1]).text(addgroup.name);
                }
            }
        }

        function AddOrEditItem() {
            var additem = GetLayerData("AddOneSelectItem");

            if (additem) {
                var listId = additem.listId;

                var targetTr = $("table.select-item tbody tr[itemid=" + additem.id + "]");
                if (targetTr.length == 0) { // 新增

                    var targetTBody = $("table.select-item[listid=" + listId + "] tbody");

                    var trHtml = '<tr itemid="' + additem.id + '" itemsort="' + additem.sort + '"> \r\n';
                    trHtml += '<td> ' + additem.code + ' </td> \r\n <td> ' + additem.name + ' </td> \r\n';
                    trHtml += '<td class="cursor-default"> \r\n';
                    trHtml += '<button type="button" class="btn btn-info btn-edit-item" itemid="' + additem.id + '">编辑</button> \r\n';
                    trHtml += '<button type="button" class="btn btn-danger btn-del-item" itemid="' + additem.id + '">删除</button> \r\n';
                    trHtml += '</td> \r\n </tr>';

                    targetTBody.append(trHtml);
                } else { // 修改
                    $(targetTr.children("td")[0]).text(additem.code);
                    $(targetTr.children("td")[1]).text(additem.name);
                }
            }
        }

        $(document).ready(function () {

            //排序拖动时的样式
            var fixHelperModified = function (e, tr) {
                var $originals = tr.children();
                var $helper = tr.clone();
                $helper.children().each(function (index) {
                    $(this).width($originals.eq(index).width())
                    $(this).css("background-color", "#CCCFD6");
                });
                return $helper;
            };

            //排序完成后的事件
            var updateIndex = function (e, ui) {
                ui.item.parent("tbody").children("tr").each(function (i) {
                    $(this).attr("itemsort", i);
                });

                UpdateItemSort(ui.item.parent("tbody"));
            };

            // 选中Group
            $(document).on("click", "table#select-group tbody tr td:not(.cursor-default)", function () {
                $("table#select-group tbody tr[selected=selected]").removeAttr("selected");
                $(this).parent("tr").attr("selected", "selected");

                var groupId = $(this).parent("tr").attr("groupid");

                $("#div-select-list").load("${ctx}/wd/selectItem/showSelectList?groupId=" + groupId, null, function() {
                    $(".select-item tbody").sortable({
                        helper: fixHelperModified,
                        stop: updateIndex
                    }).disableSelection();
                });
            });


            //新增Group
            $(document).on("click", "#btn-add-group", function () {
                OpenBigIFrame("新增Group", "${ctx}/wd/selectItem/selectGroupForm", function () {
                    AddOrEditGroup()
                });
            });

            //修改Group
            $(document).on("click", ".btn-edit-group", function () {
                var groupId = $(this).attr("groupid");
                OpenBigIFrame("修改Group", "${ctx}/wd/selectItem/selectGroupForm?groupId=" + groupId, function () {
                    AddOrEditGroup();
                });
            });

            // 删除Group
            $(document).on("click", ".btn-del-group", function () {
                var currentTr = $(this).parents("tr");
                Confirm("确定要删除当前数据？", function (){
                    if (currentTr.length == 1) {
                        var groupId = currentTr.attr("groupid"); //wd_select_group表的id
    
                        //ajax请求删除对应的item
                        $.ajax({
            				url : "${ctx}/wd/selectItem/delSelectGroup",
            				data : {groupId : groupId},
            				type: "post",
            				success : function (data){
            					currentTr.fadeOut(512, function () {
            	                    currentTr.remove();
            	                });
            				}
            			})
                    }
                });
            });

            //新增Group子项即List
            $(document).on("click", ".btn-add-group-item", function () {
                var currentTr = $(this).parents("tr");
                var groupId = $(this).attr("groupid");

                OpenBigIFrame("新增Group子项", "${ctx}/wd/selectItem/selectListForm?selectGroupId=" + groupId, function () {
                    $(currentTr.children("td")[0]).click();
                });
            });

            //修改List
            $(document).on("click", ".btn-edit-list", function () {
                var listId = $(this).attr("listid");
                var listTitle = $(this).parents(".x_title").children("h2");

                OpenBigIFrame("修改List", "${ctx}/wd/selectItem/selectListForm?listId=" + listId, function () {
                    var addlist = GetLayerData("AddOneSelectList");
                    if (addlist) {
                        $(listTitle).html(addlist.name + "<small>" + addlist.code + "</small>")
                    }
                });
            });

            // 删除List
            $(document).on("click", ".btn-del-list", function () {
                var listId = $(this).attr("listid"); //wd_select_list表的id

                Confirm("确定要删除当前数据？", function (){
                	//ajax请求删除对应的item
                    $.ajax({
        				url : "${ctx}/wd/selectItem/delSelectList",
        				data : {listId : listId},
        				type: "post",
        				success : function (data){
        					var currentPanl = $(".x_panel[listid=" + listId + "]");
        	                currentPanl.fadeOut(512, function () {
        	                    currentTr.remove();
        	                });
        				}
        			});
                	
                });
            });

            //新增List子项即Item
            $(document).on("click", ".btn-add-item", function () {
                var listId = $(this).attr("listid");

                var allTr = $("table.select-item[listid=" + listId + "] tbody").children("tr");
                var itemsort = 0;
                if (allTr.length > 0) {
                    var lastsort = $(allTr[allTr.length - 1]).attr("itemsort");
                    if (!isNaN(lastsort)) {
                        itemsort = Number(lastsort) + 1;
                    }
                };

                OpenBigIFrame("新增List子项", "${ctx}/wd/selectItem/selectItemForm?listId=" + listId + "&sort=" + itemsort, function () {
					if (GetLayerData("AddOneSelectItem")) {
                		SetLayerData("AddOneSelectItem", null);
                		$("#select-group tr[selected=selected] td").trigger("click");
					}
                   // AddOrEditItem();
                });
            });

            //修改Item
            $(document).on("click", ".btn-edit-item", function () {
                var itemId = $(this).attr("itemid");

                OpenBigIFrame("修改Item", "${ctx}/wd/selectItem/selectItemForm?itemId=" + itemId, function (){
                	if (GetLayerData("AddOneSelectItem")) {
                		SetLayerData("AddOneSelectItem", null);
                		$("#select-group tr[selected=selected] td").trigger("click");
					}
                });
            });

            // 删除Item
            $(document).on("click", ".btn-del-item", function () {
            	var _me = this;
            	Confirm("确定要删除当前数据？", function (){
            		var currentTr = $(_me).parents("tr");
                    if (currentTr.length == 1) {
                        var itemId = currentTr.attr("itemid"); //wd_select_item表的id

                        //ajax请求删除对应的item
                        $.ajax({
            				url : "${ctx}/wd/selectItem/delSelectItem",
            				data : {itemId : itemId},
            				type: "post",
            				success : function (data){
            					currentTr.fadeOut(512, function () {
                                    currentTr.remove();
                                });
            				}
            			})
                    }
            	});
            });
        });
    </script>
</body>
</html>