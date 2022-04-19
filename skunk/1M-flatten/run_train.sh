#!/bin/bash
#
# arg1 = --in_train
# arg2 = --in_vali
# arg3 = GPU Device

EXE="singularity exec --nv /lambda_stor/software/improve/containers/regress_transformer-tensorflow-latest-gpu-20220412 python smiles_regress_transformer.py --in_train $1 --in_vali $2"

echo $EXE
echo ""

base=$(basename $1 .train)
base=$(basename $base .val)

echo $base
echo ""

mkdir -p DIR.$base
/bin/cp -n $1 DIR.$base
/bin/cp -n $2 DIR.$base
/bin/cp smiles_regress_transformer.py  DIR.$base

cd DIR.$base
CUDA_VISIBLE_DEVICES=$3 $EXE --ep 200 --in_train $1 --in_vali $2 > output.log.$$ 2>&1
cd ..
#rm -r DIR.$1
