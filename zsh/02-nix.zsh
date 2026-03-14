# Nix — start daemon if needed (containers without init system) and source profile
if [ -d /nix ]; then
    if ! pgrep -x nix-daemon > /dev/null 2>&1; then
        sudo /nix/var/nix/profiles/default/bin/nix-daemon &>/dev/null &
        disown
    fi

    if [ -r /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi
fi
