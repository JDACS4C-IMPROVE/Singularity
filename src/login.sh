echo "logging into new container"
source "../config/run.config"
singularity shell --nv --fakeroot --writable $1
