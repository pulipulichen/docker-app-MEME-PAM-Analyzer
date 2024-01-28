FROM jupyter/datascience-notebook:ubuntu-20.04

RUN conda install -c conda-forge nodejs
RUN conda install -c conda-forge jupyterlab-drawio
RUN npm install -g ijavascript
RUN ijsinstall

USER root
RUN mkdir -p /opt/app
WORKDIR /opt/app


# =================================================================
# For docker web

RUN apt-get update
RUN apt-get install -y curl wget nano rsync mlocate vim

# CMD ["bash", "/startup.sh"]
CMD "jupyter nbconvert --to html --execute index.ipynb; rm index.html"
WORKDIR /opt/

# =================================================================
# For docker web

ENV LOCAL_PORT=8888
ENV LOCAL_VOLUMN_PATH=/opt/app/
ENV WAIT_FOR_SERVICE="chmod 777 -R /opt/app/;echo 'Server is up'"
ENV STARTUP_COMMAND="/usr/local/bin/start-notebook.sh"
# ENV STARTUP_COMMAND="jupyter nbconvert --to html --execute index.ipynb; rm index.html"
ENV HOMEPAGE_URI=/

# =================================================================

COPY ./docker-build/docker-web/wait-for-it.sh /wait-for-it.sh
COPY ./docker-build/docker-web/startup.sh /startup.sh

# =================================================================

ENV NOTEBOOK_ARGS="--NotebookApp.token='' --NotebookApp.password=''"
WORKDIR /opt/app

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt