#!/bin/bash

set -u -e 

trap_with_args() {
  func="$1"; shift
  for sig ; do
    trap "${func} ${sig}" "${sig}"
  done
}

trap_with_args trap_exit_handler EXIT INT TERM 

trap_exit_handler() {
  exit_status=$?
  if [[ $1 == "EXIT" ]]; then
    logging_msg "WARN" "Exit code ${exit_status}, End process."
  else
    logging_msg "WARN" "Receive SIG$1, SIGNAL_NUM is $(kill -l "$1")"
    logging_msg "WARN" "The default action for SIG$1 is to terminate the process."
    logging_msg "WARN" "Start the process shutdown."
  fi
}

trap_in_trap() {
  logging_msg "WARN" "When you ignore SIGINT, insert trap command with INT in this method."
  logging_msg "WARN" "to be run sleep 10, and try to push the shortcut 'Ctrl + C'"
  trap '' INT
  sleep 10
  logging_msg "WARN" "like this."
}



