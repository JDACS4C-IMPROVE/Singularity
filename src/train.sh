# arg 1 CUDA_VISIBLE_DEVICES
# arg 2 CANDLE_DATA_DIR
# arg 3 CANDLE_CONFIG

CANDLE_MODEL=/usr/local/Benchmarks/Pilot1/Attn/attn_baseline_keras2.py

if [[ "$#" -ne 3 ]]; then
    echo "Illegal number of parameters"
    echo "CUDA_VISIBLE_DEVICES CANDLE_DATA_DIR CANDLE_CONFIG required"
    exit -1
fi

CUDA_VISIBLE_DEVICES=$1
CANDLE_DATA_DIR=$2
CANDLE_CONFIG=$3

CMD="python $CANDLE_MODEL --config_file $CANDLE_CONFIG"

echo "using CUDA_VISIBLE_DEVICES $CUDA_VISIBLE_DEVICES"
echo "using containers at $ICL"
echo "using container pilot1.0_5_1-tensorflow:2.8.2-gpu-20220617"
echo "running command ${CMD}"

CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES CANDLE_DATA_DIR=$CANDLE_DATA_DIR $CMD


