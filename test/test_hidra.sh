#!/bin/bash
set -x

GPUID="${1:-"0"}"

IHOME=/home/brettin/Singularity
BUILD_DATE="20221210"
CONTAINER="HiDRA-HiDRA:0.0.1-$BUILD_DATE"
MODEL_FILE="hidra_default_model.txt"

singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir ${MODEL_FILE}
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir --config_file ${MODEL_FILE}
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir ${MODEL_FILE} --experiment_id EXP001 --run_id RUN001

