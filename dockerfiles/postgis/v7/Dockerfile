FROM postgis/postgis:14-master

RUN rm /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./db/  /docker-entrypoint-initdb.d/