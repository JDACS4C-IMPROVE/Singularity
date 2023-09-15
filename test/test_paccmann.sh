#!/bin/bash
<<<<<<< HEAD

# Load global config
SCRIPT_DIR=$(dirname "$0")
CONFIG_DIR=${SCRIPT_DIR}/../config/
source ${CONFIG_DIR}/improve.env

GPUID="${1:-"2"}"
BUILD_DATE=${BUILD_DATE:-"20221210"}

# IHOME=/home/brettin/Singularity
# IMPROVE_DATA_DIR=/home/brettin/improve_data_dir

CONTAINER="Paccmann_MCA-Paccmann_MCA:0.0.1-$BUILD_DATE"
MODEL_FILE="paccmann_mca_params.txt"

singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ cp /usr/local/Paccmann_MCA/$MODEL_FILE /candle_data_dir

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir ${MODEL_FILE}

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir --config_file ${MODEL_FILE}

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir ${MODEL_FILE} --experiment_id EXP001 --run_id RUN001

echo "$(date +%Y-%m-%d" "%H:%M:%S) DONE"
=======
set -x

GPUID="${1:-"2"}"

IHOME=/home/brettin/Singularity
CONTAINER="Paccmann_MCA-Paccmann_MCA:0.0.1-20221209"
MODEL_FILE="paccmann_mca_params.txt"

singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir ${MODEL_FILE}
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir --config_file ${MODEL_FILE}
singularity exec --nv --bind /home/brettin/improve_data_dir:/candle_data_dir $IHOME/sandboxes/${CONTAINER}/ train.sh 3 /candle_data_dir ${MODEL_FILE} --experiment_id EXP001 --run_id RUN001

>>>>>>> master
