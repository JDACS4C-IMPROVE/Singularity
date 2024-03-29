#!/bin/bash



# Setup
CONTAINER="${1:-""}" 
GPUID="${2:-"3"}"
IMPROVE_DATA_DIR="${3:-"/tmp/"}"
IHOME=

# Container
MODEL_BASE_DIR=/usr/local/
MODEL_FILE_CONTAINER=`singularity exec ${CONTAINER} find ${MODEL_BASE_DIR} -name "*_default_model.txt"`
MODEL_FILE=

ALL=0 

if ! [ -f ${CONTAINER} ]
then
	echo ERROR: no such file ${CONTAINER}
	echo ERROR: ${MODEL_FILE_CONTAINER}
fi

if ! [ -d ${IMPROVE_DATA_DIR} ]
then
	echo ERROR: directory ${IMPROVE_DATA_DIR} does not exists
fi

# echo Found ${MODEL_FILE_CONTAINER} ${CONTAINER}
# echo singularity exec ${CONTAINER}  "find ${MODEL_BASE_DIR} -name \"*_default_model.txt\""

if [ ${MODEL_FILE_CONTAINER}  ]
then 
	echo CONFIG: ${MODEL_FILE_CONTAINER}
else
	echo ERROR Could not find *_default_model.txt	
	echo CONFIG: ${MODEL_FILE_CONTAINER}
fi
	
	
singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} cp $MODEL_FILE_CONTAINER /candle_data_dir

if [ ${ALL} ]
then
	
	echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
	echo singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} preprocess.sh $GPUID /candle_data_dir
	singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} preprocess.sh $GPUID /candle_data_dir 

	echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
	echo singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} train.sh $GPUID /candle_data_dir --epochs 1
	singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} train.sh $GPUID /candle_data_dir --epochs 1

	echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
	echo singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} train.sh $GPUID /candle_data_dir ${MODEL_FILE} --epochs 1
	singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} train.sh $GPUID /candle_data_dir ${MODEL_FILE} --epochs 1


	echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
	echo singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} train.sh $GPUID /candle_data_dir --config_file ${MODEL_FILE} --epochs 1
	singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} train.sh $GPUID /candle_data_dir --config_file ${MODEL_FILE} --epochs 1

fi

echo "$(date +%Y-%m-%d" "%H:%M:%S) START" 
if [ ${} ]
then
	singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} train.sh $GPUID /candle_data_dir ${MODEL_FILE} --experiment_id EXP001 --run_id RUN001 --epochs 1
else
	echo ERROR: Can\'t run tests. Missing config file
fi

echo "$(date +%Y-%m-%d" "%H:%M:%S) DONE"
