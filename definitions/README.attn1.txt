export IHOME=/home/brettin/Singularity/workspace
bootstrap.sh attn

# Now inside the container

apt-get install git

git clone https://github.com/JDACS4C-IMPROVE/Benchmarks
pip install git+https://github.com/ECP-CANDLE/candle_lib.git
pip install tables

git clone https://github.com/JDACS$C-IMPROVE/Singularity
cp Singularity/src/train.sh /usr/local/bin/
chmod a+x /usr/local/bin/train.sh

# edit train.sh to have the right model executable

CANDLE_DATA_DIR=${HOME}/Singularity/workspace python Benchmarks/Pilot1/Attn/attn_baseline_keras2.py
