
# Create a clean working directory and clone the Singularity rep
#

mkdir -p /home/brettin/build_dir && cd /home/brettin/build_dir
git clone https://github.com/JDACS4C-IMPROVE/Singularity
cd Singularity

# Run make
#

make --PREFIX=/home/brettin/build_dir
