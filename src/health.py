from flask import Blueprint, make_response


blueprint = bp = Blueprint('health', __name__, url_prefix='/health')


@bp.route('/', methods=['GET'])
def get_health():
    """Return a simple 200."""
    return make_response('I\'m Ok', 200)


