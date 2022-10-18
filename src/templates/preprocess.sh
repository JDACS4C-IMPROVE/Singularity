#!/bin/bash

### Path to your script inside the container that takes in data directory parameter###
CANDLE_PREPROCESS=#PATH#

if [[ "$#" -ne 1 ]] ; then
    echo "Illegal number of parameters"
    echo "CANDLE_DATA_DIR required"
    exit -1
fi

CANDLE_DATA_DIR=$1

# Command to run your scipt
CMD="??? ${CANDLE_PREPROCESS}"

# Name of your container
echo "using container ???" # Put the name of your container here

# Displaying script parameters
echo "using CANDLE_DATA_DIR ${CANDLE_DATA_DIR}"
echo "using CANDLE_CONFIG ${CANDLE_CONFIG}"
echo "running command ${CMD}"

# Run preprocessing
CANDLE_DATA_DIR=${CANDLE_DATA_DIR} $CMD


