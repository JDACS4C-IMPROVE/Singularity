#!/bin/bash

# For building Tensorflow container sandboxes
# TODO make Tensorflow or Pytorch options
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}"/../config/improve.env"

echo $IHOME

Help()
{
	echo "Options:"
	echo "	-n: Required. Name for the image"
	echo "	-f: Build a base image for a framework. Acceptable values are: 'pytorch', 'tensorflow'. If -d option is specified, then -f is ignored."
	echo "	-d: Path to Singularity definition file. Builds an image from specified definition"
	echo "	-t: Tag for Singularity definition file. Active only for -d option"
	echo
	echo "Environmental variables are specified in a file ../config/improve.env"
	echo "Build-specific variables are specified in a file ../config/build.config"
	echo "Runtime variables are specified in a file ../config/improve.env"
}

SANDBOX="true"
while getopts hsf:d:n:t: flag
do
	case "${flag}" in
		h) Help
			exit;;
		n) NAME=${OPTARG};;
		d) DEFINITION_FILE=${OPTARG};;
		f) FRAMEWORK=${OPTARG};;
		s) SANDBOX="false";;
		t) TAG=${OPTARG};;
	esac
done

if [[ -z "$NAME" ]] ; then  
	echo "Name of the container is not set. -n option is required" 
	exit -1
fi

echo $DEFINITION_FILE
echo $FRAMEWORK

if [[ -z "$DEFINITION_FILE" ]] && [[ -z "$FRAMEWORK" ]] ; then  
	echo "Neither definition file nor base framework specified."
        echo "One of the -f or -d options should be specified."	
	exit -1
fi

DATE=$(date +%Y%m%d)

export IIL=${IHOME}/images
export ISL=${IHOME}/sandboxes
export IDL=${IHOME}/definitions


mkdir -p $IHOME
mkdir -p $IIL
mkdir -p $ISL
mkdir -p $IDL

# singularity version 3.9.4



if [[ ! -z "$DEFINITION_FILE" ]] ; then
	if [[ -z "$TAG" ]] ; then
		TAG="0.0.1"
	fi
	IMAGE="$NAME:$TAG"
	echo "building image: $IMAGE"
	singularity build --fakeroot           \
		$IIL/$IMAGE-${DATE}.sif         \
		$DEFINITION_FILE

else
	if [[ $FRAMEWORK = "tensorflow" ]] ; then
		IMAGE="tensorflow:"${TENSORFLOW_TAG}
		URI="tensorflow/"${IMAGE}
	elif [[ $FRAMEWORK = "tensorflow-gpu" ]] ; then
		IMAGE="tensorflow-gpu:"${TENSORFLOW_TAG}
		URI="tensorflow/"${IMAGE}
	elif [[ $FRAMEWORK = "pytorch" ]] ; then
		IMAGE="pytorch:"${PYTORCH_TAG}
		URI="pytorch/"${IMAGE}
	else
		echo "invalid framework: ${FRAMEWORK}"
		exit -1
	fi

	echo "getting image: $IMAGE"
	singularity build                \
		$IIL/$IMAGE-${DATE}.sif         \
		docker://${URI}
fi

echo "building sandbox from image $IIL/${IMAGE}-${DATE}.sif"
echo "building sandbox at ${ISL}"

if [ ${SANDBOX} == "true" ] ; then
  singularity build --fakeroot --sandbox      \
        $ISL/${NAME}-$IMAGE-${DATE}  \
        $IIL/${IMAGE}-${DATE}.sif

  source ${SCRIPT_DIR}"/login.sh" "$ISL/${NAME}-${IMAGE}-${DATE}"
fi
