#!/bin/bash

# For building Tensorflow container sandboxes
# TODO make Tensorflow or Pytorch options
CURRENT_DIR=$( pwd )
SCRIPT_DIR=$( dirname -- $0 )
BASE_DIR=${SCRIPT_DIR}/..
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${BASE_DIR}"
source config/improve.env


echo IHOME: $IHOME

Help()
{
	echo "Options:"
	echo "	-n: Required. Name for the image"
	echo "	-d: Path to Singularity definition file. Builds an image from specified definition"
	echo "	-t: Optional tag for Singularity definition file. Active only for -d option"
	echo "  -s: Do not log into newly created sandbox."
	echo ""
	echo "Environmental variables are specified in a file ../config/improve.env"
}

SANDBOX="true"
while getopts hsd:n:t: flag
do
	case "${flag}" in
		h) Help
			exit;;
		n) NAME=${OPTARG};;
		d) DEFINITION_FILE=${OPTARG};;
		s) SANDBOX="false";;
		t) TAG=${OPTARG};;
	esac
done

if [[ -z ${NAME} ]] ; then  
	echo "Name of the container is not set. -n option is required" 
	exit -1
elif [[ -z $DEFINITION_FILE ]] ; then
	echo "Definition file is not set. -d option is required"
	exit -1
else
	# only works if DEFINITION_FILE is relative path - add check here
	DEFINITION_FILE=${CURRENT_DIR}/${DEFINITION_FILE}
	echo Definition file: ${DEFINITION_FILE}
	echo "Name: ${NAME}"
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
if [[ -z "$TAG" ]] ; then
	TAG="0.0.1"
fi

IMAGE="$NAME:$TAG"
echo "building image: $IMAGE"
singularity build --fakeroot           \
	$IIL/$IMAGE-${DATE}.sif         \
	$DEFINITION_FILE

echo "building sandbox from image $IIL/${IMAGE}-${DATE}.sif"
echo "building sandbox at ${ISL}"

singularity build --fakeroot --sandbox      \
    		$ISL/${NAME}-$IMAGE-${DATE}  \
    		$IIL/${IMAGE}-${DATE}.sif

if [[ ${SANDBOX} != "false" ]] ; then
	exec ${SCRIPT_DIR}"/login.sh" "$ISL/${NAME}-${IMAGE}-${DATE}"
fi
