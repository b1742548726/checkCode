package com.bk.wd.web.utils;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.http.HeaderIterator;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.cookie.CookieSpecProvider;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;  
import org.apache.http.entity.mime.content.FileBody;  
import org.apache.http.entity.mime.content.StringBody;

import org.apache.http.impl.cookie.BestMatchSpecFactory;
import org.apache.http.impl.cookie.BrowserCompatSpecFactory;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class TestHttpClient {

    // 创建CookieStore实例
    static CookieStore cookieStore = null;
    static HttpClientContext context = null;
    static String loginUrl = "http://localhost/login";
    static String testUrl = "http://localhost/sm/model/detail?modelId=517e893350844256892912b7f1730a82";
    static String uploadUrl = "http://localhost/sys/globalSetting/save";
    
    static String loginErrorUrl = "http://localhost/";

    public static void testLogin() throws Exception {
        System.out.println("----testLogin");
        HttpPost httpPost = new HttpPost(loginUrl);
        Map<String, String> parameterMap = new HashMap<>();
        parameterMap.put("username", "admin1");
        parameterMap.put("password", "admin");
        UrlEncodedFormEntity postEntity = new UrlEncodedFormEntity(getParam(parameterMap), "UTF-8");
        httpPost.setEntity(postEntity);
        System.out.println("request line:" + httpPost.getRequestLine());
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            // 执行post请求
            HttpResponse httpResponse = client.execute(httpPost);
            System.out.println(httpResponse.getAllHeaders().toString());
            if ( null != httpResponse.getFirstHeader("Location")) {
                String location = httpResponse.getFirstHeader("Location").getValue();
                if (location != null && location.startsWith(loginErrorUrl)) {
                    System.out.println("----loginError");
                }
            }
            
            printResponse(httpResponse);

            // 执行get请求
            System.out.println("----the same client");
            HttpGet httpGet = new HttpGet(testUrl);
            System.out.println("request line:" + httpGet.getRequestLine());
            HttpResponse httpResponse1 = client.execute(httpGet);
            printResponse(httpResponse1);

            // cookie store
            setCookieStore(httpResponse);
            // context
            setContext();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        
        try {
            testLogin();
            upload();
           /* testContext();
            testCookieStore();*/
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }

    public static void testContext() throws Exception {
        System.out.println("----testContext");
        // 使用context方式
        CloseableHttpClient client = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(testUrl);
        System.out.println("request line:" + httpGet.getRequestLine());
        try {
            // 执行get请求
            HttpResponse httpResponse = client.execute(httpGet, context);
            System.out.println("context cookies:" + context.getCookieStore().getCookies());
            printResponse(httpResponse);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                // 关闭流并释放资源
                client.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void testCookieStore() throws Exception {
        System.out.println("----testCookieStore");
        // 使用cookieStore方式
        CloseableHttpClient client = HttpClients.custom().setDefaultCookieStore(cookieStore).build();
        HttpGet httpGet = new HttpGet(testUrl);
        System.out.println("request line:" + httpGet.getRequestLine());
        try {
            // 执行get请求
            HttpResponse httpResponse = client.execute(httpGet);
            System.out.println("cookie store:" + cookieStore.getCookies());
            printResponse(httpResponse);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                // 关闭流并释放资源
                client.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    
    public static void printResponse(HttpResponse httpResponse) throws ParseException, IOException {
        // 获取响应消息实体
        HttpEntity entity = httpResponse.getEntity();
        // 响应状态
        System.out.println("status:" + httpResponse.getStatusLine());
        System.out.println("headers:");
        HeaderIterator iterator = httpResponse.headerIterator();
        while (iterator.hasNext()) {
            System.out.println("\t" + iterator.next());
        }
        // 判断响应实体是否为空
        if (entity != null) {
            String responseString = EntityUtils.toString(entity);
            System.out.println("response length:" + responseString.length());
            System.out.println("response content:" + responseString.replace("\r\n", ""));
        }
    }
    
    public static void setCookieStore(HttpResponse httpResponse) {
        System.out.println("----setCookieStore");
        cookieStore = new BasicCookieStore();
        // JSESSIONID
        String setCookie = httpResponse.getFirstHeader("Set-Cookie").getValue();
        String JSESSIONID = setCookie.substring("JSESSIONID=".length(), setCookie.indexOf(";"));
        System.out.println("JSESSIONID:" + JSESSIONID);
        // 新建一个Cookie
        BasicClientCookie cookie = new BasicClientCookie("JSESSIONID", JSESSIONID);
        cookie.setVersion(0);
        cookie.setDomain("127.0.0.1");
        cookie.setPath("/CwlProClient");
        // cookie.setAttribute(ClientCookie.VERSION_ATTR, "0");
        // cookie.setAttribute(ClientCookie.DOMAIN_ATTR, "127.0.0.1");
        // cookie.setAttribute(ClientCookie.PORT_ATTR, "8080");
        // cookie.setAttribute(ClientCookie.PATH_ATTR, "/CwlProWeb");
        cookieStore.addCookie(cookie);
    }
    
    public static void setContext() {
        System.out.println("----setContext");
        context = HttpClientContext.create();
        Registry<CookieSpecProvider> registry = RegistryBuilder.<CookieSpecProvider>create()
                .register(CookieSpecs.BEST_MATCH, new BestMatchSpecFactory())
                .register(CookieSpecs.BROWSER_COMPATIBILITY, new BrowserCompatSpecFactory()).build();
        context.setCookieSpecRegistry(registry);
        context.setCookieStore(cookieStore);
    }
    
    
    public static List<NameValuePair> getParam(Map parameterMap) {
        List<NameValuePair> param = new ArrayList<NameValuePair>();
        Iterator it = parameterMap.entrySet().iterator();
        while (it.hasNext()) {
            Entry parmEntry = (Entry) it.next();
            param.add(new BasicNameValuePair((String) parmEntry.getKey(), (String) parmEntry.getValue()));
        }
        return param;
    }
    
    
    /** 
     * 上传文件 
     */  
    public static void upload() {  
        try (CloseableHttpClient httpclient = HttpClients.createDefault()) {  
            HttpPost httppost = new HttpPost(uploadUrl);  
  
            FileBody bin = new FileBody(new File("D:\\2.jpg"));  
            StringBody comment = new StringBody("A binary file of some kind", ContentType.TEXT_PLAIN);  
            HttpEntity reqEntity = MultipartEntityBuilder.create().addPart("loginPhotoFile", bin).addPart("comment", comment).build();  
  
            httppost.setEntity(reqEntity);  
  
            System.out.println("executing request " + httppost.getRequestLine());  
            CloseableHttpResponse response = httpclient.execute(httppost);  
            try  {  
                System.out.println("----------------------------------------");  
                System.out.println(response.getStatusLine());  
                HttpEntity resEntity = response.getEntity();  
                if (resEntity != null) {  
                    System.out.println("Response content length: " + resEntity.getContentLength());  
                }  
                EntityUtils.consume(resEntity);  
            } finally {  
                response.close();  
            }  
        } catch (ClientProtocolException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }
    }  
}