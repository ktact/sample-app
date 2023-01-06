# ビルドステージ
FROM node:18.12 AS build-stage

USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# 依存関係をコピーし、すべての依存関係をインストールする
COPY --chown=node:node package.json package-lock.json ./
RUN npm install --omit=dev --no-progress

# ソースコードをコピーする
COPY --chown=node:node index.ts tsconfig.json ./

# ビルド
RUN npm install typescript
RUN npx tsc

# ランタイムステージ
FROM node:18.12-alpine

# PID1問題に対応する
RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]

USER node
WORKDIR /home/node/app

EXPOSE 3000
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV NODE_ENV prod

# ビルドステージの成果物をコピーする
COPY --from=build-stage /home/node/app/node_modules ./node_modules
COPY --from=build-stage /home/node/app/dist ./dist

CMD ["node", "dist/index.js"]
