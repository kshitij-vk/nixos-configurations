# Start GNOME Keyring daemon
eval "$(/run/current-system/sw/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
export SSH_AUTH_SOCK