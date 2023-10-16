#!/bin/bash

err_report() {
  echo "errexit on line $(caller)" >&2
}
trap err_report ERR


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
GPUID="${1:-0}"
BUILD_DATE="${BUILD_DATE:-"20230000"}"

pids=()

for n in $(ls $SCRIPT_DIR/../build/) ; do
	echo "running default $n"
	
	CMD="$SCRIPT_DIR/../test/test_image.sh $GPUID $n"
	echo "$CMD > $BUILD_DATE.$n.test.log 2>&1"
	
	$CMD > $BUILD_DATE.$n.test.log 2>&1 &
	pids+=($!)

        GPUID=$(( GPUID+1 ))
	echo "GPUID: $GPUID"

	# assumes 8 GPUs are available
	if (( GPUID > 7 )); then
		echo "all GPUs are in use"
		for pid in ${pids[@]}; do
			echo "waiting on PID: $pid"
    			wait $pid
		done
		GPUID=0
	fi
done
