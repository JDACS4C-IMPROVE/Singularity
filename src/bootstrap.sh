#!/bin/bash

# For building Tensorflow container sandboxes
# TODO make Tensorflow or Pytorch options

# arg1 = container name
DATE=$(date +%Y%m%d)
NAME="${1:-default}"


IHOME="${IHOME:-/homes/brettin/software/improve}"
export IHOME=${IHOME}
export IIL=${IHOME}/images
export ISL=${IHOME}/sandboxes
export IDL=${IHOME}/definitions


mkdir -p $IHOME
mkdir -p $IIL
mkdir -p $ISL
mkdir -p $IDL


# singularity version 3.9.4
# IMAGE="pytorch"  # pytorch/pytorch

# For tensorflow
TAG=":2.4.3-gpu"
TAG=":2.8.2-gpu"
IMAGE="tensorflow"${TAG}

echo "getting image: $IMAGE"
singularity build                \
	$IIL/$IMAGE-${DATE}.sif         \
	docker://tensorflow/$IMAGE

echo "building sandbox from image $IIL/${IMAGE}-${DATE}.sif"
echo "building sandbox at ${ISL}"

singularity build --fakeroot --sandbox      \
        $ISL/${NAME}-$IMAGE-${DATE}  \
        $IIL/${IMAGE}-${DATE}.sif

#echo "building sandbox from definition file ${IDL}/"
#singularity build --fakeroot --sandbox      \
#	$ISL/${NAME}-$IMAGE-${DATE}         \
#	$IDL/${IMAGE}-${DATE}.def

echo "logging into new container"
singularity shell --nv --fakeroot --writable \
	$ISL/${NAME}-${IMAGE}-${DATE}

## This would go in a new file for building the container
# Python 3.8.10 
# tf.__version__ 2.8.0

# pip install pandas, matplotlib
# mkdir -p /usr/local/improve/
# cd /usr/local/improve
