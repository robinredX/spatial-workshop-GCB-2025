pip install --user --force-reinstall --ignore-installed numba==0.62.0 llvmlite==0.45.0
pip install --user -r requirements.txt --ignore-installed
pip install --user --no-cache-dir torch==2.7.1 -f https://download.pytorch.org/whl/torch_stable.html
pip install --user --no-cache-dir --upgrade typing_extensions
pip install --user torch_geometric==2.6.1
pip install --user fsspec==2023.9.2
pip install --user --no-deps SOMENDER
pip install --user --no-deps nichepca
pip install --user backports.tarfile>=1.2
