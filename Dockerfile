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

# =================================================================

RUN pip install tensorflow==2.15.0

RUN apt-get install -y python3-opencv tesseract-ocr libtesseract-dev

# COPY ./app/requirements.txt /requirements.txt
# RUN pip install -r /requirements.txt

CMD ["/opt/app_startup.sh"]
COPY ./app/app_startup.sh /opt/app_startup.sh

RUN pip install peewee==3.17.0
RUN pip install ipywidgets==8.1.1
RUN pip install git+https://github.com/epixelic/python-smart-crop
RUN pip install pytesseract==0.3.10

RUN pip install Pillow==9.0.0
RUN pip install autocrop==1.3.0
RUN pip install smartcrop==0.4.0

RUN pip install keras-ocr==0.9.3
RUN pip install keras==2.15.0

RUN pip install sentence_transformers==2.2.2
RUN pip install yellowbrick==1.5