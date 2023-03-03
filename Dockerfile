# jupyter base image
FROM jupyter/tensorflow-notebook:lab-3.6.1

# install python libraries
RUN mamba install --yes \
    'ipynbname=2021.3.2' \
    'pipreqsnb=0.2.4' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
