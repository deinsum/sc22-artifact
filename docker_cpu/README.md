# Deinsum CPU Testing with Docker Container

To reproduce CPU results with the provided Docker container, follow the steps below. Please note that in all the following, image-name, folder-name, container-name, and number-of-nodes are placeholders. The names can be freely chosen.

Estimated time to completion:
- Steps 1-4: ~30-60 min
- Steps 5-7: ~10-20 min
- Steps 8-9: ~5-10 min per node count

1. Navigate into the  `sc22-artifact/docker_cpu` folder.
2. To build the image, execute inside the artifact folder the following:
   * `docker build --rm -t image-name .`
3. Create a folder for data persistence:
   * `mkdir folder-name && cd folder-name && mkdir results && mkdir ctf_exec && mkdir libs && cd libs && mkdir ctf && mkdir hptt && cd ../../`
4. Startup a container to compile on your target machine the required libraries. The following command will start a bash shell:
   * `docker run -it --rm --name container-name --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name`


Steps 5, 6, and 7 are executed in the container's bash shell.

5. Compile CTF:
   * `./compile_ctf.sh`
6. Compile CTF programs:
   * `./compile_ctf_programs.sh`
7. Compile HPTT:
   * `./compile_hptt.sh`

Now the shell can be closed. The compiled libraries persist in the folder created in step 3.

8. To run the actual benchmarks use the `run_ctf_bench_test.sh` and `run_deinsum_test.sh` scripts in combination with your cluster's docker-compatible software (e.g., Sarus, Singularity) and mpirun or your cluster's workload manager (e.g., srun). In the following, docker-compatible-exec is a placeholder corresponds to the invocation corresponding to the cluster's docker-compatible software, while prog is one of {mm, mttkrp_order_3, mttkrp_order_5, ttmc}. For convenience, we have added two scripts, `run_ctf_bench_test_all.sh` and `run_deinsum_test_all.sh`, as a template for automating the process of running all four programs from your cluster's login node. Please note that the following **will not work** with docker if `number-of-nodes` is greater than 1.
   * `mpirun -n number-of-nodes docker-compatible-exec --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name ./run_ctf_bench_test.sh prog`
   * `mpirun -n number-of-nodes docker-compatible-exec --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name ./run_deinsum_test.sh prog`
9. After running the benchmarks for all node counts (1, 2, 4, 8, 16, 32, 64, 128, 256, 512), you can reproduce Fig. 5 in the paper by executing:
   * `docker-compatible-exec --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name ./generate_plots.sh`

Step 9 can also be executed in a local machine with docker by downloading the storage folder and executing:
   * `docker run --rm --name container-name --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name ./generate_plots.sh`

The figure is stored under `folder-name/fig2.pdf`.

**NOTE 1:** Please note that we expect that the benchmarks are executed in clusters where the nodes have a common filesystem and folder-name is stored in there. This is because Deinsum is set to have MPI rank 0 compile the shared libraries, while the other ranks wait for this operation to complete before loading them. If this constraint cannot be met, please contact us to provide a workaround.

**NOTE 2:** Before testing at scale, you may want to do validate that Deinsum works properly on a single node. Apart from using only one MPI rank, you could try spawning multiple MPI processes in a single node. However you will very quickly run out-of-memory. For this reason we provide a validation script that runs Deinsum with minimal data sizes. In the following, num-ranks is the number of MPI processes. If num-ranks is not set, the script defaults to 1 MPI process:
   * `docker run --rm --name container-name --mount=type=bind,src=/absolute/path/to/folder-name,dst=/storage image-name ./validate_deinsum_single_node.sh num-ranks`

Please also note that the validation script will not generate any actual results. It will only validate Deinsum's output against a Python reference implementation.

**NOTE 3:** You do not need to run the benchmarks for all node counts. The script that generates the plot should work even with a single data point.
