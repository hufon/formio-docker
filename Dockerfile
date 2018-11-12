FROM node:10-alpine
LABEL maintainer="Hubert FONGARNAND"

### Disable Build in Services
    ENV FORMIO_VERSION=v1.36.1 \
        FORMIO_CLIENT_VERSION=master \
        ENABLE_SMTP=FALSE \
        ENABLE_CRON=FALSE

### Install Runtime Dependencies
    RUN apk update && \
        apk add \
            expect \
            git \
            g++ \
            jq \
            make \
            python \
            && \
        \
        git clone -b $FORMIO_VERSION https://github.com/formio/formio.git /app/ && \
        git clone -b $FORMIO_CLIENT_VERSION https://github.com/formio/formio-app-formio.git /app/client && \
        \
        cd /app && \
        npm install && \

### Misc & Cleanup
        mkdir -p /app/templates && \
        rm -rf /tmp/* \
        /var/cache/apk/*

    WORKDIR /app/

### Networking Configuration
    EXPOSE 3001 

EXPOSE 3001
CMD [ "npm", "start" ]