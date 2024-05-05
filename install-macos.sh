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

echo "SIV3D=${SIV3D_INSTALLDIR}/siv3d_${INPUTS_VERSION}_macOS" >> "${GITHUB_ENV:-/dev/null}"
echo "CPATH=${CPATH}:${SIV3D}/include:${SIV3D}/include/ThirdParty" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macos" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/boost" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/freetype" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/harfbuzz" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/libgif" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/libjpeg-turbo" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/libogg" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/libpng" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/libtiff" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/libvorbis" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/libwebp" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/opencv" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/opus" >> "${GITHUB_ENV:-/dev/null}"
echo "LIBRARY_PATH=${LIBRARY_PATH}:${SIV3D}/lib/macOS/zlib" >> "${GITHUB_ENV:-/dev/null}"
