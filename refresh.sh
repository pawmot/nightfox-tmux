#!/bin/bash

echo 'Refreshing colors from source (EdenEast/nightfox.nvim)'

declare -a Styles=("nightfox" "dayfox" "dawnfox" "duskfox" "nordfox" "terafox" "carbonfox")

for style in ${Styles[@]}; do

    wget -q https://raw.githubusercontent.com/EdenEast/nightfox.nvim/main/extra/$style/nightfox_kitty.conf -O current.conf

    echo "# --> $style" > $style.tmuxtheme
    echo "thm_bg=\"$(cat current.conf | grep -E "^background" | grep -E -o "#.{6}")\" # background" >> $style.tmuxtheme
    echo "thm_fg=\"$(cat current.conf | grep -E "^foreground" | grep -E -o "#.{6}")\" # foreground" >> $style.tmuxtheme
    echo "thm_black=\"$(cat current.conf | grep -E "^active_tab_foreground" | grep -E -o "#.{6}")\" # active_tab_foreground" >> $style.tmuxtheme
    echo "thm_gray=\"$(cat current.conf | grep -E "^color0" | grep -E -o "#.{6}")\" # color0" >> $style.tmuxtheme
    echo "thm_red=\"$(cat current.conf | grep -E "^color1 " | grep -E -o "#.{6}")\" # color1" >> $style.tmuxtheme
    echo "thm_green=\"$(cat current.conf | grep -E "^color2 " | grep -E -o "#.{6}")\" # color2" >> $style.tmuxtheme
    echo "thm_yellow=\"$(cat current.conf | grep -E "^color3 " | grep -E -o "#.{6}")\" # color3" >> $style.tmuxtheme
    echo "thm_blue=\"$(cat current.conf | grep -E "^color4 " | grep -E -o "#.{6}")\" # color4" >> $style.tmuxtheme
    echo "thm_pink=\"$(cat current.conf | grep -E "^color5 " | grep -E -o "#.{6}")\" # color5" >> $style.tmuxtheme
    echo "thm_cyan=\"$(cat current.conf | grep -E "^color6 " | grep -E -o "#.{6}")\" # color6" >> $style.tmuxtheme
    echo "thm_orange=\"$(cat current.conf | grep -E "^color17 " | grep -E -o "#.{6}")\" # color17" >> $style.tmuxtheme

    rm current.conf
done

