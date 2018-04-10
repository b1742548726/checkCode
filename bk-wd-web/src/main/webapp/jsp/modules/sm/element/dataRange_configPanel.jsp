<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<table class="wd-table table table-striped table-bordered">
    <thead>
        <tr>
            <th> 名称 </th>
            <th style="width:100px;"> 是否必填 </th>
            <th style="width:188px;"> 选择项 </th>
        </tr>
    </thead>

    <tbody>
        <tr elementid="qwertyuiop" itemsort="0">
            <td>小区名</td>
            <td>
                <input type="checkbox" class="js-switch" checked="checked"  />
            </td>
            <td></td>
        </tr>
        <tr elementid="poiuytrewq" itemsort="1">
            <td>面积</td>
            <td>
                <input type="checkbox" class="js-switch"  />
            </td>
            <td></td>
        </tr>
        <tr elementid="asdfghjkl" itemsort="2">
            <td>估值</td>
            <td>
                <input type="checkbox" class="js-switch" checked="checked"  />
            </td>
            <td></td>
        </tr>
        <tr elementid="asdfghjkl" itemsort="2">
            <td>贷款余额</td> 
            <td>
                <input type="checkbox" class="js-switch" checked="checked"  />
            </td>
            <td></td>
        </tr>
    </tbody>
</table>