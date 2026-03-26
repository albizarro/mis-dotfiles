#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Electric Tempest — storm border animation
# Palette: electric cyan + ice white + storm blue (no rainbow)

# 0xff81ecff = electric cyan   | 0xfff9f9f9 = white flash
# 0xff00affe = storm core blue | 0xff00e3fd = primary gradient
# 0xffe0e5f4 = ice blue-white  | 0xff00d4ec = primary dim

hyprctl keyword general:col.active_border \
    0xff81ecff 0xfff9f9f9 0xff00affe 0xff00e3fd 0xffe0e5f4 0xff81ecff 0xff00d4ec 0xfff9f9f9 0xff00affe 0xff00e3fd \
    270deg