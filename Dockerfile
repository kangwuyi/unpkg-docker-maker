# 使用官方的 Node.js 镜像作为基础镜像
FROM node:23 AS unpkg

# 创建和设置工作目录
WORKDIR /usr/src/app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm install pnpm bun -g
RUN pnpm install
RUN pnpm run build

# 复制项目文件
COPY . .

# 设置要暴露的端口
EXPOSE 8899

ENV MODE='production'
# 直接运行 unpkg 的启动脚本
CMD ["npm", "run", "serve"]
