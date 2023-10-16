#!/bin/bash
DATE=$(date +%Y%m%d)
LOGDIR=/home/brettin/Singularity/tests

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BASE_DIR=${SCRIPT_DIR}/..
cd "${BASE_DIR}"


./src/bootstrap.sh -s -n DeepTTC -d definitions/DeepTTC.def > ${LOGDIR}/build.DeepTTC.${DATE} 2>&1
./src/bootstrap.sh -s -n DrugGCN -d definitions/DrugGCN.def > ${LOGDIR}/build.DrugGCN.${DATE} 2>&1
./src/bootstrap.sh -s -n GraphDRP -d definitions/GraphDRP.def > ${LOGDIR}/build.GraphDRP.${DATE} 2>&1
./src/bootstrap.sh -s -n HiDRA -d definitions/HiDRA.def > ${LOGDIR}/build.HiDRA.${DATE} 2>&1
./src/bootstrap.sh -s -n IGTD -d definitions/IGTD.def > ${LOGDIR}/build.IGTD.${DATE} 2>&1
./src/bootstrap.sh -s -n Paccmann_MCA -d definitions/Paccmann_MCA.def > ${LOGDIR}/build.Paccmann_MCA.${DATE} 2>&1
./src/bootstrap.sh -s -n tCNNS -d definitions/tCNNS.def > ${LOGDIR}/build.tCNNS.${DATE} 2>&1
