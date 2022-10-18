#!/bin/bash

COMMUN_PREPROCESS=/usr/local/HiDRA/HiDRA_FeatureGeneration.py
CANDLE_PREPROCESS=$COMMUN_PREPROCESS

if [[ "$#" -ne 1 ]] ; then
    echo "Illegal number of parameters"
    echo "CANDLE_DATA_DIR required"
    exit -1
fi

CANDLE_DATA_DIR=$1
#CANDLE_CONFIG=$2

#CMD="python ${CANDLE_PREPROCESS} --config_file ${CANDLE_CONFIG}"
CMD="python ${CANDLE_PREPROCESS}"

echo "using container pilot1.0_5_1-tensorflow:2.8.2-gpu-20220617"
echo "using CANDLE_DATA_DIR ${CANDLE_DATA_DIR}"
echo "using CANDLE_CONFIG ${CANDLE_CONFIG}"
echo "running command ${CMD}"

CANDLE_DATA_DIR=${CANDLE_DATA_DIR} $CMD


