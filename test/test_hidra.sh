#!/bin/bash
set -x

GPUID="${1:-"0"}"

IHOME=/home/brettin/Singularity
CONTAINER="HiDRA-HiDRA:0.0.1-20221209"
MODEL_FILE="hidra_default_model.txt"

singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir ${MODEL_FILE}
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir --config_file ${MODEL_FILE}
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh $GPUID /candle_data_dir ${MODEL_FILE} --experiment_id 001 --run_id 001

