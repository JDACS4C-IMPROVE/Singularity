import subprocess
import os
import sys
import test_container

# this test runs all images in the test/images folder
# a list of images can be specified to override the default of all images in test/images folder
# the test will run on all available GPUs
# 
def test_all_images(singularity_dir, gpuid='0', image_list=None):
    build_dir = singularity_dir + '/build'
    print(build_dir, os.path.isdir(build_dir))
    
    pids = []
    if not image_list:
        image_list = os.listdir(build_dir)
        print("Getting all the images in the directory:", build_dir)
    for n in image_list:
        print("running image:", n)
        cmd = "python test_container.run_model(" + n + ")" 
        print("cmd-", cmd)
        process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        pids.append(process)

        gpuid = str(int(gpuid) + 1)
        print("GPUID: {gpuid}")

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
    test_all_images("/homes/jain/Singularity")
