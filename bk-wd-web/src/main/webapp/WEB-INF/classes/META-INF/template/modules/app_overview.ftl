<html lang="en">
<head style="background-color: rgb(240,240,240)">
<title>总览</title>
<style type="text/css">
html body {
	width:100%;	
	font-size:12px;
	box-sizing:content-box;
	overflow-x:hidden;
    font-family:SimHei !important;
}
.table_center td {
	text-align:center;	
}
table {
	border-collapse:collapse;
	width:100%;
    font-size: 12px;
	margin:0 auto;
	left:0;
	right:0;
}
table td, table th {
	border:1px solid #ddd;	
	padding:10px;
}
.td_padding {
	border:2px solid #103050;
}
table td {
	color : #103050;
}
table.soft_info_table td {
	color : #708090;
}

table th {
	font-weight : 100;
	color : #000000;
}

.width48p {
	width: 48%;
	float: left;
}
.clear_both {
	clear: both;
}
</style>
</head>
<body>
    <h3>个人信息</h3>
    <#if customerTypeConfigList?? && customerTypeConfigList?size gt 0 > 
	    <table cellspacing="0">
	        <tbody>
	        	<#assign photo_settring_count = 0>
	            <#list customerTypeConfigList as customerTypeConfig>
	            	<#assign wdBusinessElement = wdBusinessElementConfig[customerTypeConfig.businessElementId] >
	    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
						<#if (customerTypeConfig_index - photo_settring_count) % 2 == 0>
	    					<tr>
	    				</#if>
		    				<th>${customerTypeConfig.elementName }</th>
		             		<td>${(wdPerson.getJsonData()[wdBusinessElement.key])?if_exists }</td>
	             		<#if (customerTypeConfig_index - photo_settring_count) % 2 == 1>
	    					</tr>
	    				</#if>
	    			<#else>
	    				<#assign photo_settring_count = photo_settring_count + 1>
	    			</#if>
	            </#list>
	            <#if (customerTypeConfigList?size - photo_settring_count) % 2 == 1>
					</tr>
				</#if>
	        </tbody>
	    </table>
    </#if>
    
    <h3>申请信息</h3>
    <table cellspacing="0">
        <tbody>
        	<tr>
                <th>合同编号</th>
                <td>${(wdApplication.contractCode)?if_exists }</td>
                <th>申请编号</th>
                <td>${(wdApplication.code)?if_exists }</td>
            </tr>
            <tr>
                <th>产品名称</th>
                <td>${(wdApplication.productName)?if_exists }</td>
                <th>申请时间</th>
                <td>${(wdApplication.createDate)?string('yyyy-MM-dd HH:mm:ss') }</td>
            </tr>
            <#list applyAuditInfoConfig as applyConfig>
            	<#assign wdBusinessElement = wdBusinessElementConfig[applyConfig.businessElementId] >
            	<#if applyConfig_index % 2 == 0>
					<tr>
				</#if>
	            	<th>${wdBusinessElement.name }</th>
	         		<td>${(wdApplication.getApplyInfoJson()[wdBusinessElement.key])?if_exists }</td>
         		<#if applyConfig_index % 2 == 1>
					</tr>
				</#if>
            </#list>
            <#list productConfig['AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA'] as applictionInfoConfig>
            	<#assign wdBusinessElement = wdBusinessElementConfig[applictionInfoConfig.businessElementId] >
            	<#if (applyAuditInfoConfig?size + applictionInfoConfig_index) % 2 == 0>
					<tr>
				</#if>
	            	<th>${applictionInfoConfig.elementName }</th>
	         		<td>${(wdApplication.getApplyInfoJson()[wdBusinessElement.key])?if_exists }</td>
         		<#if (applyAuditInfoConfig?size + applictionInfoConfig_index) % 2 == 1>
					</tr>
				</#if>
            </#list>
            <#if (applyAuditInfoConfig?size + productConfig['AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA']?size) % 2 == 1>
            	</tr>
            </#if>
        </tbody>
    </table>
    <h3>调查结论</h3>
    <table cellspacing="0">
        <tbody>
            <#list applyAuditInfoConfig as auditInfoConfig>
            	<#assign wdBusinessElement = wdBusinessElementConfig[auditInfoConfig.businessElementId] >
            	<#if auditInfoConfig_index % 2 == 0>
					<tr>
				</#if>
	            	<th>${wdBusinessElement.name }</th>
	         		<td>${(wdApplication.getAuditConclusionJson()[wdBusinessElement.key])?if_exists }</td>
         		<#if auditInfoConfig_index % 2 == 1>
					</tr>
				</#if>
            </#list>
            <#list productConfig['BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB'] as auditConclusionConfig>
            	<#assign wdBusinessElement = wdBusinessElementConfig[auditConclusionConfig.businessElementId] >
            	<#if (applyAuditInfoConfig?size + auditConclusionConfig_index) % 2 == 0>
					<tr>
				</#if>
	            	<th>${auditConclusionConfig.elementName }</th>
	         		<td>${(wdApplication.getAuditConclusionJson()[wdBusinessElement.key])?if_exists }</td>
         		<#if (applyAuditInfoConfig?size + auditConclusionConfig_index) % 2 == 1 || (auditConclusionConfig_index) + 1 == productConfig['BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB']?size>
					</tr>
				</#if>
            </#list>
        </tbody>
    </table>
    
    <h3>客户关系人（${personRelationList?size}条）</h3>
    <table cellspacing="0">
        <tbody>
        	<#if productConfig['00000000-0000-0000-0000-222222222222']??>
        		<#if wdApplicationCoborrowerList?? && wdApplicationCoborrowerList?size gt 0>
        			<tr>
		                <th colspan="4" style="text-align:center;font-weight:900;">
		                            共同借款人
		                </th>
		            </tr>
		            <#assign _un__top_one = false>
        			<#list personRelationList as data>
    					<#if data.isCoborrower>
    						<#if _un__top_one>
	        					<tr>
					                <td colspan="4" class="td_padding">
					                </td>
					            </tr>
	        				</#if>
	        				<#assign _un__top_one = true>
	        				<tr>
				                <th>与申请人关系：</th>
				                <td>${data.relationType}</td>
			                <#assign photo_settring_count = 1>
			                <#list customerRelationConfigList as customerRelationConfig>
			                	<#assign wdBusinessElement = wdBusinessElementConfig[customerRelationConfig.businessElementId] >
				    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
			    					<#assign _config_index = customerRelationConfig_index - photo_settring_count>
				    				<#if _config_index % 2 == 0>
										<tr>
									</#if>
					    				<th>${customerRelationConfig.elementName }</th>
					             		<td>${(data.wdPerson.getJsonData()[wdBusinessElement.key])?if_exists }</td>
				             		<#if _config_index % 2 == 1 || _config_index % 2 == -1>
										</tr>
									</#if>
								<#else>
    								<#assign photo_settring_count = photo_settring_count + 1>
				    			</#if>
			                </#list>
			                
			                <#assign wdApplicationCoborrower = wdApplicationCoborrowerService.selectByApplicationIdAndOriginalId(wdApplication.id, data.wdPerson.id)>
			                <#list productConfig['00000000-0000-0000-0000-222222222222'] as config>
			                	<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
				    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
				    				<#assign _config_index = customerRelationConfigList?size - photo_settring_count + config_index>
				    				<#if _config_index % 2 == 0>
										<tr>
									</#if>
					    				<th>${config.elementName }</th>
					             		<td>${(wdApplicationCoborrower.getJsonData()[wdBusinessElement.key])?if_exists }</td>
				             		<#if _config_index % 2 == 1>
										</tr>
									</#if>
								<#else>
    								<#assign photo_settring_count = photo_settring_count + 1>
				    			</#if>
			                </#list>
			                <#if (customerRelationConfigList?size + productConfig['00000000-0000-0000-0000-222222222222']?size - photo_settring_count) % 2 == 1>
								</tr>
							</#if>
		                </#if>
        			</#list>
               	</#if> 
        	</#if>
        	
        	<#if productConfig['99999999-9999-9999-9999-999999999999']??>
        		<#if wdApplicationRecognizorList?? && wdApplicationRecognizorList?size gt 0>
        			<tr>
		                <th colspan="4" style="text-align:center;font-weight:900;">
		                            担保人
		                </th>
		            </tr>
    				<#assign _un__top_one = false>
        			<#list personRelationList as data>
        				<#if data.isRecognizor>
        					<#if _un__top_one>
	        					<tr>
					                <td colspan="4" class="td_padding">
					                </td>
					            </tr>
	        				</#if>
	        				<#assign _un__top_one = true>
	        				<tr>
				                <th>与申请人关系：</th>
				                <td>${data.relationType}</td>
			                <#assign photo_settring_count = 1>
			                <#list customerRelationConfigList as customerRelationConfig>
			                	<#assign wdBusinessElement = wdBusinessElementConfig[customerRelationConfig.businessElementId] >
				    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
				    				<#assign _config_index = customerRelationConfig_index - photo_settring_count>
				    				<#if _config_index % 2 == 0>
										<tr>
									</#if>
					    				<th>${customerRelationConfig.elementName }</th>
					             		<td>${(data.wdPerson.getJsonData()[wdBusinessElement.key])?if_exists }</td>
				             		<#if _config_index % 2 == 1 || _config_index % 2 == -1>
										</tr>
									</#if>
								<#else>
    								<#assign photo_settring_count = photo_settring_count + 1>
				    			</#if>
			                </#list>
			                
			                <#assign wdApplicationRecognizor = wdApplicationRecognizorService.selectByApplicationIdAndOriginalId(wdApplication.id, data.wdPerson.id)>
			                <#list productConfig['99999999-9999-9999-9999-999999999999'] as config>
			                	<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
				    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
				    				<#assign _config_index = customerRelationConfigList?size - photo_settring_count + config_index>
				    				<#if _config_index % 2 == 0>
										<tr>
									</#if>
					    				<th>${config.elementName }</th>
					             		<td>${(wdApplicationRecognizor.getJsonData()[wdBusinessElement.key])?if_exists }</td>
				             		<#if _config_index % 2 == 1>
										</tr>
									</#if>
								<#else>
    								<#assign photo_settring_count = photo_settring_count + 1>
				    			</#if>
			                </#list>
			                <#if (customerRelationConfigList?size + productConfig['99999999-9999-9999-9999-999999999999']?size - photo_settring_count) % 2 == 1>
								</tr>
							</#if>
		                 </#if>
        			</#list>
               	</#if> 
        	</#if>
        	
        	<tr>
                <th colspan="4" style="text-align:center;font-weight:900;">
                             普通关系人
                </th>
            </tr>
    		<#assign _un_top_one = false>
        	<#list personRelationList as personRelation>
	        	<#if personRelation.isCoborrower == false && personRelation.isRecognizor == false>
	        		<#if _un_top_one>
    					<tr>
			                <td colspan="4" class="td_padding">
			                </td>
			            </tr>
    				</#if>
    				<#assign _un_top_one = true>
					<tr>
		                <th>与申请人关系：</th>
		                <td>${personRelation.relationType}</td>
	                <#assign photo_settring_count = 1>
	                <#list customerRelationConfigList as customerRelationConfig>
	                	<#assign wdBusinessElement = wdBusinessElementConfig[customerRelationConfig.businessElementId] >
		    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
		    				<#assign _config_index = customerRelationConfig_index - photo_settring_count>
		    				<#if _config_index % 2 == 0>
		    					<tr>
		    				</#if>
			    				<th>${wdBusinessElement.name }</th>
			             		<td>${(personRelation.wdPerson.getJsonData()[wdBusinessElement.key])?if_exists }</td>
		             		<#if _config_index % 2 == 1 || _config_index % 2 == -1>
		    					</tr>
		    				</#if>
	    				<#else>
	    					<#assign photo_settring_count = photo_settring_count + 1>
		    			</#if>
	                </#list>
	                <#if (customerRelationConfigList?size - photo_settring_count) % 2 == 1>
						</tr>
					</#if>
				</#if>
        	</#list>
        </tbody>
    </table>
   
    <#if productConfig['00000000-0000-0000-0000-111111111111']??>
     	<h3>房产抵押（${applicationBuildingMortgageList?size }条）</h3>
     	<#if applicationBuildingMortgageList?size gt 0>
     		<table cellspacing="0">
		        <tbody>
		        <#assign _un__top_one = false>
		    	<#list applicationBuildingMortgageList as data>
		    		<#if _un__top_one>
    					<tr>
			                <td colspan="4" class="td_padding">
			                </td>
			            </tr>
    				</#if>
    				<#assign _un__top_one = true>
		    		<#assign photo_settring_count = 0>
		    		<#list customerBuildingConfigList as customerBuildingConfig>
		    			<#assign wdBusinessElement = wdBusinessElementConfig[customerBuildingConfig.businessElementId] >
		    			<#assign buildingData = wdApplicationAssetsBuildingService.selectByApplicationIdAndOriginalId(data.applicationId, data.originalId) >
		    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
		    				<#assign _config_index = customerBuildingConfig_index - photo_settring_count>
		    				<#if _config_index % 2 == 0>
		    					<tr>
		    				</#if>
			    				<th>${wdBusinessElement.name }</th>
			             		<td>${(buildingData.getJsonData()[wdBusinessElement.key])?if_exists }</td>
		             		<#if _config_index % 2 == 1 || _config_index % 2 == -1>
		    					</tr>
		    				</#if>
	    				<#else>
							<#assign photo_settring_count = photo_settring_count + 1>
		    			</#if>
		    		</#list>
		    		<#list productConfig['00000000-0000-0000-0000-111111111111'] as config>
		    			<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
		    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
		    				<#assign _config_index = customerBuildingConfigList?size - photo_settring_count + config_index>
		    				<#if _config_index % 2 == 0>
		    					<tr>
		    				</#if>
			    				<th>${wdBusinessElement.name }</th>
			             		<td>${(data.getJsonData()[wdBusinessElement.key])?if_exists }</td>
		             		<#if _config_index % 2 == 1>
		    					</tr>
		    				</#if>
	             		<#else>
							<#assign photo_settring_count = photo_settring_count + 1>
		    			</#if>
		    		</#list>
		    		<#if (customerBuildingConfigList?size + productConfig['00000000-0000-0000-0000-111111111111']?size - photo_settring_count) % 2 == 1>
						</tr>
					</#if>
		    	</#list>
		    	</tbody>
		    </table>
     	</#if>
    </#if>
    
    <#if productConfig['EEEEEEEE-EEEE-EEEE-EEEE-FFFFFFFFFFFF']??>
     	<h3>车辆抵押（${applicationCarLoanMortgageList?size }条）</h3>
     	<#if applicationCarLoanMortgageList?size gt 0>
     		<table cellspacing="0">
		        <tbody>
		        <#assign _un__top_one = false>
		    	<#list applicationCarLoanMortgageList as data>
		    		<#if _un__top_one>
    					<tr>
			                <td colspan="4" class="td_padding">
			                </td>
			            </tr>
    				</#if>
    				<tr>
		                <th>抵押人：</th>
		                <td>${(data.personName)?if_exists}【${(data.relationType)?if_exists}】</td>
    				<#assign _un__top_one = true>
		    		<#assign photo_settring_count = 1>
		    		<#list productConfig['EEEEEEEE-EEEE-EEEE-EEEE-FFFFFFFFFFFF'] as config>
		    			<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
		    			<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
		    				<#assign _config_index = photo_settring_count + config_index>
		    				<#if _config_index % 2 == 0>
		    					<tr>
		    				</#if>
			    				<th>${wdBusinessElement.name }</th>
			             		<td>${(data.getJsonData()[wdBusinessElement.key])?if_exists }</td>
		             		<#if _config_index % 2 == 1>
		    					</tr>
		    				</#if>
	             		<#else>
							<#assign photo_settring_count = photo_settring_count + 1>
		    			</#if>
		    		</#list>
		    		<#if (productConfig['EEEEEEEE-EEEE-EEEE-EEEE-FFFFFFFFFFFF']?size - photo_settring_count) % 2 == 1>
						</tr>
					</#if>
		    	</#list>
		    	</tbody>
		    </table>
     	</#if>
    </#if>
     
    <#if productConfig['44444444-4444-4444-4444-444444444444']??>
    	<h3>辅助信息</h3>
	    <table cellspacing="0">
	        <tbody>
	        	<#list productConfig['44444444-4444-4444-4444-444444444444'] as config>
	        		<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
    				<#if config_index % 2 == 0>
    					<tr>
    				</#if>
	    				<th>${wdBusinessElement.name }</th>
	             		<td>${(wdApplicationExtendInfo.getJsonData()[wdBusinessElement.key])?if_exists }</td>
             		<#if config_index % 2 ==1>
    					</tr>
    				</#if>
	    		</#list>
	    		<#if (productConfig['44444444-4444-4444-4444-444444444444']?size) % 2 == 1>
					</tr>
				</#if>
        	</tbody>
 	 	</table>
 	</#if>
 	
 	<#if productConfig['66666666-6666-6666-6666-666666666666']??>
 		<h3>收入损益表(月)</h3>
	    <table cellspacing="0">
	        <tbody>
	        	<#list productConfig['66666666-6666-6666-6666-666666666666'] as config>
	        		<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
    				<#if config_index % 2 == 0>
    					<tr>
    				</#if>
	    				<th>${wdBusinessElement.name }</th>
	             		<td>${(applicationMonthlyIncomeStatement.getJsonData()[wdBusinessElement.key])?if_exists }</td>
             		<#if config_index % 2 ==1>
    					</tr>
    				</#if>
	    		</#list>
	    		<#if (productConfig['66666666-6666-6666-6666-666666666666']?size) % 2 == 1>
					</tr>
				</#if>
        	</tbody>
 	 	</table>
    </#if>
    
    <#if productConfig['55555555-5555-5555-5555-555555555555']??>
 		<h3>收入损益表(年)</h3>
	    <table cellspacing="0">
	        <tbody>
	        	<#list productConfig['55555555-5555-5555-5555-555555555555'] as config>
	        		<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
    				<#if config_index % 2 == 0>
    					<tr>
    				</#if>
	    				<th>${wdBusinessElement.name }</th>
	             		<td>${(applicationYearlyIncomeStatement.getJsonData()[wdBusinessElement.key])?if_exists }</td>
             		<#if config_index % 2 ==1>
    					</tr>
    				</#if>
	    		</#list>
	    		<#if (productConfig['55555555-5555-5555-5555-555555555555']?size) % 2 == 1>
					</tr>
				</#if>
        	</tbody>
 	 	</table>
    </#if>
    
    <#if productConfig['77777777-7777-7777-7777-777777777777']??>
 		<h3>家庭资产负债表</h3>
	    <table cellspacing="0">
	        <tbody>
	        	<#list productConfig['77777777-7777-7777-7777-777777777777'] as config>
	        		<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
    				<#if config_index % 2 == 0>
    					<tr>
    				</#if>
	    				<th>${wdBusinessElement.name }</th>
	             		<td>${(applicationBalanceSheet.getJsonData()[wdBusinessElement.key])?if_exists }</td>
             		<#if config_index % 2 ==1>
    					</tr>
    				</#if>
	    		</#list>
	    		<#if (productConfig['77777777-7777-7777-7777-777777777777']?size) % 2 == 1>
					</tr>
				</#if>
        	</tbody>
 	 	</table>
    </#if>
    
    <h3>家庭主要资产（房产）（${customerBuildingList?size }条）</h3>
    <table cellspacing="0">
        <thead>
            <tr>
            	<#list customerBuildingConfigList as config>
	        		<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
	        		<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
		        		<th>${config.elementName }</th>
	        		</#if>
        		</#list>
            </tr>
        </thead>
        <tbody>
        	<#list customerBuildingList as customerBuilding>
        		<tr>
		            <#list customerBuildingConfigList as config>
		        		<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
		        		<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
		        			<td>${customerBuilding.getJsonData()[wdBusinessElement.key] }</td>
		        		</#if>
		    		</#list>
	    		</tr>
    		</#list>
        </tbody>
    </table>
    
    <h3>家庭主要资产（车辆）（${customerCarList?size }条）</h3>
    <table cellspacing="0">
        <thead>
            <tr>
            	<#list customerCarConfigList as config>
	        		<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
	        		<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
		        		<th>${config.elementName }</th>
	        		</#if>
        		</#list>
            </tr>
        </thead>
        <tbody>
        	<#list customerCarList as customerCar>
        		<tr>
		            <#list customerCarConfigList as config>
		        		<#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
		        		<#if wdBusinessElement.baseElementId != 'idcard_photo' && wdBusinessElement.baseElementId != 'single_photo' && wdBusinessElement.baseElementId != 'multiple_photo' && wdBusinessElement.baseElementId != 'shop_photo'>
		        			<td>${(customerCar.getJsonData()[wdBusinessElement.key])?if_exists }</td>
		        		</#if>
		    		</#list>
	    		</tr>
    		</#list>
        </tbody>
    </table>
    
    <#if complexProductConfig['11111111-1111-1111-1111-111111111111']??>
		 <h3>经营信息（${wdApplicationBusinesList?size }条）</h3>
		 <#if wdApplicationBusinesList?size gt 0>
		 	<table>
		 		<#assign _un__top_one = false>
				<#list wdApplicationBusinesList as wdApplicationBusines>
					<#if _un__top_one>
    					<tr>
			                <td colspan="4" class="td_padding">
			                </td>
			            </tr>
    				</#if>
    				<#assign _un__top_one = true>
		            <#list productConfig['11111111-1111-1111-1111-111111111111'] as config>
	        			<#if config_index % 2 == 0>
	    					<tr>
	    				</#if>
	        				<th>${config.name }</th>
	        				<td>${wdApplicationBusines.getJsonData()[config.key] }</td>
	        			<#if config_index % 2 ==1>
	    					</tr>
	    				</#if>
		    		</#list>
		    		<#if (productConfig['11111111-1111-1111-1111-111111111111']?size) % 2 == 1>
						</tr>
					</#if>
	    		</#list>
			</table>
		 </#if>
		
		<h3>软件信息不对称偏差分析</h3>
	    <table cellspacing="0" class="table_center soft_info_table">
	    	<thead>
	    		<tr>
	                <th>婚姻情况</th>
	                <th>年龄</th>
	                <th>经营年限</th>
	                <th>居住年限</th>
	                <th>财产状况</th>
	                <th>信用记录</th>
	                <th>子女</th>
	                <th>配偶</th>
                </tr>
            </thead>
	        <tbody>
	            <tr>
	                <td style='${((softInfoSheet.marriage)?if_exists == "离婚")?string("color : #000000;border:4px solid #103050;", "")}'>离婚</td>
	                <td style='${((softInfoSheet.age)?if_exists == "45岁-55(60)岁")?string("color : #000000;border:4px solid #103050;", "")}'>45岁-55(60)岁</td>
	                <td style='${((softInfoSheet.businessYears)?if_exists == "1年以下")?string("color : #000000;border:4px solid #103050;", "")}'>1年以下</td>
	                <td style='${((softInfoSheet.localLimit)?if_exists == "3年以下")?string("color : #000000;border:4px solid #103050;", "")}'>3年以下</td>
	                <td style='${((softInfoSheet.assetStatus)?if_exists == "少量私有财产")?string("color : #000000;border:4px solid #103050;", "")}'>少量私有财产</td>
	                <td style='${((softInfoSheet.loanRecord)?if_exists == "非主观不良信用记录")?string("color : #000000;border:4px solid #103050;", "")}'>非主观不良信用记录</td>
	                <td style='${((softInfoSheet.childrenStatus)?if_exists == "无事")?string("color : #000000;border:4px solid #103050;", "")}'>无事</td>
	                <td style='${((softInfoSheet.spouseWork)?if_exists == "无单位")?string("color : #000000;border:4px solid #103050;", "")}'>无单位</td>
	            </tr>
	            <tr>
	                <td style='${((softInfoSheet.marriage)?if_exists == "再婚")?string("color : #000000;border:4px solid #103050;", "")}'>再婚</td>
	                <td style='${((softInfoSheet.age)?if_exists == "30岁-45岁")?string("color : #000000;border:4px solid #103050;", "")}' rowspan='2'>30岁-45岁</td>
	                <td style='${((softInfoSheet.businessYears)?if_exists == "3-5年")?string("color : #000000;border:4px solid #103050;", "")}'>3-5年</td>
	                <td style='${((softInfoSheet.localLimit)?if_exists == "本地人或居住10年以上")?string("color : #000000;border:4px solid #103050;", "")}' rowspan='2'>本地人或居住10年以上</td>
	                <td style='${((softInfoSheet.assetStatus)?if_exists == "有部分私人财产")?string("color : #000000;border:4px solid #103050;", "")}'>有部分私人财产</td>
	                <td style='${((softInfoSheet.loanRecord)?if_exists == "良好信用记录或无信用记录")?string("color : #000000;border:4px solid #103050;", "")}' rowspan='2'>良好信用记录或无信用记录</td>
	                <td style='${((softInfoSheet.childrenStatus)?if_exists == "工作")?string("color : #000000;border:4px solid #103050;", "")}'>工作</td>
	                <td style='${((softInfoSheet.spouseWork)?if_exists == "当地单位稳定")?string("color : #000000;border:4px solid #103050;", "")}'>当地单位稳定</td>
	            </tr>
	            <tr>
	                <td style='${((softInfoSheet.marriage)?if_exists == "已婚")?string("color : #000000;border:4px solid #103050;", "")}'>已婚</td>
	                <td style='${((softInfoSheet.businessYears)?if_exists == "5年以上")?string("color : #000000;border:4px solid #103050;", "")}'>5年以上</td>
	                <td style='${((softInfoSheet.assetStatus)?if_exists == "良好私人财产状况")?string("color : #000000;border:4px solid #103050;", "")}'>良好私人财产状况</td>
	                <td style='${((softInfoSheet.childrenStatus)?if_exists == "年幼或上学")?string("color : #000000;border:4px solid #103050;", "")}'>年幼或上学</td>
	                <td style='${((softInfoSheet.spouseWork)?if_exists == "参与生意")?string("color : #000000;border:4px solid #103050;", "")}'>参与生意</td>
	            </tr>
	            <tr>
	                <td style='${((softInfoSheet.marriage)?if_exists == "未婚")?string("color : #000000;border:4px solid #103050;", "")}'>未婚</td>
	                <td style='${((softInfoSheet.age)?if_exists == "30岁以下")?string("color : #000000;border:4px solid #103050;", "")}'>30岁以下</td>
	                <td style='${((softInfoSheet.businessYears)?if_exists == "1-3年")?string("color : #000000;border:4px solid #103050;", "")}'>1-3年</td>
	                <td style='${((softInfoSheet.localLimit)?if_exists == "3-10年")?string("color : #000000;border:4px solid #103050;", "")}'>3-10年</td>
	                <td style='${((softInfoSheet.assetStatus)?if_exists == "没有私人财产")?string("color : #000000;border:4px solid #103050;", "")}'>没有私人财产</td>
	                <td style='${((softInfoSheet.loanRecord)?if_exists == "不良信用记录")?string("color : #000000;border:4px solid #103050;", "")}'>不良信用记录</td>
	                <td style='${((softInfoSheet.childrenStatus)?if_exists == "无子女")?string("color : #000000;border:4px solid #103050;", "")}'>无子女</td>
	                <td style='${((softInfoSheet.spouseWork)?if_exists == "其他工作或生意")?string("color : #000000;border:4px solid #103050;", "")}'>其他工作或生意</td>
	            </tr>
	        </tbody>
	    </table>
	    
	    <table cellspacing="0" style="margin-top:10px;">
	        <tbody>
	            <tr>
	                <th>合理性解释</th>
	                <td colspan="4">${(applicationInfoDeviationAnalysis.rationalExplanation)?if_exists}</td>
	            </tr>
	            <tr>
	                <th>私人财产类型</th>
	                <td colspan="4">
	                	<#list applicationInfoDeviationAnalysis.getPrivatePropertyTypeJson() as privatePropertyType>
	                		${privatePropertyType?if_exists } &nbsp;&nbsp;
               			</#list>
	                </td>
	            </tr>
	            <tr>
	                <th>客户信息收集与核实</th>
	                <td colspan="4">
	                	<#list applicationInfoDeviationAnalysis.getCollectionVerificationJson() as collectionVerification>
	                		${collectionVerification?if_exists } &nbsp;&nbsp;
               			</#list>
	                </td>
	            </tr>
	            <tr>
	                <th>借款人履历，附带其资本累加</th>
	                <td colspan="4">${(applicationInfoDeviationAnalysis.customerRecord)?if_exists}</td>
	            </tr>
	            <tr>
	                <th>对现状的评价：经营组织，市场及财务情况</th>
	                <td colspan="4">${(applicationInfoDeviationAnalysis.actualityAssessment)?if_exists}</td>
	            </tr>
	            <tr>
	                <th>事业情况</th>
	                <td colspan="4">${(applicationInfoDeviationAnalysis.careerSituation)?if_exists}</td>
	            </tr>
	            <tr>
	                <th>申请贷款的原因</th>
	                <td colspan="4">${(applicationInfoDeviationAnalysis.loanReason)?if_exists}</td>
	            </tr>
	            <tr>
	                <th>客户在家庭或在经济网中的情况</th>
	                <td colspan="4">${(applicationInfoDeviationAnalysis.customerSituation)?if_exists}</td>
	            </tr>
	            <tr>
	                <th style="width:20%;" rowspan="${applicationInfoDeviationAnalysis.getMainVendorJson()?size + 1}" >主要供应商</th>
	                <th style="width:30%;" align="center">供应商名称</th>
	                <th align="center">采购比例(%)</th>
	                <th align="center">付款条件</th>
	                <th align="center">往来时间</th>
	            </tr>
	            <#list applicationInfoDeviationAnalysis.getMainVendorJson() as mainVendor>
            		<tr>
		                <td align="center">${(mainVendor.supplier)?if_exists}</td>
		                <td align="center">${(mainVendor.Proportion)?if_exists}</td>
		                <td align="center">${(mainVendor.Condition)?if_exists}</td>
		                <td align="center">${(mainVendor.time)?if_exists}</td>
		            </tr>
       			</#list>
	            <tr>
	                <th rowspan="${applicationInfoDeviationAnalysis.getMainCustomerJson()?size + 1}">主要客户</th>
	                <th align="center">名称</th>
	                <th align="center">销售比例 (%)</th>
	                <th align="center">付款条件</th>
	                <th align="center">往来时间</th>
	            </tr>
	            <#list applicationInfoDeviationAnalysis.getMainCustomerJson() as mainCustomer>
            		<tr>
		                <td align="center">${(mainCustomer.client)?if_exists}</td>
		                <td align="center">${(mainCustomer.Proportion)?if_exists}</td>
		                <td align="center">${(mainCustomer.Condition)?if_exists}</td>
		                <td align="center">${(mainCustomer.time)?if_exists}</td>
		            </tr>
       			</#list>
	        </tbody>
	    </table>
	    
	    <h3>资产负债表</h3>
	    <table>
	        <thead>
	            <tr>
	                <th>资产名称</th>
	                <th>本期</th>
	                <th>上期</th>
	                <th>负债名称</th>
	                <th>本期</th>
	                <th>上期</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <th>资产记录时间</th>
	                <td>${(currentPeriod.pointTime)?if_exists }</td>
	                <td>${(priorPeriod.pointTime)?if_exists }</td>
	                <th>负债记录时间</th>
	                <td>${(currentPeriod.pointTime)?if_exists }</td>
	                <td>${(priorPeriod.pointTime)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>现金</th>
	                <td>${(currentPeriod.cash)?if_exists }</td>
	                <td>${(priorPeriod.cash)?if_exists }</td>
	                <th>应付账款</th>
	                <td>${(currentPeriod.payables)?if_exists }</td>
	                <td>${(priorPeriod.payables)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>银行存款</th>
	                <td>${(currentPeriod.bankDeposit)?if_exists }</td>
	                <td>${(priorPeriod.bankDeposit)?if_exists }</td>
	                <th>预收款项</th>
	                <td>${(currentPeriod.advancepay)?if_exists }</td>
	                <td>${(priorPeriod.advancepay)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>应收账款</th>
	                <td>${(currentPeriod.receivables)?if_exists }</td>
	                <td>${(priorPeriod.receivables)?if_exists }</td>
	                <th>信用卡</th>
	                <td>${(currentPeriod.creditCard)?if_exists }</td>
	                <td>${(priorPeriod.creditCard)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>预付款项</th>
	                <td>${(currentPeriod.prepayments)?if_exists }</td>
	                <td>${(priorPeriod.prepayments)?if_exists }</td>
	                <th>短期贷款</th>
	                <td>${(currentPeriod.shortTermLoan)?if_exists }</td>
	                <td>${(priorPeriod.shortTermLoan)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>存货</th>
	                <td>${(currentPeriod.stock)?if_exists }</td>
	                <td>${(priorPeriod.stock)?if_exists }</td>
	                <th>短期负债合计</th>
	                <td>${(currentPeriod.totalShortTermLiabilities)?if_exists }</td>
	                <td>${(priorPeriod.totalShortTermLiabilities)?if_exists }</td>
	            </tr>
	            <tr class="amount">
	                <th>流动资产合计</th>
	                <td>${(currentPeriod.totalCurrentAsset)?if_exists }</td>
	                <td>${(priorPeriod.totalCurrentAsset)?if_exists }</td>
	                <th>长期贷款</th>
	                <td>${(currentPeriod.longTermLoan)?if_exists }</td>
	                <td>${(priorPeriod.longTermLoan)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>固定资产</th>
	                <td>${(currentPeriod.fixedAsset)?if_exists }</td>
	                <td>${(priorPeriod.fixedAsset)?if_exists }</td>
	                <th>其他负债</th>
	                <td>${(currentPeriod.otherLiability)?if_exists }</td>
	                <td>${(priorPeriod.otherLiability)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>待摊租金（${(currentPeriod.rentSpreadRemarks)?if_exists }）</th>
	                <td>${(currentPeriod.rentSpread)?if_exists }</td>
	                <td>${(priorPeriod.rentSpread)?if_exists }</td>
	                <th>长期负债合计</th>
	                <td>${(currentPeriod.totalLongTermLiabilities)?if_exists }</td>
	                <td>${(priorPeriod.totalLongTermLiabilities)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>其他经营资产</th>
	                <td>${(currentPeriod.otherOperatingAsset)?if_exists }</td>
	                <td>${(priorPeriod.otherOperatingAsset)?if_exists }</td>
	                 <th>总负债合计</th>
	                <td>${(currentPeriod.totalLiabilities)?if_exists }</td>
	                <td>${(priorPeriod.totalLiabilities)?if_exists }</td>
	            </tr>
	            <tr>
	                <th>其他非经营资产</th>
	                <td>${(currentPeriod.otherNonOperatingAsset)?if_exists }</td>
	                <td>${(priorPeriod.otherNonOperatingAsset)?if_exists }</td>
	                <th>权益</th>
	                <td>${(currentPeriod.equity)?if_exists }</td>
	                <td>${(priorPeriod.equity)?if_exists }</td>
	            </tr>
	            <tr class="amount">
	                <th>总资产合计</th>
	                <td>${(currentPeriod.totalAssets)?if_exists }</td>
	                <td>${(priorPeriod.totalAssets)?if_exists}</td>
	                <th>负债及权益合计</th>
	                <td>${(currentPeriod.totalAssets)?if_exists }</td>
	                <td>${(priorPeriod.totalAssets)?if_exists}</td>
	            </tr>
	        </tbody>
	    </table>
	    <br></br>
	    <div>
	    	<div class="width48p">
	    		<h3>表外资产</h3>
			    <table>
			        <thead>
			            <tr>
			                <th>名称</th>
			                <th>价值或者金额</th>
			            </tr>
			        </thead>
			        <tbody>
			       	 	<#list assetAdditionals as assetAdditional>
			                <tr>
			                    <td>${assetAdditional.text}</td>
			                    <td>${assetAdditional.amount}</td>
			                </tr>
			            </#list>
			        </tbody>
			    </table>
	    	</div>
	    	<div style="width:2%; float:left;">
	    	</div>
	    	<div style="width:100%; float:left;">
	    		<h3>表外负债</h3>
			    <table>
			        <thead>
			            <tr>
			                <th>名称</th>
			                <th>价值或者金额</th>
			            </tr>
			        </thead>
			        <tbody>
			        	<#list debtsAdditionals as debtsAdditional>
			                <tr>
			                    <td>${debtsAdditional.text}</td>
			                    <td>${debtsAdditional.amount}</td>
			                </tr>
			            </#list>
			        </tbody>
			    </table>
	    	</div>
	    </div>
	    <div class="clear_both"></div>
	    
	    <h3>对外担保情况</h3>
	    <table>
	        <thead>
	            <tr>
	                <th>名称</th>
	                <th>价值或者金额</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<#list assureAdditionals as assureAdditional>
	                <tr>
	                    <td>${assureAdditional.text}</td>
	                    <td>${assureAdditional.amount}</td>
	                </tr>
	            </#list>
	        </tbody>
	    </table>
	    
	    <h3>资产负债评价</h3>
	    <table>
	    	<tr class="amount">
		        <th>应收款与月平均营业额对比：</th>
		        <td>${wdApplicationOperatingBalanceSheet.receivablesVsTurnover }</td>
		        <th>应收款与月平均营业额对比说明：</th>
		        <td>${wdApplicationOperatingBalanceSheet.receivablesVsTurnoverText }</td>
		    </tr>
		    <tr class="amount">
		        <th>存货可销售与月平均营业额对比：</th>
		        <td>${wdApplicationOperatingBalanceSheet.stockVsTurnover }</td>
		        <th>存货可销售与月平均营业额对比说明：</th>
		        <td>${wdApplicationOperatingBalanceSheet.stockVsTurnoverText }</td>
		    </tr>
		    <tr class="amount">
		        <th>借款人权益与借款人家庭开支（月）对比：</th>
		        <td>${wdApplicationOperatingBalanceSheet.equityVsExpense }</td>
		        <th>借款人权限与借款人家庭开支（月）对比说明：</th>
		        <td>${wdApplicationOperatingBalanceSheet.equityVsExpenseText }</td>
		    </tr>
	    </table>
	    
	    <h3>初始权益点资产负债表</h3>
	    <table cellspacing="0">
	        <tbody>
	            <tr>
	                <th>权益检验原始点</th>
	                <td colspan="3">${(wdApplicationOperatingBalanceSheetCheck.checkPoint)?string("yyyy-MM-dd HH:mm:ss")}</td>
	            </tr>
	            <tr>
	                <th style="width:25%">现金及银行存款</th>
	                <td style="width:25%">${wdApplicationOperatingBalanceSheetCheck.cashAndDeposit}</td>
	                <th style="width:25%">应付账款</th>
	                <td style="width:25%">${wdApplicationOperatingBalanceSheetCheck.receivables}</td>
	            </tr>
	            <tr>
	                <th>应收账款</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.payables}</td>
	                <th>预收账款</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.prepayments}</td>
	            </tr>
	            <tr>
	                <th>预付账款</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.advancepay}</td>
	                <th>短期贷款</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.shortTermLoan}</td>
	            </tr>
	            <tr>
	                <th>存货</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.stock}</td>
	                <th>长期贷款</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.longTermLoan}</td>
	            </tr>
	            <tr>
	                <th>固定资产</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.fixedAsset}</td>
	                <th>其他负债</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.otherLiability}</td>
	            </tr>
	            <tr>
	                <th>待摊租金</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.otherOperatingAsset}</td>
	                <td></td>
	                <td></td>
	            </tr>
	            <tr>
	                <th>其他非经营资产</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.otherNonOperatingAsset}</td>
	                <th>权益</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.equity}</td>
	            </tr>
	            <tr>
	                <th>总资产</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.totalAssets}</td>
	                <th>负债及权益合计</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.liabilitiesAndEquity}</td>
	            </tr>
            </tbody>
        </table>
        <h3>初始权益点资产负债表</h3>
	    <table cellspacing="0">
	    	<tbody>
	            <tr>
	                <th width="20%">初始权益金额</th>
	                <td width="20%">${wdApplicationOperatingBalanceSheetCheck.initialEquityAmount}</td>
	                <th width="20%">初始权益</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.initialEquity}</td>
	            </tr>
	            <tr>
	                <th>期间内的利润金额</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.periodProfitAmount}</td>
	                <th>期间内的利润</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.periodProfit}</td>
	            </tr>
	            <tr>
	                <th>期间内资本注入金额</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.periodCapitalAmount}</td>
	                <th>期间内资本注入</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.periodCapital}</td>
	            </tr>
	            <tr>
	                <th>期间内提起的资金金额</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.periodFundingAmount}</td>
	                <th>期间内提起的资金</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.periodFunding}</td>
	            </tr>
	            <tr>
	                <th>折旧/升值金额</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.deOrAppreciationAmount}</td>
	                <th>折旧/升值</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.deOrAppreciation}</td>
	            </tr>
	            <tr>
	                <th>应有权益</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.entitlement}</td>
	                <th>偏差值</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.deviationValue}</td>
	            </tr>
	            <tr>
	                <th>偏差率</th>
	                <td>${wdApplicationOperatingBalanceSheetCheck.deviationRate}</td>
	                <th></th>
	                <td></td>
	            </tr>
	        </tbody>
	    </table>
    </#if>
    
    <h3>审批进度</h3>
    <table cellspacing="0">
        <tbody>
            <tr>
                <th>时间</th>
                <th>操作人</th>
                <th>操作说明</th>
                <th>结果</th>
                <th>结果</th>
            </tr>
            <#list wdApplicationTaskList as wdApplicationTask>
	            <tr>
	                <td>${wdApplicationTask.updateDate?string("yyyy-MM-dd HH:mm:ss")}</td>
	                <td>${wdApplicationTask.ownerName }</td>
	                <td>${wdApplicationTask.statusName?if_exists }</td>
	                <td>${wdApplicationTask.actionName?if_exists }</td>
	                <td>审批意见： ${wdApplicationTask.comment?if_exists}
		                <#if wdApplicationTask.status??>
			                <#switch wdApplicationTask.status>
			                	<#case 2>
			                		<#assign taskConfig = "BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB">
			                		<#break>
			                	<#case 32>
			                		<#assign taskConfig = "CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC">
			                		<#break>
			                	<#case 256>
			                		<#assign taskConfig = "DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD">
			                		<#break>
		                		<#default>
		                			<#assign taskConfig = "">
		            			<#break>
			                </#switch>
			                <#if taskConfig != "">
			                	 <#list applyAuditInfoConfig as config>
			                	 	 <#assign wdBusinessElement = wdBusinessElementConfig[config.businessElementId] >
			                		 <br></br>${wdBusinessElement.name }：${wdApplicationTask.getJsonData()[wdBusinessElement.key]?if_exists }
			                	 </#list>
			                	 <#if (productConfig[taskConfig])??>
				                	 <#list productConfig[taskConfig] as conclusionConfig>
			                            <#assign wdBusinessElement = wdBusinessElementConfig[conclusionConfig.businessElementId] >
			                            <br></br>${wdBusinessElement.name }：${wdApplicationTask.getJsonData()[wdBusinessElement.key]?if_exists }
			                        </#list>
	                        	 </#if>
			                </#if>
		                </#if>
	                </td>
	            </tr>
            </#list>
        </tbody>
    </table>
</body>
</html>