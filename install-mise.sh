#!/usr/bin/env bash

set -euo pipefail

set -x

miseBinDir=${MISE_BIN_DIR}
miseVersion=${MISE_VERSION}

if [ -z "${miseBinDir}" ]; then
    echo "MISE_BIN_DIR is not set"
    exit 1
fi

if [ -z "${miseVersion}" ]; then
    echo "MISE_VERSION is not set"
    exit 1
fi

miseBinPath="${miseBinDir}/mise"

ext=.tar.zst
# Remove possible leading 'v'
resolvedVersion=${miseVersion#v}

arch=$(uname -m)
if [[ "${arch}" = "aarch64" ]]; then
    arch="arm64"
fi
url=https://github.com/jdx/mise/releases/download/v${resolvedVersion}/mise-v${resolvedVersion}-linux-${arch}${ext}

curl -fsSL "${url}" | tar --zstd -xf - -C /tmp

mv /tmp/mise/bin/mise "${miseBinPath}"
rm -rf /tmp/mise

chmod +x "${miseBinPath}"
