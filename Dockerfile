FROM python:3.6.5-slim

MAINTAINER Arnulfo Solis <arnulfojr94@gmail.com>

# Container PORT 5000 (flask default)
ENV CONTAINER_PORT 5000

ENV APP_DIR /app

ENV PYTHONPATH "${APP_DIR}/src"

# add the build essentials
RUN apt-get update && apt-get install -yqq build-essential

# copy and install project dependencies
COPY ./requirements.txt ${APP_DIR}/requirements.txt

RUN pip install -r ${APP_DIR}/requirements.txt

# Add project code
COPY ./src/ ${APP_DIR}/src/

COPY ./conf/app/ ${APP_DIR}/conf/app/

# expose the server port
EXPOSE ${CONTAINER_PORT}

COPY ./docker-entrypoint.sh ${APP_DIR}/docker-entrypoint.sh

WORKDIR ${APP_DIR}

ENTRYPOINT ["/bin/sh", "/app/docker-entrypoint.sh"]

CMD ["serve"]
