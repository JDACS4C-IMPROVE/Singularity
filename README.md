# IMPROVE Containers
Each curated community model is deployed in a Singularity container that is extended to support standardized execution of all currated community models.

### Running an IMPROVE Container

```
CUDA_VISIBLE_DEVICES=0
CANDLE_DATA_DIR=/homes/brettin/Singularity/workspace/data_dir
CANDLE_CONFIG=/homes/brettin/Singularity/workspace/configs/st1_regress_default_model.txt

singularity exec --nv images/st1-tensorflow\:2.8.2-gpu-20220624.sif train.sh $CUDA_VISIBLE_DEVICES $CANDLE_DATA_DIR $CANDLE_CONFIG
```

### Building an IMPROVE Container

#### Using a prebuilt pytorch or tensorflow image from DockerHub.

```
export IHOME=/homes/brettin/Singularity/workspace
bootstrap.sh <name>

# See: https://github.com/JDACS4C-IMPROVE/Singularity/blob/master/src/bootstrap.sh
```

1.  Install dependencies and record what was done for later creation of a definition file.

2.  Demonstrate that the community model runs inside the container.

3.  Demonstrate that the train.sh runs the community model inside the container.

```
train.sh $CUDA_VISIBLE_DEVICES $CANDLE_DATA_DIR $CANDLE_CONFIG

# See: https://github.com/JDACS4C-IMPROVE/Singularity/blob/master/src/train.sh
```

4.  Denonstrate that train.sh can be invoked from outside the container.
```
# These are set outside the container and passed in

IHOME=/homes/brettin/Singularity/workspace
CUDA_VISIBLE_DEVICES=0
CANDLE_DATA_DIR=${IHOME}/data_dir
CANDLE_CONFIG=${IHOME}/configs/uno_default_model.txt

singularity exec --nv <image or sandbox path/name> train.sh $CUDA_VISIBLE_DEVICES $CANDLE_DATA_DIR $CANDLE_CONFIG
```

#### Using an IMPROVE container from $IHOME/sandboxes or $IHOME/images. 

# from a sandbox

singularity build --fakeroot --sandbox $ISL/${IMAGE} $ISL/${NAME}-$IMAGE-${DATE}

# or from an image

singularity build --fakeroot --sandbox $ILL/${IMAGE} $ISL/${NAME}-$IMAGE-${DATE}

### Best Practices for Build Recipes
see: (https://sylabs.io/guides/3.7/user-guide/definition_files.html)

When crafting your recipe, it is best to consider the following:

- Always install packages, programs, data, and files into operating system locations (e.g. not /home, /tmp , or any other directories that might get commonly binded on).
- Document your container. If your runscript doesn’t supply help, write a %help or %apphelp section. A good container tells the user how to interact with it.
- If you require any special environment variables to be defined, add them to the %environment and %appenv sections of the build recipe.
- Files should always be owned by a system account (UID less than 500).
- Ensure that sensitive files like /etc/passwd, /etc/group, and /etc/shadow do not contain secrets.
- Build production containers from a definition file instead of a sandbox that has been manually changed. This ensures greatest possibility of reproducibility and mitigates the “black box” effect.

## Basic commands
Create a singularity container from a def file. In the first case, an image is created.
In the second example, a writable container is created.
In the third example, an image is created from a writable container.

```
# Here we use as a psuedo standard the workspace directory for writable containers.
# IMPROVE environment variables begin with I
export IHOME=/homes/brettin/Singularity/workspace
export ISL=${IHOME}/sandboxes
export IIL=${IHOME}/images

singularity build --sandbox ${ISL}/${SANDBOX} $DEFILE
singularity build $IIL/${SANDBOX}.sif ${ISL}/${SANDBOX}
singularity build $IIL/${IMAGE}.sif $DEFFILE



```

## Setting up a model for IMPROVE

Use care when converting a sandbox directory to the default SIF format. If changes were made to the writable container before conversion, there is no record of those changes in the Singularity definition file rendering your container non-reproducible. It is a best practice to build your immutable production containers directly from a S:wqingularity definition file instead.

```
# Download an image from dockerhub. Here you can get the latest tensorflow images.
singularity build images/latest-gpu.sif docker://tensorflow/tensorflow:latest-gpu

# Create a writiable container from the image. For now, sudo is needed until
# the fakeroot option can be enabled by adding users to /etc/subuid and /etc/subgid.
sudo singularity build --nv --sandbox workspace/latest-gpu-uno images/latest-gpu.sif

# Log into the singularity container and install necessary dependancies
# for the model of interest.
sudo singularity shell --nv --writable workspace/latest-gpu-uno
```


Creating a writable container from an image in the images directory (cd images)

```
cd images/
sudo singularity build --sandbox ../workspace/latest-gpu-uno  latest-gpu docker://tensorflow/tensorflow:latest-gpu `
```

```
Building into existing container: ../workspace/latest-gpu-uno
Building from local image: latest-gpu
Singularity container built: ../workspace/latest-gpu-uno
Cleaning up...
```

Installing the environment for the model requires logging into the container 

` sudo singularity shell --writable --nv $HOME/Singularity/workspace/latest-gpu `

## Conda

```
cd /usr/local/src
curl -o Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod u+x Miniconda3-latest-Linux-x86_64.sh 
./Miniconda3-latest-Linux-x86_64.sh 
```

when prompted, install miniconda here
/usr/local/miniconda3

` export PATH=$PATH:/usr/local/miniconda3/bin `

install pytables blosc<1.19 
install candle
run uno

## Transforming your conda environment into a singularity container
Notes:
First, try to use only conda to build the environment.
Try to install as many conda packages as possible with a single conda install command
Once you have the environment, start with the appropriate docker or singularity container.
  For Tensorflow based models, start with a docker image from dockerhub
  https://hub.docker.com/r/tensorflow/tensorflow/
  
For the Hidra model:
Dump Jamies conda environment
Identify python version and tensorflow version

### Download an appropriate image.
The fakeroot option can be enabled by adding users to /etc/subuid and /etc/subgid.
The fakeroot optiom may not work on a network attached filesystem. In this case, you can use /tmp and copy your work back to the shared filesystem before you finish for the day.
`singularity build --fakeroot images/tensorflow:1.9.0-gpu-py3.sif docker://tensorflow/tensorflow:1.9.0-gpu-py3`

### Create a writiable container from the image.
`singularity build --fakeroot --nv --sandbox workspace/tensorflow:1.9.0-gpu-py3-hidra images/tensorflow:1.9.0-gpu-py3.sif`

### Installing the environment for the model requires logging into the container

```
singularity shell --fakeroot --writable --nv --net workspace/latest-gpu`
Singularity> whoami
root
```

### Build the conda environment

```
Singularity> cd /tmp/Singularity/workspace/tensorflow:1.9.0-gpu-py3-hidra/usr/local/src
Singularity> curl -o Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
Singularity> chmod u+x Miniconda3-latest-Linux-x86_64.sh 
Singularity> ./Miniconda3-latest-Linux-x86_64.sh
Singularity> export PATH=$PATH:/usr/local/miniconda3/bin
Singularity> conda env create -f hidra_env_tf1.yml
Singularity> source activate hidra_env_tf1.yml
```

### Installing the model code from the IMPROVE-JDACAS4C github organization.
When trying to install git, apt-get was unable to resolve 

```
Singularity> apt-get install git
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package git
...
```

Similarly, apt-get update returned an error as well.

```
Singularity> apt-get update
Err:1 http://archive.ubuntu.com/ubuntu xenial InRelease
  Temporary failure resolving 'archive.ubuntu.com'
...
```

Adding a valid nameserver to the /etc/resolv.conf file solved this issue. The nameserver added is one of Googles.

```
Singularity> cat >> /etc/resolv.conf 
nameserver 8.8.8.8
```
Consider testing these:

![image](https://user-images.githubusercontent.com/991769/155187883-473c94cd-ebf9-4fd7-840a-b6403e3830d9.png)


Now apt-get worked properly.

```
Singularity> apt-get update
Singularity> apt-get install git
```

### Install, test and debug the model code from the github.com/IMPROVE-JDACS4C/HiDRA

```
git clone https://github.com/JDACS4C-IMPROVE/HiDRA.git
cd HiDRA
./test.sh
```

### Build and test an image from the sandbox
```
singularity build --fakeroot images/tensorflow\:1.9.0-gpu-py3-hidra.sif workspace/tensorflow\:1.9.0-gpu-py3-hidra
CUDA_VISIBLE_DEVICES=1 singularity exec --nv images/tensorflow\:1.9.0-gpu-py3-hidra.sif /usr/local/src/HiDRA/test.sh
```
