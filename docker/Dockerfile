FROM --platform=linux/amd64 ubuntu:22.04 as builder

ARG SIV3D_VERSION=main

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        wget \
        g++ \
        ninja-build \
        libasound2-dev \
        libavcodec-dev \
        libavformat-dev \
        libavutil-dev \
        libboost-dev \
        libcurl4-openssl-dev \
        libgtk-3-dev \
        libgif-dev \
        libglu1-mesa-dev \
        libharfbuzz-dev \
        libmpg123-dev \
        libopencv-dev \
        libopus-dev \
        libopusfile-dev \
        libsoundtouch-dev \
        libswresample-dev \
        libtiff-dev \
        libturbojpeg0-dev \
        libvorbis-dev \
        libwebp-dev \
        libxft-dev \
        uuid-dev \
        xorg-dev \
        cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Siv3D/OpenSiv3D.git -b "${SIV3D_VERSION}" /opt/OpenSiv3D
WORKDIR /tmp/build
RUN cmake -GNinja -DCMAKE_BUILD_TYPE=RelWithDebInfo /opt/OpenSiv3D/Linux \
    && cmake --build . \
    && cmake --install .

FROM --platform=linux/amd64 ubuntu:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/include/Siv3D /usr/local/include/Siv3D
COPY --from=builder /usr/local/lib/libSiv3D.a /usr/local/lib/libSiv3D.a
COPY --from=builder /usr/local/lib/cmake /usr/local/lib/cmake
    