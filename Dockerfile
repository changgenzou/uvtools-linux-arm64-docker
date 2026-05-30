FROM ubuntu:24.04

ARG UVTOOLS_ZIP=dist/uvtools-linux-arm64-v6.0.3.zip

LABEL org.opencontainers.image.title="UVtools Linux ARM64"
LABEL org.opencontainers.image.description="Ubuntu-based container image with UVtools v6.0.3 for linux-arm64"
LABEL org.opencontainers.image.source="https://github.com/sn4k3/UVtools"
LABEL org.opencontainers.image.licenses="AGPL-3.0-or-later"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       fontconfig \
       libicu74 \
       libfontconfig1 \
       libice6 \
       libsm6 \
       libx11-6 \
       libxext6 \
       libxrender1 \
       unzip \
    && rm -rf /var/lib/apt/lists/*

COPY ${UVTOOLS_ZIP} /tmp/uvtools.zip

RUN mkdir -p /opt/uvtools \
    && unzip -q /tmp/uvtools.zip -d /opt/uvtools \
    && chmod +x /opt/uvtools/UVtools /opt/uvtools/UVtoolsCmd /opt/uvtools/UVtools.sh \
    && ln -sf /opt/uvtools/UVtoolsCmd /usr/local/bin/uvtoolscmd \
    && ln -sf /opt/uvtools/UVtools /usr/local/bin/uvtools \
    && rm /tmp/uvtools.zip

WORKDIR /workspace

CMD ["uvtoolscmd", "--help"]
