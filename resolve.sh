#!/bin/bash
set -euo pipefail

VERSION="${INPUTS_VERSION:-latest}"

versions() {
  curl -sSL --retry 5 --retry-delay 1 https://api.github.com/repos/Siv3D/OpenSiv3D/tags | jq -r .[].name | sort -V
}

resolve_version() {
  if [ "${VERSION}" == 'latest' ]; then
    VERSION=$(versions | tail -1)
  else
    VERSION=$(versions | grep "^${VERSION}\$" | tail -1)
  fi
}

if [ "${VERSION}" == 'latest' ] || (echo "${VERSION}" | grep '[*]'); then
  echo '::group::📖 Resolve siv3d version ...'
  resolve_version
  echo '::endgroup::'
fi

echo "version=${VERSION}" | tee -a "${GITHUB_OUTPUT:-/dev/null}"

SIV3D_TEMPDIR="${INPUTS_SIV3D_TEMPDIR:-}"
if [ -z "${SIV3D_TEMPDIR}" ]; then
  if [ -n "${RUNNER_TEMP:-}" ]; then
    SIV3D_TEMPDIR="${RUNNER_TEMP:-}"
  else
    SIV3D_TEMPDIR="$(mktemp -d)"
  fi
fi

SIV3D_INSTALLDIR="${RUNNER_TOOL_CACHE:-${SIV3D_TEMPDIR}}/siv3d/${VERSION}"

echo "path=${SIV3D_INSTALLDIR}" | tee -a "${GITHUB_OUTPUT:-/dev/null}"
