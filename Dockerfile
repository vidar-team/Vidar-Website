FROM node:22-bookworm AS dep-builder

WORKDIR /app

# place ARG statement before RUN statement which need it to avoid cache miss
ARG USE_CHINA_NPM_REGISTRY=1
RUN \
    set -ex && \
    if [ "$USE_CHINA_NPM_REGISTRY" = 1 ]; then \
        echo 'use npm mirror' && \
        npm config set registry https://registry.npmmirror.com && \
        yarn config set registry https://registry.npmmirror.com; \
    fi;

COPY ./yarn.lock /app/
COPY ./package.json /app/
COPY ./poi.config.js /app/
COPY ./public /app/public
COPY ./src /app/src

RUN \
    set -ex && \
	ls && \
	yarn 

Run \
	set -ex && \
	cd /app/ && \
	yarn build
