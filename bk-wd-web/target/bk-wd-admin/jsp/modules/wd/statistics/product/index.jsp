<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<head style="background-color: rgb(240,240,240)">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>产品统计</title>
	<!--统一样式，不删-->
	<link href="${ imgStatic }vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ imgStatic }vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="${ imgStatic }build/css/custom.css" rel="stylesheet">    
	<!-- Datatables -->
    <link href="${ imgStatic }vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="${ imgStatic }vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="${ imgStatic }vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="${ imgStatic }vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="${ imgStatic }vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
	
	<!-- 重要！样式重写! -->
	<link href="${ imgStatic }zwy/css/custom-override.css" rel="stylesheet" />
	
	<link href="${ imgStatic }zwy/LBQ/css/statistical.css" rel="stylesheet">
	<style type="text/css">
		div#export_target_table_wrapper div.dt-buttons.btn-group a {
			color: #334421;
		}
	</style>
</head>
<body>
	<div class="wd-content">
		<div class="organization">
			<h2> 产品统计 
				<select id="dateType" class="select_time">
					<option value="1">今天</option>
					<option value="2">近7天</option>
					<option value="3">近6周</option>
					<option value="4">近6个月</option>
					<option value="5">近12个月</option>
				</select>
			</h2>
			<div class="left_wrap">
				<div class="shop_info">
					<div class="tb_wrap" style="margin-left: 0">
						<ul class="table_content">
							<li>
                                <span class="name reduce curr" allproduct><i></i>全部产品 </span>
								<ul class="next_class">
                                    <c:forEach items="${productList }" var="wdProductCategoryMap">
                                        <li>
                                            <span class="name plus" productcategory="${wdProductCategoryMap.category}"><i></i>${wdProductCategoryMap.category}</span>
                                            <ul class="next_class">
                                                <c:forEach items="${wdProductCategoryMap.productList }" var="product">
                                                    <li><span class="name" productid="${ product.id }"><i></i>${ product.name }</span></li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:forEach>
								</ul>
                            </li>
						</ul>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>

			<div class="right_wrap">
			</div>
			<div class="clearfix"></div>
		</div>
	</div>

	<!-- 统一js，不删 -->
	<script src="${ imgStatic }vendors/jquery/dist/jquery.min.js"></script>
	<script src="${ imgStatic }vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="${ imgStatic }vendors/layer/layer.js"></script>
	<script src="${ imgStatic }zwy/js/layer-customer.js"></script>
	<script src="${ imgStatic }build/js/custom.js"></script>
    <!-- Datatables -->
    <script src="${ imgStatic }vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="${ imgStatic }vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="${ imgStatic }vendors/jszip/dist/jszip.min.js"></script>
    <script src="${ imgStatic }vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="${ imgStatic }vendors/pdfmake/build/vfs_fonts.js"></script>

	<script src="${ imgStatic }vendors/echarts-3.5.4/echarts.min.js"></script>

	<script>
		function freshCharts() {
			var _dateType = $("#dateType").val();
			var _data = {
				dateType : _dateType
			}
          	var _selected = $(".table_content .curr");
			if (_selected.attr("productcategory")) {
				_data.productCategory = _selected.attr("productcategory");
			}
			if (_selected.attr("productid")) {
				_data.productId = _selected.attr("productid");
			}
			
			StartLoad();
			$.get("${ctx}/wd/statistics/product/charts", _data, function(data){
				$(".right_wrap").empty().html(data);
				FinishLoad();
			})
		}

		$(function() {
			freshCharts()
			
			$('.option').on('click', function() {
				if ($('.detail_data').is(':hidden')) {
					$('.detail_data').show();
				} else {
					$('.detail_data').hide();
				}
			})

			$('.select_time').change(function() {
				if ($(this).val() == '自定义') {
					alert('调用时间控件')
				}

				freshCharts();
			})

			var Module = {
				init : function() {
					$('.table_content .name').each(function() {
						if ($(this).hasClass('plus')) {
							$(this).siblings('ul').hide();
						}
					})
					this.plus();
					this.reduce();
					this.setBg();
					this.click();
				},
				setBg : function() {
					$('.table_content li:visible').each(
							function() {
								var self = $(this)
								var idx = $('.table_content li:visible').index(
										this) + 1
								if (idx % 2 != 0) {
									self.children('span').addClass('cur')
								} else {
									self.children('span').removeClass('cur')
								}
							})
				},
				plus : function() {
					var self = this
					$('.plus').on('click','i',function(e){
		                e.stopPropagation()
								if ($(this).parent().hasClass('plus')) {
									$(this).parent().siblings('ul').show();
									$(this).parent().removeClass('plus').addClass('reduce');
									self.plus();
									self.reduce();
									self.setBg();
								}
							})
				},
				reduce : function() {
					var self = this
					$('.reduce').on('click','i',function(e){
		                e.stopPropagation()
								if ($(this).parent().hasClass('reduce')) {
									$(this).parent().siblings('ul').hide();
									$(this).parent().removeClass('reduce').addClass('plus');
									self.plus();
									self.reduce();
									self.setBg();
								}
							});
				},
				click : function() {
					$('.table_content').on('click', 'li span', function(){
						$('.table_content li span').removeClass('curr');
						$(this).addClass('curr');

						freshCharts();
					})
				}
			}
			Module.init();
		})
	</script>
</body>
</html>