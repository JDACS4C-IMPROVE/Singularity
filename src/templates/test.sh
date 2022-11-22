#!/bin/bash

# arg 1 CUDA_VISIBLE_DEVICES
# arg 2 CANDLE_DATA_DIR
# arg 3 CANDLE_CONFIG

# Check if path to model directory is set otherwise assume this scriot is in top level of model dir
if [ -z $MODEL_DIR ]
then
        MODEL_DIR=$( dirname -- "$0"; )
fi

# Check if directory exists
if ! [ -d $MODEL_DIR ]
then
        echo No directory $MODEL_DIR
        exit 404
fi



export CUDA_VISIBLE_DEVICES=$1
export CANDLE_DATA_DIR=$2
export CANDLE_CONFIG=$3


# Change into directory and execute tests
cd ${MODEL_DIR}
python HiDRA_FeatureGeneration.py
python HiDRA_training.py

# Check if successful
exit 0
