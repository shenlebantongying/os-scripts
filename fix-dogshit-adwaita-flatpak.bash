#!/usr/bin/env bash

# TODO: add somethings to check if it works.
flatpak install org.gtk.Gtk3theme.Breeze
flatpak override --env=GTK_THEME=Breeze --user
