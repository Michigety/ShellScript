#!/bin/bash

OS_ID="$(. /etc/os-release; echo "${ID}")"
DOWNLOAD_DIRECTORY="./downloads"

download_dir_count=1

################################################################################
# Download & Save packages.
# Globals:
#   DOWNLOAD_DIRECTORY
#   OS_ID
#   download_dir_count
# Arguments:
#   $@
# Outputs:
#   Global Variables:
#     download_dir_count
#   Files:
#     ./${subdir_name}/*
################################################################################
get_pkgs() {
  local subdir_name
  local packages
  subdir_name="${DOWNLOAD_DIRECTORY}/$(printf "%.3d" "${download_dir_count}")_$1"
  packages="${*:2}"
  [[ ! -d "${subdir_name}" ]] && mkdir -p "${subdir_name}"

  if [[ ${OS_ID^^} == *"CENTOS"* || ${OS_ID^^} == *"RHEL"* || ${OS_ID^^} == *"ROCKY"* ]]; then
    echo "${sudoPW}" | sudo -S yum install -q -y --downloadonly --downloaddir="${subdir_name}" "${packages}"
    echo "${sudoPW}" | sudo -S yum install -y "${packages}"
    ((download_dir_count++))

  elif [[ ${OS_ID^^} == *"UBUNTU"* ]]; then
    echo "${sudoPW}" | sudo -S apt-get update -y
    echo "${sudoPW}" | sudo -S apt-get install -q -y --download-only "${packages}"
    echo "${sudoPW}" | sudo -S mv "${UBUNTU_CACHE_DIRECTORY}/*.deb" "${subdir_name}"
    echo "${sudoPW}" | sudo -S apt-get install -y "${packages}"
    echo "${sudoPW}" | sudo -S rm "${UBUNTU_CACHE_DIRECTORY}/*.deb"
    ((download_dir_count++))
  fi
}

################################################################################
# Download & Save python libraries.
# Refer to get_pkgs() comments.
################################################################################
get_pylibs() {
  local subdir_name
  local packages
  subdir_name="${DOWNLOAD_DIRECTORY}/$(printf "%.3d" "${download_dir_count}")_$1"
  packages="${*:2}"  
  [[ ! -d ${subdir_name} ]] && mkdir -p "${subdir_name}"

  python3 -m pip download -q -d "${subdir_name}" "${packages}"
  python3 -m pip install -q "${packages}" --user
}


