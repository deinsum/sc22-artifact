#!/bin/bash

source fix_path.sh

cd multilinear-algebra-sc22-artifact/ctf_programs
echo $CTF_EXEC
for prog in "mm" "mttkrp_order_3" "mttkrp_order_5" "ttmc"
do
    FILE=${CTF_EXEC}/${prog}_ctf_gpu
    if [ -f "$FILE" ]; then
        echo "$FILE exists."
    else
        mpicxx ${prog}_ctf_gpu.cpp -I /ctf/include -fopenmp -march=native -O3 -std=c++14 -L${CTF_ROOT}/lib -lctf -lhptt -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -Wl,--no-as-needed -lmkl_intel_lp64 -lmkl_gnu_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -lgomp -lpthread -lm -ldl -lstdc++fs -lcuda -lcudart -lcublas -o ${CTF_EXEC}/${prog}_ctf_gpu
    fi
    chmod +x ${CTF_EXEC}/${prog}_ctf_gpu
done
