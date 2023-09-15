import os
import sys
import datetime

def check_file_exists(filename):
    return os.path.isfile(filename)

def test_model(model_name, model_dir):
    """
    Tests the model for candle compliance
    """


    print("Test start", datetime.datetime.now())
    print("model_name:", model_name)
    print("model_dir:", model_dir)
    

    # Check python version
    python_version = sys.version_info.minor 
    if python_version < 3:
        python = "python3"
    else:
        python = "python"

    # Check if files are present
    current_dir = os.getcwd()
    os.chdir(model_dir)

    for m in ["preprocess.sh", "train.sh", "infer.sh"]:
        if check_file_exists(m):
            print(m, " exists")
        else:
            print(m, " does not exist")
    if model_name:
        model_name = model_name.lower()
        # List files in model_dir
        files_in_model_dir = os.listdir(model_dir)
        baseline_pattern = model_name + "_baseline"
        config_pattern = model_name + "_default_model"
        
        # for debugging
        # print(files_in_model_dir, "files_in_model_dir")
        
        baseline = None
        config = None
        
        try:
            baseline = [f for f in files_in_model_dir if baseline_pattern in f][0]
            config = [f for f in files_in_model_dir if config_pattern in f][0]
        except IndexError:
            print("No baseline or config file found")
            
        print("baseline / config:", baseline, config)
        if baseline:
            if check_file_exists(baseline):
                print("Test found baseline file: passed")
            else:
                print("Test found baseline file: failed")
        else:
            print("Test found baseline file: failed")

        if config:
            print("Test found config file: passed")
        else:
            print("Test found config file: failed")
            
    return baseline, config, model_name
            
def run_baseline(baseline, config, model_name):
    cmd = "python ", baseline, " --epochs 1", ">", model_name+"_run.out"
    cmd=" ".join(cmd)
    print (cmd)
    os.system
    results = os.system(cmd)