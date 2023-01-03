### Building an IMPROVE Container

#### Using bootstrap.sh

```
Options:
    -n: Required. Name for the image
    -d: Required. Path to Singularity definition file.
    -t: Tag for Singularity definition file. Active only for -d option. Default value is 0.0.1
    -s: If set, the user will not be logged into the newly built sandbox.
    -h: Help

Environmental variables are specified in a file ../config/improve.env
Runtime variables are specified in a file ../config/run.config
```

#### Building from definition file

In order to build a container from a definition file, you have to write that definintion file. While writing the definition file, you might rebuild the container several times. The bootstrap.sh script was developed to provide some automation in the iterative cycle of writing a definition file.

There are definition files in the definitions directory of the Singularity repository. Your definition file can start by using a pre-built improve image that has tensorflow or pytorch already installed along with candle_lib, or your definition file can start by using a deep learning docker image from dockerhub such as tensorflow/tensorflow:latest-gpu.

Definition files for images should be committed to the definitions directory of the Singularity repository.

Custom containers can be built using the bootstrap.sh command, for example:
```
cd Singularity
./src/bootstrap.sh -d definitions/GraphDRP.def -n GraphDRP
```

When bootstrap.sh is done running with no errors, you will be automatically logged into the sandbox. This can be disabled with the -s option to bootstrap.sh.


#### Testing during the process of developing the definition file
The following is an iterative process that likely requires rebuilding the container several times as the definition file is updated.

1.  Build a container bootstrapped from a base image (Bootstrap: docker From: pytorch/pytorch for example). THis starts with a very simple definition file that can be passed to bootstrap.sh. If the container build is successful, you will be logged into the container sandbox.

3.  Clone model repository, install dependencies and update definition file until the community model is running.

2.  From within the container, demonstrate that the train.sh runs the community model. In this case, CANDLE_DATA_DIR can be any path within the container. See: https://github.com/JDACS4C-IMPROVE/Singularity/blob/master/src/templates/train.sh

```
# from within the container
CUDA_VISIBLE_DEVICES=0
CANDLE_DATA_DIR=/candle_data_dir
CANDLE_CONFIG=/usr/local/GraphDRP/graphdrp_default_model.txt

train.sh $CUDA_VISIBLE_DEVICES $CANDLE_DATA_DIR $CANDLE_CONFIG
```

3.  Demonstrate that train.sh can be invoked from outside the container. These variables are set outside the container and passed in. NOTE: the path that is assigned to CANDLE_CONFIG is relative to IMPROVE_DATA_DIR on the host, and CANDLE_DATA_DIR inside the container.
```
# from the host system
CUDA_VISIBLE_DEVICES=0
IMPROVE_DATA_DIR=/path/to/host/data_dir
CANDLE_CONFIG=uno_default_model.txt

singularity exec --nv --bind $IMPROVE_DATA_DIR:/candle_data_dir <image or sandbox path/name> train.sh $CUDA_VISIBLE_DEVICES $CANDLE_DATA_DIR $CANDLE_CONFIG
```
In the above example, the model config file would exist at $IMPROVE_DATA_DIR/uno_default_model.txt on the host. Thus, the CANDLE_CONFIG is relative to IMPROVE_DATA_DIR on the host and /candle_data_dir inside the container.

4. Build a non-writable image from the sandbox and run train.sh
```
singularity build --fakeroot images/tensorflow\:1.9.0-gpu-py3-hidra.sif workspace/tensorflow\:1.9.0-gpu-py3-hidra
CUDA_VISIBLE_DEVICES=1 singularity exec --nv images/tensorflow\:1.9.0-gpu-py3-hidra.sif /usr/local/src/HiDRA/test.sh
```
