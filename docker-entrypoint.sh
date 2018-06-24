#/bin/sh


if [ "${1}" = 'develop' ]; then
  export FLASK_DEBUG=1
  export FLASK_APP=${APP_DIR}/src/run.py
  exec flask run
fi

if [ "${1}" = 'serve' ]; then
  exec gunicorn -c ${APP_DIR}/conf/app/conf.py run:app
fi

# execute the given command
exec "${@}"
