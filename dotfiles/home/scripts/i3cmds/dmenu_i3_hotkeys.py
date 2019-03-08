#!/usr/bin/env python3

import os
from re import compile
from subprocess import run, Popen, PIPE

__author__ = "Mariusz 'Maledorak' Korzekwa"
__credits__ = ["Mariusz 'Maledorak' Korzekwa"]
__license__ = "CC BY 4.0"
__version__ = "1.0.0"
__email__ = "maledorak@gmail.com"


I3_CONFIG_PATH = os.path.join(os.environ.get("HOME"), ".config", "i3", "config")
DMENU_COMMAND = ["rofi", "-dmenu", "-i", "-p", "i3 HotKeys", "-lines", "20", "-width", "35"]
START_LINE_SEARCHING_PATTERN = "%%hotkey:"
END_LINE_SEARCHING_PATTERN = "%%"
ADDITIONAL_DOTS = 10


class I3HotKeys():
    """
    Getting bindsym (hotkeys) info from i3 config file.
    If you want use this script you should:
    1. Add the following comment line before "bindsym" which you want to use in your i3 config
    # %%hotkey: Some description of the following bindsym %%
    2. Run this script
    """

    def __init__(self):
        self.path = I3_CONFIG_PATH
        self.content = self.get_config_file_content(self.path)
        self.entries = self.get_entries(self.content)
        self.output = self.format_entries(self.entries)

    def get_config_file_content(self, path):
        """
        Getting content of i3 config file.
        :param path: string with path to your i3 config file
        :return: string
        """
        with open(path, "r") as file_:
            content = file_.read()
        return content

    def get_entries(self, content):
        """
        Geting entries of hotkey "info" and hotkey itself.
        :param content: string with i3 config content
        :return: list of tuples, eg. [(hotkey, info), (hotkey, info)]
        """
        regex_search = compile(r"^.*{start}([^%]+){end}$".format(
            start=START_LINE_SEARCHING_PATTERN, end=END_LINE_SEARCHING_PATTERN))
        content_lines = content.splitlines()
        entries = list()
        for index, line in enumerate(content_lines):
            match = regex_search.match(line)
            if match:
                info = match.group(1).strip()
                hotkey_line = content_lines[index + 1]
                hotkey = hotkey_line.split(None)[1]
                entries.append((hotkey, info))
        return entries

    def format_entries(self, entries):
        """
        Adding nice looking dots between "hotkey" and "info" and return entries in string.
        :param entries: list of tuples, eg. [(hotkey, info), (hotkey, info)]
        :return: string
        """
        longest_hotkey = max(set(len(entry[0]) for entry in entries))
        dots_length = longest_hotkey + ADDITIONAL_DOTS
        output = list()
        for hotkey, info in entries:
            output.append("{hotkey} {dots} {info}".format(
                hotkey=hotkey,
                dots="." * (dots_length - len(hotkey)),
                info=info
            ))
        return "\n".join(output)


if __name__ == "__main__":
    hot_keys = I3HotKeys()
    # subprocess piping was created based on: https://stackoverflow.com/a/4846923
    echo = Popen(["echo", hot_keys.output], stdout=PIPE)
    run(DMENU_COMMAND, stdin=echo.stdout)
    echo.stdout.close()
