#!/usr/bin/env python3
# Todoist polybar widget

import os, json, requests, time, math
from configparser import ConfigParser
from pathlib import Path

if __name__ == '__main__':
    cfg = ConfigParser()
    config_path = os.path.join(os.getenv('XDG_CONFIG_HOME'), 'todoist', 'config.cfg')
    if not os.path.exists(config_path):
        exit(f"ERROR: No config in {config_path}")

    cfg.read(config_path)
    api_token = cfg.get("GENERAL", 'token')
    if not api_token:
        exit(f"ERROR: No api token in {config_path}")

    tasks = requests.get(
        "https://api.todoist.com/rest/v1/tasks",
        params={"filter": "today | overdue"}, # filter based on https://todoist.com/help/articles/introduction-to-filters
        headers={"Authorization": f"Bearer {api_token}"}
    ).json()

    if len(tasks) > 0:
        print(f"{len(tasks)} tasks")
    else:
        print("No tasks")
