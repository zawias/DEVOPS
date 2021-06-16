"""
    Main API module
"""
import os
import logging
import time
import jsonpickle
from flask import Flask, request

LOGGER = logging.getLogger("test")
FORMATTER = logging.Formatter('%(asctime)s %(levelname)s %(message)s')  # format
CONSOLEHANDLER = logging.StreamHandler()
CONSOLEHANDLER.setFormatter(FORMATTER)
LOGGER.addHandler(CONSOLEHANDLER)

level = os.environ.get("LOG_LEVEL","INFO")
if level == "INFO":
    LOGGER.setLevel(logging.INFO)
if level == "DEBUG":
    LOGGER.setLevel(logging.DEBUG)

my_static_var=1

APP = Flask(__name__)


@APP.route('/healthz')
def hello_world():
    """
        Healthz endpoint to check service status
    """
    return "Service is OK"


@APP.route('/api/v1/info', methods=['GET'])
def info():
    """
        Base invocation API endpoint
    """
    global my_static_var
    LOGGER.info('Static var is %s', my_static_var)
    started_at = time.time()

    my_static_var += 1
    response_payload = {'info_number': my_static_var}

    response = APP.response_class(
        response=jsonpickle.encode(response_payload, unpicklable=False),
        status=200,
        mimetype='application/json'
    )
    duration = time.time() - started_at
    LOGGER.debug('Request took %s', duration)
    return response
