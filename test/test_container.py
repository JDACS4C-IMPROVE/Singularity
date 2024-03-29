import os
import subprocess
import sys
import argparse
import subprocess

def check_file_exists(filename):
    return os.path.isfile(filename)

def test_singularity_container(model_name, candle_data_dir, gpuid, definitions_file, deployment_dir_file, options="--epochs 1  "):
    """
    Build singularity container from model_name and singularity_dir, and run it for 1 epoch
    """

    if os.path.isfile(deployment_dir_file):
        print("Singularity container exists")
    else:
        print("Singularity container does not exist", deployment_dir_file)
        # exit(1)

    print("Running singularity container")
    
    cmd = "singularity run --nv --bind " + candle_data_dir + ":/candle_data_dir " + deployment_dir_file + " train.sh " + gpuid + " /candle_data_dir " + options
    
    print("Running command:", cmd)
    
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()

    print("Standard Output:")
    # print(stdout.encode("utf-8").decode("utf-8"))
    print(stdout)

    print("\nStandard Error:")
    # print(stderr.encode("utf-8").decode("utf-8"))
    print(stderr)
    
    return process.returncode


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Build Singularity container. Launch from Singularity/test as Eg. 1: python build_container.py --model_name DeepTTC  .OR. Eg.2: python build_container.py --model_name GraphDRP --definitions_file /PathTo/GraphDRP.def --deployment_dir_file /PathTo/GraphDRP.sif")
    parser.add_argument("--model_name", help="Name of the model", default="GraphDRP")
    parser.add_argument("--candle_data_dir", help="Path to the candle data directory", default="/tmp/")
    parser.add_argument("--gpuid", help="GPU ID", default="0")
    parser.add_argument("--singularity_dir", help="Path to the Singularity directory", default="")
    parser.add_argument("--definitions_file", help="Path to the Singularity definition file", default="")
    parser.add_argument("--deployment_dir_file", help="Path to the deployment directory including .sif filename", default="")
    parser.add_argument("--options", help="Additional options for Singularity build", default="--epochs 1")

    args = parser.parse_args()
    
    model_name = args.model_name
    deployment_dir_file = args.deployment_dir_file
    definitions_file = args.definitions_file
    singularity_dir = args.singularity_dir
    
    # some contents of definitions file reply on hard coded paths ./src/..GPU_fix.. 
    # TODO: fix this and remove the need to change directory (cp -r src/..GPU_fix.. . needed by definitions file)
    # Once fixed this change to be in the singularity directory won't be needed
    print("change directory to the singularity directory")
    os.chdir("../")

    if deployment_dir_file == "":
        directory_container = "build/"
        deployment_dir = os.path.join(singularity_dir, directory_container)
        deployment_dir_file = deployment_dir_file + directory_container + model_name + ".sif"
    else:
        deployment_dir_file = os.path.join("test", deployment_dir_file)
        
    if definitions_file == "":
        definitions_file = os.path.join(singularity_dir, "definitions", model_name + ".def")

    print("deployment_dir_file:", deployment_dir_file, "definitions_file:", definitions_file)
    
    for m in [definitions_file, deployment_dir_file]:
        if check_file_exists(m):
            print(m, " exists")
        else:
            print(m, " does not exist")
            sys.exit(1)
    
    args.deployment_dir_file = deployment_dir_file
    args.definitions_file = definitions_file
    
    print(args)
    
    test_out = test_singularity_container(args.model_name, args.candle_data_dir, args.gpuid, args.definitions_file, args.deployment_dir_file, args.options)
    
    print("Testing container completed, exit code:", test_out)
    