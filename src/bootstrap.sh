#!/bin/bash

# For building Tensorflow container sandboxes
# TODO make Tensorflow or Pytorch options
FRAMEWORK="tensorflow"

if [[ "$#" -ne 1 ]] ; then
    echo "Illegal number of parameters"
    echo "Requires container name"
    exit -1
fi

DATE=$(date +%Y%m%d)
NAME="$1"


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

if [[ $FRAMEWORK = "tensorflow" ]] ; then
	# TAG=":2.4.3-gpu"
	TAG=":2.8.2-gpu"
	IMAGE="tensorflow"${TAG}
	URI="tensorflow/"${IMAGE}
elif [[ $FRAMEWORK = "pytorch" ]] ; then
	TAG=":1.11.0-cuda11.3-cudnn8-devel"
	IMAGE="pytorch"${TAG}
	URI="pytorch/"${IMAGE}
else
	echo "invalid framework: ${FRAMEWORK}"
	exit -1
fi

echo "getting image: $IMAGE"
singularity build                \
	$IIL/$IMAGE-${DATE}.sif         \
	docker://${URI}

echo "building sandbox from image $IIL/${IMAGE}-${DATE}.sif"
echo "building sandbox at ${ISL}"

singularity build --fakeroot --sandbox      \
        $ISL/${NAME}-$IMAGE-${DATE}  \
        $IIL/${IMAGE}-${DATE}.sif

echo "logging into new container"
singularity shell --nv --fakeroot --writable \
	$ISL/${NAME}-${IMAGE}-${DATE}
