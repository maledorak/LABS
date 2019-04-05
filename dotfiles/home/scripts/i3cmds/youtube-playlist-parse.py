#!/usr/bin/python3

# Name: youParse.py
# Version: 1.5
# Author: pantuts (modified by robgibbons)
# Email: pantuts@gmail.com
# Description: Parse URLs in Youtube Playlist (Video Playlist not Favorites)
# Use python3 and later
# Agreement: You can use, modify, or redistribute this tool under
# the terms of GNU General Public License (GPLv3).
# This tool is for educational purposes only. Any damage you make will not affect the author.
# Usage: python3 youParse.py youtubeURLhere

import re
import urllib.request
import urllib.error
import sys
import time
from collections import OrderedDict

def crawl(url):
    sTUBE = ''
    cPL = ''
    amp = 0
    final_url = []

    if 'list=' in url:
        eq = url.rfind('=') + 1
        cPL = url[eq:]

    else:
        print('Incorrect Playlist.')
        exit(1)

    try:
        yTUBE = urllib.request.urlopen(url).read()
        sTUBE = str(yTUBE)
    except urllib.error.URLError as e:
        print(e.reason)

    tmp_mat = re.compile(r'watch\?v=\S+?list=' + cPL)
    mat = re.findall(tmp_mat, sTUBE)

    if mat:

        for PL in mat:
            yPL = str(PL)
            if '&' in yPL:
                yPL_amp = yPL.index('&')
            final_url.append('http://www.youtube.com/' + yPL[:yPL_amp])

        all_url = list(OrderedDict.fromkeys(final_url))

        i = 0
        while i < len(all_url):
            sys.stdout.write(all_url[i] + '\n')
            time.sleep(0.04)
            i = i + 1

    else:
        print('No videos found.')
        exit(1)

if len(sys.argv) < 2 or len(sys.argv) > 2:
    print('USAGE: python3 youParse.py YOUTUBEurl')
    exit(1)

else:
    url = sys.argv[1]
    if 'http' not in url:
        url = 'http://' + url
    crawl(url)
