#!/bin/bash

MODEL_NAME="${1:-}"
MODEL_DIR="${2:-"./"}" # keras2 or pytorch
DATA_DIR="${3:-"/tmp"}"

echo "Test start $(date)"

# Check python version
PYTHON=python
if [ -z "$PYTHON" ]; then
    if ! command -v python3 &> /dev/null; then
        echo "ERROR: no python version found"
        exit 1
    else
        PYTHON=python3
    fi
fi

# Check if files are present
CURRENT=$(pwd)
cd "$MODEL_DIR"

for m in preprocess.sh train.sh infer.sh; do
    if [ -f "$m" ]; then
        echo "Test exists ${m}: passed"
    else
        echo "Test exists ${m}: failed"
    fi
done

if [ -z "$MODEL_NAME" ]; then
    echo "Testing ${MODEL_NAME}"
else
    BASELINE=$(find . -name "${MODEL_NAME}_baseline_*.py")
    CONFIG=$(find . -name "*_default_model.txt")

    if [ -f "$BASELINE" ]; then
        echo "Test found baseline file: passed"
    else
        echo "Test found baseline file: failed"
    fi

    if [ -f "$CONFIG" ]; then
        echo "Test found config file: passed"
    else
        echo "Test found config file: failed"
    fi

    results="$($PYTHON "$BASELINE" --epochs 1)"
    if [ $? -eq 0 ]; then
        echo "Test is executable: passed"
    else
        echo "Test is executable: failed"
    fi
fi

echo "Test done $(date)"
