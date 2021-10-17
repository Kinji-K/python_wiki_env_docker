FROM python:3.7
USER root

COPY . /code
WORKDIR /code

RUN apt-get update \
&&  apt-get install -y gosu vim busybox-static \
&&  apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt
ENV PYTHONPATH /usr/local/lib/python3.7/site-packages

ARG UID
ARG GID
ENV UID ${UID}
ENV GID ${GID}
ENV TZ=Asia/Tokyo

COPY ./setVolumePermission.sh /usr/local/bin/setVolumePermission.sh
COPY crontab /var/spool/cron/crontabs/root
RUN chmod +x /usr/local/bin/setVolumePermission.sh

ENTRYPOINT ["/usr/local/bin/setVolumePermission.sh"]
