<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>
<div class="x_panel">
    <!--<div class="x_title">
        <h2> 新增模块 </h2>
        <div class="clearfix"></div>
    </div>-->
    <div class="x_content">
        <form id="form-add-module" data-parsley-validate class="form-horizontal form-label-left">
            <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="product_category">
                    产品大类 <span class="required">*</span>
                </label>
                <div class="col-md-6 col-sm-7 col-xs-12">
                    <select id="product_category" name="product_category" class="form-control col-md-8 col-xs-12">
                        <option value="">请选择产品大类</option>
                        <option value="车贷" ${'车贷' eq wdProduct.category ? 'selected' : ''}>车贷</option>
                        <option value="房贷" ${'房贷' eq wdProduct.category ? 'selected' : ''}>房贷</option>
                        <option value="消费贷" ${'消费贷' eq wdProduct.category ? 'selected' : ''}>消费贷</option>
                        <option value="经营贷" ${'经营贷' eq wdProduct.category ? 'selected' : ''}>经营贷</option>
                        <option value="信用卡" ${'信用卡' eq wdProduct.category ? 'selected' : ''}>信用卡</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="product_name">
                    产品名称 <span class="required">*</span>
                </label>
                <div class="col-md-6 col-sm-7 col-xs-12">
                    <input type="text" id="product_name" name="product_name" value="${wdProduct.name }" required="required" class="form-control col-md-8 col-xs-12">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="product_name_en">
                    产品英文名称 <span class="required">*</span>
                </label>
                <div class="col-md-6 col-sm-7 col-xs-12">
                    <input type="text" id="product_name_en" name="product_name_en" value="${wdProduct.nameEn }" required="required" class="form-control col-md-8 col-xs-12">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="product_code">
                    产品代码 <span class="required">*</span>
                </label>
                <div class="col-md-6 col-sm-7 col-xs-12">
                    <input type="text" id="product_code" name="product_code" value="${wdProduct.code }" required="required" class="form-control col-md-8col-xs-12">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="product_remarks">
                    产品描述 <span class="required">&nbsp;</span>
                </label>
                <div class="col-md-6 col-sm-7 col-xs-12">
                    <textarea id="product_remarks" name="product_remarks" class="form-control col-md-8 col-xs-12" rows="10">${wdProduct.remarks }</textarea>
                </div>
            </div>
            <c:if test="${empty wdProduct.id}">
                <hr style="border: 1px solid #cccccc;" />
                <div class="form-group">
                    <div class="col-md-6 col-sm-7 col-xs-12 col-md-offset-3 col-sm-offset-3">
                        <small> *您可以从下列产品中选择直接拷贝配置 </small>
                    </div>
                    <div class="col-md-6 col-sm-7 col-xs-12 col-md-offset-3 col-sm-offset-3">
                        <select id="copy_product_id" name="copyProductId" class="form-control col-md-8 col-xs-12">
                            <option value=""> -- 请选择 -- </option>
                            <spring:eval expression="@wdProductService.selectByRegion(currentUser.companyId)" var="productList"/>
                            <c:if test="${not empty productList}">
                                <c:forEach items="${productList}" var="product">
                                    <option value="${product.id }" ${product.id eq params.productId ? 'selected' : '' }>${product.category } - ${product.name }</option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </div>
                </div>
            </c:if>
        </form>
    </div>
</div>

<script type="text/javascript">
    function GetProductInfo() {
        var info = {
            "category": $("#product_category").val(),
            "name": $("#product_name").val(),
            "nameEn": $("#product_name_en").val(),
            "code": $("#product_code").val(),
            "remarks": $("#product_remarks").val(),
            "productId": $("#product-id").val(),
            "newVersion": $("#product-version").val()
        };
        return info;
    }
</script>