#!/bin/bash
set -euo pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${SIV3D_INSTALLDIR}"

SIV3D_ENV_VERSION_NUMBER="${VERSION#v}"
SIV3D_ENV_VERSION_NAME="${SIV3D_ENV_VERSION_NUMBER//./_}"
SIV3D=${SIV3D_INSTALLDIR}/OpenSiv3D_SDK_${SIV3D_ENV_VERSION_NUMBER}

download() {
  echo '::group::📖 Download Siv3D ...'
  curl -sSL -o "${SIV3D_TEMPDIR}/OpenSiv3D_SDK_${SIV3D_ENV_VERSION_NUMBER}.zip" "https://siv3d.jp/downloads/Siv3D/manual/${SIV3D_ENV_VERSION_NUMBER}/OpenSiv3D_SDK_${SIV3D_ENV_VERSION_NUMBER}.zip"
  echo '::endgroup::'
  echo '::group::📖 Unarchive Siv3D ...'
  unzip "${SIV3D_TEMPDIR}/OpenSiv3D_SDK_${SIV3D_ENV_VERSION_NUMBER}.zip" -d "${SIV3D_INSTALLDIR}"
  echo '::endgroup::'
}

install() {
  if [ ! -f "${SIV3D}/lib/Windows/Siv3D.lib" ]; then
    download
  fi
}

install

{
  echo "SIV3D=${SIV3D}"
  echo "SIV3D_${SIV3D_ENV_VERSION_NAME}=${SIV3D}"
} >> "${GITHUB_ENV:-/dev/null}"

echo "path=${SIV3D}" | tee -a "${GITHUB_OUTPUT:-/dev/null}"
