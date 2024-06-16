#!/bin/bash
set -euox pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${SIV3D_INSTALLDIR}"
SIV3D_ENV_VERSION_NUMBER="${VERSION#v}"
SIV3D_ENV_VERSION_NAME="${SIV3D_ENV_VERSION_NUMBER//./_}"
SIV3D_IMAGE="ghcr.io/srz-zumix/setup-siv3d:${VERSION}"
SIV3D="${SIV3D_INSTALLDIR}/siv3d_${VERSION}_linux"
INSTALL_PATH="${INSTALL_PATH:-./usr/local}"

install_deps() {
  echo '::group::📖 Install dependencies ...'
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends \
    libasound2-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libcurl4-openssl-dev \
    libgtk-3-dev \
    libgif-dev \
    libglu1-mesa-dev \
    libmpg123-dev \
    libopencv-dev \
    libopus-dev \
    libopusfile-dev \
    libsoundtouch-dev \
    libturbojpeg0-dev \
    libvorbis-dev \
    libwebp-dev
  echo '::endgroup::'
}

install() {
  echo '::group::📖 Download Siv3D image ...'
  docker pull "${SIV3D_IMAGE}"
  echo '::endgroup::'
  echo '::group::📖 Copy Siv3D ...'
  docker run --rm -v "${SIV3D}:/siv3d" --entrypoint bash "${SIV3D_IMAGE}" -c "cp -RT /usr/local/lib /siv3d/lib && cp -RT /usr/local/include/Siv3D/ /siv3d/include"
  ls -l "${SIV3D}/lib"
  ls -l "${SIV3D}/include"
  sudo chown -R "$(id -u):$(id -g)" "${SIV3D}"
  sudo cp -RT "${SIV3D}/lib" "${INSTALL_PATH}"
  sudo cp -RT "${SIV3D}/include/" "${INSTALL_PATH}/include/Siv3D"
  ls "${INSTALL_PATH}/lib"
  ls "${INSTALL_PATH}/include/Siv3D"
  echo '::endgroup::'
}

install_deps

install

{
  echo "SIV3D=${SIV3D}"
  echo "SIV3D_${SIV3D_ENV_VERSION_NAME}=${SIV3D}"
} >> "${GITHUB_ENV:-/dev/null}"


echo "path=${SIV3D}" | tee -a "${GITHUB_OUTPUT:-/dev/null}"
