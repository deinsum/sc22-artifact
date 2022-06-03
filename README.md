# SC'22 Deinsum Artifact

This repository is the main accompanying artifact for the SC'22 submission "Deinsum: Practically I/O Optimal Multilinear Algebra".

## Submission Summary

The submission describes Deinsum, a Python-based framework for automatically optimizing and executing in distributed-memory machines multilinear algebra kernels expressed in Einstein notation (einsum). Deinsum is evaluated on 10 different kernels and its performance is compared with [Cyclops Tensor Framework's (CTF)](https://github.com/cyclops-community/ctf) on CPU (Fig. 5), and GPU (paper Fig.6).

## Hardware Requirements

### Submission Testing Setup

The benchmarks shown on the paper were ran on the [Piz Daint supercomputer](https://www.cscs.ch/computers/piz-daint/) using 1-512 Cray XC50 compute nodes. Each Cray XC50 compute node has a 12-core Intel E5-2690 v3 CPU @ 2.6Ghz, an Nvidia P100 GPU with 16GB of memory, and 64GB of main memory. The nodes are connected through a Cray Aries network using a Dragonfly topology.

### Compatibility

Both Deinsum and CTF use MPI. Therefore, any cluster supporting MPI should be compatible network-wise. Although the network topology should influence performance, it should not affect reproducibility of the results in a qualitative manner. All CPU architectures should in principle work (the provided scripts may need to be significantly adjusted), but the results are only reproducible with Intel CPUs. Only Nvidia GPU architectures can be used to both test functionality and reproducibility. There are also constraints on the exact Nvidia GPU architectures supported (see TODO). However, any P100 or newer GPU with at least 16GB of memory should work.

<table align="center">
  <tr>
    <th rowspan="2" colspan="2">Architecture</th>
    <th colspan="2">Functional</th>
    <th colspan="2">Reproducible</th>
  <tr>
    <th>Deinsum</th>
    <th>CTF</th>
    <th>Deinsum</th>
    <th>CTF</th>
  </tr> 
  <tr>
    <td rowspan="2">CPU</td>
    <td>Intel</td>
    <td>✔️</td>
    <td>✔️</td>
    <td>✔️</td>
    <td>✔️</td>
  </tr>
  <tr>
    <td>Other</td>
    <td>✔️</td>
    <td>✔️</td>
    <td>❌</td>
    <td>❌</td>
  </tr>
  <tr>
    <td rowspan="2">GPU</td>
    <td>Nvidia</td>
    <td>✔️</td>
    <td>✔️</td>
    <td>✔️</td>
    <td>✔️</td>
  </tr>
  <tr>
    <td>Other</td>
    <td>❌</td>
    <td>❌</td>
    <td>❌</td>
    <td>❌</td>
  </tr>
</table>

## Software Requirements

### Submission Testing Setup

The Piz Daint supercomputer runs SUSE Linux Enterprise Server 15 SP2. Deinsum uses the `soap` branch of the [Data-Centric Parallel Programming framework (DaCe)](https://github.com/spcl/dace) (commit ID d096693, may change during AE). For CPU, the latest verified version of CTF was used (commit ID c4f89dc). For GPU, we used CTF's `gpu_devel_v2` branch (commit ID 0c41739b). Generated C++ codes for both Deinsum and CTF were compiled with GCC 9.3.0 and were linked against Cray MPICH (CUDA-aware) 7.7.18, Intel oneAPI MKL 2021.3.0, and CUDA 11.4. Both frameworks utilize the [High-Performance Tensor Transpose Library (HPTT)](https://github.com/springer13/hptt). For Deinsum we used the latest available version (commit ID 9425386), while CTF automatically downloaded and compiled a [forked version](https://github.com/solomonik/hptt) (commit ID 3c77169). Deinsum also uses Nvidia's cuTENSOR library. We used version 1.5.0.3.

### Compatibility

Our benchmarks should execute on any Linux distribution, assuming all relevant tools are available. Deinsum's functionality on CPU should also be verifiable on the Windows Linux Subsystem (WSL). We have not tested Deinsum on Windows and MacOS. DaCe's version/branch currently cannot change. Newer CTF versions should be compatible, at least on CPU. However, for GPU we use a special branch as the main branch currently fails to compile with CUDA. The GCC version is not important as long as it supports C++14 and is compatible with the available CUDA/NVCC version. Any recent MPI implementation should work for CPU. For GPU, a CUDA-aware version is mandatory. The versions of Intel MKL, HPTT, and cuTENSOR should not be important.
