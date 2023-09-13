import os
import sys
import datetime

from test_model import test_model, run_baseline
from build_container import build_singularity_container

import subprocess

def send_terminal_output_to_file(command, filename):
    with open(filename, "w") as f:
        output = subprocess.run(command, stdout=f, text=True)


if __name__ == "__main__":
    
    model_name = sys.argv[1] if len(sys.argv) > 1 else ""
    model_dir = sys.argv[2] if len(sys.argv) > 2 else "./"
    singularity_dir = sys.argv[3] if len(sys.argv) > 3 else "../"
    
    
    #  TEST THE MODEL
    baseline, config, model_name = test_model(model_name, model_dir)
    
    #  RUN THE BASELINE FROM SOURCE FOR 1 EPOCH
    run_baseline(baseline, config, model_name)
    
    # BUILD THE SINGULARITY CONTAINER
    print("singularity_dir:", singularity_dir)
    build_singularity_container(model_name, singularity_dir)
    
    # TEST THE SINGULARITY CONTAINER
    # image_path = test_singularity_container(model_name, singularity_dir)
    
    print("Test done", datetime.datetime.now())