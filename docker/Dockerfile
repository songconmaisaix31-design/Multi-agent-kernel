FROM node:24.16.0-bookworm-slim@sha256:ca520832af80fa37a57c14077ed0fcdd83b5aefccc356059fdc3a9a05b78ae1f

RUN node -e "require('fs').writeFileSync('/tmp/build-ca.pem', require('tls').rootCertificates.join('\n'))" \
    && sed -i 's|http://deb.debian.org|https://deb.debian.org|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get -o Acquire::https::CaInfo=/tmp/build-ca.pem -o Acquire::Retries=1 -o Acquire::https::Timeout=30 update \
    && apt-get -o Acquire::https::CaInfo=/tmp/build-ca.pem -o Acquire::Retries=1 -o Acquire::https::Timeout=30 install -y --no-install-recommends \
    ca-certificates curl dbus-x11 git openssh-client procps util-linux xvfb \
    libasound2 libatk-bridge2.0-0 libgtk-3-0 libnss3 libgbm1 libdrm2 \
    libxss1 libxtst6 libx11-xcb1 libsecret-1-0 libnotify4 \
    && rm -f /tmp/build-ca.pem && rm -rf /var/lib/apt/lists/*

COPY --from=orca_asset orca-linux.AppImage /opt/orca/orca-linux.AppImage
RUN echo '2e70cb5e199741e5602a7060825575319f5e03bc2faa4b89cd27328f3f55d4b4  /opt/orca/orca-linux.AppImage' | sha256sum -c - \
    && chmod 755 /opt/orca/orca-linux.AppImage \
    && cd /opt/orca && ./orca-linux.AppImage --appimage-extract >/dev/null \
    && find /opt/orca/squashfs-root -type d -exec chmod 755 {} + \
    && chmod 4755 /opt/orca/squashfs-root/chrome-sandbox \
    && rm /opt/orca/orca-linux.AppImage \
    && mkdir -p /home/node/.codex /home/node/projects \
    && chown -R node:node /home/node

ENV HOME=/home/node \
    CODEX_HOME=/home/node/.codex \
    LIBGL_ALWAYS_SOFTWARE=1
USER node
WORKDIR /home/node
ENTRYPOINT ["/opt/orca/squashfs-root/orca-ide"]
CMD ["serve", "--port", "6768", "--no-pairing", "--json"]
