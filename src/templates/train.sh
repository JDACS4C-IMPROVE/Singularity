
#!/bin/bash

#########################################################################
### THIS IS A TEMPLATE FILE. SUBSTITUTE #PATH# WITH THE MODEL EXECUTABLE.
#########################################################################


# arg 1 CUDA_VISIBLE_DEVICES
# arg 2 CANDLE_DATA_DIR
# arg 3 CANDLE_CONFIG

### Path to your CANDLEized model's main Python script###
CANDLE_MODEL=#/usr/local/GraphDRP/graphdrp_baseline_pytorch.py#

if [ $# -lt 2 ] ; then
	echo "Illegalnumber of paramaters"
	exit -1

elif [ $# -eq 3 ] ; then
  CUDA_VISIBLE_DEVICES=$1
  CANDLE_DATA_DIR=/candle_data_dir/$2
  CANDLE_CONFIG=$3
  CMD="python ${CANDLE_MODEL} --config_file $CANDLE_CONFIG"
  echo "CMD = $CMD"

else
  echo "num args is greather than 3 $#"
  # the candle config is converted to command line parameters
  CUDA_VISIBLE_DEVICES=$1 ; shift
  CANDLE_DATA_DIR=/candle_data_dir/$1 ; shift
  CMD="python ${CANDLE_MODEL} $@"
  echo "CMD = $CMD"
fi

# Display runtime arguments
echo "using CUDA_VISIBLE_DEVICES ${CUDA_VISIBLE_DEVICES}"
echo "using CANDLE_DATA_DIR ${CANDLE_DATA_DIR}"
echo "using CANDLE_CONFIG ${CANDLE_CONFIG}"
echo "running command ${CMD}"

# Set up environmental variables and execute model
CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES} CANDLE_DATA_DIR=${CANDLE_DATA_DIR} $CMD
