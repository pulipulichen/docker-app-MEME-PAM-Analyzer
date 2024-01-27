FROM jupyter/datascience-notebook:ubuntu-20.04

RUN conda install -c conda-forge nodejs
RUN conda install -c conda-forge jupyterlab-drawio
RUN npm install -g ijavascript
RUN ijsinstall

WORKDIR /home/jovyan/work