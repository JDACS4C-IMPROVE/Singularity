import torch
available_gpus = [torch.cuda.device(i) for i in range(torch.cuda.device_count())]
for n in available_gpus:
    print(n)
