# Getting base image for postgres.
FROM postgres:11
LABEL Maintainer="Ruth Waiganjo <ruthnwaiganjo@gmail.com>"

RUN apt-get update \
        && apt-get install -y postgresql-11-postgis-2.5 \
        && apt-get install postgresql-11-postgis-2.5-scripts \
        && apt-get install -y postgresql-11-hll \
        && apt-get -y install postgresql-11-cron


RUN mkdir -p /docker-entrypoint-initdb.docker
COPY ./dbextensions.sh /docker-entrypoint-initdb.d/dbextensions.sh