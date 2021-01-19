#!/usr/bin/env python3
# Toggl polybar widget

import os, json, requests, time, math
from configparser import ConfigParser
from pathlib import Path

if __name__ == '__main__':
    cfg = ConfigParser()
    config_path = os.path.join(os.getenv('XDG_CONFIG_HOME'), 'toggl', 'config.cfg')
    if not os.path.exists(config_path):
        exit(f"ERROR: No config in {config_path}")

    cfg.read(config_path)
    api_token = cfg.get("GENERAL", 'token')
    if not api_token:
        exit(f"ERROR: No api token in {config_path}")

    current = json.loads(
        requests.get("https://www.toggl.com/api/v8/time_entries/current",
        auth=(api_token, "api_token")
    ).content)

    if current['data'] is not None and ("pid" in current["data"] or "description" in current["data"]):
        time_in_seconds = time.time() - abs(current['data']['duration'])
        hours = str(math.floor(time_in_seconds / 3600))
        minutes = str(math.floor(time_in_seconds % 3600 / 60)).zfill(2)
        seconds = str(math.floor(time_in_seconds % 60)).zfill(2)

        if "pid" in current["data"]:
            link = 'https://www.toggl.com/api/v8/projects/' + str(current['data']['pid'])
            name = json.loads(requests.get(link, auth=(api_token, "api_token")).content)["data"]["name"]
        else:
            name = current['data']['description']

        print(f"{name} ({hours}:{minutes}:{seconds})")
    else:
        print("No project")
