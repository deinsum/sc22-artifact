#!/bin/bash

if [[ $# -eq 1 ]]
then
    num_nodes=$1
else
    num_nodes=1
fi

distrun="srun -C gpu -A account --partition=debug -N $num_nodes --mpi=pmi2"
dockrun="sarus run"
storage="/scratch/snx3000/username/storage"
image="load/library/image"

for prog in "mm" "mttkrp_order_3" "mttkrp_order_5" "ttmc"
do
    $distrun $dockrun --mount=type=bind,src=$storage,dst=/storage $image ./run_deinsum_test.sh $prog
done
