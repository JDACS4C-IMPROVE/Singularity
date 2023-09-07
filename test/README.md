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


Tests for run() and initialize_parameters(). Imports \*\_baseline\_\*.py from *$MODEL_DIR*
Command: `pytest`

Options:
- -s Test module, e.g. test_candle.py

Environment:
- *MODEL_DIR*: Path to top level model directory

Example:
```bash
export MODEL_DIR=PATH/TO/IMPROVE/GraphDRP
cd Singularity/test
pytest -s test_candle.py
...
 'train_bool': True,
 'train_data': 'train_data',
 'val_batch': 256,
 'val_data': 'val_data',
 'verbose': False,
 'y_col_name': 'AUC'}
.

================================================================= warnings summary ==================================================================
Singularity/test/test_candle.py::TestCandle::test_initialize_parameters_type
  /Users/me/miniconda3/envs/IMPROVE/lib/python3.9/site-packages/candle/parsing_utils.py:742: RuntimeWarning: These keywords used in the configuration file are not defined in CANDLE: ['cache_subdir']
    warnings.warn(message, RuntimeWarning)

Singularity/test/test_candle.py::TestCandle::test_initialize_parameters_type
  /Users/me/miniconda3/envs/IMPROVE/lib/python3.9/site-packages/candle/file_utils.py:217: RuntimeWarning: Path: /tmp/GraphDRP/Output/EXP000/RUN000 already exists... overwriting.
    warnings.warn(message, RuntimeWarning)

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html
=========================================================== 6 passed, 2 warnings in 1.88s ===========================================================
```


