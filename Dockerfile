ARG BUILD_FROM
FROM $BUILD_FROM

# Install requirements for add-on
RUN \
  apk add --no-cache \
    wireguard-tools \
    openssh \
    rsync \
    nano \
    jq

COPY rootfs /
