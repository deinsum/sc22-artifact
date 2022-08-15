FROM debian:bullseye-slim

# Basic toolchain
# NOTE: Constrain GCC version later?
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget build-essential libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev git
RUN apt-get -y install mpich libmpich-dev unzip libblas-dev liblapack-dev

# Intel oneAPI MKL 2021.3.0
RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list
RUN apt-get update && apt-get -y install intel-oneapi-mkl-2021.3.0 intel-oneapi-mkl-devel-2021.3.0

# Python 3.10.2
RUN wget https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tgz 
RUN tar xzf Python-3.10.2.tgz
RUN cd Python-3.10.2 && ./configure --enable-optimizations && make install

# DaCe  and CTF Artifacts
# ARG DUMMY=unknown
RUN git clone -b soap --recurse-submodules https://github.com/spcl/dace.git
RUN git clone https://spclgitlab.ethz.ch/alexnick/multilinear-algebra-sc22-artifact.git
RUN git clone https://github.com/cyclops-community/ctf.git
RUN cd dace && python3 -m pip install .
RUN python3 -m pip install mpi4py opt_einsum pandas seaborn matplotlib

# Setup MKL
ENV MKLROOT /opt/intel/oneapi/mkl/2021.3.0
RUN update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so libblas.so-x86_64-linux-gnu $MKLROOT/lib/intel64/libmkl_rt.so 50
RUN update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so.3 libblas.so.3-x86_64-linux-gnu $MKLROOT/lib/intel64/libmkl_rt.so 50
RUN update-alternatives --install /usr/lib/x86_64-linux-gnu/liblapack.so liblapack.so-x86_64-linux-gnu  $MKLROOT/lib/intel64/libmkl_rt.so 50
RUN update-alternatives --install /usr/lib/x86_64-linux-gnu/liblapack.so.3 liblapack.so.3-x86_64-linux-gnu $MKLROOT/lib/intel64/libmkl_rt.so 50
RUN echo "${MKLROOT}/lib/intel64" >> /etc/ld.so.conf.d/mkl.conf
RUN ldconfig
RUN echo "MKL_THREADING_LAYER=GNU" >> /etc/environment

RUN apt-get clean
RUN g++ --version
RUN python3 --version
RUN echo $MKLROOT
RUN ls /opt/intel/oneapi/mkl/2021.3.0
RUN pwd
RUN mkdir storage && cd storage && mkdir results && mkdir ctf_exec && mkdir libs && cd libs && mkdir ctf && mkdir hptt

# Env vars
ENV DACE_compiler_cpu_executable mpicxx
ENV DACE_compiler_default_build_folder /storage/.dacecache
ENV DACE_compiler_use_cache 1
ENV DACE_library_blas_default_implementation MKL
ENV DACE_library_linalg_default_implementation TTGT
ENV DACE_library_ttranspose_default_implementation HPTT
ENV CTF_ROOT /storage/libs/ctf
ENV CTF_EXEC /storage/ctf_exec
ENV HPTT_ROOT /storage/libs/hptt

COPY compile_ctf.sh compile_ctf.sh
COPY compile_ctf_programs.sh compile_ctf_programs.sh
COPY run_ctf_bench.sh run_ctf_bench.sh
COPY run_ctf_bench_single_node.sh run_ctf_bench_single_node.sh
COPY run_ctf.sh run_ctf.sh
COPY compile_hptt.sh compile_hptt.sh
COPY run_deinsum.sh run_deinsum.sh
COPY validate_deinsum.sh validate_deinsum.sh
COPY generate_plots.sh generate_plots.sh
RUN chmod +x compile_ctf.sh
RUN chmod +x compile_ctf_programs.sh
RUN chmod +x run_ctf_bench.sh
RUN chmod +x run_ctf_bench_single_node.sh
RUN chmod +x run_ctf.sh
RUN chmod +x compile_hptt.sh
RUN chmod +x run_deinsum.sh
RUN chmod +x validate_deinsum.sh
RUN chmod +x generate_plots.sh
COPY validate_deinsum_single_node.sh validate_deinsum_single_node.sh
RUN chmod +x validate_deinsum_single_node.sh
COPY run_deinsum_single_node.sh run_deinsum_single_node.sh
RUN chmod +x run_deinsum_single_node.sh
RUN cd dace && git config pull.rebase false
RUN cd dace && git pull
CMD bash


# CMD [ "mpirun", "-n", "4", "python3", "dace/samples/distributed/mm_validation.py"]