FROM node:24.16.0-bookworm-slim@sha256:ca520832af80fa37a57c14077ed0fcdd83b5aefccc356059fdc3a9a05b78ae1f

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git openssh-client procps util-linux xvfb \
    libasound2 libatk-bridge2.0-0 libgtk-3-0 libnss3 libgbm1 libdrm2 \
    libxss1 libxtst6 libx11-xcb1 libsecret-1-0 libnotify4 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=orca_asset orca-linux.AppImage /opt/orca/orca-linux.AppImage
RUN echo '2e70cb5e199741e5602a7060825575319f5e03bc2faa4b89cd27328f3f55d4b4  /opt/orca/orca-linux.AppImage' | sha256sum -c - \
    && chmod 755 /opt/orca/orca-linux.AppImage \
    && cd /opt/orca && ./orca-linux.AppImage --appimage-extract >/dev/null \
    && rm /opt/orca/orca-linux.AppImage \
    && mkdir -p /home/node/.codex /home/node/projects \
    && chown -R node:node /home/node

ENV HOME=/home/node \
    CODEX_HOME=/home/node/.codex \
    LIBGL_ALWAYS_SOFTWARE=1
USER node
WORKDIR /home/node
ENTRYPOINT ["/opt/orca/squashfs-root/AppRun"]
CMD ["serve", "--port", "6768", "--json"]
