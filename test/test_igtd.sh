#!/bin/bash

GPUID="${1:-"6"}"
BUILD_DATE=${BUILD_DATE:-"20221210"}

IHOME=/home/brettin/Singularity
IMPROVE_DATA_DIR=/home/brettin/improve_data_dir

CONTAINER="IGTD-IGTD:0.0.1-$BUILD_DATE"
MODEL_FILE="Default_Params.txt"

singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ cp /usr/local/IGTD/$MODEL_FILE /candle_data_dir

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir ${MODEL_FILE}

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir --config_file ${MODEL_FILE}

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir ${MODEL_FILE} --experiment_id EXP001 --run_id RUN001

echo "$(date +%Y-%m-%d" "%H:%M:%S) DONE"

