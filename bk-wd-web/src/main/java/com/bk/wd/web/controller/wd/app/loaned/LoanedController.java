package com.bk.wd.web.controller.wd.app.loaned;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.common.entity.Pagination;
import com.bk.common.service.DfsService;
import com.bk.common.utils.DateUtils;
import com.bk.common.utils.FileUtil;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.common.utils.ZipUtil;
import com.bk.common.web.BaseController;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.dto.AppSearchParamsDto;
import com.bk.wd.model.WdApplication;
import com.bk.wd.model.WdApplicationTask;
import com.bk.wd.service.WdApplicationService;
import com.bk.wd.service.WdApplicationTaskService;
import com.bk.wd.util.BusinessConsts;

/**
 * 贷后管理列表
 * @Project Name:bk-wd-web 
 * @Date:2017年9月12日下午1:56:13 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/wd/application/loaned")
public class LoanedController extends BaseController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(LoanedController.class);
    
    @Autowired
    private WdApplicationService wdApplicationService;
    
    @Autowired
    private DfsService dfsService;
    
    @Autowired
    private WdApplicationTaskService wdApplicationTaskService;
 
    /**
     * 我的贷后
     * date: 2017年4月8日 下午5:46:49 <br/> 
     * @author Liam 
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:loaned:mine:view")
    @RequestMapping(value = { "mineList"})
    public String mineList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        if (null == searchParamsDto.getStatus()) {
            searchParamsDto.setStatus(2048); // 默认为还款中
        }
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        searchParamsDto.setPagination(pagination);
        pagination.setTotal(wdApplicationService.countMineList(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineList(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/loaned/mineList";
    }
    
    /**
     * 下载归档资料
     * date: 2017年9月4日 上午10:22:52 <br/> 
     * @author Liam 
     * @param applicationId
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:loaned:manager:archivefile")
    @RequestMapping(value = { "downloadAllArchiveFile"})
    public void downloadAllArchiveFile(HttpServletResponse response, AppSearchParamsDto searchParamsDto) {
        searchParamsDto.setDataScope("office");
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        List<WdApplication> appList = wdApplicationService.selectMineList(searchParamsDto);
        List<String> fileIdList = new ArrayList<>();
        for (WdApplication wdApplication : appList) {
            if (StringUtils.isNotEmpty(wdApplication.getArchiveFile())) {
                fileIdList.add(wdApplication.getArchiveFile());
            }
        }
        
        try (ZipOutputStream out = new ZipOutputStream(response.getOutputStream());) {
            response.setContentType("application/x-download");// 设置response内容的类
            response.setHeader("Content-disposition", "attachment;filename="+ URLEncoder.encode(DateUtils.formatDate(new Date(), "yyyy_MM_dd") + ".zip", "UTF-8"));// 设置头部信息
            
            if (!fileIdList.isEmpty()) {
                String basePath = "/app/file/" + DateUtils.formatDate(new Date(), "yyyy_MM_dd_HH_MM_ss");
                Map<String, byte[]> fileMap = dfsService.downloadFile(fileIdList);
                for (WdApplication wdApplication : appList) {
                    if (StringUtils.isNotEmpty(wdApplication.getArchiveFile())) {
                        String fileName = wdApplication.getCustomerName() + "_" + wdApplication.getCode() + wdApplication.getArchiveFile().substring(wdApplication.getArchiveFile().lastIndexOf("."));
                        String path = basePath + "/" + wdApplication.getOwnerName();
                        FileUtil.createDir (path);
                        FileUtil.byte2File(fileMap.get(wdApplication.getArchiveFile()), path, fileName);
                    }
                }
                ZipUtil.doCompress(new File(basePath), out);
                response.flushBuffer();
                FileUtil.delDir(basePath);
            }
        } catch (IOException e) {
            LOGGER.error("归档下载失败", e);
        }
    }
    
    /**
     * 重新归档资料
     * date: 2017年9月4日 上午10:22:52 <br/> 
     * @author Liam 
     * @param applicationId
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:loaned:manager:resetAllArchiveFile")
    @RequestMapping(value = { "resetAllArchiveFile"})
    @ResponseBody
    public String resetAllArchiveFile(HttpServletResponse response, AppSearchParamsDto searchParamsDto) {
        if (null == searchParamsDto.getStatus()) {
            searchParamsDto.setStatus(2048); // 默认为还款中
        }
        searchParamsDto.setDataScope("office");
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        List<WdApplication> appList = wdApplicationService.selectMineList(searchParamsDto);
        Thread t = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    for (WdApplication wdApplication : appList) {
                        LOGGER.info("申请单：" + wdApplication.getCode() + " 归档中，请稍候");
                        String zipFile = wdApplicationService.applicationArchiveFile(wdApplication.getId());
                        WdApplication wdApplication1 = wdApplicationService.selectByPrimaryKey(wdApplication.getId());
                        wdApplication1.setArchiveFile(zipFile);
                        wdApplicationService.updateByPrimaryKeySelective(wdApplication1);
                    }
                } catch (IOException e) {
                    LOGGER.error("贷款信息归档失败", e);
                }
            }
        });
        t.start();
        return "true";
    }
    
    /**
     * 贷后管理
     * date: 2017年4月27日 上午9:28:28 <br/> 
     * @author Liam 
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:loaned:manager:view")
    @RequestMapping(value = { "managerList"})
    public String managerList(Model model, Pagination pagination, AppSearchParamsDto searchParamsDto) {
        if (null == searchParamsDto.getStatus()) {
            searchParamsDto.setStatus(2048); // 默认为还款中
        }
        searchParamsDto.setDataScope("office");
        searchParamsDto.setPagination(pagination);
        searchParamsDto.setUserId(UserUtils.getUser().getId());
        pagination.setTotal(wdApplicationService.countMineList(searchParamsDto));
        pagination.setDataList(wdApplicationService.selectMineList(searchParamsDto));
        model.addAttribute("pagination", pagination);
        model.addAttribute("params", searchParamsDto);
        return "modules/wd/application/loaned/managerList";
    }
    
    /**
     * 终止申请
     * date: 2017年4月27日 上午9:28:28 <br/> 
     * @author Liam 
     * @param model
     * @return 
     * @since JDK 1.8
     */
    @RequiresPermissions("wd:application:settlement")
    @RequestMapping(value = { "settlement"})
    @ResponseBody
    public JsonResult settlement(Model model, String applicationId) {
        WdApplication wdApplication = wdApplicationService.selectByPrimaryKey(applicationId);
        if (null == wdApplication || wdApplication.getStatus() != 2048) {
        	return new JsonResult("该笔单子尚未到达还款阶段，暂不能直接还清");
        }
        wdApplication.setUpdateDate(new Date());
        wdApplication.setStatus(4096);
        wdApplicationService.updateByPrimaryKeySelective(wdApplication);
        
        WdApplicationTask ctask = new WdApplicationTask();
        ctask.setId(UidUtil.uuid());
        ctask.setStatus(4096);
        ctask.setStatusName("已还清");
        ctask.setApplicationId(applicationId);
        ctask.setOwnerId(UserUtils.getUser().getId());
        ctask.setOwnerName(UserUtils.getUser().getName());
        ctask.setClose(BusinessConsts.TrueOrFalseAsString.True);
        ctask.setCloseDate(new Date());
        ctask.setDone(BusinessConsts.TrueOrFalseAsString.True);
        ctask.setDonerId(UserUtils.getUser().getId());
        ctask.setDonerName(UserUtils.getUser().getName());
        ctask.setDoneDate(new Date());
        ctask.setAction(BusinessConsts.Action.Pass);
        ctask.setActionName(BusinessConsts.ACTIONS.get(BusinessConsts.Action.Pass));
        ctask.setCreateBy(UserUtils.getUser().getId());
        ctask.setCreateDate(new Date());
        ctask.setUpdateBy(UserUtils.getUser().getId());
        ctask.setUpdateDate(new Date());
        wdApplicationTaskService.insertSelective(ctask);
        
        return new JsonResult();
    }
    
}