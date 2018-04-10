function InitModuleSettingPage(moduleName, moduleCode) {
    var tabHtml = "<li><a href='#" + moduleCode + "-r' data-toggle='tab'>" + moduleName + "</a></li>";
    $("div.x_content ul.nav-tabs").append(tabHtml);
}

$(document).ready(function () {
    //新增模块
    $(document).on("click", "#btn-add-module", function () {
        OpenBigIFrame("新增模块", $(this).data("url"), function () {
            var addmodule = GetLayerData("AddOneModule");
            if (addmodule) {
                location.reload();
            }
        });
    });

    // 子项必选
    $(document).on("click", ".switchery", function () {
        var currentTr = $(this).parents("tr");
        var currentSwitch = $(this).prev(".js-switch");
        if (currentTr.length == 1 && currentSwitch.length == 1) {
            var itemId = currentTr.attr("itemid"); //wd_default_simple_module_setting表的id
            var isRequest = currentSwitch.is(':checked') ? "1" : "0" ; //是否必选，True Or False
            //ajax请求设置对应的item是否是必选
            $.ajax({
                url : ctx + "/wd/simlpeModule/setItemRequired",
                data : {"id" : itemId, "required" : isRequest},
                type: "post",
                success : function (data) {
                }
        	});
        }
    });

    // 编辑子项
   /* $(document).on("click", ".wd-module-select-element", function () {
        var moduleCode = $(this).attr("modulecode");

        OpenBigIFrame("选择业务元件", ctx + "/wd/simlpeModule/itemForm?defaultSimpleModuleCode=" + moduleCode, function () {
            $("div#" + moduleCode + "-r").load( ctx +"/wd/simlpeModule/itemList?defaultSimpleModuleCode=" + moduleCode, null, function () {
                if ($(".js-switch")[0]) {
                    var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not([data-switchery])'));

                    elems.forEach(function (html) {
                        var switchery = new Switchery(html, {
                            color: 'rgb(93, 102, 125)'
                        });
                    });
                }
            });
        });
    });*/

});