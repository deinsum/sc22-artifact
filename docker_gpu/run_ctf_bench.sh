#!/bin/bash

source fix_path.sh

cd /storage/results
current_ldpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MKLROOT/lib/intel64:$CTF_ROOT/lib"
ls $CTF_EXEC
for prog in "mm" "mttkrp_order_3" "mttkrp_order_5" "ttmc"
do
    ${CTF_EXEC}/${prog}_ctf_gpu
done
export LD_LIBRARY_PATGH=$current_ldpath
