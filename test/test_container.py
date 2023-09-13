import os

def test_singularity_container(image_path):
    """
    Build singularity container from model_name and singularity_dir
    """
    
    print("Building singularity container")
    image_path = singularity_dir + "/images/" + model_name + ".img"
    print("image_path:", image_path)    
    
    if os.path.isfile(image_path):
        print("Singularity container already exists")
        return
    else:
        print("Singularity container does not exist")
        run_model(image_path)
        
    
    
def run_model(image_path):
    """run the singularity container model for 1 epoch"""
    
    os.chdir(singularity_dir)
    # launch the command to build the singularity container
    print("Building singularity container:-", image_path)
    
    cmd = "singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir ${CONTAINER} train.sh $GPUID /candle_data_dir --config_file ${MODEL_FILE} --epochs 1"
    
    print(cmd)
    
    # # Check if singularity is installed
    # if not check_singularity_installed():
    #     print("Singularity is not installed")
    #     return
    
    # # Check if singularity_dir exists
    # if not check_file_exists(singularity_dir):
    #     print("Singularity directory does not exist")
    #     return
    
    # # Check if model_name is valid
    # if not model_name:
    #     print("Model name is not valid")
    #     return
    
    # # Check if model_name is in singularity_dir
    # if not check_file_exists(os.path.join(singularity_dir, model_name)):
    #     print("Model name is not in singularity directory")
    #     return
    
    # # Check if model_name.sif already exists
    # if check_file_exists(os.path.join(singularity_dir, model_name + ".sif")):
    #     print("Model name already exists")
    #     return
    
    # # Build singularity container
    # command = ["singularity", "build", os.path.join(singularity_dir, "/images/" model_name + ".img"), ""]
    # print(" ".join(command))
    # send_terminal_output_to_file(command, os.path.join(singularity_dir, "build_singularity_container.txt"))
    # print("Done building singularity container")
    # return
