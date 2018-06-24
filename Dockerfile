FROM python:3.6.5-slim

MAINTAINER Arnulfo Solis <arnulfojr94@gmail.com>

ENV CONTAINER_PORT 5000

ENV APP_DIR /app

ENV PYTHONPATH "${PATH}/src"

# add the build essentials
RUN apt-get update && apt-get install -yqq build-essential

# copy and install project dependencies
COPY ./requirements.txt ${APP_DIR}/requirements.txt

RUN pip install -r ${APP_DIR}/requirements.txt

# expose the server port
EXPOSE ${CONTAINER_PORT}

ENTRYPOINT ["/bin/sh", "/app/docker-entrypoint.sh"]

CMD ["serve"]
