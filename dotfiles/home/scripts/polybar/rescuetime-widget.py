#!/usr/bin/env python3
# RescueTime polybar widget

import os
import datetime
from configparser import ConfigParser
from pdb import Pdb

import requests

API_URL = "https://www.rescuetime.com/anapi"

STARTED = 'started'
ENDED = 'ended'
FOCUSTIME_RECORD_TYPES = [STARTED, ENDED]

START = 'start'
END = 'end'
FOCUSTIME_ACTIONS = [START, END]


def _focustime_records(api_token, record_type):
    if record_type not in FOCUSTIME_RECORD_TYPES:
        exit(f"ERROR: '{record_type}' not in {FOCUSTIME_RECORD_TYPES}")

    try:
        # filter based on https://www.rescuetime.com/anapi/setup/documentation#focustime-feed-reference
        req = requests.get(f"{API_URL}/focustime_{record_type}_feed", params={"key": api_token})

    except requests.exceptions.ConnectionError:
        return "No connection"

    if req.status_code != 200:
        return req.reason

    records = req.json()
    return records


def get_focustime_started(api_token):
    return _focustime_records(api_token, STARTED)


def get_focustime_ended(api_token):
    return _focustime_records(api_token, ENDED)


def _focustime_action(api_token, action_type, duration=None):
    if action_type not in FOCUSTIME_ACTIONS:
        exit(f"ERROR: '{action_type}' not in {FOCUSTIME_ACTIONS}")

    params = { "key": api_token }

    if action_type == START:
        if not duration:
            exit(f"ERROR: duration argument must exist in '{START}' type")
        elif (duration == -1) or (duration % 5 !=  0):
            exit(f"ERROR: duration argument must be -1 or a multiple of 5")
        else:
            params["duration"] = duration

    try:
        # filter based on https://www.rescuetime.com/anapi/setup/documentation#focustime-feed-reference
        req = requests.post(f"{API_URL}/{action_type}_focustime", params=params)

    except requests.exceptions.ConnectionError:
        return "No connection"

    if req.status_code != 200:
        return req.reason

    return req.json()['message']


def focustime_start(api_token, duration):
    return _focustime_action(api_token, action_type=START, duration=duration)


def focustime_end(api_token):
    return _focustime_action(api_token, action_type=END)


def is_focustime_active(focustime_record):
    if not focustime_record:
        return False, 0

    start_date = datetime.datetime.fromisoformat(focustime_record['timestamp'])
    start_date_utc = datetime.datetime.fromtimestamp(start_date.timestamp(), tz=datetime.timezone.utc)
    now_utc = datetime.datetime.now(datetime.timezone.utc)
    delta = now_utc - start_date_utc
    is_active = delta.seconds <= focustime_record['duration'] * 60
    min_left = focustime_record['duration'] - int(delta.seconds / 60)
    return is_active, min_left


if __name__ == '__main__':
    cfg = ConfigParser()
    config_path = os.path.join(os.getenv('XDG_CONFIG_HOME'), 'rescue-time', 'config.cfg')
    if not os.path.exists(config_path):
        exit(f"ERROR: No config in {config_path}")

    cfg.read(config_path)
    api_token = cfg.get("GENERAL", 'token')
    if not api_token:
        exit(f"ERROR: No api token in {config_path}")

    started = get_focustime_started(api_token)
    is_active, min_left = is_focustime_active(started[0])
    print(f'{min_left} min' if is_active else 'Focus Off')
