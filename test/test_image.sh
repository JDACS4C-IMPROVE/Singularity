#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

GPUID=$1
CONTAINER=$2
IMPROVE_DATA_DIR="${3:-"/tmp"}"

CMD="singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $$SCRIPT_DIR/../images/${CONTAINER}/ train.sh $GPUID /candle_data_dir"

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 

$CMD

echo "$(date +%Y-%m-%d" "%H:%M:%S) DONE"
