# Singularity
Singularity definitions that can be extended to support execution of community models. These definition files range from base operating systems (ie Ubuntu 20.04) to fully configured containers. It is a best practice to build your immutable production containers directly from a Singularity definition file.





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
WORKSPACE=${HOME}/Singularity/workspace
IMAGES=${HOME}/Singularity/images

DEFFILE=improve-base-ubuntu-20_04-nvidia-driver-460.def
BASE=$(basename $DEFFILE .def)

sudo singularity build $IMAGES/$BASE $DEFFILE
sudo singularity build --sandbox $WORKSPACE/$BASE $DEFFILE
sudo singularity build ${IMAGES}/${BASE}.sif ${WORKSPACE}/${BASE}
```

## Setting up a model for IMPROVE

Use care when converting a sandbox directory to the default SIF format. If changes were made to the writable container before conversion, there is no record of those changes in the Singularity definition file rendering your container non-reproducible. It is a best practice to build your immutable production containers directly from a Singularity definition file instead.

```
# Download an image from dockerhub. Here you can get the latest tensorflow images.
singularity build images/latest-gpu.sif docker:tensorflow/tensorflow:latest-gpu

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



