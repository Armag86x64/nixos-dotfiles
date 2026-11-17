/* Autostart */
static const char *const autostart[] = {
	"waybar", NULL,
	"awww-daemon", NULL,
	"sh", "-c", "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots && systemctl --user restart xdg-desktop-portal xdg-desktop-portal-termfilechooser", NULL,
	NULL
};

/*
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
systemctl --user restart xdg-desktop-portal-termfilechooser
*/
