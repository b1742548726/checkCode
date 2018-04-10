<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html lang="en">
<head style="background-color: rgb(240,240,240)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--统一样式，不删-->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
<!-- Switchery -->
<link href="${imgStatic }/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${imgStatic }/vendors/bootstrap-clockpicker/bootstrap-clockpicker.min.css">

<link href="${imgStatic }/zwy/LBQ/css/investigation.css" rel="stylesheet">
<style type="text/css">
.wa-se-st-single-video-zhanzhang-play {
    position: absolute;
    height: 40px;
    width: 40px;
    top: 77px;
    left: 100px;
    margin: -20px 0 0 -20px;
    background: url(${imgStatic }/zwy/img/play.png) no-repeat;
    background-size: 40px 40px;
}
li {
    position: relative;
}
</style>
</head>

<body>
    <div class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
                <h2> 实时定位设置 </h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li>
                        <button type="button" class="btn wd-btn-normal wd-btn-gray wd-btn-width-middle" id="btn-add-element">保存</button>
                    </li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content" style="margin-bottom: 2em;">
                <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left" method="post" action="${ctx }/oa/location/config/save">
                    <input type="hidden" name="id" value="${oaLocationConfig.id }">
                    <input type="hidden" name="timeQuantums" id="timeQuantums">
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                                            是否启用定位
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="checkbox" ${oaLocationConfig.enable ? 'checked': ''} name="enable" value="1" class="js-switch" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-6" for="placeholder">
                                            定位时间间隔（秒） <span class="required"></span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-3">
                            <input type="text"  name="interval" value="${oaLocationConfig.interval }" class="form-control">
                        </div>
                    </div>
                    <div class="label_content">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="placeholder">
                                            定位时断 <span class="required"></span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <table class="table table-striped table-bordered wd-table" id="configTimeQuantumTable">
                                <thead>
                                    <tr>
                                        <th>开始时间</th>
                                        <th>结束时间</th>
                                        <th class="add"><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt="" style="cursor:pointer;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${oaLocationConfig.configTimeQuantumList }" var="timeQuantum">
                                        <tr>
                                            <td>
                                                <div class="input-group clockpicker pull-center" style="padding-top: .5em;" data-placement="bottom" data-align="top" data-autoclose="true">
                                                    <input type="text" class="form-control" name="startTimeInput" placeholder="开始时间" value="${timeQuantum.startTime }"/>
                                                     <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-time"></span>
                                                    </span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="input-group clockpicker pull-center" style="padding-top: .5em;" data-placement="bottom" data-align="top" data-autoclose="true">
                                                    <input type="text" class="form-control" name="endTimeInput" placeholder="结束时间" value="${timeQuantum.endTime }"/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-time"></span>
                                                    </span>
                                                </div>
                                            </td>
                                            <td><button class="btn wd-btn-small wd-btn-orange">删除</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div style="display: none;">
        <table>
            <tr id="addTd">
                <td>
                    <div class="input-group clockpicker pull-center" style="padding-top: .5em;" data-placement="bottom" data-align="top" data-autoclose="true">
                        <input type="text" class="form-control" name="startTimeInput" placeholder="开始时间"/>
                         <span class="input-group-addon">
                            <span class="glyphicon glyphicon-time"></span>
                        </span>
                    </div>
                </td>
                <td>
                    <div class="input-group clockpicker pull-center" style="padding-top: .5em;" data-placement="bottom" data-align="top" data-autoclose="true">
                        <input type="text" class="form-control" name="endTimeInput" placeholder="结束时间"/>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-time"></span>
                        </span>
                    </div>
                </td>
                <td><button class="btn wd-btn-small wd-btn-orange">删除</button></td>
            </tr>
        </table>
    </div>
<!-- 统一js，不删 -->
<script src="${imgStatic }/vendors/jquery/dist/jquery.min.js"></script>
<script src="${imgStatic }/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${imgStatic }/build/js/custom.js"></script>
<script src="${imgStatic }/zwy/LBQ/js/iframeFix.js"></script>

<script type="text/javascript" src="${imgStatic }/vendors/bootstrap-clockpicker/bootstrap-clockpicker.min.js"></script>
<!-- Switchery -->
<script src="${imgStatic }/vendors/switchery/dist/switchery.min.js"></script>
 <!-- Layer -->
<script src="${imgStatic }/vendors/layer/layer.js"></script>
<script src="${imgStatic }/zwy/js/layer-customer.js"></script>
<script>
$(function(){
    $('.wd-btn-orange').on('click',function(){
        $(this).closest('tr').remove()
    });
    
    $("#configTimeQuantumTable tbody").find(".clockpicker").clockpicker();
    
    $('.add').on('click',function(){
        var _html = "<tr>" + $("#addTd").html() + "</tr>";
        $("#configTimeQuantumTable tbody").append(_html);
        $("#configTimeQuantumTable tbody").find(".clockpicker").clockpicker();
    })
    
    $("#btn-add-element").on("click", function(){
    	var _timeQuantumArray = [];
    	$("#configTimeQuantumTable tbody tr").each(function(index, dom){
    		console.log(index)
    		var _timeQuantum = {
				startTime: $(this).find(":input[name=startTimeInput]").val(),
				endTime: $(this).find(":input[name=endTimeInput]").val()
    		}
    		_timeQuantumArray.push(_timeQuantum);
    	});
    	$("#timeQuantums").val(JSON.stringify(_timeQuantumArray));
    	$("#form-add-module").submit();
    });
})
</script>
</body>
</html>