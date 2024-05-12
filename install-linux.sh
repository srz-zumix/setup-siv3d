#!/bin/bash
set -euo pipefail

source "${GITHUB_ACTION_PATH:-.}/resolve.sh"

mkdir -p "${SIV3D_INSTALLDIR}"
SIV3D_IMAGE="ghcr.io/srz-zumix/setup-siv3d:${INPUTS_VERSION}"

install() {
  echo '::group::📖 Download Siv3D image ...'
  docker pull "${SIV3D_IMAGE}"
  echo '::endgroup::'
  echo '::group::📖 Copy Siv3D ...'
  docker run -it --rm -v "${SIV3D_INSTALLDIR}:/siv3d" "${SIV3D_IMAGE}" cp -r /usr/local/lib /siv3d/lib && cp -r /usr/local/include /siv3d/include
  cp -r /siv3d/lib /usr/local/lib
  cp -r /siv3d/include /usr/local/include
  ls /usr/local/lib
  ls /usr/local/include
  echo '::endgroup::'
}

install
