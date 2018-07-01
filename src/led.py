import ujson
from logs import logger

from cerberus import Validator
from flask import Blueprint, make_response, request
from gpiozero import LED
from settings.led import PIN_NUMBER


# default LED in the PIN_NUMBER
_DEFAULT_LED = LED(PIN_NUMBER)

# SCHEMA for LED endpoints
SCHEMA = {
    'pin': {
        'type': 'integer',
        'default': PIN_NUMBER
    },
    'value': {
        'type': 'integer',
        'required': True,
        'min': 0,
        'max': 1
    },
    'action': {
        'type': 'string',
        'required': False,
        'default': 'boolean',
        'allowed': ['boolean', 'blink']
    }
}


def get_led(pin_number: int = PIN_NUMBER) -> LED:
    """LED Factory."""
    global _DEFAULT_LED

    logger.info(f'Will get LED for pin {pin_number}')
    if pin_number == PIN_NUMBER:
        return _DEFAULT_LED

    led = LED(pin_number)
    return led


blueprint = bp = Blueprint('leds', __name__, url_prefix='/led')


validator = Validator(SCHEMA)


@bp.route('/', methods=['GET'])
def get_state():
    """Get the global state."""
    global _DEFAULT_LED
    payload = {
        'pin': PIN_NUMBER,
        'value': _DEFAULT_LED.value
    }

    return make_response(ujson.dumps(payload), 200)


@bp.route('/', methods=['PUT'])
def set_state():
    """Update the state of the LED."""
    global _DEFAULT_LED
    global validator

    payload = request.get_json()

    if not validator.validate(payload):
        return make_response(ujson.dumps(validator.errors), 400)

    document = validator.document
    value = document.get('value')

    if document.get('action') == 'boolean':
        _DEFAULT_LED.value = value

    if document.get('action') == 'blink':
        _DEFAULT_LED.blink()

    return make_response(ujson.dumps(payload), 200)


@bp.route('/<int:pin>/', methods=['GET'])
def get_state_for(pin: int):
    """Return the state of the LED at the given pin."""
    led = get_led(pin)
    payload = {
        'pin': pin,
        'value': led.value
    }
    return make_response(ujson.dumps(payload), 200)


@bp.route('/<int:pin>/', methods=['PUT'])
def set_state_for(pin: int):
    """Set the state of the pin."""
    payload = request.get_json()

    if not validator.validate(payload):
        logger.warn('Invalid request!')
        return make_response(ujson.dumps(validator.errors), 400)

    led = get_led(pin)
    document = validator.document
    value = document.get('value')

    if document.get('action') == 'boolean':
        logger.info(f'Will set LED {pin} with value: {value}')
        led.value = value

    if value and document.get('action') == 'blink':
        led.blink()

    return make_response(ujson.dumps(document), 200)
