export IHOME=/homes/brettin/Singularity/workspace
export ISL=${IHOME}/sandboxes
export IIL=${IHOME}/images

bootstrap.sh uno

# Now inside the container

apt-get install -y git
apt-get install -y vim

cd /usr/local
git clone https://github.com/JDACS4C-IMPROVE/Benchmarks
pip install git+https://github.com/ECP-CANDLE/candle_lib.git
pip install tables

CUDA_VISIBLE_DEVICES=2 CANDLE_DATA_DIR=${HOME}/Singularity/workspace python Benchmarks/Pilot1/Uno/uno_baseline_keras2.py


