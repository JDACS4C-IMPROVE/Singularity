echo "logging into new container"
source "../config/run.config"
singularity shell --nv --fakeroot --writable --bind $IDD:/candle_data_dir $1
