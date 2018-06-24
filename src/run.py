from flask import Flask
from werkzeug.serving import run_simple

import led

from settings import HOSTNAME, PORT


app = Flask(__name__)

# register LED endpoints
app.register_blueprint(led.blueprint)


if __name__ == '__main__':
        run_simple(HOSTNAME, PORT, app,
                   use_reloader=True,
                   use_debugger=True)
