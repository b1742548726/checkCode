package com.bk.wd.web.controller.wdpl;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.antgroup.zmxy.openplatform.api.internal.mapping.ApiField;
import com.bk.common.utils.DateUtils;
import com.bk.wd.model.WdApplication;
import com.bk.wd.pl.model.WdPlOriginalDataLuoyangLog;
import com.bk.wd.pl.service.WdPlOriginalDataLuoyangLogService;
import com.bk.wd.service.WdApplicationService;
import org.apache.commons.collections.list.CursorableLinkedList;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bk.common.entity.JsonResult;
import com.bk.common.utils.UidUtil;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.pl.model.WdPlOriginalDataLuoyang;
import com.bk.wd.pl.service.WdPlOriginalDataLuoyangService;
import com.bk.wd.web.utils.ExcelUtils;

@Controller
@RequestMapping(value = "/wdpl/originaldataluoyang/")
public class WdPlOriginalDataLuoyangController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(WdPlOriginalDataLuoyangController.class);
    
    @Autowired
    private WdPlOriginalDataLuoyangService wdPlOriginalDataLuoyangService;

    @Autowired
    private WdApplicationService wdApplicationService;

    @Autowired
    private WdPlOriginalDataLuoyangLogService wdPlOriginalDataLuoyangLogService;
    
    /**
     * 洛阳放款的台账数据导入
     * @param excelFile
     * @param request
     * @return
     */
    @RequestMapping(value = "/implExcelData" )
    @ResponseBody
    @Transactional
    public JsonResult implExcelData(@RequestParam(value = "excelFile", required = false)MultipartFile excelFile, HttpServletRequest request) {
        String fileName = excelFile.getOriginalFilename();
        String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
        if (!(fileType.equals(".xlsx") || fileType.equals(".xls"))) {
            return new JsonResult(false, "上传的文件不是Excel文件");
        }

        Workbook workbook = null;
        try {
            workbook = WorkbookFactory.create(excelFile.getInputStream());
        } catch (EncryptedDocumentException | InvalidFormatException | IOException e) {
            LOGGER.error("上传excel", e);
            return new JsonResult(false, "当前模板不是最新，请下载最新的调查模板");
        }

        Date now = new Date();
        Sheet sheet = workbook.getSheetAt(0);
        List<Map<String,Object>> applicationList = wdApplicationService.queryApplicationInfoListStatus();
        Map<String,Object> resultErrorMap1 = new HashMap<>();//统计重复数据
        Map<String,Object> resultErrorMap2 = new HashMap<>();//统计重复数据结果
        List<Map<String,Object>> applicationList2048 = new ArrayList<>();
        List<WdPlOriginalDataLuoyang> wdPlOriginalDataLuoyangList = new ArrayList<>();
        List<WdPlOriginalDataLuoyang> wdPlOriginalDataLuoyangList512 = new ArrayList<>();
        int rowNumber = 4;
        for (; rowNumber <= sheet.getLastRowNum(); rowNumber++) {
            Row row= sheet.getRow(rowNumber);
            WdPlOriginalDataLuoyang wdPlOriginalDataLuoyang = new WdPlOriginalDataLuoyang();
            wdPlOriginalDataLuoyang.setId(UidUtil.uuid());
            wdPlOriginalDataLuoyang.setCreateDate(now);
            wdPlOriginalDataLuoyang.setCreateBy(UserUtils.getUser().getId());
            
            wdPlOriginalDataLuoyang.setPipeProtectionMechanism(ExcelUtils.getValue(row.getCell(0)));
            wdPlOriginalDataLuoyang.setEntryAgency(ExcelUtils.getValue(row.getCell(1)));
            wdPlOriginalDataLuoyang.setCustomerCode(ExcelUtils.getValue(row.getCell(2)));
            wdPlOriginalDataLuoyang.setCustomerName(ExcelUtils.getValue(row.getCell(3)));
            wdPlOriginalDataLuoyang.setContactAddress(ExcelUtils.getValue(row.getCell(4)));
            wdPlOriginalDataLuoyang.setContactPhone(ExcelUtils.getValue(row.getCell(5)));
            wdPlOriginalDataLuoyang.setLoanVariety(ExcelUtils.getValue(row.getCell(6)));
            wdPlOriginalDataLuoyang.setLoanInvestment(ExcelUtils.getValue(row.getCell(7)));
            wdPlOriginalDataLuoyang.setLoanUse(ExcelUtils.getValue(row.getCell(8)));
            wdPlOriginalDataLuoyang.setLoanAccount(ExcelUtils.getValue(row.getCell(9)));
            wdPlOriginalDataLuoyang.setContractCode(ExcelUtils.getValue(row.getCell(10)));
            wdPlOriginalDataLuoyang.setIouCode(ExcelUtils.getValue(row.getCell(11)));
            wdPlOriginalDataLuoyang.setGuaranteeMethod(ExcelUtils.getValue(row.getCell(12)));
            wdPlOriginalDataLuoyang.setFiveLevelClassification(ExcelUtils.getValue(row.getCell(13)));
            wdPlOriginalDataLuoyang.setIouAmount(ExcelUtils.stringToBig(ExcelUtils.getValue(row.getCell(14))));
            wdPlOriginalDataLuoyang.setLoanAmount(ExcelUtils.stringToBig(ExcelUtils.getValue(row.getCell(15))));
            wdPlOriginalDataLuoyang.setLoanBalance(ExcelUtils.stringToBig(ExcelUtils.getValue(row.getCell(16))));
            wdPlOriginalDataLuoyang.setStartDay(ExcelUtils.getValue(row.getCell(17)));
            wdPlOriginalDataLuoyang.setDueDate(ExcelUtils.getValue(row.getCell(18)));
            wdPlOriginalDataLuoyang.setInterestRate(ExcelUtils.stringToBig(ExcelUtils.getValue(row.getCell(19))));
            wdPlOriginalDataLuoyang.setLoanMethod(ExcelUtils.getValue(row.getCell(20)));
            wdPlOriginalDataLuoyang.setCustomerManager(ExcelUtils.getValue(row.getCell(21)));
            
            wdPlOriginalDataLuoyangService.insertSelective(wdPlOriginalDataLuoyang);

            wdPlOriginalDataLuoyangList.add(wdPlOriginalDataLuoyang);
            //找出已结清的数据
            for (Map<String,Object> app:applicationList){
                if (app.get("phone").equals(wdPlOriginalDataLuoyang.getContactPhone()) && app.get("cuName").equals(wdPlOriginalDataLuoyang.getCustomerName()) && wdPlOriginalDataLuoyang.getLoanAmount().compareTo(new BigDecimal(app.get("amount").toString()))==0 ) {
                    //把Excel和数据中能够对应上的数据保存下来
                    if(app.get("status").equals(512)){
                        wdPlOriginalDataLuoyangList512.add(wdPlOriginalDataLuoyang);
                    }
                    if(app.get("status").equals(2048)){//保存还款中状态的记录
                        applicationList2048.add(app);
                    }
                    String contractCode = wdPlOriginalDataLuoyang.getContractCode();
                    if(!resultErrorMap1.containsKey(contractCode)){
                        resultErrorMap1.put(contractCode,1);
                    }else{
                        resultErrorMap1.put(contractCode,((Integer)resultErrorMap1.get(contractCode)+1));
                    }
                    if(((Integer)resultErrorMap1.get(contractCode)>=2)){
                        applicationList2048.remove(app);
                        resultErrorMap2.put(contractCode,resultErrorMap1.get(contractCode));
                    }
                }
            }
        }
        //删除相同的元素,保留未匹配到的元素
        wdPlOriginalDataLuoyangList.removeAll(applicationList);

        //执行数据处理任务
        Thread thread = new Thread(new ApplicationStatusWith(wdPlOriginalDataLuoyangList512,applicationList2048));
        thread.start();

        // TODO: 暂时不做贷后任务

        //保存数据
        WdPlOriginalDataLuoyangLog luoyangLog = new WdPlOriginalDataLuoyangLog();
        boolean isSuccess = true;
        Map<String,Object> map = new HashMap<>();
        map.put("resultMsg","导入成功！");
        map.put("resultErrorMap",resultErrorMap2);//重复数据
        map.put("notInMap",wdPlOriginalDataLuoyangList);//不存在的数据
        if(resultErrorMap2.size()>0||wdPlOriginalDataLuoyangList.size()>0){
            //保存错误信息
            map.put("resultMsg","导入出错！");
            isSuccess = false;
        }
        luoyangLog.setId(UidUtil.uuid());
        luoyangLog.setResult(isSuccess);
        luoyangLog.setResultJson(JSONObject.toJSONString(map));
        luoyangLog.setCreateDate(new Date());
        luoyangLog.setCreateBy(UserUtils.getUser().getId());
        wdPlOriginalDataLuoyangLogService.insertSelective(luoyangLog);
        return new JsonResult();
    }

    @RequestMapping(value = "/dataInput" )
    public String dataInput(Model model, HttpServletRequest request, HttpServletResponse response){
        WdPlOriginalDataLuoyangLog dataLuoyangLog = wdPlOriginalDataLuoyangLogService.selectLastOneByUserId(UserUtils.getUser().getId());
        if(dataLuoyangLog!=null){
            Map<String,Object> map = new  HashMap<String,Object>();
            model.addAttribute("resultSuccess",dataLuoyangLog.getResult());
            model.addAttribute("inputResult",JSONObject.parseObject(dataLuoyangLog.getResultJson(),map.getClass()));
            model.addAttribute("upTime", DateUtils.formatDate(dataLuoyangLog.getCreateDate(),"yyyy-MM-dd HH:mm:ss"));
        }

        return "/modules/wd/dataManager/dataInput";
    }

    /***
     * 处理数据
     */
    class ApplicationStatusWith implements Runnable{

        private List<WdPlOriginalDataLuoyang> wdPlOriginalDataLuoyangList;

        private List<Map<String,Object>> applicationList;

        public ApplicationStatusWith(List<WdPlOriginalDataLuoyang> wdPlOriginalDataLuoyangList, List<Map<String, Object>> applicationList) {
            this.wdPlOriginalDataLuoyangList = wdPlOriginalDataLuoyangList;
            this.applicationList = applicationList;
        }

        @Override
        public void run() {
            wdPlOriginalDataLuoyangList.forEach(l->{
                String amount = l.getLoanAmount()==null?"0":l.getLoanAmount().toString();
                wdApplicationService.updateApplicationInfoListStatus512(l.getContractCode(),l.getContactPhone(),l.getCustomerName(),amount);
            });
            applicationList.forEach(l->{
                WdApplication app = new WdApplication();
                app.setId(l.get("applicationId").toString());
                app.setStatus(4096);
                app.setStatusName("贷款完结");
                wdApplicationService.updateByPrimaryKeySelective(app);
            });
        }
    }

}