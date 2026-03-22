#!/usr/bin/env bash

layout=$(setxkbmap -query | awk '/layout/ {print $2}')

case "$layout" in
  de|ua|ru) ;;
  *) layout="??" ;;
esac

echo " $layout"

