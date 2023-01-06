# ビルドステージ
FROM node:18.12 AS build-stage

# 依存関係をコピーし、すべての依存関係をインストールする
COPY package*.json ./
RUN npm install

# ソースコードをコピーする
COPY index.ts ./
COPY tsconfig.json ./

# ビルド
RUN npx tsc

# ランタイムステージ
FROM node:18.12-alpine

EXPOSE 3000

COPY package*.json ./
RUN npm install

# ビルドステージの成果物をコピーする
COPY --from=build-stage ./dist ./dist

CMD ["node", "dist/index.js"]
