#!/usr/bin/env bash

# https://wiki.archlinux.org/title/mirrors

set -e
set -x

#canada
sudo curl -s "https://archlinux.org/mirrorlist/?country=CA&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on" \
  | sed -e 's/^#Server/Server/' -e '/^#/d' \
  | rankmirrors -n 5 - \
  > /etc/pacman.d/mirrorlist

cat /etc/pacman.d/mirrorlist
# local only
# sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
# sudo rankmirrors -n 8 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist