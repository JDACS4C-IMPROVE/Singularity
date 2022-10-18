#!/bin/bash

# Launches model for inferencing from within the container
# TODO: define what args can be passed

CANDLE_DATA_DIR=$1
export CANDLE_DATA_DIR=$CANDLE_DATA_DIR

infer.py --args $ARGS
