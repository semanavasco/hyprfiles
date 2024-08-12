#!/bin/bash

players=$(playerctl -l)

if ! echo "$players" | grep -q "spotify"; then
  exit 1
fi

function get_time ()
{
  duration=$(playerctl --player=spotify metadata --format "{{duration(mpris:length - position)}}")
  IFS=':' read -r minutes seconds <<< "$duration"
  duration=$(expr $minutes \* 60 + $seconds)

  position=$(playerctl --player=spotify metadata --format "{{duration(position)}}")
  IFS=':' read -r minutes seconds <<< "$position"
  position=$(expr $minutes \* 60 + $seconds)

  percentage=$((100 * $position / $duration))

  echo $percentage
}

case $1 in
  previous)
    playerctl --player=spotify previous
  ;;
  next)
    playerctl --player=spotify next
  ;;
  pause)
    playerctl --player=spotify play-pause

    info=$(playerctl --player=spotify metadata --format "{{title}} - {{artist}}")
    time=$(playerctl --player=spotify metadata --format "--- {{duration(position)}} / {{duration(mpris:length)}} ---")
    time_value=$(get_time)
    image=$(playerctl --player=spotify metadata --format "{{mpris:artUrl}}")
    curl $image --output /tmp/spotify-img.png --silent

    state=$(playerctl --player=spotify status)

    dunstify -a Music -r 555 -h int:value:$time_value -i /tmp/spotify-img.png " $state music." "$info<br>$time" -t 2000
  ;;
esac
