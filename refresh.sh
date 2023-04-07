#!/bin/bash

echo 'Refreshing colors from source (EdenEast/nightfox.nvim)'

declare -a Styles=("nightfox" "dayfox")

for style in ${Styles[@]}; do

    wget -q https://raw.githubusercontent.com/EdenEast/nightfox.nvim/main/extra/$style/nightfox_kitty.conf -O $style.conf
done

