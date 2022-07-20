#!/bin/bash

if [[ $# -ge 1 ]]
then
    num_nodes=$1
else
    num_nodes=1
fi

./compile_hptt.sh
cd /storage/results
libiomp_path=/opt/intel/oneapi/compiler/2021.3.0/linux/compiler/lib/intel64_lin
current_path=$LIBRARY_PATH
current_ldpath=$LD_LIBRARY_PATH
export LIBRARY_PATH="$LIBRARY_PATH:$MKLROOT/lib/intel64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MKLROOT/lib/intel64:$libiomp_path:$HPTT_ROOT/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MKLROOT/lib/intel64:$HPTT_ROOT/lib"
for prog in "mm" "mttkrp" "ttmc"
do
    echo "Running ${prog} CPU validation with ${num_nodes} MPI processes."
    mpirun -n ${num_nodes} python3 /dace/samples/distributed/${prog}_validation.py
done
export LIBRARY_PATH=$current_path
export LD_LIBRARY_PATH=$current_ldpath
