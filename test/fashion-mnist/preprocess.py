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

## IMPROVE put in a function called run

def run(params):
   # Part 1: Data Loading and Preprocessing

   # Download datasets (not necessary as we are using download=True in the next step)

   # # Define transformations for data preprocessing
   transform = transforms.Compose([
      transforms.ToTensor(),
      transforms.Normalize((0.5,), (0.5,))
   ])

   # Load Fashion MNIST dataset
   ## IMPROVE
   dataset_dir = params["data_dir"]
   ##
   trainset = torchvision.datasets.FashionMNIST(root=dataset_dir, train=True, download=True, transform=transform)
   testset = torchvision.datasets.FashionMNIST(root=dataset_dir, train=False, download=True, transform=transform)

   # Create data loaders
   ## IMPROVE
   batch_size = params["batch_size"]
   trainloader = torch.utils.data.DataLoader(trainset, batch_size=batch_size, shuffle=True)
   testloader = torch.utils.data.DataLoader(testset, batch_size=batch_size, shuffle=False)
   ##
## IMPROVE
model_preproc_params = [

    {"name": "data_dir", # default
     "type": str,
     "help": "Directory containing the Fashion MNIST dataset.",
    },
]

app_preproc_params = [

    {"name": "batch_size", # default
     "type": int,
     "help": "Batch size for creating data loaders.",
    },
]

preprocess_params = app_preproc_params + model_preproc_params

req_preprocess_args = [ll["name"] for ll in preprocess_params]

def main():
    params = frm.initialize_parameters(
        filepath,
        default_model="fashion-mnist_default_model.txt",
        additional_definitions=preprocess_params,
        required=req_preprocess_args,
    )
    # processed_outdir = run(params)
    ml_data_outdir = run(params)
    print("\nFinished FASHION-MNIST pre-processing.")


if __name__ == "__main__":
    main()

## END IMPROVE