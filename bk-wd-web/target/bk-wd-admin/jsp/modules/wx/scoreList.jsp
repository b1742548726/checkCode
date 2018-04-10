<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title></title>
<!-- Bootstrap -->
<link href="${imgStatic }/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Font Awesome -->
<link href="${imgStatic }/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />
<!-- iCheck -->
<link href="${imgStatic }/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet" />
<!-- PNotify -->
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.css"
	rel="stylesheet" />
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.buttons.css"
	rel="stylesheet" />
<link href="${imgStatic }/vendors/pnotify/dist/pnotify.nonblock.css"
	rel="stylesheet" />

<!-- Custom Theme Style -->
<link href="${imgStatic }/build/css/custom.css" rel="stylesheet" />

<!-- 重要！样式重写! -->
<link href="${imgStatic }/zwy/css/custom-override.css" rel="stylesheet" />

<style type="text/css">
table#customer-list tbody tr td:nth-child(2) {
	text-align: center;
}

table#customer-list tbody tr td:nth-child(3) {
	text-align: center;
}

table#customer-list tbody tr td:nth-child(4) {
	text-align: center;
}
</style>
</head>

<body>
	<!-- page content -->
	<div class="wd-content">
		<div class="wd-piece-content col-md-12 col-sm-12 col-xs-12">
			<form action="${ctx}/wx/feedback/score/list" id="searchForm"
				method="POST">
				<input id="current" name="current" type="hidden" value="1" />
				<div class="list-page-search-div col-xs-12">
					<!-- 左边搜索条件 -->
					<div class="col-md-10 col-sm-10 col-xs-12">
						<div class="col-xs-4">
							<span class="col-xs-3"> 客户经理 </span>
							<div class="col-xs-9">
								<div class="auto-clear-input">
									<input type="text" class="form-control" name="manager"
										id="manager" value="${ manager }" />
								</div>
							</div>
						</div>
					</div>

					<div class="col-xs-2">
						<button type="button" class="btn wd-btn-normal wd-btn-gray right"
							id="btn-detail" style="margin-right: 0px;">评分统计</button>
					</div>
				</div>
				<div class="x_content">
					<table class="table table-striped table-bordered wd-table"
						id="customer-list">
						<colgroup>
							<col style="width: 88px" />
							<col style="width: 75px" />
							<col style="width: 75px" />
							<col style="width: 75px" />
							<col style="width: 120px" />
							<col style="width: 150px" />
							<col style="width: auto" />
						</colgroup>
						<thead>
							<tr>
								<th>客户经理</th>
								<th>服务评分</th>
								<th>效率评分</th>
								<th>廉洁评分</th>
								<th>评分人</th>
								<th>评价时间</th>
								<th>投诉内容</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ pagination.dataList }" var="data">
								<tr>
									<td>${ data.userName }</td>
									<td>${ data.scoreService }</td>
									<td>${ data.scoreEfficiency }</td>
									<td>${ data.scoreProbity }</td>
									<td>${ data.nickName }</td>
									<td><fmt:formatDate value="${data.createDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td style="white-space: inherit;">${ data.remarks }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="dataTables_wrapper">${pagination}</div>
				</div>
			</form>
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
	<script src="${imgStatic }/zwy/js/wd-common-bind.js"></script>

	<script src="${imgStatic }/vendors/layer/layer.js"></script>
	<script src="${imgStatic }/zwy/js/layer-customer.js"></script>

	<script src="${imgStatic }/zwy/js/pnotify-customer.js"></script>

	<script type="text/javascript">
		function SearchCustomer() {
			$("#searchForm").submit();
		}
		
		$(function() {

			$("div.list-page-search-div").on("change", "input", function() {
				SearchCustomer()
			}).on("change", "select", function() {
				SearchCustomer()
			}).on("click", "table.category-table td", function() {
				SearchCustomer()
			});

			$("#btn-detail").click(function() {
				var current = "${ pagination.current }";
				var manager = $("#manager").val();

				var url = "${ctx}/wx/feedback/score/detail";

	            var parames = new Array();
	            parames.push({ name: "current", value: current});
	            parames.push({ name: "manager", value: manager});

	            Post(url, parames);

	            return false;
			});
		});

		function page(n, s) {
			$("#current").val(n);
			$("#searchForm").submit();
			return false;
		}
		
        function Post(URL, PARAMTERS) {
            //创建form表单
            var temp_form = document.createElement("form");
            temp_form.action = URL;
            //如需打开新窗口，form的target属性要设置为'_blank'
            temp_form.target = "_self";
            temp_form.method = "post";
            temp_form.style.display = "none";
            //添加参数
            for (var item in PARAMTERS) {
                var opt = document.createElement("textarea");
                opt.name = PARAMTERS[item].name;
                opt.value = PARAMTERS[item].value;
                temp_form.appendChild(opt);
            }
            document.body.appendChild(temp_form);
            //提交数据
            temp_form.submit();
        }
	</script>
</body>
</html>