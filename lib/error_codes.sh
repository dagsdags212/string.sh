#!/usr/bin/env bash

declare -A ERRORS

SUCCESS=0
ERRORS[IndexError]=10
ERRORS[ValueError]=11

display_error_codes() {
  for i in "${!ERRORS[@]}"; do
    printf "%s\t%s\n" "${i}" "${ERRORS[${i}]}"
  done
}

raise() {
  local err_type=$1
  local msg=$2
  printf "%s: %s\n" "${err_type}" "${msg}" 1>&2
  exit ${ERRORS[err_type]}
}
