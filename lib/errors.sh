echo "imported errors.sh submodule"

declare -A ERRORS

SUCCESS=0
ERRORS[GenericError]=1
ERRORS[IndexError]=10
ERRORS[ValueError]=11
ERRORS[NoMatchError]=12

display_error_codes() {
  for i in "${!ERRORS[@]}"; do
    printf "%s\t%s\n" "${i}" "${ERRORS[${i}]}"
  done
}

raise() {
  local err_type=$1
  local msg=$2
  if [[ "${err_type}" == GenericError ]]; then
    printf "%s: %s\n" "${err_type}" "an exception was raised" 1>&2
    exit ${ERRORS[err_type]}
  fi
  printf "%s: %s\n" "${err_type}" "${msg}" 1>&2
  exit ${ERRORS[err_type]}
}
