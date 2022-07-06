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


# experimental
supported_definitions = ['data_url','train_data','val_data','shuffle','feature_subsample']


class PreProcessor(candle.Benchmark):

    def set_locals(self):
        if required is not None:
            self.required = set(required)
        if additional_definitions is not None:
            self.additional_definitions = additional_definitions


def initialize_parameters():
    preprocessor_bmk = PreProcessor(file_path,
        'data_default_params.txt',
        'keras',
        prog='preprocessor',
        desc='Data Preprocessor'
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


def main():
    params = initialize_parameters()
    run(params)


if __name__ == "__main__":
    main()
    if K.backend() == "tensorflow":
        K.clear_session()

    
    

