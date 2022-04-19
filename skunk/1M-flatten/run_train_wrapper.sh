#!/bin/bash

# file of dataframe names in the form of ml.3CLPRO_1.dsc.csv.reg.csv
df_file=$1

num_devices=8

i=0
for n in $(cat $df_file)  ; do
  
  device=$(( $i % $num_devices ))

  
  echo "data: $n"
  echo "device: $device"

  train=${n}.train
  val=${n}.val

  ./run_train.sh $train $val $device > run_train.$n.log 2>&1 &


  i=$(( $i + 1 ))

  # wait for num_devices to finish, then launch more
  if [ $(($i % $num_devices)) -eq "0" ] ; then
    echo "calling wait"
    wait
  fi

done

wait
