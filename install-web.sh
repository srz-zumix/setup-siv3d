#!/bin/bash
set -euo pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${SIV3D_INSTALLDIR}"

SIV3D=${SIV3D_INSTALLDIR}/OpenSiv3D-wasm-${VERSION}
SIV3D_ENV_VERSION_NUMBER="${VERSION#v}"
SIV3D_ENV_VERSION_NAME="${SIV3D_ENV_VERSION_NUMBER//./_}"

download() {
  echo '::group::📖 Download Siv3D ...'
  curl -sSL -o "${SIV3D_TEMPDIR}/OpenSiv3D-wasm.tgz" "https://github.com/nokotan/OpenSiv3D/releases/download/${VERSION}/OpenSiv3D-wasm.tgz"
  echo '::endgroup::'
  echo '::group::📖 Unarchive Siv3D ...'
  tar -xvf "${SIV3D_TEMPDIR}/OpenSiv3D-wasm.tgz"
  mv Package "${SIV3D}"
  echo '::endgroup::'
}

install() {
  if [ ! -f "${SIV3D}/lib/libSiv3D.a" ]; then
    download
  fi
}

install

{
  echo "SIV3D=${SIV3D}"
  echo "SIV3D_${SIV3D_ENV_VERSION_NAME}=${SIV3D}"
} >> "${GITHUB_ENV:-/dev/null}"

echo "path=${SIV3D}" | tee -a "${GITHUB_OUTPUT:-/dev/null}"
