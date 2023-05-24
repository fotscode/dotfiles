import os
import yaml
import gi
from gi.repository import Gtk, Gdk


def get_uptime():
    with open("/proc/uptime", "r") as f:
        uptime_seconds = float(f.readline().split()[0])

    return uptime_seconds / 3600


def get_time_string(uptime_notif):
    time = get_uptime() - uptime_notif / 1000 / 1000 / 3600
    mins = time % 1 * 60
    if time > 1:
        notif_info = "%d hs %d min\n" % (time, mins)
    elif mins > 1:
        notif_info = "%d min\n" % mins
    else:
        notif_info = "now\n"
    return notif_info


def load_style():
    try:
        with open(os.path.join(os.path.dirname(__file__), "style.css"), "r") as f:
            # with lodaer
            # config = yaml.load(f, Loader=yaml.FullLoader)
            return f.read()
    except Exception as e:
        return None


def load_config():
    try:
        with open(os.path.join(os.path.dirname(__file__), "dnc.yml"), "r") as f:
            # with lodaer
            config = yaml.load(f, Loader=yaml.FullLoader)
        return config
    except Exception as e:
        return None


def get_provider():
    css_data = load_style()
    provider = Gtk.CssProvider.new()
    provider.load_from_data(css_data.encode())
    return provider
