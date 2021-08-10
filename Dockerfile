#
# Megabasterd Dockerfile
#
#

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.12-v3.5.7

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=unknown

# Define software download URLs.
ARG JDOWNLOADER_URL=https://github.com/tonikelope/megabasterd/releases/download/v7.42/MegaBasterd_7.42.jar

# Define working directory.
WORKDIR /tmp

# Download JDownloader 2.
RUN \
    add-pkg --virtual build-dependencies \
        curl \
        && \
    mkdir -p /defaults && \
    # Download.
    curl -# -L -o /defaults/JDownloader.jar ${JDOWNLOADER_URL} && \
    # Cleanup.
    del-pkg build-dependencies && \
    rm -rf /tmp/* /tmp/.[!.]*

# Install dependencies.
RUN \
    add-pkg \
        openjdk8-jre \
        libstdc++ \
        ttf-dejavu \
        # For ffmpeg and ffprobe tools.
        ffmpeg \
        # For rtmpdump tool.
        rtmpdump

# Maximize only the main/initial window.
RUN \
    sed-patch 's/<application type="normal">/<application type="normal" title="Megabasterd">/' \
        /etc/xdg/openbox/rc.xml

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/tonikelope/megabasterd/blob/master/src/main/resources/images/mbasterd_logo_git.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /

# Set environment variables.
ENV APP_NAME="Megabasterd" \
    S6_KILL_GRACETIME=8000

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/output"]

# Expose ports.
#   - 3129: For MyJDownloader in Direct Connection mode.
EXPOSE 3129

# Metadata.
LABEL \
      org.label-schema.name="megabasterd" \
      org.label-schema.description="Docker container for Megabasterd" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-jdownloader-2" \
      org.label-schema.schema-version="1.0"
