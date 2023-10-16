#!/bin/bash
set -x

echo "logging into new container"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../config/run.config"
singularity shell --nv --fakeroot --writable $1
