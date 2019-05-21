#!/bin/bash
cd $1
declare -a arr

arr=($(grep -c "<Author>" * | sort -t : -k 2 -n -r))

for el in "${arr[@]}"
do
	echo "$el" | awk -F '.dat:' '{print $1, $2}'
done
