# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/minimal-notebook
FROM $BASE_CONTAINER
ARG JUPYTERHUB_VERSION=3.0.0
LABEL maintainer="Robin Khatri <robin.khatri@zmnh.uni-hamburg.de>"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# R pre-requisites
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    r-cran-rodbc \
    gfortran \
    gcc \
    r-base \
    r-base-dev \
    libxml2 \
    libxml2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache jupyterhub==$JUPYTERHUB_VERSION

USER ${NB_UID}

# Install conda packages
RUN mamba install --yes -c "conda-forge" \
    "bash_kernel" \
    "jupyterlab_widgets" \
    "ipywidgets" \
    "nbgitpuller" \
    "rpy2" \
    "numba" \
    "tqdm" \
    "plotly" \
    "pillow"

# Install packages from requirements.txt
RUN pip install --no-cache-dir \
    "numpy==1.24.4" \
    "pandas==2.1.1" \
    "scikit-learn==1.3.1" \
    "umap-learn==0.5.7" \
    "statsmodels==0.14.0" \
    "tifffile==2023.9.26" \
    "xarray==2024.11.0" \
    "ome_zarr==0.11.1" \
    "harmonypy==0.0.10" \
    "anndata==0.11.4" \
    "scanpy==1.11.1" \
    "squidpy==1.6.5" \
    "matplotlib==3.8.0" \
    "seaborn==0.13.2" \
    "celltypist==1.7.0" \
    "spatialleiden==0.3.0" \
    "POT==0.9.6" \
    "GraphST==1.1.1" \
    "pingouin>=0.5.3"

# Install packages without dependencies to avoid conflicts
RUN pip install --no-cache-dir torch==2.7.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install --no-cache-dir --upgrade typing_extensions
RUN pip install torch_geometric==2.6.1
RUN pip install --no-deps SOMENDER
RUN pip install --no-deps nichepca

USER root

RUN Rscript -e "install.packages(c('BiocManager', 'remotes'), repos='https://cran.rstudio.com/')" && \
    Rscript -e "BiocManager::install(c('SingleCellExperiment', 'SummarizedExperiment', 'BayesSpace'))"

RUN python3 -c "import pathlib; import json; data = json.loads(pathlib.Path('/opt/conda/share/jupyter/lab/schemas/@jupyterlab/docmanager-extension/plugin.json').read_text()); data['properties']['defaultViewers']['default'] = {'markdown':'Markdown Preview'}; pathlib.Path('/opt/conda/share/jupyter/lab/schemas/@jupyterlab/docmanager-extension/plugin.json').write_text(json.dumps(data))" && \
    rm -r /home/jovyan/work/ && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}