#!/usr/bin/env python3
# RescueTime polybar widget

import os
import datetime
from configparser import ConfigParser

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

def iso_tz_aware_string_to_utc_datetime(date_string):
    date = datetime.datetime.fromisoformat(date_string)
    return datetime.datetime.fromtimestamp(date.timestamp(), tz=datetime.timezone.utc)



def is_focustime_active(started_records=[], ended_records=[]):
    if len(started_records) == 0:
        return False, 0

    started_last = started_records[0]

    start_date_utc = iso_tz_aware_string_to_utc_datetime(started_last['created_at'])
    now_utc = datetime.datetime.now(datetime.timezone.utc)
    delta = now_utc - start_date_utc

    is_active = delta.seconds <= started_last['duration'] * 60
    min_left = started_last['duration'] - int(delta.seconds / 60)

    # In case that focustime was ended before duration time
    # if is_active and len(ended_records) > 0:
    #     ended = ended_records[0]
    #     end_date_utc = iso_tz_aware_string_to_utc_datetime(ended['created_at'])
    #     if len(started_records) == 1 and now_utc > end_date_utc:
    #         # Only 1 started record means that its current one
    #         is_active = False
    #         min_left = 0

        # elif len(started_records) > 1 and now_utc > end_date_utc:
        #     started_previously = started_records[1]
        #     started_previously_date_utc = iso_tz_aware_string_to_utc_datetime(started_previously['created_at'])
        #     import pdb; pdb.set_trace()



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

    started_records = get_focustime_started(api_token)
    ended_records = get_focustime_ended(api_token)
    is_active, min_left = is_focustime_active(started_records, ended_records)
    print(f'{min_left} min' if is_active else 'Focus Off')
