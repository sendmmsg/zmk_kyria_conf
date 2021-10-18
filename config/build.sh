#!/usr/bin/env bash
set -euo pipefail
cp /config/kyria.conf /zmk/app/boards/shields/kyria/kyria.conf
cp /config/swed* /zmk/app/boards/shields/kyria/
cp /config/kyria.keymap /zmk/app/boards/shields/kyria/kyria.keymap

#west init -l config
#west update
west zephyr-export
west build --pristine -s zmk/app -b nice_nano_v2 -- -DSHIELD=kyria_left -DZMK_CONFIG="/config"
cat -n build/zephyr/nice_nano_v2.dts.pre.tmp
cat build/zephyr/.config | grep -v "^#" | grep -v "^$" >/config/left_config
cp build/zephyr/zmk.uf2 /config/kyria_left_nice_nano_v2.uf2
west build --pristine -s zmk/app -b nice_nano_v2 -- -DSHIELD=kyria_right -DZMK_CONFIG="/config"
cat build/zephyr/.config | grep -v "^#" | grep -v "^$" >/config/right_config
cp build/zephyr/zmk.uf2 /config/kyria_right_nice_nano_v2.uf2
