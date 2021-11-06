#!/usr/bin/env bash
rclone copy --update --transfers 30 --checkers 8 --exclude ".git/" --verbose /home/slbtty/s/ google-drive:script

# Google drive can works out of box with all options set as default

# TODO -> arbitrary path copy to google cloud