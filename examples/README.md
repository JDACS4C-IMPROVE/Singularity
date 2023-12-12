# File organization:

This directory provides template files for config and model code executable. You can use it to generate your model infrastructure scripts. 

Suggested naming convention:

- Name the main file where the actual model resides as <_model\_name_>\_<_preprocess|train|infer|baseline_>\_<_keras2|pytorch|etc._>.py
- <_model_name_>\_default.cfg

Please follow the above conventions for naming files, all lowercase filenames.
`model_name` is a required keyword for all models.

This would enable the model a user to run `python example_baseline_keras2.py`

Users never change parameters inside the model scripts, any parameters needed for tweaking or optimizing the model
must be provided through <_model_name_>\_default.cfg 
