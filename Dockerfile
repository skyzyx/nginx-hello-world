# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM nginx:mainline-alpine

SHELL ["/bin/ash", "-euxo", "pipefail", "-c"]

# Informational
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM."

# Upgrade
RUN apk upgrade --update --no-cache

# Configure Nginx
RUN rm /etc/nginx/conf.d/*
COPY helloworld.conf /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html/
COPY run.sh /bin/
RUN chmod +x /bin/run.sh

# Run
EXPOSE 80
ENTRYPOINT ["/bin/run.sh"]
