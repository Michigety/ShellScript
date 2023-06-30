#!/bin/bash

trap_in_trap() {
  logging_msg "WARN" "When you ignore SIGINT, insert trap command with INT in this method."
  logging_msg "WARN" "to be run sleep 10, and try to push the shortcut 'Ctrl + C'"
  trap '' INT
  sleep 10
  logging_msg "WARN" "like this."
}

touch_az() {
  echo "touch a.txt to z.txt"
  mkdir -p run_on_bg
  for i in ./run_on_bg/{a..z}.txt; do
    sleep 1
    touch $i
  done
}

sleep_ten() {
  for i in {1..10}; do
    echo $i
    sleep 1
  done
}

main() {
  touch_az &
  background_PID=$!
  wait "${background_PID}"
}

#trap '' INT
#sleep_ten

#trap INT
#sleep_ten

