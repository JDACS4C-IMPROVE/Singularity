#!/bin/bash

# Launches model for inferencing from within the container
# TODO: define what args can be passed

CANDLE_DATA_DIR=$1
export CANDLE_DATA_DIR=$CANDLE_DATA_DIR

####################################################################
## Exceute inference script for your model with the CMD arguments ##
####################################################################