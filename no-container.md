# Deinsum CPU/GPU Testing without containers

To run the benchmarks without using the provided containers, you need the following software:
- GNU C/C++ compiler set as the main compiler in your installation. Other compilers may work, but GCC is the safest choice.
- Intel MKL. Modules provided in a cluster should work.  `$MKLROOT` should be set. Otherwise, sample installation instructions follow below.
- Python >=3.7, <= 3.10. We suggest using a virtual environment.
- For GPU testing, you also need the cudatoolkit and the [cuTENSOR](https://developer.nvidia.com/cutensor) library.

Sample instructions for installing Intel MKL on a Debian-based system:
- `RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null`
- `echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list`
- `apt-get update && apt-get -y install libblas-dev liblapack-dev intel-oneapi-mkl-2021.3.0 intel-oneapi-mkl-devel-2021.3.0`
- `export MKLROOT=/opt/intel/oneapi/mkl/2021.3.0` (you may want to add this to your terminal's configuration file)
- `update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so libblas.so-x86_64-linux-gnu $MKLROOT/lib/intel64/libmkl_rt.so 50`
- `update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so.3 libblas.so.3-x86_64-linux-gnu $MKLROOT/lib/intel64/libmkl_rt.so 50`
- `update-alternatives --install /usr/lib/x86_64-linux-gnu/liblapack.so liblapack.so-x86_64-linux-gnu  $MKLROOT/lib/intel64/libmkl_rt.so 50`
- `update-alternatives --install /usr/lib/x86_64-linux-gnu/liblapack.so.3 liblapack.so.3-x86_64-linux-gnu $MKLROOT/lib/intel64/libmkl_rt.so 50`
- `echo "${MKLROOT}/lib/intel64" >> /etc/ld.so.conf.d/mkl.conf`
- `ldconfig`
- `echo "MKL_THREADING_LAYER=GNU" >> /etc/environment`

To run the benchmarks you need to download the following repositories:
- `git clone -b soap --recurse-submodules https://github.com/spcl/dace.git`
- `git clone https://spclgitlab.ethz.ch/alexnick/multilinear-algebra-sc22-artifact.git`
- `git clone https://github.com/cyclops-community/ctf.git`

For GPU, please use the following CTF branch:
- `git clone -b gpu_devel_v2 https://github.com/cyclops-community/ctf.git`

You need install the following Python modules:
- `cd dace && python3 -m pip install .`
- `python3 -m pip install mpi4py opt_einsum pandas seaborn matplotlib`

For GPU testing, you also need cupy. In the following, XXX is the CUDA runtime version installed on the target machine:
- `python3 -m pip install cupy-cudaXXX`

We suggest that you create a folder to store compiled programs and results:
-  `mkdir folder-name && cd folder-name && mkdir results && mkdir ctf_exec && mkdir libs && cd libs && mkdir ctf && mkdir hptt && cd ../../`

You need to set the following environment variables:
- `export DACE_compiler_cpu_executable=mpicxx`
- `export DACE_compiler_default_build_folder=/absolute/path/to/folder-name/.dacecache`
- `export DACE_compiler_use_cache=1`
- `export DACE_library_blas_default_implementation=MKL`
- `export DACE_library_linalg_default_implementation=TTGT`
- `export DACE_library_ttranspose_default_implementation=HPTT`
- `export CTF_ROOT=/absolute/path/to/folder-name/libs/ctf`
- `export CTF_EXEC=/absolute/path/to/folder-name/ctf_exec`
- `export HPTT_ROOT=/absolute/path/to/folder-name/libs/hptt`

You may run the benchmarks and recreate the paper's figures by running the following scripts that are in the `docker_cpu` and `docker_gpu` folders. Please note that you may have to adapat these scripts to match paths in your installation:
- `run_ctf.sh` (compiles CTF, and CTF programs and runs CTF benchmarks)
- `validate_deinsum.sh` (compiles Deinsum programs and runs Deinsum with minimal data)
- `run_deinsum.sh` (compiles Deinsum programs and rns Deinsum benchmarks)
- `generate_plots.sh` (generates figures)
