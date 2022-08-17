#!/bin/bash

if [[ $# -eq 1 ]]
then
    prog=$1
else
    echo "The script takes as argument one of {mm, mttkrp_order_3, mttkrp_order_5, ttmc}"
    exit 1
fi

cd /storage/results
current_ldpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MKLROOT/lib/intel64:$CTF_ROOT/lib"
export OMP_NUM_THREADS=$(lscpu -p | egrep -v '^#' | sort -u -t, -k 2,4 | wc -l)
export CTF_PPN=1

${CTF_EXEC}/${prog}_ctf

export LD_LIBRARY_PATH=$current_ldpath
