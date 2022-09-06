IHOME="${IHOME:-/homes/brettin/software/improve}"
export IHOME=${IHOME}
export IIL=${IHOME}/images
export ISL=${IHOME}/sandboxes
export IDL=${IHOME}/definitions

DATE=$(date +%Y%m%d)
# name of new image to be used as prefix to name new container
NAME=tensorboard_plugin_profile # $1

# IMAGE (or sandbox) for smile_regress_transformer.py
IMAGE=regress_transformer-tensorflow-latest-gpu-20220412 # $2

ISL=$IHOME/sandboxes
ILL=$IHOME/images

# from a sandbox
#singularity build --fakeroot --sandbox \
singularity build --sandbox \
	$ISL/${NAME}-$IMAGE-${DATE} \
	$ISL/${IMAGE}

# or from an image
#singularity build --fakeroot --sandbox \
#	$ILL/${IMAGE} \
#	$ISL/${NAME}-$IMAGE-${DATE}
