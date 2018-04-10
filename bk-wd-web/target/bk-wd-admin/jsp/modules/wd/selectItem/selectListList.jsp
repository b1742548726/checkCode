<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="form-group">
<c:forEach items="${wdSelectLists}" var="wdSelectList">
    <div class="x_panel" style="margin-bottom:48px;" listid="${wdSelectList.id }">
        <div class="x_title">
            <h2> ${wdSelectList.name } <small>${wdSelectList.code }</small> </h2>
            <ul class="nav navbar-right panel_toolbox">
                <li>
                    <button type="button" class="btn wd-btn-normal wd-btn-indigo wd-btn-width-middle btn-edit-list" listid="${wdSelectList.id }">编辑</button>
                    <button type="button" class="btn wd-btn-normal wd-btn-orange wd-btn-width-middle btn-del-list" listid="${wdSelectList.id }">删除</button>
                    <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle btn-add-item" listid="${wdSelectList.id }">增加子项</button>
                </li>
            </ul>
            <div class="clearfix"></div>
        </div>
        <div class="x_content">
            <table class="wd-table table table-striped table-bordered select-item" listid="qwertyuiop">
                <thead>
                    <tr>
                        <th style="width:38%;"> CODE </th>
                        <th> NAME </th>
                        <th style="width:168px;"></th>
                    </tr>
                </thead>

                <tbody>
                    <!-- itemid是wd_select_item的id -->
                    <c:forEach items="${wdSelectList.itemList}" var="item">
                    <tr itemid="${item.id }" itemsort='1'>
                        <td> ${item.code } </td>
                        <td> ${item.name } </td>
                        <td class="cursor-default">
                            <button type="button" class="btn wd-btn-small wd-btn-indigo btn-edit-item" itemid="${item.id }">编辑</button>
                            <button type="button" class="btn wd-btn-small wd-btn-orange btn-del-item" itemid="${item.id }">删除</button>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</c:forEach>
</div>