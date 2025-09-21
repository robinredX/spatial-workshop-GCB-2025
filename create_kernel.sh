conda create -n st22_env python=3.11.6 -y
source activate st22_env
pip install -r requirements.txt
ipython kernel install --user --name st22_kernel
conda deactivate
