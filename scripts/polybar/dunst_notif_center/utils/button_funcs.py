import subprocess
from .gtk_funcs import show_empty_notification


def remove_notification(x, grid_notifications, notifications):
    grid_notifications.remove(x.get_parent())
    subprocess.getoutput("dunstctl history-rm %d" % x.text)
    notifications.pop(x.id - 1)
    # add empty label if grid is empty
    if len(notifications) == 0:
        show_empty_notification(grid_notifications)


def clear_notifications(x, grid_notifications, notifications):
    subprocess.getoutput("dunstctl history-clear")
    notifications.clear()
    for child in grid_notifications.get_children():
        grid_notifications.remove(child)
    show_empty_notification(grid_notifications)


def run_utility(x):
    # run command
    subprocess.run(x.command, shell=True)

    # toggle visible class
    if hasattr(x, "visible"):
        add_fill(x)


def add_fill(x):
    if not x.visible:
        x.get_style_context().add_class("fill")
        x.visible = True
    else:
        x.get_style_context().remove_class("fill")
        x.visible = False
