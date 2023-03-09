ARG BUILD_FROM
FROM $BUILD_FROM

# Install requirements for add-on
RUN \
  apk add --no-cache \
    wireguard-tools \
    openssh \
    rsync

# Copy data for add-on
#COPY run.sh /
#RUN chmod a+x /run.sh

#CMD [ "/run.sh" ]

COPY rootfs /