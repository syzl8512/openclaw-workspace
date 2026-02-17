# OpenClaw Workspace Docker Image
# 基于官方 OpenClaw 镜像，预先配置好工作空间

FROM node:22-alpine AS builder

# 安装构建工具
RUN apk add --no-cache git

WORKDIR /workspace

# 复制 package.json（如果有）
# COPY package*.json ./

# 安装依赖
# RUN npm install

FROM node:22-alpine

# 安装运行时依赖
RUN apk add --no-cache \
    git \
    curl \
    bash \
    python3 \
    make \
    g++

# 安装 OpenClaw CLI
RUN npm install -g openclaw

# 创建工作目录
RUN mkdir -p /root/.openclaw/workspace

# 复制工作空间文件
COPY --from=builder /workspace /root/.openclaw/workspace

# 设置工作目录
WORKDIR /root/.openclaw/workspace

# 初始化 OpenClaw 配置（如果需要）
# RUN openclaw config set ...

# 暴露端口
EXPOSE 18789

# 启动命令
CMD ["openclaw", "gateway", "run"]
