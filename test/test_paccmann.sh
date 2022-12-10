#!/bin/bash
set -x

GPUID="${1:-"2"}"

IHOME=/home/brettin/Singularity
CONTAINER="Paccmann_MCA-Paccmann_MCA:0.0.1-20221209"
MODEL_FILE="paccmann_mca_params.txt"

singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir ${MODEL_FILE}
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir --config_file ${MODEL_FILE}
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir ${MODEL_FILE} --experiment_id EXP001 --run_id RUN001

