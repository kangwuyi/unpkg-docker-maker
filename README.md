## fork unpkg

通用用法 https://unpkg.com/，但不支持元数据 API 等。

## 一个小工具

用来扩展 Verdaccio 

命令顺序
```bash
pnpm install
```
执行测试之前，需要先把 npm 源更换为官方源
```bash
vi packages/unpkg-files/src/lib/request-handler.ts
## // const publicNpmRegistry = "https://registry.npmjs.org";
```
执行测试命令

```bash
pnpm test
```

## useage

file list, eq:
```
http://localhost:8899/list/react@19.1.0/
```

## 镜像上传
https://hub.docker.com/

```bash
sudo docker build -f ./Dockerfile -t unpkg-serve:test .
sudo docker login
sudo docker push kangwuyi/unpkg-serve:test
```