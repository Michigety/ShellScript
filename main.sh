#!/bin/bash

set -e
for f in $(find ./src/ -name "*.sh"); do source "${f}"; done

while (( $# != 0 )); do
  case $1 in
    -h|--help)
      usage
      ;;
    -v|--version)
      version
      ;;
    -d|--debug)
      logging_msg "DEBUG" "running on Debug mode."
      set -x
      shift
      ;;
    -*|--*)
      echo "$0: $1: invalid option"
      echo "$0: usage: $0 [-h|--help] [-v|--version] [-d|--debug]"
      exit 1
      ;;
    *)
      echo "$0: $1: invalid argument"
      echo "$0: usage: $0 [-h|--help] [-v|--version] [-d|--debug]"
      exit 1
      ;;
  esac
done

logging_msg "INFO" "Start $0"

#logging_msg "INFO" "You can control to save or not with using logging_start()."
#logging_start ./logs/
#logging_msg "INFO" "This message is saved in ${log_name},"
#logging_msg "INFO" "and logrotate file is saved in ${logconf}"

#logging_msg "INFO" "If you wanna stop the logging, use logging_stop()."
#logging_stop
logging_msg "INFO" "This message isn't saved in \${log_name}, only displayed on the screen."

