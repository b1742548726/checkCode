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

    <title></title>

    <!-- Bootstrap -->
    <link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/iCheck/skins/flat/blue.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

    <link href="${imgStatic}/zwy/LBQ/css/popup_style.css" rel="stylesheet">
    
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/css/afterLoanPolicy.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${imgStatic }/vendors/iCheck/skins/flat/green.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
</head>
<style>
[name=div_layui_layer] {
    display: none;
}

[name=td_product] {
    overflow: hidden;
    text-overflow:ellipsis;
    white-space: nowrap;
}
</style>
<body>
    <!-- page content -->

    <div id="relateScore" class="wd-content">

        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            
            <div class="x_content">
                <table class="table table-striped table-bordered wd-table">
                    <thead>
                        <tr>
                            <th> 名称 </th>
                            <th> 描述 </th>
                            <th> 应用的产品 </th>
                            <th> 操作 </th>
                        </tr>
                    </thead>
                    <tbody>
                   	    <c:forEach items="${pagination.dataList}" var="data">
                            <tr data-id="${data.key }">
                                <td> ${data.name } </td>
                                <td> ${data.remarks } </td>
                                <td name="td_product">
                                    <spring:eval expression="@wdProductSmModelService.selectByModelKey(data.key)" var="productList"/>
                                    <c:forEach items="${productList}" var="product">
                                        ${product.productName },
                                    </c:forEach>
                                    <span style="display: none;" name="model_prdocut_ids"><c:forEach items="${productList}" var="product">${product.productId },</c:forEach></span>
                                </td>
                                <td>
                                    <button type="button" name="btn_config" class="btn wd-btn-small wd-btn-orange">配置</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        
        
        <div style="margin:0 auto;top:50%;left:0;margin-top:-27.5em;right:0;width:52.3em;height:55em;" class="layui-layer  layer-anim"  name="div_layui_layer" >
            <div class="layui-layer-title" style="cursor: move;">
                同步节点
                <span class="layui-layer-setwin">
                    <a class="layui-layer-min" href="javascript:;"><cite></cite></a>
                    <a class="layui-layer-ico layui-layer-max" href="javascript:;"></a>
                    <a class="layui-layer-ico layui-layer-close layui-layer-close1" href="javascript:void(0)" onclick="$(this).closest('[name=div_layui_layer]').hide();return false;"></a>
                </span>
            </div>
            <div class="layui-layer-content" style="height:80%;">
                <div name="praoductPopup" tabindex="0" class="standardControl_afl popupCheckbox noBorderAndBackGround" style="display: flex;" data-key="请选择产品">
                   <!--  <div style="display: flex;justify-content: space-between;" data-arg="all">
                        <div>所有产品（含后期新增）<input type="checkbox"></div>
                    </div> -->
                    <spring:eval expression="@wdProductService.selectByRegion(currentUser.companyId)" var="productList"/>
                    <c:if test="${not empty productList}">
                        <c:forEach items="${productList}" var="product">
                            <div style="display: flex;justify-content: space-between;" data-arg="${product.id}">${product.name }<input type="checkbox"></div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-6 obj_center" style="left:50%;transform:translateX(-50%);width:auto;">
            <input name="btn_config_submit" type="button" class="btn wd-btn-normal wd-btn-orange wd-btn-width-middle pull-right" style="background:#169bd5;border:none;height:2.1em;" value="确定" >
                <input name="btn_config_cancel" type="button" class="btn wd-btn-normal wd-btn-orange wd-btn-width-middle pull-right" style="background:#ffffff;color:#000000;border:none;height:2.1em;" value="取消" onclick="$(this).closest('[name=div_layui_layer]').hide();return false;" >
            </div>
        </div>
    </div>
    <!-- /page content -->
    <!-- jQuery -->
    <script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- PNotify -->
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <!-- iCheck -->
    <script src="${imgStatic }/vendors/iCheck/icheck.min.js"></script>
    <script src="${imgStatic }/zwy/js/wd-common.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    <script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>
    <script src="${imgStatic }/zwy/js/scoreModule.js"></script>
    <script type="text/javascript">

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        // 写上真是的地址
        var currentPageUrl = {
            saveUrl:" ${ctx}/wd/product/useSmModel"
        }

        // Hi, boy! look at here! this function need you override!
        // 注意！注意！这个方法要你处理的
        // 刷新页面，重新载入数据
        function ReloadData() {
            location.reload();
        }
        
        $(function() {
            //初始化函数放在列表数据渲染完成后
            init_relateScore();
            
            //保存发送AJAX数据按钮
            $(document).on("click", "[name=btn_config_submit]", function() {
                var id = $(this).attr("data-id");
                var $tr = $("#relateScore .x_content table tbody tr[data-id="+id+"]");
                var $layer = $(this).closest("[name=div_layui_layer]");
                var $chks = $layer.find(".icheckbox_flat-blue.checked");
                var json_data = {};
                var flag = "";
                
                json_data.modelKey = id;
                
                var productIdArray = [];
                
                //复选框的选项
                $chks.each(function(index, item) {
                	productIdArray.push($(item).parent().data("arg"));
                });
                json_data.productIds = JSON.stringify(productIdArray);
                
                //ajax
                $.ajax({
                    url: currentPageUrl.saveUrl,
                    type: "post",
                    data: json_data,
                    dataType: "json",
                    cache: false,
                    success: function (result) { 
                        if (result.success) {
                        	ReloadData();
                        }
                    }
                });
                $layer.hide();
            });
        });
    </script>
</body>
</html>