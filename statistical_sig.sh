first=$(grep "<Overall>" $1/$2.dat |  sed 's/.*>//' | awk -v name=$2 '{
	for(i=1;i<=NF;i++) {
		sum[i] += $i; 
		sumsq[i] += ($i)^2;
	}
}  END {
	for (i=1;i<=NF;i++) { 
		printf "Mean %s : %0.2f, SD: %0.2f \n", name, sum[i]/NR,sqrt((sumsq[i]-sum[i]^2/NR)/NR)
	} 
}') 
second=$(grep "<Overall>" $1/$3.dat |  sed 's/.*>//' | awk -v name=$3 '{
	for(i=1;i<=NF;i++) {
		sum[i] += $i; 
		sumsq[i] += ($i)^2;
	}
}  END {
	for (i=1;i<=NF;i++) { 
		printf "Mean %s : %0.2f, SD: %0.2f \n", name, sum[i]/NR, sqrt((sumsq[i]-sum[i]^2/NR)/NR)
	} 
}' )

average1=$(grep "<Overall>" $1/$2.dat | sed 's/.*>//' | awk '{
	for(i=1;i<=NF;i++) {
		sum[i] += $i;
	}
}  END {
	for (i=1;i<=NF;i++) { 
		printf sum[i]/NR 
	}
}')
average2=$(grep "<Overall>" $1/$3.dat | sed 's/.*>//' | awk '{
	for(i=1;i<=NF;i++) {
		sum[i] += $i;
	}
}  END {
	for (i=1;i<=NF;i++) { 
		printf sum[i]/NR 
	}
}')

sd1=$(grep "<Overall>" $1/$2.dat |  sed 's/.*>//' | awk '{
	for(i=1;i<=NF;i++) {
		sum[i] += $i; 
		sumsq[i] += ($i)^2;
	}
}  END {
	for (i=1;i<=NF;i++) { 
		printf sqrt((sumsq[i]-sum[i]^2/NR)/NR)
	} 
}')
sd2=$(grep "<Overall>" $1/$3.dat |  sed 's/.*>//' | awk '{
	for(i=1;i<=NF;i++) {
		sum[i] += $i; 
		sumsq[i] += ($i)^2;
	}
}  END {
	for (i=1;i<=NF;i++) { 
		printf sqrt((sumsq[i]-sum[i]^2/NR)/NR)
	} 
}')

count1=$(grep "<Overall>" $1/$2.dat -c)
count2=$(grep "<Overall>" $1/$3.dat -c)

average_difference=$( awk '{print $1-$2}' <<< "$average1 $average2" )

bottom=$( awk '{ print (($1-1)*$3*$3 + ($2-1)*$4*$4)*(1/$1+1/$2)/($1+$2-2) } ' <<< "$count1 $count2 $sd1 $sd2" )

t=$( awk '{ print $1/sqrt($2)}' <<< "$average_difference $bottom")
abs=$(bc -l <<< "sqrt($t*$t)")

printf "t :%0.2f\n" $t
echo $first
echo $second
printf $(bc <<< "$4 > $abs")
echo
