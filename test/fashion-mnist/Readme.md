#INTRODUCTION
This directory contains the code to run the fashion-mnist example and explains the changes made to the original python notebook to make it work with IMPROVE.

The python notebook ***fashion-mnist.ipynb*** consists of 3 sections. 
Please read the comments on top of that notebook.

Notice the changes marked by comment line *## IMPROVE*
in the following files:
#Running 
```
PYTHONPATH=<PATH-TO-IMPROVE>:$PYTHONPATH
IMPROVE_DATA_DIR=<PATH-TO-IMPROVE-DATA-DIR>

python preprocess.py
python train.py (if you rerun this, it will use the checkpointed model and restart)

python infer.py
```

#NOTES
IMPROVE_DATA_DIR is the directory where the data is downloaded and preprocessed. It is also the place where the model checkpoints are stored. It also saves the model and inference output under the same directory.

All the above files read the configuration and hyperparameters from the file *fashion-mnist_default_model.txt*

The 3 subsections in *fashion-mnist_default_model.txt* are [preprocess], [train] and [infer]. The [preprocess] section is used by preprocess.py, [train] section is used by train.py and [infer] section is used by infer.py. Train has a few more parameters than the other two. It includes the checkpointing parameters. Checkpointing functions used in the model can be found [here]([text](https://candle-lib.readthedocs.io/en/latest/api_ckpt_pytorch_utils/_autosummary/candle.ckpt_pytorch_utils.CandleCkptPyTorch.html))

```
save_path='save/'
ckpt_save_best=True
ckpt_save_interval=1
```


Note that checkpointing is not enabled in the original python notebook, but it is enabled in train.py. See train.py for implementation details.

Directory Structure for IMPROVE:
IMPROVE_DATA_DIR should contain the following directory structure:
```
└── raw_data
    ├── splits
    ├── x_data
    └── y_data
```