#/bin/sh


if [ "${1}" = 'develop' ]; then
  exec python ${APP_DIR}/src/run.py
fi

if [ "${1}" = 'serve' ]; then
  exec gunicorn -c ${APP_DIR}/conf/app/conf.py run:app
fi

# execute the given command
exec "${@}"
