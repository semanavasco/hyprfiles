#!/bin/bash

case $1 in
  text)
    status=$(playerctl --player=spotify status)
    info=$(playerctl --player=spotify metadata --format "{{title}} - {{artist}}")

    case $status in
      Playing)
        echo " $info"
      ;;
      Paused)
        echo " $info"
      ;;
    esac
  ;;
  time)
    time=$(playerctl --player=spotify metadata --format "--- {{duration(mpris:length - position)}} ---")

    echo "$time"
  ;;
esac
