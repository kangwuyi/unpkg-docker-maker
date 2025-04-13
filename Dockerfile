# 使用官方的 Node.js 镜像作为基础镜像
FROM node:23 AS unpkg

# 创建和设置工作目录
WORKDIR /usr/src/app

# 复制项目文件
COPY . .

# 安装依赖
RUN npm install pnpm bun -g

# 挂代理
# RUN export HTTP=http://192.168.51.34:808
# RUN export HTTPS=http://192.168.51.34:808

RUN pnpm install
RUN pnpm run build

# 设置要暴露的端口
EXPOSE 8899

ENV MODE='production'
# 直接运行 unpkg 的启动脚本
CMD ["npm", "run", "serve"]
