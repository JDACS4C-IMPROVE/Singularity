import torch
import torch.nn as nn
import torch.optim as optim
import torchvision
import torchvision.transforms as transforms

# Define the neural network model
class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.fc1 = nn.Linear(784, 256)
        self.fc2 = nn.Linear(256, 128)
        self.fc3 = nn.Linear(128, 10)

    def forward(self, x):
        x = x.view(x.size(0), -1)
        x = torch.relu(self.fc1(x))
        x = torch.relu(self.fc2(x))
        x = self.fc3(x)
        return x

## IMPROVE
from improve import framework as frm
import candle
from pathlib import Path

filepath = Path(__file__).resolve().parent


# Part 3: Model Testing
## IMPROVE
def run(params):
##

   # Need to get testloader from Part 1.
   transform = transforms.Compose([
      transforms.ToTensor(),
      transforms.Normalize((0.5,), (0.5,))
   ])
   
   # Get the data directory, batch size and other hyperparameters from params 
   ##IMPROVE 
   batch_size = params["batch_size"]
   learning_rate = params["learning_rate"]
   momentum = params["momentum"]
   dataset_dir = params["data_dir"]
   
   # NOTE: using false now for data loading
   testset = torchvision.datasets.FashionMNIST(root=dataset_dir, train=False, download=False, transform=transform)
   testloader = torch.utils.data.DataLoader(testset, batch_size=batch_size, shuffle=True)

   # Check if GPU is available, else use CPU
   device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
   
   # Create a neural network model
   model = Net().to(device)

   # Define optimizer
   optimizer = optim.SGD(model.parameters(), lr=learning_rate, momentum=momentum)

   ##IMPROVE 
   # Use CANDLE checkpointing to load the model weights for inferencing
   ckpt = candle.CandleCkptPyTorch(params)
   ckpt.set_model({"model": model, "optimizer": optimizer})
   J = ckpt.restart(model)
   ## 

   correct = 0
   total = 0
   with torch.no_grad():
      for data in testloader:
         images, labels = data
         outputs = model(images)
         _, predicted = torch.max(outputs.data, 1)
         total += labels.size(0)
         correct += (predicted == labels).sum().item()

   print(f'Accuracy on test set: {(100 * correct / total):.2f}%')




## IMPROVE
# Note some of these are similar to previous section and may be adjusted as per model requirements
model_infer_params = [

    {"name": "data_dir", # default
     "type": str,
     "help": "Directory containing the Fashion MNIST dataset.",
    },
]

infer_params = [

    {"name": "batch_size", # default
     "type": int,
     "help": "Batch size for creating data loaders.",
    },
]

req_infer_args = [ll["name"] for ll in infer_params]

def main():
    params = frm.initialize_parameters(
        filepath,
        default_model="fashion-mnist_default_model.txt",
        additional_definitions=model_infer_params,
        required=req_infer_args,
    )
    run(params)

if __name__ == "__main__":
    main()

## END IMPROVE