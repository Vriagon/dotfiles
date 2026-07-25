#!/bin/bash

set -e

echo "========== Arch Cleanup Script =========="

# 1. Refresh mirrors FIRST (with longer timeout to prevent warnings)
if command -v reflector &> /dev/null; then
    echo -e "\n[1/6] Refreshing mirrorlist..."
    sudo reflector \
        --country India \
        --number 10 \
        --latest 5 \
        --download-timeout 10 \
        --protocol https \
        --sort rate \
        --save /etc/pacman.d/mirrorlist
else
    echo -e "\n[1/6] Reflector not installed, skipping mirror refresh."
fi

# 2. Sync package databases + upgrade
echo -e "\n[2/6] Syncing system and upgrading packages..."
paru -Syu --noconfirm

# 3. Remove orphan packages (force non-interactive)
echo -e "\n[3/6] Removing orphan packages..."
orphans=$(paru -Qtdq || true)

if [ -n "$orphans" ]; then
    echo "$orphans" | paru -Rns --noconfirm -
else
    echo "No orphan packages found."
fi

# 4. Clean pacman and AUR cache
echo -e "\n[4/6] Cleaning package cache..."
if command -v paccache &> /dev/null; then
    sudo paccache -rk3
else
    echo "paccache not installed! Run 'sudo pacman -S pacman-contrib' to enable it."
fi

# Clean AUR build files non-interactively
paru -Sc --noconfirm

# 5. Clean user cache SAFELY
echo -e "\n[5/6] Cleaning user cache (~/.cache)..."
rm -rf ~/.cache/thumbnails/* 2>/dev/null || true
find ~/.cache -type f -atime +7 -delete 2>/dev/null || true
find ~/.cache -type d -empty -delete 2>/dev/null || true
echo "User cache pruned."

# 6. Clean systemd journal logs
echo -e "\n[6/6] Cleaning system logs..."
journalctl --disk-usage
sudo journalctl --vacuum-time=7d

echo -e "\nCleanup complete!"
