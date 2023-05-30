#!/bin/bash

# Load global config
SCRIPT_DIR=$(dirname "$0")
CONFIG_DIR=${SCRIPT_DIR}/../config/
source ${CONFIG_DIR}/improve.env

GPUID="${1:-"2"}"
BUILD_DATE=${BUILD_DATE:-"20221210"}

# IHOME=/home/brettin/Singularity
# IMPROVE_DATA_DIR=/home/brettin/improve_data_dir

CONTAINER="tCNNS-tCNNS:0.0.1-$BUILD_DATE"
MODEL_FILE="tcnns_default_model.txt"

singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ cp /usr/local/tCNNS-Project/$MODEL_FILE /candle_data_dir

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir ${MODEL_FILE}

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir --config_file ${MODEL_FILE}

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir ${MODEL_FILE} --experiment_id EXP001 --run_id RUN001

echo "$(date +%Y-%m-%d" "%H:%M:%S) DONE"
