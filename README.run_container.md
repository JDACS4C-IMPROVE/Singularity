


```
# Get the latest default_model.txt file
# Create a directory that will be used for CANDLE_DATA_DIR

CUDA_VISIBLE_DEVICES=7
IMAGE=/software/improve/images/GraphDRP:0.0.1-20221028
CANDLE_DATA_DIR=/homes/brettin/candle_data_dir
CANDLE_CONFIG=/homes/brettin/GraphDRP/graphdrp_default_model.txt

singularity exec --nv $IMAGE train.sh $CUDA_VISIBLE_DEVICES $CANDLE_DATA_DIR $CANDLE_CONFIG
```
