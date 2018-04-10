package com.bk.wd.web.controller.sys;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bk.common.entity.JsonResult;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysCarDealer;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.sys.service.SysCarDealerService;

/**
 * 车辆经销商
 * @Project Name:bk-wd-web 
 * @Date:2017年12月25日下午3:48:53 
 * @author Liam
 * @Copyright (c) 2017, lizhenxing@bakejinfu.com All Rights Reserved.
 */
@Controller
@RequestMapping(value = "/sys/cardealer")
public class SysCarDealerController {
    
    @Autowired
    private SysCarDealerService sysCarDealerService;
    
    @RequestMapping(value = {"index"})
    public String index() {
        return "modules/sys/carDealer/index";
    }
    
    @RequestMapping(value = {"list"})
    @ResponseBody
    public JsonResult list() {
        List<SysCarDealer> sysCarDealerList = sysCarDealerService.selectByCompanyId(UserUtils.getUser().getCompanyId());
        return new JsonResult(treeData(sysCarDealerList, null));
    }
    
    public List<SysCarDealer> treeData(List<SysCarDealer> carDealerList, String parentId) {
        List<SysCarDealer> list = new ArrayList<>();
        if (!carDealerList.isEmpty()) {
            for (SysCarDealer sysCarDealer : carDealerList) {
                System.out.println(parentId + "-- " +sysCarDealer.getParentId());
                if ((null == parentId &&  StringUtils.isEmpty(sysCarDealer.getParentId())) ||  (parentId != null && parentId.equals(sysCarDealer.getParentId()))) {
                    sysCarDealer.setItemList(treeData(carDealerList, sysCarDealer.getId()));
                    list.add(sysCarDealer);
                }
            }
        }
        return list;
    }
    
    @RequestMapping(value = {"del"})
    @ResponseBody
    public JsonResult del(String id) {
        sysCarDealerService.deleteByPrimaryKey(id);
        return new JsonResult();
    }
    
    @RequestMapping(value = {"getChild"})
    @ResponseBody
    public JsonResult getChild(String parentId) {
        return new JsonResult(sysCarDealerService.selectByParentId(parentId));
    }
    
    @RequestMapping(value = {"save"})
    @ResponseBody
    public JsonResult save(SysCarDealer sysCarDealer) {
        SysUser user = UserUtils.getUser();
        
        if (StringUtils.isEmpty(sysCarDealer.getId())) {
            sysCarDealer.setId(UidUtil.uuid());
            sysCarDealer.setCompanyId(user.getCompanyId());
            sysCarDealer.setDelFlag(false);
            sysCarDealer.setCreateBy(user.getId());
            sysCarDealer.setCreateDate(new Date());
            sysCarDealer.setUpdateBy(user.getId());
            sysCarDealer.setUpdateDate(new Date());
            sysCarDealer.setSort(sysCarDealerService.countByCompanyId(user.getCompanyId()));
            sysCarDealerService.insertSelective(sysCarDealer);
        } else {
            sysCarDealer.setUpdateBy(user.getId());
            sysCarDealer.setUpdateDate(new Date());
            sysCarDealerService.updateByPrimaryKeySelective(sysCarDealer);
        }
        return new JsonResult(sysCarDealer);
    }
    
    @RequestMapping(value = {"sort"})
    @ResponseBody
    public JsonResult sort(String ids) {
        if (StringUtils.isNotEmpty(ids)) {
            String[] idArray = JSON.parseObject(StringEscapeUtils.unescapeHtml4(ids), String[].class);
            for (int i = 0; i < idArray.length; i++) {
                SysCarDealer sysCarDealer = sysCarDealerService.selectByPrimaryKey(idArray[i]);
                sysCarDealer.setSort(i);
                sysCarDealerService.updateByPrimaryKey(sysCarDealer);
            }
        }
        return new JsonResult();
    }
}