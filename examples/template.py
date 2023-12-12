import json
import os

import candle


#########################################################
# Common settings
#########################################################

# Just because the tensorflow warnings are a bit verbose
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"

# This should be set outside as a user environment variable
if not (os.environ["CANDLE_DATA_DIR"] 
        and os.path.isdir(os.environ["CANDLE_DATA_DIR"]) :
        pass


####################################################
# Command Line Interface
# 
# Sets standard input options 
# and allows for the declaration of custom prameters
#####################################################

# Define any needed additional args to ensure all new args are command-line accessible.
additional_definitions = [
    {"name": "new_keyword", "type": str, "nargs": 1, "help": "helpful description"}
]

# Define args that are required.
required = None
    
# file_path becomes the default location of the example_default_model.txt file
file_path = os.path.dirname(os.path.realpath(__file__))

# Extend candle.Benchmark to configure the args:
class CLI(candle.Benchmark):
    def set_locals(self):
        if required is not None:
            self.required = set(required)
        if additional_definitions is not None:
            self.additional_definitions = additional_definitions

# In the initialize_parameters() method, we will instantiate the base
# class, and finally build an argument parser to recognize your customized
# parameters in addition to the default parameters.The initialize_parameters()
# method should return a python dictionary, which will be passed to the run()
# method.
def initialize_parameters():
    cli = CLI(
        file_path,  # this is the path to this file needed to find the default config file
        "default.cfg",  # name of the default config file for the model, 
        "keras",  # framework, choice is keras or pytorch
        prog="myModel",  # basename of the model
        desc="IMPROVE Model",
    )

    gParameters = candle.finalize_parameters(
        cli
    ) 
    # returns the parameter dictionary built from
    # default.cfg and overwritten by any
    # matching comand line parameters or config file

    return gParameters


def run(params):

    # Execute main logic here, either for preprocessing, 
    # training or inference/prediction
    # define callbacks and set checkpointing
    

    # replace with a call to your code
    print("running third party code") 
    # metrics = CALL_YOUR_CODE_HERE(params)
    print("returning training metrics")


    # metrics is used by the supervisor when running
    # HPO workflows (and possible future non HPO workflows)
    metrics = {"val_loss": 0.101, "pcc": 0.923, "scc": 0.777, "rmse": 0.036}
  
    # Dumping results into file, workflow requirement
    val_scores = {
        "key": "val_loss",
        "value": metrics["val_loss"],
        "val_loss": metrics["val_loss"],
        "pcc": metrics["pcc"],
        "scc": metrics["scc"],
        "rmse": metrics["rmse"],
    }
   
    with open(params["output_dir"] + "/scores.json", "w", encoding="utf-8") as f:
        json.dump(val_scores, f, ensure_ascii=False, indent=4)

    return metrics  # metrics is used by the supervisor when running
    # HPO workflows (and possible future non HPO workflows)


def main():
    
    # Get config, either from cli or file
    params = initialize_parameters()
    # print(params["data_dir"])
    #
    # demonstrating a list
    # for i, value in enumerate(params["dense"]):
    #     print("dense layer {} has {} nodes".format(i, value))
    
    # main logic
    scores = run(params)
   




if __name__ == "__main__":
    main()