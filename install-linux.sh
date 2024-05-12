#!/bin/bash
set -euox pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${SIV3D_INSTALLDIR}"
SIV3D_IMAGE="ghcr.io/srz-zumix/setup-siv3d:${VERSION}"
SIV3D=${SIV3D_INSTALLDIR}/siv3d_${VERSION}_linux
INSTALL_PATH="${INSTALL_PATH:-./usr/local}"

install() {
  echo '::group::📖 Download Siv3D image ...'
  docker pull "${SIV3D_IMAGE}"
  echo '::endgroup::'
  echo '::group::📖 Copy Siv3D ...'
  docker run --rm -v "${SIV3D}:/siv3d" --entrypoint bash "${SIV3D_IMAGE}" -c "cp -r /usr/local/lib /siv3d/lib && cp -r /usr/local/include /siv3d/include"
  ls "${SIV3D}/lib"
  ls "${SIV3D}/include"
  sudo chown -R "$(id -u):$(id -g)" "${SIV3D}"
  cp -r "${SIV3D}" "${INSTALL_PATH}"
  ls "${INSTALL_PATH}/lib"
  ls "${INSTALL_PATH}/include"
  echo '::endgroup::'
}

install
