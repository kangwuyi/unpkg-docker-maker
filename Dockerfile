# 使用官方的 Node.js 镜像作为基础镜像
FROM node:18.20.4-alpine AS unpkg

# 创建和设置工作目录
WORKDIR /usr/src/app

# 将本地的 unpkg.tgz 文件复制到容器中
ADD unpkg.tgz /usr/src/app

# 重命名
RUN mv package unpkg

# 设置工作目录到 unpkg
WORKDIR /usr/src/app/unpkg

# 安装依赖
RUN npm install --force

# 设置要暴露的端口
EXPOSE 8899

# 直接运行 unpkg 的启动脚本
# CMD ["node", "start.js"]  # 替换 start.js 为实际的启动文件

# 使用 PM2 运行 unpkg
CMD ["pm2-runtime", "ecosystem.config.js"]