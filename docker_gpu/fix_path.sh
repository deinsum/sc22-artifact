#!/bin/bash

export PATH="/usr/bin:${PATH}"
export CC=mpicc
export CXX=mpicxx
export LD_LIBRARY_PATH="/opt/nvidia/hpc_sdk/Linux_x86_64/21.9/cuda/11.4/targets/x86_64-linux/lib:/opt/nvidia/hpc_sdk/Linux_x86_64/21.9/math_libs/11.4/targets/x86_64-linux/lib:${LD_LIBRARY_PATH}"
export LIBRARY_PATH="/opt/nvidia/hpc_sdk/Linux_x86_64/21.9/cuda/11.4/targets/x86_64-linux/lib:/opt/nvidia/hpc_sdk/Linux_x86_64/21.9/math_libs/11.4/targets/x86_64-linux/lib:${LIBRARY_PATH}"
export C_INCLUDE_PATH="/opt/nvidia/hpc_sdk/Linux_x86_64/21.9/cuda/11.4/targets/x86_64-linux/include:${C_INCLUDE_PATH}"
export CPLUS_INCLUDE_PATH="/opt/nvidia/hpc_sdk/Linux_x86_64/21.9/cuda/11.4/targets/x86_64-linux/include:${CPLUS_INCLUDE_PATH}"
