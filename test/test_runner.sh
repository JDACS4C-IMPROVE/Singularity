export DATE=${1:-"20221215"}

for n in test_* ; do
	b=$(basename $n ".sh")
	d=$(date +"%Y%m%d")
	echo $n
	echo ${d}-${b}
	./$n | tee ../tests/${d}-${b}.log
done
