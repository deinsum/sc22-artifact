# Deinsum GPU Testing with Docker Container

To reproduce GPU results with the provided Docker container, follow the steps below. Please note that in all the following, image-name, folder-name, container-name, and number-of-nodes are placeholders. The names can be freely chosen. Please note, that you will actually need to use the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker) or other compatible software.

Estimated time to completion:
- Steps 1-4: ~30-60 min
- Steps 5-7: ~10-20 min
- Steps 8-9: ~5-10 min per node count

1. Navigate into the `sc22-artifact/docker_gpu`folder.
2. To build the image, execute inside the artifact folder the following:
   * `nvidia-docker build --rm -t image-name .`
3. Create a folder for data persistence:
   * `mkdir folder-name && cd folder-name && mkdir results && mkdir ctf_exec && mkdir libs && cd libs && mkdir ctf && mkdir hptt && cd ../../`
4. Startup a container to compile on your target machine the required libraries. The following command will start a bash shell:
   * `nvidia-docker run -it --rm --name container-name --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name`


Steps 5, and 6 are executed in the container's bash shell.

5. Compile CTF:
   * `./compile_ctf.sh`
6. Compile CTF programs:
   * `./compile_ctf_programs.sh`

Now the shell can be closed. The compiled libraries persist in the volume created in step 3.

7. To run the actual benchmarks use the `run_ctf_bench.sh` and `run_deinsum.sh` scripts in combination with docker and mpirun or your cluster's workload manager (e.g. srun):
   * `mpirun -n number-of-nodes nvidia-docker --rm --name container-name --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name ./run_ctf_bench.sh`
   * `mpirun -n number-of-nodes nvidia-docker --rm --name container-name --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name ./run_deinsum.sh`
8. After running the benchmarks for all node counts (1, 2, 4, 8, 16, 32, 64, 128, 256, 512), you can reproduce Fig. 6 in the paper by executing:
   * `nvidia-docker --rm --name container-name --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storagee image-name ./generate_plots.sh`

The figure is stored under `folder-name/gpu.pdf`.

**NOTE 1:** Please note that we expect that the benchmarks are executed in clusters where the nodes have a common filesystem and folder-name is stored in there. This is because Deinsum is set to have MPI rank 0 compile the shared libraries, while the other ranks wait for this operation to complete before loading them. If this constraint cannot be met, please contact us to provide a workaround.

**NOTE 2:** Before testing at scale, you may want to do validate that Deinsum works properly on a single node. Apart from using only one MPI rank, you could try spawning multiple MPI processes in a single node. However you will very quickly run out-of-memory. For this reason we provide a validation script that runs Deinsum with minimal data sizes:
`mpirun -n number-of-nodes nvidia-docker --rm --name container-name --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name ./validate_deinsum.sh`

**NOTE 3:** You do not need to run the benchmarks for all node counts. The script that generates the plot should work even with a single data point.
