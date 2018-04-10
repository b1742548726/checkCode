package com.bk.wd.web.utils;
import java.io.File;
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bk.wd.model.view.ViewResolution;

import freemarker.template.Configuration;  
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class WordGenerator {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(WordGenerator.class);
    
    public static Template getTemplate(String template) {
        Configuration configuration = new Configuration(Configuration.VERSION_2_3_22);
        configuration.setDefaultEncoding("utf-8");
        try {
            configuration.setDirectoryForTemplateLoading(new File(System.getProperty("sys.root") + "WEB-INF/classes/META-INF/template"));
            return configuration.getTemplate(template +  ".ftl");
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
            throw new RuntimeException(e);
        }
    }

    private WordGenerator() {
        throw new AssertionError();
    }

    public static File createDoc(String template, Map<?, ?> dataMap) {
        String name = "/temp" + (int) (Math.random() * 100000) + ".doc";
        File f = new File(name);
        Template t = getTemplate(template);
        // 这个地方不能使用FileWriter因为需要指定编码类型否则生成的Word文档会因为有无法识别的编码而无法打开
        Writer w;
        try {
            w = new OutputStreamWriter(new FileOutputStream(f), "utf-8");
            t.process(dataMap, w);
            w.close();
        } catch (TemplateException | IOException e) {
            LOGGER.error(e.getMessage(), e);
        }
        return f;
    }
    
    public static void main(String[] args) throws IOException, TemplateException {
        ViewResolution resolution = new ViewResolution();
        resolution.setPost("测试科目");
        Map<String, Object> params = new HashMap<>();
        params.put("resolution", resolution);
        createDoc("resolution", params);
    }

}