import gi
import cairo
import subprocess
import json
import yaml
import os


def get_uptime():
    with open("/proc/uptime", "r") as f:
        uptime_seconds = float(f.readline().split()[0])

    return uptime_seconds / 3600


gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

css_data = """
*{
  border-radius:0;
}
.label {
    margin:5px;
}

.rounded{
    border-radius: 5px;
    border: 2px solid #51afef;
    margin: 0 10px;
    margin-top:-10px;
}

.btn{
    border: 0px;
    color: #ffffff;
    background:#282C34;
    border-radius: 5px;
    border: 2px solid #c678dd;
}

.fill{
    background:#c678dd;
    color: #282C34;
}

.grid{
    border:1px solid #c678dd;
}

.invisible{
    background:transparent;
    color:transparent;
    border:0px;
    margin-top:-1000px;
}
"""

provider = Gtk.CssProvider.new()
provider.load_from_data(css_data.encode())


def cb_draw(widget, cr):
    cr.set_source_rgba(0.0, 0.0, 0.0, 0.98)
    cr.set_operator(cairo.OPERATOR_SOURCE)
    cr.paint()


win = Gtk.Window()
win.connect("destroy", Gtk.main_quit)


win.set_decorated(False)
win.set_app_paintable(True)

screen = win.get_screen()
visual = screen.get_rgba_visual()
win.set_visual(visual)
# make window always on top
win.set_keep_above(True)
# make the window float in i3
win.set_type_hint(Gdk.WindowTypeHint.UTILITY)

# make window size
win.set_default_size(500, screen.get_height() - 22)

# set the window on the right side of the screen
win.move(screen.get_width() - 502, -2)

win.set_resizable(True)

# win change scroll behavior
win.set_property("skip-taskbar-hint", True)
win.set_property("skip-pager-hint", True)
win.set_property("urgency-hint", True)
win.set_property("type", Gtk.WindowType.POPUP)


scroll = Gtk.ScrolledWindow()
grid = Gtk.Grid()
grid.set_column_homogeneous(True)
# set grid background color
grid.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.16, 0.17, 0.2, 0.98))
grid.get_style_context().add_class("grid")
grid.get_style_context().add_provider(provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)


box_header = Gtk.Box()
label_header = Gtk.Label()
label_header.set_markup("<b>Notifications</b>")
label_header.set_halign(Gtk.Align.START)
label_header.set_margin_start(10)
label_header.set_margin_top(10)
label_header.set_margin_bottom(10)
box_header.pack_start(label_header, True, True, 0)
grid.attach(box_header, 0, 0, 1, 1)


res = subprocess.getoutput("dunstctl history")
res = json.loads(res)
notifications = res["data"][0]
i = 1
boxEmpty = Gtk.Box(spacing=6)
labelEmpty = Gtk.Label()
labelEmpty.set_line_wrap(True)
# set background color to red
labelEmpty.override_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.69, 0.71, 0.77, 0.98))
# set border color
boxEmpty.override_background_color(
    Gtk.StateFlags.NORMAL, Gdk.RGBA(0.21, 0.23, 0.25, 0.98)
)
# boxEmpty with border radius
boxEmpty.get_style_context().add_class("rounded")
boxEmpty.get_style_context().add_provider(
    provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
)
labelEmpty.set_halign(Gtk.Align.START)
labelEmpty.set_margin_start(10)
labelEmpty.set_margin_top(10)
labelEmpty.set_margin_bottom(10)
labelEmpty.set_max_width_chars(35)

boxEmpty.pack_start(labelEmpty, True, True, 0)
# set box as invisible
boxEmpty.get_style_context().add_class("invisible")
labelEmpty.get_style_context().add_class("invisible")
# set label as invisible
grid.attach(boxEmpty, 0, i, 2, 1)
if len(notifications) == 0:
    boxEmpty.set_border_width(10)
    labelEmpty.set_markup("There are no notifications")
    boxEmpty.get_style_context().remove_class("invisible")
    labelEmpty.get_style_context().remove_class("invisible")
    # box empty make it visible
    boxEmpty.show()

i+=1
num = 0
for notif in notifications:
    box = Gtk.Box(spacing=6)
    label = Gtk.Label()
    label.set_line_wrap(True)
    label.set_markup(notif["message"]["data"])
    # set background color to red
    label.override_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.69, 0.71, 0.77, 0.98))
    box.set_border_width(10)
    # set border color
    box.override_background_color(
        Gtk.StateFlags.NORMAL, Gdk.RGBA(0.21, 0.23, 0.25, 0.98)
    )
    # box with border radius
    box.get_style_context().add_class("rounded")
    box.get_style_context().add_provider(
        provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
    label.set_halign(Gtk.Align.START)
    label.set_margin_start(10)
    label.set_margin_top(15)
    label.set_margin_bottom(15)
    label.set_max_width_chars(35)

    box.pack_start(label, True, True, 0)

    # button
    button = Gtk.Button()
    button.set_label("X")
    button.set_valign(Gtk.Align.CENTER)
    button.set_size_request(50, 50)
    # remove button border
    button.set_relief(Gtk.ReliefStyle.NONE)

    button.get_style_context().add_class("btn")
    button.get_style_context().add_provider(
        provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
    button.text = notif["id"]["data"]
    button.connect("clicked", lambda x: remove_notification(x))
    button.shadow_type = Gtk.ShadowType.NONE
    button.id = num

    time = get_uptime() - notif["timestamp"]["data"] / 1000 / 1000 / 3600
    mins = time % 1 * 60

    notif_info = ""

    if time > 1:
        notif_info += "%d hs %d min\n" % (time, mins)
    elif mins > 1:
        notif_info += "%d min\n" % mins
    else:
        notif_info += "now\n"

    notif_info_label = Gtk.Label()
    notif_info += "<b>%s</b>" % notif["appname"]["data"]
    notif_info_label.set_markup(notif_info)
    notif_info_label.set_halign(Gtk.Align.END)
    notif_info_label.set_justify(Gtk.Justification.RIGHT)

    box.pack_end(button, False, False, 5)
    box.pack_end(notif_info_label, False, False, 5)

    # set label bold
    grid.attach(box, 0, i, 2, 1)
    i += 1
    num += 1


def run_utility(x):
    # run command
    subprocess.run(x.command, shell=True)

    # toggle visible class
    if hasattr(x, "visible"):
        print(x.visible)
        add_fill(x)


def add_fill(x):
    if not x.visible:
        x.get_style_context().add_class("fill")
        x.visible = True
        print("fill")
    else:
        x.get_style_context().remove_class("fill")
        x.visible = False
        print("remove fill")


def load_config():
    try:
        with open(os.path.join(os.path.dirname(__file__), "dnc.yml"), "r") as f:
            # with lodaer
            config = yaml.load(f, Loader=yaml.FullLoader)
        return config
    except Exception as e:
        print(e)
        return None


config = load_config()
utils = []
if config:
    utils = config["utilities"]


if len(utils) > 0:
    box_utilities = Gtk.Box(spacing=6)
    label_utilities = Gtk.Label()
    label_utilities.set_markup("<b>Utilities</b>")
    label_utilities.set_halign(Gtk.Align.START)
    label_utilities.set_margin_start(10)
    label_utilities.set_margin_top(10)
    label_utilities.set_margin_bottom(10)
    box_utilities.pack_start(label_utilities, True, True, 0)

    grid.attach(box_utilities, 0, i, 2, 2)
    i += 1

    grid_utilities = Gtk.Grid()
    grid_utilities.set_column_homogeneous(True)
    grid_utilities.set_margin_start(10)
    grid_utilities.set_margin_end(10)
    grid.attach(grid_utilities, 0, i + 1, 2, 1)

j = 0
for util in utils:
    button = Gtk.Button()
    button.set_relief(Gtk.ReliefStyle.NONE)
    button.get_style_context().add_class("btn")
    button.get_style_context().add_provider(
        provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
    button.set_size_request(50, 50)
    button.set_margin_end(10)
    button.set_margin_start(10)
    button.set_margin_bottom(10)
    button.command = utils[util]["command"]
    if "fill" in utils[util]:
        button.visible = subprocess.getoutput(utils[util]["fill"]) == "1"
        button.visible = not button.visible
        add_fill(button)
    if "icon" in utils[util]:
        button.set_label(utils[util]["icon"] + "\t" + utils[util]["name"])
    else:
        button.set_label(utils[util]["name"])
    button.connect("clicked", lambda x: run_utility(x))
    grid_utilities.attach(button, j, i, 1, 1)
    j += 1
    if j == 2:
        j = 0
        i += 1





def remove_notification(x):
    print(x.get_parent())
    grid.remove(x.get_parent())
    subprocess.getoutput("dunstctl history-rm %d" % x.text)
    notifications.pop(x.id-1)
    # add empty label if grid is empty
    print(len(notifications))
    if len(notifications) == 0:
        boxEmpty.set_border_width(10)
        labelEmpty.set_markup("There are no notifications")
        boxEmpty.get_style_context().remove_class("invisible")
        labelEmpty.get_style_context().remove_class("invisible")


scroll.add(grid)

# scroll.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC)
# remove scroll animations when reaching top
scroll.set_kinetic_scrolling(False)
scroll.get_style_context().add_class(Gtk.STYLE_CLASS_FLAT)
scroll.get_style_context().add_provider(
    provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
)


win.add(scroll)

win.connect("draw", cb_draw)
win.show_all()
Gtk.main()
