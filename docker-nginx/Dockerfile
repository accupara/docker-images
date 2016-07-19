FROM uvatbc/ubuntu:15.10

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get -y install \
        build-essential \
        git \
        libpq-dev \
        nginx \
        python-dev \
        python-django \
        python-pip \
        python-setuptools \
        python-software-properties \
        sqlite3 \
        ssh-client \
        sshpass \
        supervisor

RUN sudo pip install --upgrade \
        django \
        uwsgi

RUN sudo rm /etc/nginx/sites-enabled/* ; \
    sudo ln -s /app/nginx-site.conf /etc/nginx/sites-enabled/nginx-site.conf

# nginx conf file
COPY nginx.conf /etc/nginx/

# Use supervisord to start django and nginx by default
COPY apps.conf /etc/supervisor/conf.d/
COPY supervisord.conf /etc/supervisor/
CMD ["sudo", "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
