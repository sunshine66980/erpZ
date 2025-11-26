package com.ruoyi.framework.config;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;
import com.ruoyi.common.utils.ServletUtils;

/**
 * 服务相关配置
 * 
 * @author ruoyi
 */
@Component
public class ServerConfig
{
    /**
     * 获取完整的请求路径，包括：域名，端口，上下文访问路径
     * 
     * @return 服务地址
     */
    public String getUrl()
    {
        HttpServletRequest request = ServletUtils.getRequest();
        return getDomain(request);
    }

    public static String getDomain(HttpServletRequest request)
    {
        String scheme = request.getHeader("X-Forwarded-Proto");
        if (scheme == null) {
            scheme = request.getScheme();
        }
        
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        String contextPath = request.getServletContext().getContextPath();
        
        StringBuilder url = new StringBuilder();
        url.append(scheme).append("://").append(serverName);
        
        // 检查是否使用标准端口
        boolean isStandardPort = ("http".equals(scheme) && serverPort == 80) || 
                               ("https".equals(scheme) && serverPort == 443);
        
        if (!isStandardPort) {
            url.append(":").append(serverPort);
        }
        
        url.append(contextPath);
        return url.toString();
    }
}
