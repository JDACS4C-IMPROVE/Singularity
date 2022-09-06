apt-get install -y git
apt-get install -y vim

cd /usr/local
git clone https://github.com/JDACS4C-IMPROVE/Benchmarks
pip install git+https://github.com/ECP-CANDLE/candle_lib.git
pip install tables

# This should run:
# CUDA_VISIBLE_DEVICES=2 CANDLE_DATA_DIR=${HOME}/Singularity/workspace python Benchmarks/Pilot1/ST1/srt_baseline_keras2.py
