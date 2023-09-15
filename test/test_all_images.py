import subprocess
import os
import sys
import test_container
import argparse

# this test runs all images in the <Singularity/build> folder
# a list of images can be specified to override the default of all images in the <Singularity/build> folder
# the test will run on 0-7 GPUs, and will cycle through them as needed
# the test will run on the candle_data_dir specified, or the default of /tmp
def test_all_images(singularity_dir, candle_data_dir, gpuid, images_dir, images_list):
    
    pids = []
    print(images_list)
    if not images_list:
        print("Getting all the images in the directory:", images_dir)
        print(images_dir, os.path.isdir(images_dir))
        images_list = os.listdir(images_dir)
        
    for n in images_list:
        if n.endswith(".sif"):
            model_name, extension = n.split(".")
        else:
            model_name = n
            print("WARNING: image name does not end with .sif:", n)
        print("running image:", model_name)
        deployment_dir_file = images_dir + "/" + n
        cmd = "python test_container.py --model_name " + model_name + " --candle_data_dir " + candle_data_dir + " --gpuid " + gpuid + " --deployment_dir_file " + deployment_dir_file
        print("Running testing cmd: ", cmd)
        # cmd = "python temp.py"
        # print("cmd: ", cmd)
        process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()

        print("Standard Output: ", model_name)
        print(stdout)


        print("\nStandard Error: ", model_name)
        print(stderr)


        pids.append(process)

        gpuid = str(int(gpuid) + 1)
        # print("Next GPUID: {gpuid}")

        # assumes 8 GPUs are available
        if int(gpuid) > 7:
            print("all GPUs are in use")
            for process in pids:
                print("waiting on PID: {process.pid}")
                process.wait()
            gpuid = '0'

    for process in pids:
        process.wait()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Test all singularity images in a particular director")
    parser.add_argument("--singularity_dir", help="path to singularity directory", default="../")
    parser.add_argument("--gpuid", help="GPU ID", default="0")
    parser.add_argument("--candle_data_dir", help="CANDLE DATA DIR", default="/tmp")
    parser.add_argument("--images_dir", help="Directory where all the images are stored and to be tested", default="../build/")
    parser.add_argument("--images_list", nargs='+', help="Image list", default="")
    
    args = parser.parse_args()
    print(args)
    test_all_images(args.singularity_dir, args.candle_data_dir, args.gpuid, args.images_dir, args.images_list)
