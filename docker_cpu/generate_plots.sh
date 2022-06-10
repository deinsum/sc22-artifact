#!/bin/bash

cd multilinear-algebra-sc22-artifact
git pull
python3 fig2.py -f /storage/results
cp fig2.pdf /storage/
