package com.bk.wd.test;

import java.io.IOException;
import java.util.Date;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bk.common.service.DfsService;
import com.bk.common.utils.DateUtils;
import com.bk.wd.service.WdApplicationPhotoService;


public class TestService extends BaseSpringTest {
	
    private static final Logger LOGGER = LoggerFactory.getLogger(TestService.class);
    
    @Autowired
    private DfsService dfsService;
    
    @Autowired
    private WdApplicationPhotoService wdApplicationPhotoService;
    
    private final static String applicationId = "eeb33e2b4a5b4acda3b94a71646d9067";

    @Test
    public void testIncrease() throws IOException {
        System.out.println(DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
    }
    
}
