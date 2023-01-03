#!/bin/bash

BUILD_DATE=${1:-${BUILD_DATE}}
# need a check for build date not set
if [ -z "$BUILD_DATE" ] ; then
	echo "BUILD_DATE not set"
	exit
else
	echo "BUILD_DATE: $BUILD_DATE"
	export BUILD_DATE=${BUILD_DATE}
fi

arr=( test_* )
i=$(( ${#arr[@]} - 1 ))

echo ${#arr[#]}

for m in $(seq 0 $i) ; do

	device=$(($m % 8))
	program=${arr[$device]}
	
	base=$(basename $program ".sh")
	date=$(date +"%Y%m%d")
	outfile=${date}-${base}.log

	echo "device: $device"
	echo "program: $program"
	echo "outfile: $outfile"

	echo "cmd: ./$program $device > ../tests/$outfile 2>&1"
	./$program $device > ../tests/$outfile 2>&1 &

	# right now, there are less than 8 tests

	pids[$device]=$!

	if [ $device -eq 7 ] ; then
		for p in "${pids[@]}" ; do
			wait $p
		done	
	fi

done
