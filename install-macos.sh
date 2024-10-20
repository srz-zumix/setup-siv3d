#!/bin/bash
set -euo pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${SIV3D_INSTALLDIR}"

SIV3D=${SIV3D_INSTALLDIR}/siv3d_${VERSION}_macOS
SIV3D_ENV_VERSION_NUMBER="${VERSION#v}"
SIV3D_ENV_VERSION_NAME_FULL="${SIV3D_ENV_VERSION_NUMBER//./_}"
SIV3D_ENV_VERSION_NAME_MAJOR_MINOR="${SIV3D_ENV_VERSION_NAME_FULL%%_*}"
SIV3D_ENV_VERSION_NAME_MAJOR="${SIV3D_ENV_VERSION_NAME_MAJOR_MINOR%%_*}"

download() {
  echo '::group::📖 Download Siv3D ...'
  curl -sSL -o "${SIV3D_TEMPDIR}/siv3d_${VERSION}_macOS.zip" "https://siv3d.jp/downloads/Siv3D/siv3d_${VERSION}_macOS.zip"
  echo '::endgroup::'
  echo '::group::📖 Unarchive Siv3D ...'
  unzip "${SIV3D_TEMPDIR}/siv3d_${VERSION}_macOS.zip" -d "${SIV3D_INSTALLDIR}"
  echo '::endgroup::'
}

install() {
  if [ ! -f "${SIV3D}/lib/macos/libSiv3D.a" ]; then
    download
  fi
}

install

CPATH="${CPATH:-}:${SIV3D}/include:${SIV3D}/include/ThirdParty"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macos"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/boost"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/freetype"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/harfbuzz"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libgif"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libjpeg-turbo"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libogg"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libpng"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libtiff"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libvorbis"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libwebp"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/opencv"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/opus"
LIBRARY_PATH="${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/zlib"

{
  echo "SIV3D=${SIV3D}"
  echo "SIV3D_${SIV3D_ENV_VERSION_NAME_FULL}=${SIV3D}"
  echo "SIV3D_${SIV3D_ENV_VERSION_NAME_MAJOR_MINOR}=${SIV3D}"
  echo "SIV3D_${SIV3D_ENV_VERSION_NAME_MAJOR}=${SIV3D}"
  echo "CPATH=${CPATH:-}"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}"
} >> "${GITHUB_ENV:-/dev/null}"

echo "path=${SIV3D}" | tee -a "${GITHUB_OUTPUT:-/dev/null}"
