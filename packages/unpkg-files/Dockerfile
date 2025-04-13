# syntax = docker/dockerfile:1

# Use Node.js for the build image
FROM node:23 AS build

# 创建和设置工作目录
WORKDIR /app

# 挂代理
RUN mkdir -p /etc/apt/apt.conf.d/
RUN echo 'Acquire::http::proxy "http://192.168.51.34:808/";\nAcquire::https::proxy "http://192.168.51.34:808/";' >> /etc/apt/apt.conf.d/proxy.conf
RUN export APT_CONFIG=/etc/apt/apt.conf.d/proxy.conf

# Install packages needed to build node modules
RUN apt-get update -qq
RUN apt-get install --no-install-recommends -y build-essential node-gyp pkg-config python-is-python3

# Install pnpm
RUN npm install -g pnpm@10.7.0

# 复制项目文件
# COPY . .
# Copy workspace configuration files
COPY .npmrc package.json pnpm-workspace.yaml ./
COPY packages/unpkg-files/package.json ./packages/unpkg-files/
COPY packages/unpkg-worker/package.json ./packages/unpkg-worker/

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy application code
COPY packages/unpkg-files ./packages/unpkg-files/
COPY packages/unpkg-worker ./packages/unpkg-worker/

# Build all packages
RUN pnpm run build

# Create production deploy
RUN pnpm --filter unpkg-files deploy --prod dist-files

########
##############
###############
######

# https://bun.sh/
FROM oven/bun:latest AS unpkg
LABEL fly_launch_runtime="Bun"

# 创建和设置工作目录
WORKDIR /usr/src/app


ENV DEBUG=1

ARG MODE=production
ENV MODE=$MODE

# Copy built application
COPY --from=build /app/dist-files /usr/src/app

# 安装依赖
# RUN bun install --global pnpm -g
# 挂代理
# RUN export HTTP=http://192.168.51.34:808
# RUN export HTTPS=http://192.168.51.34:808
# RUN pnpm install
# RUN pnpm run build

# 设置要暴露的端口
EXPOSE 8899

# 直接运行 unpkg 的启动脚本
# CMD ["pnpm", "run", "serve"]
CMD [ "bun", "./dist/server.js" ]
