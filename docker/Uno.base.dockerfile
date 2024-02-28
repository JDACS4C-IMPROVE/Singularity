From tensorflow/tensorflow:2.10.0-gpu


LABEL MAINTAINER="woz@anl.gov / weaverr@anl.gov"
LABEL VERSION v0.0.2





        # Available at runtime not build time
ENV     WORK_DIR="/usr/local"
ENV     BENCHMARK_DIR="Benchmarks/Pilot1"
ENV     MODEL="Uno_IMPROVE"
ENV     IMPROVE_MODEL_DIR="$WORK_DIR/$BENCHMARK_DIR/$MODEL"
ENV     PATH=$PATH:$IMPROVE_MODEL_DIR
ENV     CANDLE_DATA_DIR=/candle_data_dir
ENV     PYTHONPATH=$WORK_DIR/IMPROVE:$WORK_DIR/candle_lib:$PYTHONPATH


    # Install prerequisites and update image
    # See this thread for more information about apt-keys for NVIDIA:
    # https://forums.developer.nvidia.com/t/invalid-public-key-for-cuda-apt-repository/212901/18
    # apt-get install wget
    # apt-key del 7fa2af80
    # rm -v /etc/apt/sources.list.d/nvidia-ml.list /etc/apt/sources.list.d/cuda.list
    # wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
    # dpkg -i cuda-keyring_1.0-1_all.deb

    # Apt commands
 RUN   apt-get -y update && apt-get install -y git ed

WORKDIR /IMPROVE
COPY    src/Singularity_gpu_fix.sh ./
RUN     chmod a+x Singularity_gpu_fix.sh && ./Singularity_gpu_fix.sh
    # Singularity gpu fix

WORKDIR /candle_data_dir
# ensure the candle_data_dir is created


WORKDIR /usr/local

# Cloning candle and IMPROVE
RUN python3 -m pip install git+https://github.com/ECP-CANDLE/candle_lib@v0.6

RUN git clone -b develop https://github.com/JDACS4C-IMPROVE/IMPROVE.git
#RUN git clone -b develop https://github.com/ECP-CANDLE/candle_lib.git

    # Pip install packages
RUN python -m pip install pandas==2.0.3 scikit-learn==1.3.2 numpy==1.24.4 joblib==1.3.2 pillow==9.4.0 kiwisolver==1.4.5 pyyaml==6.0.1 pyarrow==9.0.0
RUN pip install tqdm
    # Get UNO model scripts
RUN git clone https://github.com/JDACS4C-IMPROVE/Benchmarks.git
RUN cd Benchmarks && git checkout preprocess_improve && chmod a+x Pilot1/Uno_IMPROVE/*.sh
    
