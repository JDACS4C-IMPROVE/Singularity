BUILD_DATE=${1:-${BUILD_DATE}}
export BUILD_DATE=${BUILD_DATE}

arr=( test_* )
i=$(( ${#arr[@]} - 1 ))

for m in $(seq 0 $i) ; do

	device=$(($m % 8))
	program=${arr[$device]}
	
	base=$(basename $program ".sh")
	date=$(date +"%Y%m%d")
	outfile=${date}-${base}.log

	echo "device: $device"
	echo "program: $program"
	echo "outfile: $outfile"

	cmd="$program $device > ../tests/$outfile 2>&1 &"
	echo $cmd

	#$cmd
	#pids[$device]=$!

	#if [ $device -eq 7 ] ; then
	#	for p in "${pids[@]}" ; do
	#		wait $p
	#	done	
	#fi

done
