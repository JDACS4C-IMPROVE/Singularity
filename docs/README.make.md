# Building model singularity container

Model container can be build and deployed using make. To build all container invoke ```make``` from within the top level directory of this repository. This will build and test the container in the build directory and copy the finished container into the deploy directory. Default directory for deploying containers is *./images*. The deploy dir can be set by passing a different value for **PREFIX**  on the command line:

Build and deploy container:

```bash
cd Singularity
make
make deploy PREFIX=~/mySingularityContainer
```


## Makefile targets

### configure ###

Creates **BUILD_DIR**, **TEST_DIR** and **DEPLOY_DIR**

### build ###

Depends on the **configure** target and all definitions files in *./definitions*. Executes the `singularity build` command on every definition file and creates a sif file in *./build*.

### test ###

Runs a test on every sif file in the *./build* directory. 

### deploy ###

Deploys the sif files into *./images* or *PREFIX/images*

### clean ###

Removes files from **BUILD_DIR** and **TEST_DIR**.
