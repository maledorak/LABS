# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# ----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os
# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


class empty(Command):
    """:empty

    Empties the trash directory ~/.local/share/Trash
    """

    def execute(self):
        self.fm.run("gio trash --empty")


class img_to_pdf(Command):
    """:to_pdf

    Convert selected image to pdf
    """

    def execute(self):
        cf = self.fm.thisfile
        out = "{}.pdf".format(os.path.splitext(cf.basename)[0])
        self.fm.run("convert {cf} -quality 100 {out}".format(cf=cf.basename, out=out))
