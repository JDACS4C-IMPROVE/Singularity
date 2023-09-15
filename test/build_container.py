import os
import subprocess
import sys
import argparse
import subprocess

def build_singularity_container(model_name, definitions_file, deployment_dir_file, options="--fakeroot --disable-cache "):
    """
    Build singularity container deployment_dir_file from model_name and definitions_file
    """

    cmd = "singularity build " + options + deployment_dir_file + " " + definitions_file
    print("Running command:", cmd)
    
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()

    print("Standard Output:")
    print(stdout.decode("utf-8"))

    print("\nStandard Error:")
    print(stderr.decode("utf-8"))
    
    return deployment_dir_file



if __name__ == "__main__":
    
    
    parser = argparse.ArgumentParser(description="Build Singularity container. Launch from Singularity/test as Eg. 1: python build_container.py --model_name DeepTTC  .OR. Eg.2: python build_container.py --model_name GraphDRP --definitions_file /PathTo/GraphDRP.def --deployment_dir_file /PathTo/GraphDRP.sif")
    parser.add_argument("--model_name", help="Name of the model", default="GraphDRP")
    parser.add_argument("--singularity_dir", help="Path to the Singularity directory", default="../")
    parser.add_argument("--definitions_file", help="Path to the Singularity definition file", default="")
    parser.add_argument("--deployment_dir_file", help="Path to the deployment directory including .sif filename", default="")
    parser.add_argument("--options", help="Additional options for Singularity build", default="--fakeroot --disable-cache ")

    args = parser.parse_args()
    
    model_name = args.model_name
    deployment_dir_file = args.deployment_dir_file
    definitions_file = args.definitions_file
    singularity_dir = args.singularity_dir
    
    if deployment_dir_file == "":
        deployment_dir_file = singularity_dir + "/images/" + model_name + ".sif"
        if os.path.isfile(deployment_dir_file):
            print("Singularity container already exists: ", deployment_dir_file)
            sys.exit(1)
        else:
            print("Singularity container does not exist", deployment_dir_file)
    else:
        print("Trying to create singularity container:", deployment_dir_file)
        
    if definitions_file == "":
        definitions_file = singularity_dir + "/definitions/" + model_name + ".def"
        if os.path.isfile(definitions_file):
            print("Definition file exists:", definitions_file)
        else:
            print("Definition file does not exist:", definitions_file)
            sys.exit(1)
    else:
        if os.path.isfile(definitions_file):
            print("Definition file exists:", definitions_file)
        else:
            print("Definition file does not exist:", definitions_file)
            sys.exit(1)
    
    args.deployment_dir_file = deployment_dir_file
    args.definitions_file = definitions_file
    
    print(args)

    # call build_singularity_container
    image_path = build_singularity_container(args.model_name, args.definitions_file, args.deployment_dir_file, args.options)
    
    print("Build completed, created, IMAGE:", image_path)
    
    