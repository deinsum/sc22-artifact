#!/bin/bash

source fix_path.sh
mpicxx --version

echo $MKLROOT
ls $MKLROOT/lib/intel64
echo $CTF_ROOT
ls $CTF_ROOT
FILE=$CTF_ROOT/lib/libctf.a
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    cd ctf
    CXX=mpicxx ./configure 'LD_LIB_PATH=-L${MKLROOT}/lib/intel64/' 'LD_LIBS=-lmkl_scalapack_lp64 -Wl,--no-as-needed -lmkl_intel_lp64 -lmkl_gnu_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -lgomp -lpthread -lm -ldl' '--with-cuda' '--build-hptt' '--install-dir=/storage/libs/ctf'
    sed -i -e "\$iOFFLOAD_CXX = nvcc -ccbin g++ -x cu -O2 -std=c++11 -m64 \$(DEFS) \$(INCLUDES) -shared -Xcompiler" -e '$d' config.mk
    make && make install
    cp hptt/include/* $CTF_ROOT/include/
    cp hptt/lib/* $CTF_ROOT/lib/
    cd ../
fi
ls $CTF_ROOT
ls $CTF_ROOT/include
ls $CTF_ROOT/lib
