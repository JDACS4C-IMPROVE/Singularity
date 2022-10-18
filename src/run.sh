# This file is a wrapper for executing scripts inside CANDLE-compliant container
# It binds CANDLE_DATA_DIR defined on host system to the internal directory in Singularity container

if [ ! -z "${CANDLE_DATA_DIR}" ]; then
        if [ ! -d "$CANDLE_DATA_DIR" ]; then
            echo "Cannot access $CANDLE_DATA_DIR! Make sure this directory exists"
			exit -1
        fi
else
	echo "\$CANDLE_DATA_DIR is not defined! Cannot proceed. Terminating..."
	exit -1
fi

CANDLE_DIR_INSIDE_CONTAINER="/usr/local/Data/"
BINDINGS=${CANDLE_DATA_DIR}":"$CANDLE_DIR_INSIDE_CONTAINER

ARGS="$@" 

singularity exec --nv --bind $BINDINGS $ARGS