import subprocess
import json
import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk
from utils.gtk_funcs import (
    make_grid,
    make_button,
    make_label,
    make_box,
    make_window,
    show_empty_notification,
)
from utils.others import load_config, get_time_string
from utils.button_funcs import (
    remove_notification,
    clear_notifications,
    run_utility,
    add_fill,
)

win = make_window()
config = load_config()


utils = []
if config:
    utils = config["utilities"]

scroll = Gtk.ScrolledWindow()
win.add(scroll)

overlay = Gtk.Overlay()
scroll.add(overlay)

grid = make_grid(end=0, row_homogeneous=False)
grid.get_style_context().add_class("grid")

box_header = Gtk.Box()
label_header = make_label(
    "<b>Notifications</b>", margin=10, halign=Gtk.Align.START, valign=Gtk.Align.CENTER
)
label_header.set_margin_start(20)
box_header.pack_start(label_header, True, True, 0)


button_clear = make_button(
    "Clear",
    lambda x: clear_notifications(x, grid_notifications, notifications),
    halign=Gtk.Align.END,
)
button_clear.set_margin_end(20)
grid.attach(box_header, 0, 0, 1, 1)
grid.attach(button_clear, 0, 0, 2, 1)

grid_notifications = make_grid(start=0, end=0, row_homogeneous=False)
grid.attach(grid_notifications, 0, 1, 2, 1)

res = subprocess.getoutput("dunstctl history")
res = json.loads(res)
notifications = res["data"][0]

if len(notifications) == 0:
    show_empty_notification(grid_notifications)

row = 1
for notif in notifications:
    box = make_box()

    label = make_label(
        notif["message"]["data"],
        margin=10,
        halign=Gtk.Align.START,
        valign=Gtk.Align.CENTER,
    )

    button = make_button(
        "X",
        lambda x: remove_notification(x, grid_notifications, notifications),
        size=50,
    )
    button.text = notif["id"]["data"]
    button.id = row - 1

    notif_info = get_time_string(notif["timestamp"]["data"])
    notif_info += "<b>%s</b>" % notif["appname"]["data"]
    notif_info_label = make_label(
        notif_info,
        margin=10,
        halign=Gtk.Align.END,
        valign=Gtk.Align.CENTER,
        justify=Gtk.Justification.RIGHT,
    )

    box.pack_start(label, True, True, 0)
    box.pack_end(button, False, False, 5)
    box.pack_end(notif_info_label, False, False, 5)

    grid_notifications.attach(box, 0, row, 1, 1)
    row += 1


if len(utils) > 0:
    box_utilities = Gtk.Box(spacing=6)
    label_utilities = make_label(
        "<b>Utilities</b>", margin=10, halign=Gtk.Align.START, valign=Gtk.Align.CENTER
    )
    label_utilities.set_margin_start(20)
    box_utilities.pack_start(label_utilities, True, True, 0)

    grid_utilities = make_grid()

    grid.attach(box_utilities, 0, 2, 2, 1)
    grid.attach(grid_utilities, 0, 3, 2, 1)

column = 0
for util in utils:
    button = make_button(
        utils[util]["name"],
        lambda x: run_utility(x),
        size=50,
        halign=None,
        valign=None,
    )
    button.command = utils[util]["command"]
    if "fill" in utils[util]:
        button.visible = subprocess.getoutput(utils[util]["fill"]) != "1"
        add_fill(button)
    grid_utilities.attach(button, column, row, 1, 1)
    # 2 columns per row
    column += 1
    if column == 2:
        column = 0
        row += 1


overlay.add(grid)

win.show_all()
Gtk.main()
