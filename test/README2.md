
# Testing using python scripts

- All scripts use args parse, use --help to find out options. Eg. `python test_container.py --help`
- For saving output of a script to a file use `>` option. Eg. `python build_container.py DrugCell` 
- All the scripts have been tested on the lambda machine, for Polaris get a compute node and setup proxy and run the scripts: https://docs.alcf.anl.gov/polaris/data-science-workflows/containers/containers/ 

## Model Curation in-source testing 
- Make sure the python in your path is the one that has all the model dependencies for this in-source testing.
- `python test_model_curation.py --model_name=DeepTTC --model_source_dir=../../DeepTTC/`

## Building a container

- `python build_container.py --model_name DeepTTC`

## Test a container

- `python test_container.py --model_name DeepTTC`

## Testing all images (0-7 GPU usage)

- `python test_all_images.py`