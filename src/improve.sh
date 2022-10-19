# This file is a wrapper for executing scripts inside CANDLE-compliant container
# It binds CANDLE_DATA_DIR defined on host system to the internal directory in Singularity container

improve__preprocess__help() {
    echo "improve train takes in the following position arguments:"
    echo "improve preprocess IMAGE ARGS"
    echo "    IMAGE - path to a Singularity image"
    echo "    ARGS (Optional) Trailing arguments for model-specific preprocess.sh script"
}

improve__infer__help() {
    echo "improve infer takes in the following position arguments:"
    echo "improve preprocess IMAGE ARGS"
    echo "    IMAGE - path to a Singularity image"
    echo "    ARGS (Optional) Trailing arguments for model-specific infer.sh script"
}

improve__shell__help() {
    echo "improve shell starts an interactive session on the selected container."
    echo "This function takes in the following position arguments:"
    echo "    IMAGE - path to a Singularity image"
}

improve__train__help() {
    echo "improve train takes in the following position arguments:"
    echo "improve train IMAGE CUDA_AVAILABLE_DEVICES CONFIG_FILE"
    echo "    IMAGE - path to a Singularity image"
    echo "    CUDA_AVAILABLE_DEVICES - specify which CUDA devices are visible to the containerized model"
    echo "    CONFIG_FILE (Optional) - CANDLE-style configuration file for the containerized model"
    echo "    ARGS (Optional) - Trailing arguments for model-specific train.sh script"
    echo ""
}

improve__help() {
    echo "IMPROVE suit executes functions from the CANDLE-compliant Singularity images."
    echo "Available commands are: train, preprocess, infer."
    echo "Environmental directory CANDLE_DATA_DIR is required for this script."
    echo "Scripts would look for input data in CANDLE_DATA_DIR and write output there, make sure that you have necessary permissions."
    echo ""
    echo "DISCLAIMER. Each improve function has common interface but their behavior and effect on files located in CANDLE_DATA_DIR is model-specific. We advise to not store critical information in CANDLE_DATA_DIR to avoid its loss or modifications."
    echo "    'improve train' command performs model training. ATTENTION: changes to the Singularity images that are not sandboxes would not persist."
    echo "    'improve preprocess' command does a data preprocessing that transforms input data from CANDLE_DATA_DIR to the format usable by the model."
    echo "    'improve infer' performs predictions on the provided data. This command passes an entire arguments down to script, data files are model-specific."
    echo "    'improve shell' launches an interactive shell session inside the Singularity container."
    echo ""
    echo "To learn more use subcommand-specific help function, e.g., improve train help"
    echo ""
}


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

improve__shell() {
    BINDINGS=$1; shift
    CANDLE_DIR_INSIDE_CONTAINER=$1; shift
    singularity shell --nv --bind $BINDINGS $SINGULARITY_IMAGE
}

improve() {
    _check_candle_data_dir
    CANDLE_DIR_INSIDE_CONTAINER="/Data/"
    BINDINGS=${CANDLE_DATA_DIR}":"$CANDLE_DIR_INSIDE_CONTAINER

    cmdname=$1; shift
    SINGULARITY_IMAGE=$1; shift

    if type "improve__$cmdname" >/dev/null 2>&1; then
        if "improve__${cmdname}__${SINGULARITY_IMAGE}" > /dev/null 2>&1; then
            "improve__${cmdname}__${SINGULARITY_IMAGE}" "$@"
            return
        fi
        "improve__$cmdname" "$BINDINGS" "$CANDLE_DIR_INSIDE_CONTAINER" "$@"
    else
        echo "Unknown command $cmdname!"
        echo
        improve__help
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