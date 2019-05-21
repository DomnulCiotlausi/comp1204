#!/bin/bash
cd $1

for f in *
do
	filename=${f%.*}
	filename="${filename##*/}"
	awk -v name=$filename -F "<Overall>" 'NF>1 {sum+=$2; c++} END {printf "%s %0.2f\n", name, sum/c}' $f
done | sort -r -k2 -g

