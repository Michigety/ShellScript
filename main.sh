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
      set -x
      logging_start
      logging_msg "DEBUG" "running on Debug mode."
      logging_msg "DEBUG" "saving logs in ${log_name}"
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
