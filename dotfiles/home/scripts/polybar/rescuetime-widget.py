#!/usr/bin/env python3
# Todoist polybar widget

import os, requests
from configparser import ConfigParser

def parser(api_token):
    base_url = "https://www.rescuetime.com/anapi"
    try:
        # filter based on https://www.rescuetime.com/anapi/setup/documentation#focustime-feed-reference
        req = requests.get(f"{base_url}/focustime_started_feed", params={"key": api_token})

    except requests.exceptions.ConnectionError:
        return "No connection"
    import pdb; pdb.set_trace()

    if req.status_code != 200:
        return req.reason

    # tasks = req.json()


    # if len(tasks) > 0:
    #     return f"{len(tasks)} tasks"
    # else:
    #     return "No tasks"


if __name__ == '__main__':
    cfg = ConfigParser()
    config_path = os.path.join(os.getenv('XDG_CONFIG_HOME'), 'rescue-time', 'config.cfg')
    if not os.path.exists(config_path):
        exit(f"ERROR: No config in {config_path}")

    cfg.read(config_path)
    api_token = cfg.get("GENERAL", 'token')
    if not api_token:
        exit(f"ERROR: No api token in {config_path}")

    print(parser(api_token))
