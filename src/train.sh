#!/bin/bash

# Launches model training from within the container
# TODO: define what args can be passed

# Anything that needs to be done within the container before
# the model can be trained



PARAMS_FILE="model_params.txt"
ARGS="--config_file ${PARAMS_FILE}"
drp_model.py --args $ARG


