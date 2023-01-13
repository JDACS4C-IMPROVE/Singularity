# File organization:
- Name the main file where the actual model resides as <model>_baseline_<keras2> or <_pytorch>.py
- <model>.py for the Benchmark class
- <model>_default_model.txt

Please follow the above conventions for naming files, all lowercase filenames.

This would enable the model a user to run `python example_baseline_keras2.py`

Users never change parameters inside the file example_baseline_keras2.py, any parameters needed for tweaking or optimizing the model
must be provide vi example_default_model.txt