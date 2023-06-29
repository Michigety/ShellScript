#!/bin/bash

logging_status=1
logconf="src/logrotate.d/my.conf"
log_name="${0##*/}"
log_name="${log_name%.*}.log"

################################################################################
# Configure the logrotate file at ${logconf}
# Globals:
#   logconf
#   log_name
# Arguments:
#   $1 : Path to save the logrotate file
# Outputs:
#   Files:
#     ${logconf} = src/logrotate.d/my.conf
#     ${logconf%.*}.status = src/logrotate.d/my.status
################################################################################
logrotate_config() {
  [[ ! -d ${logconf%/*} ]] && mkdir -p "${logconf%/*}"
  [[ ! -e ${logconf%.*}.status ]] && touch "${logconf%.*}.status"
  local log_name_dir
  cd $1 && log_name_dir="$(pwd)/*.log" && cd -
  cat << EOF > ${logconf}
${log_name_dir//\/\//\/} {
    rotate 365
    daily
    create
    missingok
    dateext
    dateformat _%Y%m%d
    maxage 365
    maxsize 10M
}
EOF
}

logrotate_start() {
  case $1 in
    -v|--verbose)
      logging_msg "INFO" "logrotate Start."
      /sbin/logrotate -v -s "${logconf%.*}.status" "${logconf}"
      ;;
    *)
      /sbin/logrotate -s "${logconf%.*}.status" "${logconf}"
      ;;
  esac
}

################################################################################
# Save a log named ${log_name} with logging_start().
# After that, you wanna cancel the saving it, use logging_stop().
# Globals:
#   logging_status
#   log_name
# Arguments:
#   $1 : Path to save the log file
# Outputs:
#   Global Variables:
#     logging_status
#     log_name
#   Files:
#     $1/${log_name}
################################################################################
logging_start() {
  logging_status=0
  [[ ! -d $1 ]] && mkdir -p "$1"
  log_name="$1/${log_name}"
  log_name="${log_name//\/\//\/}"
  logrotate_config "$1"
  logging_msg "INFO" "Saving the log file to ${log_name}"
  exec 3>&1 4>&2 1> >(tee -a "${log_name}") 2>&1
  logrotate_start
}

logging_stop() {
  if (( logging_status == 1 )); then
    logging_msg "WARN" "Logging is not enabled. YOU MUST RUN logging_start() BEFORE logging_stop()."
  else
    logging_status=1
    exec 1>&3 2>&4
  fi
}

################################################################################
# Print log message using logging_msg().
# Globals:
#   None
# Arguments:
#   $1 : Log Level
#   $2 : Log Message
# Outputs:
#   stdout
################################################################################
logging_msg() {
  local log_level
  local log_msg
  log_level="$1"
  log_msg="$2"
  if (( logging_status == 0 )); then
    echo "$(date -Is) [${log_level}] $0: ${log_msg}"
  else
    echo "${log_msg}"
  fi
}

