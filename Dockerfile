# OpenClaw Workspace Docker Image
# 完整的工作空间镜像，带所有配置和技能

FROM node:22-alpine AS builder

WORKDIR /workspace

# 复制整个 workspace
COPY . .

FROM node:22-alpine

# 安装运行时依赖
RUN apk add --no-cache \
    git \
    curl \
    bash \
    python3 \
    make \
    g++ \
    && rm -rf /var/cache/apk/*

# 安装 OpenClaw CLI
RUN npm install -g openclaw

# 设置工作目录
WORKDIR /root/.openclaw/workspace

# 复制 workspace 内容
COPY --from=builder /workspace /root/.openclaw/workspace

# 创建数据目录
RUN mkdir -p /root/.openclaw/data

# 暴露端口
EXPOSE 18789

# 启动网关
CMD ["openclaw", "gateway", "run"]
