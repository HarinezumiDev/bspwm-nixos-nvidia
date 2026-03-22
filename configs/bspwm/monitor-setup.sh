#!/usr/bin/env bash
connected=($(xrandr --query | awk '/ connected/ {print $1}'))
if printf '%s\n' "${connected[@]}" | grep -qx "HDMI-1"; then
  HDMI_W=$(xrandr --query | awk '/^HDMI-1 connected/ { match($0, /[0-9]+x[0-9]+/); split(substr($0,RSTART,RLENGTH),a,"x"); print a[1] }')
  : "${HDMI_W:=1920}"
  xrandr --output HDMI-1 --auto --pos 0x0 --output eDP-1 --primary --auto --pos "${HDMI_W}x0"
  sleep 0.3
  bspc monitor eDP-1 -d I II III IV V
  bspc monitor HDMI-1 -d VI VII VIII
  for m in $(bspc query -M --names); do
    bspc config -m "$m" top_padding 24 bottom_padding 0 left_padding 0 right_padding 0
  done
else
  xrandr --output HDMI-1 --off --output eDP-1 --primary --auto --pos 0x0
  bspc monitor eDP-1 -d I II III IV V VI VII VIII
  bspc config -m eDP-1 top_padding 24 bottom_padding 0 left_padding 0 right_padding 0
fi
