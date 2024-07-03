# This is a pre-processing script for the Fashion MNIST dataset in IMPROVE compliant format.
# This code requires PYTHONPATH to be set to the IMPROVE library
# It also requires fashion-mnist_default_model.txt

import torch
import torch.nn as nn
import torch.optim as optim
import torchvision
import torchvision.transforms as transforms

## IMPROVE
# Note for the line below we need to set pythonpath to IMPROVE library
from improve import framework as frm
from pathlib import Path
filepath = Path(__file__).resolve().parent
##


def run(params):
   # Part 1: Data Loading and Preprocessing

   # Download datasets (not necessary as we are using download=True in the next step)

   # # Define transformations for data preprocessing
   transform = transforms.Compose([
      transforms.ToTensor(),
      transforms.Normalize((0.5,), (0.5,))
   ])

   ## IMPROVE
   params = frm.build_paths(params)
   frm.create_outdir(outdir=params["ml_data_outdir"])  
   # Load Fashion MNIST dataset use datadir from params
   dataset_dir = params["data_dir"]
   trainset = torchvision.datasets.FashionMNIST(root=dataset_dir, train=True, download=True, transform=transform)
   testset = torchvision.datasets.FashionMNIST(root=dataset_dir, train=False, download=True, transform=transform)
   
   return params["ml_data_outdir"]
## IMPROVE
# Before calling the main function define any model/application specific parameters

app_preproc_params = [

    {"name": "batch_size", # default
     "type": int,
     "help": "Batch size for creating data loaders.",
    },
]

preprocess_params = app_preproc_params

req_preprocess_args = [ll["name"] for ll in preprocess_params]

def main():
    # Use the IMPROVE framework to initialize parameters
    params = frm.initialize_parameters(
        filepath,
        default_model="fashion-mnist_default_model.txt",
        additional_definitions=preprocess_params,
        required=req_preprocess_args,
    )

    ml_data_outdir = run(params)
    print("ml_data_outdir: ", ml_data_outdir)
    print("\nFinished FASHION-MNIST pre-processing.")


if __name__ == "__main__":
    main()

## END IMPROVE