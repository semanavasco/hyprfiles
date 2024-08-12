#!/bin/bash

function send_notification ()
{
  microphone=$(pamixer --default-source --get-volume)

  dunstify -a Volume -r 669 -h int:value:${microphone} -i ~/.config/hypr/icons/microphone-control.png "Microphone Volume : ${microphone}%"
}

function detect_mute ()
{
  if $(pamixer --default-source --get-mute); then
    pamixer --default-source -t
  fi
}

case $1 in 
  up)
    detect_mute

    pamixer --default-source -i 5
    
    send_notification
  ;;
  down)
    detect_mute

    pamixer --default-source -d 5
    
    send_notification
  ;;
  mute)
    pamixer --default-source -t

    if $(pamixer --default-source --get-mute); then
      dunstify -a Volume -r 669 -i ~/.config/hypr/icons/microphone-mute.png "The microphone has been muted."
    else 
      send_notification
    fi
  ;;
esac
