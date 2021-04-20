#!/usr/bin/env bash

dconf write  /desktop/ibus/general/engines-order "['xkb:us::eng', 'libpinyin']"
ibus restart

echo "Good :)"
