package com.bk.wd.web.controller.wdpl;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bk.common.entity.JsonResult;
import com.bk.common.utils.UidUtil;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.pl.model.WdPlOriginalDataFuzhou;
import com.bk.wd.pl.service.WdPlOriginalDataFuzhouService;
import com.bk.wd.pl.util.InitCardInfo;
import com.bk.wd.pl.util.InitCardInfo4Fuzhou;
import com.bk.wd.web.utils.ExcelUtils;

@Controller
@RequestMapping(value = "/wdpl/originaldatafuzhou/")
public class WdPlOriginalDataFuzhouController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(WdPlOriginalDataFuzhouController.class);
    
    @Autowired
    private WdPlOriginalDataFuzhouService wdPlOriginalDataFuzhouService;
    
    /**
     * 福州放款的台账数据导入
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
        for (int rowNumber = 1; rowNumber <= sheet.getLastRowNum(); rowNumber++) {
            Row row= sheet.getRow(rowNumber);
            WdPlOriginalDataFuzhou wdPlOriginalDataFuzhou = new WdPlOriginalDataFuzhou();
            wdPlOriginalDataFuzhou.setId(UidUtil.uuid());
            wdPlOriginalDataFuzhou.setCreateDate(now);
            wdPlOriginalDataFuzhou.setKaHao(ExcelUtils.getValue(row.getCell(0)));
            wdPlOriginalDataFuzhou.setKaPianChanPinZhongLei(ExcelUtils.getValue(row.getCell(1)));
            wdPlOriginalDataFuzhou.setKaiHuRiQi(ExcelUtils.getValue(row.getCell(2)));
            wdPlOriginalDataFuzhou.setKeHuMingChen(ExcelUtils.getValue(row.getCell(3)));
            wdPlOriginalDataFuzhou.setKaPianDaoQiRi(ExcelUtils.getValue(row.getCell(4)));
            wdPlOriginalDataFuzhou.setZhengJianLeiXing(ExcelUtils.getValue(row.getCell(5)));
            wdPlOriginalDataFuzhou.setZhengJianHaoMa(ExcelUtils.getValue(row.getCell(6)));
            wdPlOriginalDataFuzhou.setXinYongEDu(ExcelUtils.getValue(row.getCell(7)));
            wdPlOriginalDataFuzhou.setFenQiFuKuanXinYongEDu(ExcelUtils.getValue(row.getCell(8)));
            wdPlOriginalDataFuzhou.setZongYuE(ExcelUtils.getValue(row.getCell(9)));
            wdPlOriginalDataFuzhou.setTouZhiBenJin(ExcelUtils.getValue(row.getCell(10)));
            wdPlOriginalDataFuzhou.setZhengChangTouZhiBenJin(ExcelUtils.getValue(row.getCell(11)));
            wdPlOriginalDataFuzhou.setYuQiTouZhiBenJin(ExcelUtils.getValue(row.getCell(12)));
            wdPlOriginalDataFuzhou.setDaiZhiTouZhiBenJin(ExcelUtils.getValue(row.getCell(13)));
            wdPlOriginalDataFuzhou.setDaiZhangTouZhiBenJin(ExcelUtils.getValue(row.getCell(14)));
            wdPlOriginalDataFuzhou.setTouZhiBiaoNeiLiXi(ExcelUtils.getValue(row.getCell(15)));
            wdPlOriginalDataFuzhou.setTouZhiBiaoWaiLiXi(ExcelUtils.getValue(row.getCell(16)));
            wdPlOriginalDataFuzhou.setFenQiFuKuanShengYuBenJin(ExcelUtils.getValue(row.getCell(17)));
            wdPlOriginalDataFuzhou.setZhangHuZhuangTai(ExcelUtils.getValue(row.getCell(18)));
            wdPlOriginalDataFuzhou.setHaiKuanJieZhiRiQi(ExcelUtils.getValue(row.getCell(19)));
            wdPlOriginalDataFuzhou.setYuQiRiQi(ExcelUtils.getValue(row.getCell(20)));
            wdPlOriginalDataFuzhou.setZhuanTouZhiRiQi(ExcelUtils.getValue(row.getCell(21)));
            wdPlOriginalDataFuzhou.setYuQiBiaoZhi(ExcelUtils.getValue(row.getCell(22)));
            wdPlOriginalDataFuzhou.setShangQiWuJiFenLeiBiaoZhi(ExcelUtils.getValue(row.getCell(23)));
            wdPlOriginalDataFuzhou.setWuJiFenLeiZhuangTai(ExcelUtils.getValue(row.getCell(24)));
            wdPlOriginalDataFuzhou.setZhuGuanKeHuJingLi(ExcelUtils.getValue(row.getCell(25)));
            wdPlOriginalDataFuzhou.setZhangWuJiGou(ExcelUtils.getValue(row.getCell(26)));
            wdPlOriginalDataFuzhou.setZhuGuanJiGou(ExcelUtils.getValue(row.getCell(27)));
            wdPlOriginalDataFuzhou.setDanBaoRenZhengJianHaoMa(ExcelUtils.getValue(row.getCell(28)));
            wdPlOriginalDataFuzhou.setDanBaoRenMingChen(ExcelUtils.getValue(row.getCell(29)));
            wdPlOriginalDataFuzhou.setDanBaoRenShouJi(ExcelUtils.getValue(row.getCell(30)));
            wdPlOriginalDataFuzhou.setKeHuHangYe(ExcelUtils.getValue(row.getCell(31)));
            wdPlOriginalDataFuzhou.setDanBaoFangShi(ExcelUtils.getValue(row.getCell(32)));
            wdPlOriginalDataFuzhou.setXingBie(ExcelUtils.getValue(row.getCell(33)));
            wdPlOriginalDataFuzhou.setChuShengRiQi(ExcelUtils.getValue(row.getCell(34)));
            wdPlOriginalDataFuzhou.setLianXiDianHua(ExcelUtils.getValue(row.getCell(35)));
            wdPlOriginalDataFuzhou.setLianXiDiZhi(ExcelUtils.getValue(row.getCell(36)));
            wdPlOriginalDataFuzhou.setQiXian(ExcelUtils.getValue(row.getCell(37)));
            wdPlOriginalDataFuzhou.setLiLvLeiXing(ExcelUtils.getValue(row.getCell(38)));
            wdPlOriginalDataFuzhou.setYingZiEDu(ExcelUtils.getValue(row.getCell(39)));
            wdPlOriginalDataFuzhou.setBenQiFeiYongZongE(ExcelUtils.getValue(row.getCell(40)));
            wdPlOriginalDataFuzhou.setBenQiBiaoNeiYingShouFeiYong(ExcelUtils.getValue(row.getCell(41)));
            wdPlOriginalDataFuzhou.setBiaoWaiYingShouFeiYong(ExcelUtils.getValue(row.getCell(42)));
            wdPlOriginalDataFuzhou.setZuiDiHaiKuanEWeiHaiBuFen(ExcelUtils.getValue(row.getCell(43)));
            wdPlOriginalDataFuzhou.setDanWeiShuXing(ExcelUtils.getValue(row.getCell(44)));
            wdPlOriginalDataFuzhou.setShiFouHeXiaoKaPian(ExcelUtils.getValue(row.getCell(45)));
            wdPlOriginalDataFuzhou.setTuiJianRenDaiHao(ExcelUtils.getValue(row.getCell(46)));
            
            wdPlOriginalDataFuzhou.setCreateBy(UserUtils.getUser().getId());
            wdPlOriginalDataFuzhouService.insertSelective(wdPlOriginalDataFuzhou);
        }
        //清洗福州数据
        InitCardInfo initCardInfo = new InitCardInfo4Fuzhou();
        initCardInfo.init();
        return new JsonResult();
    }
    
    
}