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


