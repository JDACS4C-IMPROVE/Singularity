import os
import sys
import datetime
import argparse
import subprocess

from test_model import test_model, run_baseline
from build_container import build_singularity_container


if __name__ == "__main__":
    
    parser = argparse.ArgumentParser(description="Test the model for candle compliance. IN SOURCE.")
    parser.add_argument("--singularity_dir", help="path to singularity directory", default="../")
    parser.add_argument("--model_name", help="Name of the model", default="GraphDRP")
    parser.add_argument("--model_source_dir", help="Path to the model source directory", default="../../GraphDRP")
    args = parser.parse_args()

    print("singularity_dir:", args.singularity_dir)
    
    #  TEST THE MODEL LOCALLY USING ENV PYTHON
    baseline, config, model_name = test_model(args.model_name, args.model_source_dir)
    
    #  RUN THE BASELINE FROM SOURCE FOR 1 EPOCH
    run_baseline(baseline, config, model_name)
    
    print("Test DONE\n\n", datetime.datetime.now())
    
    print("Next step: build singularity container. \nrun: Example: python build_container.py --model_name DeepTTC. \nNote: Make sure you have fakeroot access.")