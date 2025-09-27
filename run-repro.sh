#!/usr/bin/env bash

set -euo pipefail

set -x

mkdir -p output
docker run --rm \
    --mount type=bind,src=./repro.sh,dst=/tmp/repro.sh \
    --mount type=bind,src=./project,dst=/home/ubuntu/project \
    --mount type=bind,src=./output,dst=/tmp/output \
    --env MISE_GITHUB_TOKEN \
    temp-mise-shim-issue \
    bash /tmp/repro.sh
