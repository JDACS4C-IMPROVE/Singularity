import candle
import os


# This should be set outside as a user environment variable
os.environ['CANDLE_DATA_DIR'] = '/homes/brettin/Singularity/workspace/data_dir/'
file_path = os.path.dirname(os.path.realpath(__file__))


additional_definitions = [
    {'name':'new_keyword',
     'type':str,
     'nargs':1,
     'help':'helpful description'
    }
]

required = None


class IBenchmark(candle.Benchmark):

    def set_locals(self):
        if required is not None:
            self.required = set(required)
        if additional_definitions is not None:
            self.additional_definitions = additional_definitions
        if supported_definitions is not None:
            self.supported_definitions = supported_definitions


def initialize_parameters():
    preprocessor_bmk = IBenchmark(
        file_path,                           # this is the path to this file needed to find default_model.txt
        'mymodel_default_model.txt',         # name of the default_model.txt file
        'keras',                             # framework, choice is keras or pytorch
        prog='mymodel_baseline',             # basename of the model
        desc='IMPROVE Benchmark'
    )

    gParameters = candle.finalize_parameters(preprocessor_bmk)  # returns the parameter dictionary built from 
                                                                # default_model.txt and overwritten by any 
                                                                # matching comand line parameters.

    return gParameters


def run(params):
    # fetch data
    # preprocess data
    # save preprocessed data
    # define callbacks
    # build / compile model
    # train model
    # infer using model
    # etc
    print("running third party code")
    
    # Dumping results into file, workflow requirement
    val_scores = { 'key' : 'val_loss' ,
                  'value' : metrics['val_loss'],
                  'val_loss':metrics['val_loss'], 
                  'pcc':metrics['pcc'], 
                  'scc':metrics['scc'], 
                  'rmse':metrics['rmse']}

    with open(params['output_dir'] + "/scores.json", "w", encoding="utf-8") as f:
        json.dump(val_scores, f, ensure_ascii=False, indent=4)
    
    return metrics                                              # metrics is used by the supervisor when running
                                                                # HPO workflows (and possible future non HPO workflows)

def main():
    params = initialize_parameters()
    run(params)


if __name__ == "__main__":
    main()
    if K.backend() == "tensorflow":
        K.clear_session()

    
    

