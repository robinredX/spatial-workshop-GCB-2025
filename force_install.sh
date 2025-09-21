pip install --force-reinstall numba==0.62.0 llvmlite==0.45.0
pip install -r requirements.txt --ignore-installed
pip install --no-cache-dir torch==2.7.1 -f https://download.pytorch.org/whl/torch_stable.html
pip install --no-cache-dir --upgrade typing_extensions
pip install torch_geometric==2.6.1
pip install fsspec==2023.9.2
pip install --no-deps SOMENDER
pip install --no-deps nichepca
pip install backports.tarfile>=1.2