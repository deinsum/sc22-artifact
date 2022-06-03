#!/bin/bash

cd multilinear-algebra-sc22-artifact/ctf_programs
echo $CTF_EXEC
for prog in "mm" "mttkrp_order_3" "mttkrp_order_5" "ttmc"
do
    FILE=${CTF_EXEC}/${prog}_ctf
    if [ -f "$FILE" ]; then
        echo "$FILE exists."
    else
        mpicxx ${prog}_ctf.cpp -I /ctf/include $CTF_ROOT/lib/libctf.a -fopenmp -march=native -O3 -std=c++14 -L${CTF_ROOT}/lib -lhptt -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -Wl,--no-as-needed -lmkl_intel_lp64 -lmkl_gnu_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -lgomp -lpthread -lm -ldl -lstdc++fs -o ${CTF_EXEC}/${prog}_ctf
    fi
done
