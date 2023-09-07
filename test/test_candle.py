import os
import sys
import importlib

class TestCandle:
    value = 0
    directory = os.getenv('MODEL_DIR' , None)
    module_name = "graphdrp_baseline_pytorch"
    sys.path.insert(0, directory)
    module = importlib.import_module(module_name, package=None)

    # set CANDLE_DATA_DIR
    os.environ["CANDLE_DATA_DIR"] = "/tmp"

    def test_fail(self):
        assert self.value == 1
    
    def test_model_dir(self):
        assert os.path.isdir(self.directory)

    def test_model_imported(self):
        assert self.module
    
    def test_run_method(self):
        assert "run" in dir(self.module)
    
    def test_initialize_parameters_method(self):
        assert "initialize_parameters" in dir(self.module)
    
    def test_initialize_parameters_type(self):
        params=self.module.initialize_parameters()
        assert isinstance(params , dict)
        


