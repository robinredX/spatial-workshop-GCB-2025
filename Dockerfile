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

RUN mamba install --yes -c "conda-forge" \
    "bash_kernel" \
    "pandas" \
    "numpy" \
    "scipy" \
    "matplotlib" \
    "seaborn" \
    "scikit-learn" \
    "scanpy" \
    "squidpy" \
    "leidenalg" \
    "python-igraph" \
    "jupyterlab_widgets" \
    "ipywidgets" \
    "nbgitpuller" \
    "rpy2" \
    "numba" \
    "tqdm" \
    "plotly" \
    "umap-learn" \
    "pillow" \
    "statsmodels"

RUN mamba install --yes -c "bioconda" \
    "anndata"

RUN pip install --no-cache-dir \
    "pingouin>=0.5.3"

USER root

RUN Rscript -e "install.packages(c('BiocManager', 'remotes'), repos='https://cran.rstudio.com/')" && \
    Rscript -e "BiocManager::install(c('SingleCellExperiment', 'SummarizedExperiment', 'BayesSpace'))"

RUN python3 -c "import pathlib; import json; data = json.loads(pathlib.Path('/opt/conda/share/jupyter/lab/schemas/@jupyterlab/docmanager-extension/plugin.json').read_text()); data['properties']['defaultViewers']['default'] = {'markdown':'Markdown Preview'}; pathlib.Path('/opt/conda/share/jupyter/lab/schemas/@jupyterlab/docmanager-extension/plugin.json').write_text(json.dumps(data))" && \
    rm -r /home/jovyan/work/ && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}
