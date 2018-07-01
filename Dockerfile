FROM python:3.6.5-slim

MAINTAINER Arnulfo Solis <arnulfojr94@gmail.com>

# Container PORT 5000 (flask default)
ENV CONTAINER_PORT 5000

ENV APP_DIR /app

# add the bins to the PATH
ENV PATH "${PATH}:${APP_DIR}/bin"

ENV PYTHONPATH "${APP_DIR}/src"

# add the build essentials
RUN apt-get update && \
    apt-get install -yqq --no-install-recommends build-essential wget && \
    rm -rf /var/lib/apt/lists/*

# copy and install project dependencies
COPY ./requirements.txt ${APP_DIR}/requirements.txt

RUN pip install -r ${APP_DIR}/requirements.txt

# remove the build-essential
RUN apt-get remove -y --purge build-essential

# Add project code
COPY ./src/ ${APP_DIR}/src/

COPY ./conf/app/ ${APP_DIR}/conf/app/

COPY ./bin/ ${APP_DIR}/bin/

# expose the server port
EXPOSE ${CONTAINER_PORT}

COPY ./docker-entrypoint.sh ${APP_DIR}/docker-entrypoint.sh

WORKDIR ${APP_DIR}

ENTRYPOINT ["/bin/sh", "/app/docker-entrypoint.sh"]

CMD ["serve"]

# server's healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
    CMD wget --quiet --spider --tries=1 http://${HOSTNAME}:${CONTAINER_PORT}/health/ || exit 1
