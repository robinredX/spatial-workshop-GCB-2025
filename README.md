# Spatial domain identification: computational methods for discovering tissue architecture

## Introduction
This workshop will focus on computational approaches for identifying and characterizing spatial domains in single-cell spatial transcriptomics (ST) data. Spatial domains are tissue regions that share similar features, such as similar gene expression profiles and cell type abundances. For analysis of ST data, it is generally necessary to identify these domains to understand their dynamics under different tissue conditions, such as between healthy and disease states.

As ST data is increasingly used in research due to the benefit of in-situ identification of transcripts and cells, several computational approaches for spatial domain identification have been developed. In this workshop, participants will learn methods for unsupervised detection of spatial domains with distinct molecular signatures and understand techniques for biological interpretation of spatial domains along with associated caveats. Through hands-on tutorials, participants will learn about and apply state-of-the-art domain identification algorithms to real spatial transcriptomics datasets.

## Data
We'll use two sets of data:
1. Complete [ANCA-GN](https://unckidneycenter.org/kidneyhealthlibrary/glomerular-disease/anca-vasculitis/) Visium data from "Immune profiling-based targeting of pathogenic T cells with ustekinumab in ANCA-associated glomerulonephritis" ([Nature Communications, 2024](https://www.nature.com/articles/s41467-024-52525-w))
2. A subset of Xenium kidney data from "[Spatio-temporal interaction of immune and renal cells determines glomerular crescent formation in autoimmune kidney disease](https://www.biorxiv.org/content/10.1101/2024.12.18.629206v1)" (bioRxiv, 2024)

## Environments

There are three options to set up environment:

1. Requirements are provided in `requirements.txt`. The following packages: MENDER and nichepca should be installed without dependencies to avoid conficts using `pip install --no-deps SOMENDER` and `pip install --no-deps nichepca` respectively.

2. (Preferable) Create a conda environment and export it as a jupyterhub kernel, this can be done by running `bash create_kernel.sh`, or by running the following in terminal:
```
conda create -n st22_env python=3.11.6 -y
source activate st22_env
pip install -r requirements.txt
ipython kernel install --user --st22_kernel
conda deactivate
```
After this, create a new notebook with the jupyterhub kernel "st22_kernel" and install MENDER and nichePCA: `pip install --no-deps SOMENDER` and `pip install --no-deps nichepca`

3. A dockerfile is also provided to setup everything.

## Schedule

### Background
1. Introduction to spatial transcriptomics and technologies  [[Slides]](slides/part0-ST-Intro.pdf)
  
2. Introduction to spatial domains  [[Slides]](slides/part1-domains.pdf)
  
3. Methods  [[Slides]](slides/part2-methods.pdf)

### Practical Sessions

1. **Introduction to Visium data** [[Notebook]](notebooks/1-visium-intro.ipynb)
   
2. **Simple approach for domain identification in Visium** [[Notebook]](notebooks/2.1-visium-domains.ipynb)
   
3. **Domain identification and cell type deconvolution with GraphST** [[Notebook]](notebooks/2.2-visium-domains.ipynb)
   
4. **Evaluation and downstream analysis using Visium domains** [[Notebook]](notebooks/3-evaluation-and-downstream.ipynb)
   
5. **Introduction to Xenium data** [[Notebook]](notebooks/4-xenium-intro.ipynb)
   
6. **Multi-sample domain identification in Xenium data with nichePCA** [[Notebook]](notebooks/5-xenium-domains.ipynb)
   
7. **Targeted detection of cellular communities** [[Notebook]](notebooks/6-xenium-domains-targeted.ipynb)