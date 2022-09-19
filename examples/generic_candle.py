import candle
import os

from tensorflow.keras import backend as K


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

def initialize_parameters():
    preprocessor_bmk = IBenchmark(file_path,
        'data_default_params.txt',
        'keras',
        prog='my_program.py',
        desc='IMPROVE Benchmark'
    )

    gParameters = candle.finalize_parameters(preprocessor_bmk)

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

def main():
    params = initialize_parameters()
    run(params)


if __name__ == "__main__":
    main()
    if K.backend() == "tensorflow":
        K.clear_session()

    
    

