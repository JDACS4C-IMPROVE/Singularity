# Testing scripts

- test-model
- test-container
- test_candle.py

## Test model interface scripts

Command: `test-model $MODEL_NAME $MODEL_DIR $DATA_DIR`

Options:
- MODEL_NAME: Name of model, prefix in `${MODEL_NAME}_baseline_*.py`
- MODEL_DIR: Path to top level model directory, default `./`
- DATA_DIR: Path to data dir (candle dir), default `/tmp/`

Tests for presence of required scripts and config.

## Test container setup

## Test candle

Command: `pytest`

Options:

Environment:
- *MODEL_DIR*: Path to top level model directory

Tests for run() and initialize_parameters(). Imports \*\_baseline\_\*.py from *$MODEL_DIR*

