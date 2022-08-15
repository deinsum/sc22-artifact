#!/bin/bash

if [[ $# -ge 1 ]]
then
    num_nodes=$1
else
    num_nodes=1
fi

cd /storage/results
current_ldpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MKLROOT/lib/intel64:$CTF_ROOT/lib"
export OMP_NUM_THREADS=$(lscpu -p | egrep -v '^#' | sort -u -t, -k 2,4 | wc -l)
export CTF_PPN=1
ls $CTF_EXEC
for prog in "mm" "mttkrp_order_3" "mttkrp_order_5" "ttmc"
do
    echo "Running CTF ${prog} CPU with ${num_nodes} MPI processes."
    mpirun -n ${num_nodes} ${CTF_EXEC}/${prog}_ctf
done
export LD_LIBRARY_PATGH=$current_ldpath
