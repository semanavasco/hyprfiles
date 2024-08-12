#!/bin/bash

function send_notification ()
{
  volume=$(pamixer --get-volume)

  dunstify -a Volume -r 667 -h int:value:${volume} -i ~/.config/hypr/icons/volume-$1.png "Volume : ${volume}%"
}

case $1 in 
  up)
    if $(pamixer --get-mute); then
      pamixer -t
    fi

    pamixer -i 5
    
    send_notification $1
  ;;
  down)
    if $(pamixer --get-mute); then
      pamixer -t
    fi

    pamixer -d 5
    
    send_notification $1
  ;;
  mute)
    pamixer -t

    if $(pamixer --get-mute); then
      dunstify -a Volume -r 667 -i ~/.config/hypr/icons/volume-mute.png "All sounds have been muted."
    else 
      send_notification up
    fi
  ;;
esac
