<%@ page contentType="text/html;charset=UTF-8" %>
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
    <!-- PNotify -->
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

    <link href="${imgStatic }/zwy/LBQ/css/popup_style.css" rel="stylesheet">
    
    <!-- Custom Theme Style -->
    <link href="${imgStatic }/build/css/custom.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/css/afterLoanPolicy.css" rel="stylesheet">

    <!-- 重要！样式重写! -->
    <link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/css/scoreModule.css" rel="stylesheet">
    
    <link href="${imgStatic }/zwy/css/house.css" rel="stylesheet" />
</head>
<body>
     <div id="id_scoreModuleList" class="wd-content">
        <div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
            <div class="x_title non_bottom_border">
                <h2>  </h2>
            </div>
                      
            <!--表格标签-->
            <div name="div_headLabel" class="div_headLabel">
            	<div class="wd-piece-title"><h2 style="font-weight: 600;">车商管理</h2></div>
            	
            	
            	
            	<div class="div_line_noMargin"></div>
            </div>
            <!--结束表格标签-->
            
            <div class="wd-content">
    			<div class="left_info">

        			<div class="tab_content">
            			<div class="soft_info">

                			<div class="soft_left">								
								<ul class="si_list">
	                    			<li>
	                    				<label>车商<span>*拖动列表可排序</span></label>		
	                        			<div class="label_content">
	                            			<table class="supplier">
	                                			<thead id="onethead">
	                                				<tr>
	                                    				<th>车商</th>
	                                    				<th class="add"><img src="${imgStatic }/zwy/LBQ/images/plus2.png" alt=""></th>
	                                				</tr>
	                                			</thead>
	                                			<tbody id="onetbody">
	                              
	                                			</tbody>
	                            			</table>
	                        			</div>
	                    			</li>
                				</ul>
							</div>
							
							<div class="soft_moudle">
				
							</div>
			
							<div class="soft_right">
				
							</div>
            			</div>

        			</div>
   				 </div>
			</div>
			<div style="display: none;">
			    <table>
			        <tr id="addTd">
			            <td><input type="text" value="黄新国"></td>
			            <td><button class="color3">删除</button></td>
			        </tr>
			    </table>
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

    <script src="${imgStatic }/zwy/js/wd-common.js"></script>

    <script src="${imgStatic }/vendors/layer/layer.js"></script>
    <script src="${imgStatic }/zwy/js/layer-customer.js"></script>

    <script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>
    <script src="${imgStatic }/zwy/js/scoreModule.js"></script>
    <script src="${imgStatic }/zwy/js/common_bake_jyshen.js"></script>
    
    
    <script src="${imgStatic }/build/js/custom.js"></script>
    <script src="${imgStatic }/zwy/LBQ/js/dealIn.js"></script>
    
    <!-- jquery ui -->
    <script src="${imgStatic }/vendors/jquery-ui-1.12.1/jquery-ui.min.js"></script>

    <script type="text/javascript">
    var currentPageUrl = {
		list : "${ctx}/sys/cardealer/list",
		save : "${ctx}/sys/cardealer/save",
		del : "${ctx}/sys/cardealer/del",
		sort: "${ctx}/sys/cardealer/sort",
		getChild : "${ctx}/sys/cardealer/getChild"
    }
    </script>
    <script src="${imgStatic }/zwy/js/ajax.js"></script>
    <script src="${imgStatic }/zwy/js/car.js"></script>
</body>
</html>