#!/bin/bash

./compile_hptt.sh
cd /storage/results
libiomp_path=/opt/intel/oneapi/compiler/2021.3.0/linux/compiler/lib/intel64_lin
current_path=$LIBRARY_PATH
current_ldpath=$LD_LIBRARY_PATH
export LIBRARY_PATH="$LIBRARY_PATH:$MKLROOT/lib/intel64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MKLROOT/lib/intel64:$libiomp_path:$HPTT_ROOT/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MKLROOT/lib/intel64:$HPTT_ROOT/lib"
export OMP_NUM_THREADS=$(lscpu -p | egrep -v '^#' | sort -u -t, -k 2,4 | wc -l)
for prog in "mm" "mttkrp_order_3" "mttkrp_order_5" "ttmc"
do
    python3 /dace/samples/distributed/${prog}_testing.py
done
export LIBRARY_PATH=$current_path
export LD_LIBRARY_PATH=$current_ldpath
