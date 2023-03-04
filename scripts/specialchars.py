#!/usr/bin/env python3
import os
import gi
gi.require_version("Gtk", "3.0")
gi.require_version('Wnck', '3.0')
from gi.repository import Gtk, Wnck, Gdk
import subprocess
import pyclip
import pyautogui


css_data = """
*{
  border-radius:0;
  border-left:1px solid black;
  border-bottom:1px solid black;
}
.label {
  font-weight: bold;
  color: #c678dd;
  background: #282c34;
  border-radius: 0;
}
.delete {
  background: #373b41;
  color: #e06c75;
}

.char{
  background: #373b41;
  border-radius:0;
  color: #56b6c2;
}

.add{
  background: #373b41;
  color: #98c379;
  border-top:0px;
}
"""

fpath = os.environ["HOME"] + "/.specialchars"

def create_dirs():
    try:
        os.mkdir(fpath)
    except FileExistsError:
        pass


def listfiles():
    files = os.listdir(fpath)
    chardata = []
    for f in files:
        f = os.path.join(fpath, f)
        chars = [s.strip() for s in open(f).readlines()]
        try:
            category = chars[0]
            members = chars[1:]
        except IndexError:
            os.remove(f)
        else:
            chardata.append([category, members, f])
    chardata.sort(key=lambda x: x[0])
    return chardata


def create_newfamily(button):
    print("yay")
    n = 1
    while True:
        name = "charfamily_" + str(n)
        file = os.path.join(fpath, name)
        if os.path.exists(file) and os.path.getsize(file) > 0:
            n = n + 1
        else:
            break
    open(file, "wt").write("")
    subprocess.Popen(["xdg-open", file])


class Window(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self)
        self.set_decorated(True)
        # self.set_active(True)
        self.set_keep_above(True);
        self.set_position(Gtk.WindowPosition.CENTER_ALWAYS)
        self.connect("key-press-event", self.get_key)
        self.set_default_size(0, 0)
        self.provider = Gtk.CssProvider.new()
        self.provider.load_from_data(css_data.encode())
        self.maingrid = Gtk.Grid()
        self.add(self.maingrid)
        chardata = listfiles()
        # get the currently active window
        self.screendata = Wnck.Screen.get_default()
        self.screendata.force_update()
        self.curr_subject = self.screendata.get_active_window().get_xid()
        row = 0
        for d in chardata:
            bbox = Gtk.HBox()
            fambutton = Gtk.Button(d[0])
            fambutton_cont = fambutton.get_style_context()
            fambutton_cont.add_class("label")
            fambutton.connect("clicked", self.open_file, d[2])
            Gtk.StyleContext.add_provider(
                fambutton_cont,
                self.provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
            )
            fambutton.set_tooltip_text(
                "Edit special characters of '" + d[0] + "'"
            )
            bbox.pack_start(fambutton, False, False, 0)
            for c in d[1]:
                button = Gtk.Button(c)
                button_cont = button.get_style_context()
                button_cont.add_class("char")
                button.connect("clicked", self.replace, c)
                button.set_size_request(1, 1)
                bbox.pack_start(button, False, False, 0)
                Gtk.StyleContext.add_provider(
                    button_cont,
                    self.provider,
                    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
                )
            self.maingrid.attach(bbox, 0, row, 1, 1)
            deletebutton = Gtk.Button("X")

            deletebutton_cont = deletebutton.get_style_context()
            deletebutton_cont.add_class("delete")
            Gtk.StyleContext.add_provider(
                deletebutton_cont,
                self.provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
            )

            deletebutton.connect("clicked", Gtk.main_quit, d[2], bbox)
            deletebutton.set_tooltip_text("Close")

            self.maingrid.attach(deletebutton, 100, row, 1, 1)
            row = row + 1
        addbutton = Gtk.Button("+")
        addbutton.connect("clicked", create_newfamily)
        addbutton.set_tooltip_text("Add family")
        addbutton_cont = addbutton.get_style_context()
        addbutton_cont.add_class("add")
        Gtk.StyleContext.add_provider(
            addbutton_cont,
            self.provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
        )

        label=Gtk.Label("- Press Esc to exit -")
        label_cont = label.get_style_context()
        label_cont.add_class("label")
        Gtk.StyleContext.add_provider(
            label_cont,
            self.provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
        )
        self.maingrid.attach(addbutton, 100, 100, 1, 1)
        self.maingrid.attach(label, 0, 100, 1, 1)
        self.show_all()
        Gtk.main()

    def get_key(self, button, val):
        # keybinding to close the previews
        if Gdk.keyval_name(val.keyval) == "Escape":
            Gtk.main_quit()

    def replace(self, button, char, *args):
        pyclip.copy(char)
        subprocess.call(["wmctrl", "-ia", str(self.curr_subject)])
        pyautogui.hotkey('ctrl', 'v')
        Gtk.main_quit()


    def open_file(self, button, path):
        subprocess.Popen(["xdg-open", path])

    def delete_file(self, button, path, widget):
        os.remove(path)
        widget.destroy()
        button.destroy()
        self.resize(10, 10)

create_dirs()
Window()
