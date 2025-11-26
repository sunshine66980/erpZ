# 阶段1：使用Alpine基础镜像构建（体积更小且避免apt网络问题）
FROM eclipse-temurin:17-jdk-alpine AS builder

# 安装字体和依赖（Alpine使用apk）
RUN apk add --no-cache fontconfig ttf-dejavu && \
    fc-cache -fv

# 构建应用
WORKDIR /app
COPY jar/ruoyi-admin.jar .
COPY application-prod.yml ./config/
RUN mkdir -p /app/logs

# 阶段2：使用精简的JRE运行环境
FROM eclipse-temurin:17-jre-alpine

# 从builder阶段复制已安装的字体和配置
COPY --from=builder /usr/share/fonts /usr/share/fonts
COPY --from=builder /etc/fonts /etc/fonts
COPY --from=builder /app /app

# 环境变量
ENV TZ=Asia/Shanghai \
    JAVA_HOME=/opt/java/openjdk \
    PATH=$PATH:/opt/java/openjdk/bin \
    JAVA_OPTS="-Djava.awt.headless=true"

# 健康检查（Alpine自带wget，无需额外安装curl）
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget -q -O /dev/null http://localhost:48080/actuator/health || exit 1

# 启动命令
WORKDIR /app
EXPOSE 48080
CMD ["sh", "-c", "java $JAVA_OPTS -Dspring.profiles.active=prod -jar ruoyi-admin.jar --spring.config.location=/app/config/application-prod.yml"]