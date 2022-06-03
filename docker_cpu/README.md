# Deinsum CPU Testing with Docker Container

Please follow the steps below:

1. Download the files included in `sc22-artifact/docker_cpu` in the same folder.
2. To build the image, execute inside the artifact folder the following:
   * `docker build --rm -t image-name .`
3. Create a volume for data persistence:
   * `docker volume create volume-name`
4. Startup a container to compile on your target machine the required libraries. The following command will start a bash shell:
   * `docker run -it --rm --name container-name -v volume-name:/storage image-name`


Steps 5, 6, and 7 are executed in the container's bash shell.

5. Compile CTF:
   * `./compile_ctf.sh`
6. Compile CTF programs:
   * `./compile_ctf_programs.sh`
7. Compile HPTT:
   * `./compile_hptt.sh`

Now the shell can be closed. The compiled libraries persist in the volume created in step 3.

8. To run the actual benchmarks use the `run_ctf_bench.sh` and `run_deinsum.sh` scripts in combination with docker and mpirun or your cluster's workload manager (e.g. srun):
   * `mpirun -n number-of-nodes docker --rm --name container-name -v volume-name:/storage image-name run_ctf_bench.sh`
   * `mpirun -n number-of-nodes docker --rm --name container-name -v volume-name:/storage image-name run_deinsum.sh`
9. After running the benchmarks for all node counts (1, 2, 4, 8, 16, 32, 64, 128, 256, 512), you can reproduce Fig. 5 in the paper by executing:
   * `docker --rm --name container-name -v volume-name:/storage image-name generate_plots.sh`
