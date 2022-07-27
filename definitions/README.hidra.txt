
apt-get update
apt-get install git
apt-get install vim
pip install git+https://github.com/ECP-CANDLE/candle_lib@develop
pip install pandas
pip install seaborn
pip install rdkit

cd /usr/local
git clone file:///root/Singularity/workspace/HiDRA



# END #
#
# See test.sh for examples of running the model before
# standardizing on candle_lib.
