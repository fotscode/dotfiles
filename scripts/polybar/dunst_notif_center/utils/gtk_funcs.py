import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk
from .others import get_provider

provider = get_provider()


def make_window():
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
    return win


def make_grid(top=0, bottom=0, start=10, end=10, row_homogeneous=True):
    grid = Gtk.Grid()
    grid.set_margin_top(top)
    grid.set_margin_bottom(bottom)
    grid.set_margin_start(start)
    grid.set_margin_end(end)
    grid.set_column_homogeneous(True)
    grid.set_row_homogeneous(row_homogeneous)
    grid.get_style_context().add_provider(
        provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
    return grid


def make_button(
    label,
    function,
    valign=Gtk.Align.CENTER,
    halign=Gtk.Align.START,
    margin=10,
    size=None,
):
    button = Gtk.Button()
    button.set_label(label)
    button.get_style_context().add_class("btn")
    button.get_style_context().add_provider(
        provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
    if valign:
        button.set_valign(valign)
    if halign:
        button.set_halign(halign)
    button.set_margin_top(margin)
    button.set_margin_bottom(margin)
    button.set_margin_start(margin)
    button.set_margin_end(margin)
    button.set_relief(Gtk.ReliefStyle.NONE)
    button.connect("clicked", function)
    if size:
        button.set_size_request(size, size)
    return button


def make_label(
    text,
    margin=10,
    halign=Gtk.Align.START,
    valign=Gtk.Align.CENTER,
    justify=Gtk.Justification.LEFT,
):
    label = Gtk.Label()
    label.set_markup(text)
    label.set_halign(halign)
    label.set_valign(valign)
    label.set_margin_top(margin)
    label.set_margin_bottom(margin)
    label.set_margin_start(margin)
    label.set_margin_end(margin)
    label.set_line_wrap(True)
    label.set_alignment(0, 0)
    label.set_justify(justify)
    label.set_max_width_chars(35)
    label.set_line_wrap_mode(Gtk.WrapMode.WORD)
    return label


def make_box(border_width=10, color=Gdk.RGBA(0.21, 0.23, 0.25, 0.98)):
    box = Gtk.Box()
    box.set_border_width(border_width)
    box.override_background_color(Gtk.StateFlags.NORMAL, color)
    box.get_style_context().add_class("rounded")
    box.get_style_context().add_provider(
        provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
    return box


def show_empty_notification(grid_notifications):
    boxEmpty = make_box()
    labelEmpty = make_label(
        "There are no notifications",
        margin=10,
        halign=Gtk.Align.START,
        valign=Gtk.Align.CENTER,
    )
    boxEmpty.pack_start(labelEmpty, True, True, 0)
    boxEmpty.show()
    labelEmpty.show()
    grid_notifications.attach(boxEmpty, 0, 0, 1, 1)
