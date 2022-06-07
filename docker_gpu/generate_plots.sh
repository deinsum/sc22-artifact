#!/bin/bash

cd multilinear-algebra-sc22-artifact
git pull
python3 fig3.py -f /storage/results
cp fig3.pdf /storage/
