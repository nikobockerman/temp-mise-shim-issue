#!/usr/bin/env bash

set -euo pipefail


miseDataDir=${MISE_DATA_DIR}

if [ -z "${miseDataDir}" ]; then
    echo "MISE_DATA_DIR is not set"
    exit 1
fi

set -x

#export MISE_ALWAYS_KEEP_DOWNLOAD=1
export MISE_AQUA_GITHUB_ATTESTATIONS=0

#export MISE_DEBUG=1
export MISE_TRACE=1
export MISE_COLOR=1


for i in $(seq 1 100); do
    # Delete all but downloads
    #find "${miseDataDir}" -mindepth 1 -maxdepth 1 -type d -not -name "downloads" -exec rm -rf {} \;
    #ls -la "${miseDataDir}"
    rm -r "${miseDataDir}"
    mkdir -p "${miseDataDir}"

    # Install tools
    printf '\n\n\n\n\n\n\n\n\n'
    echo "Iteration $i"
    pushd "${HOME}/project"
    mise upgrade 2>/tmp/output/trace.log
    popd

    # Verify shims
    ls -la "${miseDataDir}/shims"
    for shim in pip pip3 pip3.13 prettier pydoc3 pydoc3.13 python python3 python3-config python3.13 python3.13-config uv uvx; do
        if [ ! -f "${miseDataDir}/shims/${shim}" ]; then
            echo "${shim} shim not found"

            unset MISE_TRACE
            mise doctor 2>&1 | tee /tmp/output/doctor.log

            export MISE_TRACE=1
            mise reshim 2>/tmp/output/reshim.log
            if [ -f "${miseDataDir}/shims/${shim}" ]; then
                echo "${shim} shim found after reshim"
            else
                echo "${shim} shim not found after reshim"
            fi
            exit 1
        fi
    done
done
