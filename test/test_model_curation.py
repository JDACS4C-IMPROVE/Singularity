import os
import sys
import datetime
import argparse
import subprocess

from test_model import test_model, run_baseline
from build_container import build_singularity_container


if __name__ == "__main__":
    
    model_name = sys.argv[1] if len(sys.argv) > 1 else ""
    model_source_dir = sys.argv[2] if len(sys.argv) > 2 else "./"
    singularity_dir = sys.argv[3] if len(sys.argv) > 3 else "../"
    
    print("singularity_dir:", singularity_dir)
    # get current directory
    pwd = os.getcwd()
    
    #  TEST THE MODEL LOCALLY USING ENV PYTHON
    baseline, config, model_name = test_model(model_name, model_source_dir)
    
    #  RUN THE BASELINE FROM SOURCE FOR 1 EPOCH
    run_baseline(baseline, config, model_name)
    
    # BUILD THE SINGULARITY CONTAINER
    definitions_file = singularity_dir + "/definitions/" + model_name + ".def"
    deployment_dir_file = singularity_dir + "/images/" + model_name + ".sif"
    
    image = build_singularity_container(model_name, definitions_file, deployment_dir_file)
    print("Done calling build_singularity_container: ", image)
    
    # TEST THE SINGULARITY CONTAINER
    cmd = "python test_container.py --model_name " + model_name 
    print("Running testing cmd: ", cmd)
    # cmd = "python temp.py"
    # print("cmd: ", cmd)
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()

    print("Standard Output: ", model_name)
    print(stdout)


    print("\nStandard Error: ", model_name)
    print(stderr)    
    print("Test done", datetime.datetime.now())