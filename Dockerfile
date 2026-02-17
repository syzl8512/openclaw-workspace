# OpenClaw Workspace Docker Image
# 完整的工作空间镜像，带文档处理和数据分析技能

FROM node:22-alpine AS builder

WORKDIR /workspace

# 复制整个 workspace
COPY . .

# 安装 Python 依赖
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-pillow \
    && pip3 install --no-cache-dir "markitdown[pptx]"

# 安装 LibreOffice 和 Poppler
RUN apk add --no-cache \
    libreoffice \
    poppler-utils \
    && rm -rf /var/cache/apk/*

FROM node:22-alpine

# 安装运行时依赖
RUN apk add --no-cache \
    git \
    curl \
    bash \
    python3 \
    py3-pip \
    py3-pillow \
    libreoffice \
    poppler-utils \
    && rm -rf /var/cache/apk/*

# 安装 OpenClaw CLI
RUN npm install -g openclaw

# 安装 Node.js PPT 生成库
RUN npm install -g pptxgenjs

# 设置工作目录
WORKDIR /root/.openclaw/workspace

# 复制 workspace 内容
COPY --from=builder /root/.openclaw/workspace /root/.openclaw/workspace

# 创建数据目录
RUN mkdir -p /root/.openclaw/data

# 配置环境变量（API Keys）
ENV AMAP_API_KEY=85ce00fba0d657eb3138edc562b0183d

# 暴露端口
EXPOSE 18789

# 启动网关
CMD ["openclaw", "gateway", "run"]
