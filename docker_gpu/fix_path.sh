#!/bin/bash

export PATH="/usr/bin:${PATH}"
export CC=mpicc
export CXX=mpicxx
export LD_LIBRARY_PATH="/opt/nvidia/hpc_sdk/Linux_x86_64/22.5/cuda/11.0/targets/x86_64-linux/lib:/opt/nvidia/hpc_sdk/Linux_x86_64/22.5/math_libs/11.0/targets/x86_64-linux/lib:${LD_LIBRARY_PATH}"
export LIBRARY_PATH="/opt/nvidia/hpc_sdk/Linux_x86_64/22.5/cuda/11.0/targets/x86_64-linux/lib:/opt/nvidia/hpc_sdk/Linux_x86_64/22.5/math_libs/11.0/targets/x86_64-linux/lib:${LIBRARY_PATH}"
export C_INCLUDE_PATH="/opt/nvidia/hpc_sdk/Linux_x86_64/22.5/cuda/11.0/targets/x86_64-linux/include:${C_INCLUDE_PATH}"
export CPLUS_INCLUDE_PATH="/opt/nvidia/hpc_sdk/Linux_x86_64/22.5/cuda/11.0/targets/x86_64-linux/include:${CPLUS_INCLUDE_PATH}"
