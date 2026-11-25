#!/bin/sh
# Installs soundcloud-rpc for the current user (no root needed).
# Usage: ./install.sh [DISCORD_APPLICATION_ID]
set -eu

cd "$(dirname "$0")"
BIN="$HOME/.local/bin"
UNIT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/soundcloud-rpc"

if ! python3 -c 'import dbus' 2>/dev/null; then
    echo "python-dbus is missing. Install it first:"
    echo "  Arch:          sudo pacman -S python-dbus"
    echo "  Debian/Ubuntu: sudo apt install python3-dbus"
    echo "  Fedora:        sudo dnf install python3-dbus"
    exit 1
fi

install -Dm755 soundcloud-rpc "$BIN/soundcloud-rpc"
install -Dm644 soundcloud-rpc.service "$UNIT_DIR/soundcloud-rpc.service"
mkdir -p "$CONF_DIR"

if [ "${1:-}" ]; then
    printf '%s\n' "$1" > "$CONF_DIR/client_id"
fi

if [ ! -s "$CONF_DIR/client_id" ]; then
    printf 'Discord Application ID (https://discord.com/developers/applications): '
    read -r id
    printf '%s\n' "$id" > "$CONF_DIR/client_id"
fi

systemctl --user daemon-reload
systemctl --user enable soundcloud-rpc.service >/dev/null
systemctl --user restart soundcloud-rpc.service

echo "Done. soundcloud-rpc is running and will start automatically on login."
echo "Logs: journalctl --user -u soundcloud-rpc -f"
