#!/bin/bash

function send_notification ()
{
  brightness=$(($(brightnessctl g)/960))

  dunstify -a Brightness -r 96000 -h int:value:${brightness} -i ~/.config/hypr/icons/brightness-$1.png "Screen Brightness : ${brightness}%"
}

case $1 in 
  up)
    brightnessctl s 5%+
  ;;
  down)
    brightnessctl s 5%-
  ;;
esac

send_notification $1
