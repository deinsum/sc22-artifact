#!/bin/bash

cd /storage/results
current_ldpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MKLROOT/lib/intel64:$CTF_ROOT/lib"
export OMP_NUM_THREADS=$(lscpu -p | egrep -v '^#' | sort -u -t, -k 2,4 | wc -l)
export CTF_PPN=1
for prog in "mm" "mttkrp_order_3" "mttkrp_order_5" "ttmc"
do
    ${CTF_EXEC}/${prog}_ctf
done
export LD_LIBRARY_PATH=$current_ldpath
