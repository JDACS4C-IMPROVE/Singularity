import torch
import torch.nn as nn
import torch.optim as optim
import torchvision
import torchvision.transforms as transforms
import candle

# Part 2: Model Training
## IMPROVE
from improve import framework as frm

from pathlib import Path

filepath = Path(__file__).resolve().parent
##

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
def run(params):
##
   # # Define transformations for data preprocessing
   transform = transforms.Compose([
      transforms.ToTensor(),
      transforms.Normalize((0.5,), (0.5,))
   ])
   
   # Get the data directory, batch size and other hyperparameters from params 
   ##IMPROVE 
   dataset_dir = params["data_dir"]
   batch_size = params["batch_size"]
   learning_rate = params["learning_rate"]
   epochs = params["epochs"]
   momentum = params["momentum"]
   ##
   
   # NOTE: using false now for data loading
   trainset = torchvision.datasets.FashionMNIST(root=dataset_dir, train=True, download=False, transform=transform)
   trainloader = torch.utils.data.DataLoader(trainset, batch_size=batch_size, shuffle=True)

   # Check if GPU is available, else use CPU
   device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
   
   # Create a neural network model
   model = Net().to(device)

   # Define loss function and optimizer
   criterion = nn.CrossEntropyLoss()
   optimizer = optim.SGD(model.parameters(), lr=learning_rate, momentum=momentum)

   ##IMPROVE
   # Use CANDLE checkpointing
   ckpt = candle.CandleCkptPyTorch(params)
   ckpt.set_model({"model": model, "optimizer": optimizer})
   J = ckpt.restart(model)
   if J is not None:
      initial_epoch = J["epoch"]
      print("restarting from ckpt: initial_epoch: %i" % initial_epoch)
   ##
   
   # Train the model
   for epoch in range(epochs):
      running_loss = 0.0
      for i, data in enumerate(trainloader, 0):
         inputs, labels = data

         optimizer.zero_grad()

         outputs = model(inputs)
         loss = criterion(outputs, labels)
         loss.backward()
         optimizer.step()

         running_loss += loss.item()
         if i % 200 == 199:
               print(f'Epoch: {epoch + 1}, Batch: {i + 1}, Loss: {running_loss / 200}')
               running_loss = 0.0
      # set loss and ckpt
      loss = running_loss / len(trainloader)
      ckpt.ckpt_epoch(epoch, loss)
   print('Training finished.')
   

  
## IMPROVE
#Note some parameters are pre-defined in the framework and any additional parameters can be defined here``
model_train_params = [

    {"name": "data_dir", # default
     "type": str,
     "help": "Directory containing the Fashion MNIST dataset.",
    },
]

train_params = [

    {"name": "batch_size", # default
     "type": int,
     "help": "Batch size for creating data loaders.",
    },
]

# train_params = app_train_params + model_preproc_params
req_train_args = [ll["name"] for ll in train_params]

def main():
   # Use the IMPROVE framework to initialize parameters
    params = frm.initialize_parameters(
        filepath,
        default_model="fashion-mnist_default_model.txt",
        additional_definitions=model_train_params,
        required=req_train_args,
    )
    run(params)


if __name__ == "__main__":
    main()

## END IMPROVE