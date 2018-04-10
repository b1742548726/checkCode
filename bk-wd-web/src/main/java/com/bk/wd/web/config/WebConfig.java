package com.bk.wd.web.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration("webConfig")
public class WebConfig {

    @Value("${static.resources.url}")
    private String staticResourcesUrl;
    
    @Value("${dfs.http.server}")
    private String dfsHttpServer;

    public String getStaticResourcesUrl() {
        return staticResourcesUrl;
    }

    public void setStaticResourcesUrl(String staticResourcesUrl) {
        this.staticResourcesUrl = staticResourcesUrl;
    }

    public String getDfsHttpServer() {
        return dfsHttpServer;
    }

    public void setDfsHttpServer(String dfsHttpServer) {
        this.dfsHttpServer = dfsHttpServer;
    }
    
}
