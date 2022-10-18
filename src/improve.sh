# This file is a wrapper for executing scripts inside CANDLE-compliant container
# It binds CANDLE_DATA_DIR defined on host system to the internal directory in Singularity container

_check_candle_data_dir() {
    if [ ! -z "${CANDLE_DATA_DIR}" ]; then
        if [ ! -d "$CANDLE_DATA_DIR" ]; then
            echo "Cannot access $CANDLE_DATA_DIR! Make sure this directory exists"
			return
        fi
    else
	    echo "\$CANDLE_DATA_DIR is not defined! Cannot proceed. Terminating..."
	    return
    fi
}


improve__train() {
    BINDINGS=$1; shift
    CANDLE_DIR_INSIDE_CONTAINER=$1; shift
    CUDA_VISIBLE_DEVICES=$1; shift
    #CANDLE_CONFIG=$1; shift

    echo "singularity exec --nv --bind $BINDINGS $SINGULARITY_IMAGE train.sh $CUDA_VISIBLE_DEVICES $CANDLE_DIR_INSIDE_CONTAINER "$@""
    singularity exec --nv --bind $BINDINGS $SINGULARITY_IMAGE train.sh $CUDA_VISIBLE_DEVICES $CANDLE_DIR_INSIDE_CONTAINER "$@"
}

improve__preprocess() {
    BINDINGS=$1; shift
    CANDLE_DIR_INSIDE_CONTAINER=$1; shift
    singularity exec --nv --bind $BINDINGS $SINGULARITY_IMAGE preprocess.sh $CANDLE_DIR_INSIDE_CONTAINER "$@"
}

improve__infer() {    
    BINDINGS=$1; shift
    CANDLE_DIR_INSIDE_CONTAINER=$1; shift
    singularity exec --nv --bind $BINDINGS $SINGULARITY_IMAGE infer.sh "$@"
}

improve() {
    _check_candle_data_dir
    CANDLE_DIR_INSIDE_CONTAINER="/Data/"
    BINDINGS=${CANDLE_DATA_DIR}":"$CANDLE_DIR_INSIDE_CONTAINER

    cmdname=$1; shift
    SINGULARITY_IMAGE=$1; shift

    if type "improve__$cmdname" >/dev/null 2>&1; then
        "improve__$cmdname" "$BINDINGS" "$CANDLE_DIR_INSIDE_CONTAINER" "$@"
    else
        echo "Unknown command $cmdname!"
        return
    fi
}

[[ $_ != $0 ]] && return

if declare -f "$1" >/dev/null 2>&1; then
    "$@" 
else
    echo "Function $1 not recognized" >&2
    return
fi


if ! command -v improve /dev/null
then
    #source ./improve.sh
    #Get the path to the current file
    echo "NOT A COMMAND!!!"
    SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    echo "source ${SCRIPTPATH}/improve.sh">>~/.bash_profile
    source ~/.bash_profile
fi