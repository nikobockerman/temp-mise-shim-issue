#!/usr/bin/env bash

set -euo pipefail

set -x

docker build --progress=plain -t temp-mise-shim-issue .
