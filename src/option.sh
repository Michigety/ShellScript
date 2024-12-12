#!/bin/bash

################################################################################
# Print help message.
################################################################################
usage() {
  cat << HELP

Usage:
  $0 [OPTIONS]

Writes Description at this section.

Options:
  -h, --help		Show help message
  -v, --version		Show current script version
      --logging_test	Run script tests with logging.

HELP
exit 0
}

################################################################################
# Print version.
################################################################################
version() {
  echo -e "Author:\t\tanlil <anlil@timbel.net>"
  echo -e "Date:\t\t$(date -r "$0")"
  echo -e "Version:\t3.6.1"
  exit 0
}

################################################################################
# Print logging test.
################################################################################
logging_test() {
  echo ""
  logging_msg "INFO" "\033[32mStart ${0##*/} logging test."
  logging_msg "INFO" "You can control to save or not with using logging_start()."
  logging_msg "INFO" "logging_start ./logs/\033[39m"
  logging_start ./logs/
  echo ""
  logging_msg "INFO" "As it starts, be added the timestamp to logging message."
  logging_msg "INFO" "This message is saved in ${log_name}(==\${log_name})."
  logging_msg "INFO" "and logrotate config file is saved in ${logconf}(==\${logconf})"
  echo ""
  logging_msg "INFO" "If you wanna stop the logging, use logging_stop()."
  logging_msg "INFO" "logging_stop"
  logging_stop
  echo ""
  logging_msg "INFO" "\033[32mlogging stopped, and at the same time the timestamp also disappeared."
  logging_msg "INFO" "Now, This message isn't saved in ${log_name}(==\${log_name}), only displayed on the screen."
  logging_msg "INFO" "It's all.\033[39m"
  echo ""
  exit 0
}
