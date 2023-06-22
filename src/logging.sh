#!/bin/bash

logging_status=1

################################################################################
# Print log message using logging_msg().
# and also save it when using logging_start().
# Globals:
#   None
# Arguments:
#   $0 $1 $2
# Outputs:
#   Global Variables:
#     logging_status
#     log_name
#   Files:
#     ./${log_name}
################################################################################
logging_start() {
  logging_status=0
  local tmp
  tmp="${0##*/}"
  log_name="$(date "+%Y%m%d%a")_${tmp%.*}.log"
  exec 1> >(tee -a "./${log_name}") 2>&1
}

logging_msg() {
  local log_level
  local log_msg
  log_level=$1
  log_msg=$2
  if (( logging_status == 0 )); then
    echo "$(date -Is) [${log_level}] $0: ${log_msg}"
  else
    echo "${log_msg}"
  fi
}

