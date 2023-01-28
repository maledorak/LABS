#!/usr/bin/env python3
# Todoist polybar widget

import os
from configparser import ConfigParser

import requests


def parser(api_token):
    try:
        # filter based on https://todoist.com/help/articles/introduction-to-filters
        req = requests.get(
            "https://api.todoist.com/rest/v2/tasks",
            params={"filter": "today | overdue"}, headers={"Authorization": f"Bearer {api_token}"}
        )

    except requests.exceptions.ConnectionError:
        return "No connection"

    if req.status_code != 200:
        return req.reason

    tasks = req.json()


    if len(tasks) > 0:
        return f"{len(tasks)} tasks"
    else:
        return "No tasks"


if __name__ == '__main__':
    cfg = ConfigParser()
    config_path = os.path.join(os.getenv('XDG_CONFIG_HOME'), 'todoist', 'config.cfg')
    if not os.path.exists(config_path):
        exit(f"ERROR: No config in {config_path}")

    cfg.read(config_path)
    api_token = cfg.get("GENERAL", 'token')
    if not api_token:
        exit(f"ERROR: No api token in {config_path}")

    print(parser(api_token))
