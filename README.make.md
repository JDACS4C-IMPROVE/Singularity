# Building model singularity container

Model container can be build and deployed using make. To build all container invoke `make` from within the top level directory of this repository. This will build and test the container in the build directory and copy the finished container into the deploy directory. Default directory for deploying containers is *./images*. The deploy dir can be set by passing a different value for **PREFIX**  on the command line:


```bash
make -j 3 PREFIX=/home/brettin/deploy_dir
```

The Makefile has following targets:
- configure
- build
- test
- deploy
- clean
