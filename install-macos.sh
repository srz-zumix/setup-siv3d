#!/bin/bash
set -euo pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${SIV3D_INSTALLDIR}"

download() {
  echo '::group::📖 Download siv3d ...'
  curl -sSL -o "${SIV3D_TEMPDIR}/siv3d_${INPUTS_VERSION}_macOS.zip" "https://siv3d.jp/downloads/Siv3D/siv3d_${INPUTS_VERSION}_macOS.zip"
  echo '::endgroup::'
  echo '::group::📖 Unarchive siv3d ...'
  unzip "${SIV3D_TEMPDIR}/siv3d_${INPUTS_VERSION}_macOS.zip" -d "${SIV3D_INSTALLDIR}"
  echo '::endgroup::'
}

install() {
  if [ ! -f "${SIV3D_INSTALLDIR}/siv3d_${INPUTS_VERSION}_macOS/lib/macos/libSiv3D.a" ]; then
    download
  fi
}

install

{
  echo "SIV3D=${SIV3D_INSTALLDIR}/siv3d_${INPUTS_VERSION}_macOS"
  echo "CPATH=${CPATH:-}:${SIV3D}/include:${SIV3D}/include/ThirdParty"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macos"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/boost"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/freetype"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/harfbuzz"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libgif"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libjpeg-turbo"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libogg"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libpng"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libtiff"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libvorbis"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/libwebp"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/opencv"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/opus"
  echo "LIBRARY_PATH=${LIBRARY_PATH:-}:${SIV3D}/lib/macOS/zlib"
} >> "${GITHUB_ENV:-/dev/null}"

