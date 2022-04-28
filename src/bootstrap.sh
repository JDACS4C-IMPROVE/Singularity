#!/bin/bash

export IHOME=/home/brettin/software/improve
export IIL=${IHOME}/images
export ICL=${IHOME}/containers
export IDL=${IHOME}/definitions

# export ICL=/tmp/containers
DATE=$(date +%Y%m%d)
NAME="${1:-default}" 

mkdir -p $IHOME
mkdir -p $IIL
mkdir -p $ICL
mkdir -p $IDL


# singularity version 3.9.4
# IMAGE="pytorch"  # pytorch/pytorch

# For tensorflow
TAG=":2.8.0-gpu"
IMAGE="tensorflow"${TAG}

echo "getting image: $IMAGE"
singularity build                \
	$IIL/$IMAGE-${DATE}.sif         \
	docker://tensorflow/$IMAGE

echo "building sandbox"
singularity build --fakeroot --sandbox      \
        $ICL/${NAME}-$IMAGE-${DATE}  \
        $IIL/${IMAGE}-${DATE}.sif

echo "logging into new container"
singularity shell --nv --fakeroot --writable \
	$ICL/${NAME}-${IMAGE}-${DATE}

## This would go in a new file for building the container
# Python 3.8.10 
# tf.__version__ 2.8.0

# pip install pandas, matplotlib
# mkdir -p /usr/local/improve/
# cd /usr/local/improve
