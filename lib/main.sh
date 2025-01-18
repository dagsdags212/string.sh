#!/usr/bin/env bash

# import error codes
source ./error_codes.sh

prefix() {
  # Get the first n characters of a string.
  #
  # Parameters:
  #   str - a string to subset
  #   n   - number of characters to extract from the start of the string

  local str=$1
  local n=$2

  if [[ "${n}" -gt "${#str}" ]]; then
    raise "IndexError" "string index out of range"
  fi
  echo ${str:0:${n}}
  return ${SUCCESS}
}

suffix() {
  # Get the last n characters of a string.
  #
  # Parameters:
  #   str - a string to subset
  #   n   - number of characters to extract from the end of the string

  local str=$1
  local n=$2

  if [[ "${n}" -gt "${#str}" ]]; then
    raise "IndexError" "string index out of range"
  fi
  echo ${str:(-${n})}
  return ${SUCCESS}
}

substr() {
  # Subset a given string from index a to index b, inclusive.
  # The first character of the given string corresponds to index 1.
  #
  # Parameters:
  #   str    - a string to subset
  #   start  - start index
  #   length - number of characters to extract

  local str=$1
  local start=$2
  local length=$3

  if [[ "${start}" -gt ${#str} ]]; then
    raise "IndexError" "starting index should be less than ${#str}"
  elif [[ "${length}" -gt "${#str}" ]]; then
    raise "ValueError" "substring length exceeds string length"
  elif [[ "${length}" -le 0 ]]; then
    raise "ValueError" "string length cannot be zero"
  fi
  echo ${str:start:length}
  return ${SUCCESS}
}
