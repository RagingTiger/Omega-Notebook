# jupyter base image
FROM jupyter/scipy-notebook:lab-3.6.3 as cpu-only

# install python libraries
RUN mamba install --yes \
    'cenpy=1.0.1' \
    'contextily=1.3.0' \
    'cookiecutter=2.1.1' \
    'graphviz=7.1.0' \
    'ipynbname=2021.3.2' \
    'nashpy=0.0.35' \
    'osmnx=1.3.0' \
    'pipreqsnb=0.2.4' \
    'python-graphviz=0.20.1' \
    'scikit-surprise=1.1.3' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
  pip install tensorflow==2.12.*

# additional GPU-enabled steps
FROM cpu-only as gpu-enabled

# install CUDA tools
RUN mamba install -c conda-forge cudatoolkit=11.8.0 && \
  pip install nvidia-cudnn-cu11==8.6.0.163

# setting up cuda library path
RUN CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)")) && \
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib
