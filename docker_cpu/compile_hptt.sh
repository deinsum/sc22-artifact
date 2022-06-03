#!/bin/bash

FILE=$HPTT_ROOT/lib/libhptt.so
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    git clone https://github.com/springer13/hptt.git
    cd hptt
    CXX=g++ make avx
    ls
    mkdir $HPTT_ROOT/lib
    cp lib/* $HPTT_ROOT/lib/
    mkdir $HPTT_ROOT/include
    cp include/* $HPTT_ROOT/include/
fi
ls $HPTT_ROOT
ls $HPTT_ROOT/include
ls $HPTT_ROOT/lib
