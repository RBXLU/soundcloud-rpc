#!/bin/sh
# Removes soundcloud-rpc. Add --purge to also delete the saved application ID.
set -eu

UNIT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/soundcloud-rpc"

systemctl --user disable --now soundcloud-rpc.service 2>/dev/null || true
rm -f "$HOME/.local/bin/soundcloud-rpc" "$UNIT_DIR/soundcloud-rpc.service"
systemctl --user daemon-reload

if [ "${1:-}" = "--purge" ]; then
    rm -rf "$CONF_DIR"
    echo "Removed, including $CONF_DIR"
else
    echo "Removed. Your application ID is kept in $CONF_DIR (use --purge to delete it)."
fi
