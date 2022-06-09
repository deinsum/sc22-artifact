#!/bin/bash

cd multilinear-algebra-sc22-artifact
git pull
python3 plot_gpu.py -f /storage/results
cp gpu.pdf /storage/
