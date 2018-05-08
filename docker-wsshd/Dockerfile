FROM python:2-stretch

RUN apt-get update && apt-get -y upgrade && apt-get install -y \
  build-essential \
  vim \
  git
RUN git clone https://github.com/aluzzardi/wssh.git && cd wssh && \
  python2 setup.py build && \
  python2 setup.py install && \
  pip install gevent && \
  pip install gevent-websocket && \
  pip install paramiko && \
  pip install flask && \
  pip install websocket-client

EXPOSE 5000
CMD ["/usr/local/bin/wsshd"]
