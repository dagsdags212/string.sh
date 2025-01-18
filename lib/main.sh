#!/usr/bin/env bash

#
# This script provides a set of convenience functions for doing string manipulation in bash.
#
# Note that bash does not officially support the use of named parameters within functions, and assigning
# local variables was done for the sake of documentation. As seen in the docstring, each function has
# a list of parameters that can be treated as positional. The ordered position in the list corresponds to
# the postional index of the paramter. Parameters are passed subsequently after calling the function, with
# a set of parametrs being separated by whitespaces.
#
# For example, the `prefix` function takes in two parameters ('str' and 'n'). The function can be invoked
# as follows:
#
#   prefix "the cat in the hat" 7
#
# Running the above function would generate the following result:
#
#   the cat
#
#
# Written and maintained by Jan Emmanuel Samson
#

# import error codes
source ./error_codes.sh

strlen() {
  # Computes the length of a string.
  #
  # Patameters:
  #   str - an input string

  local str=$1

  echo ${#str} && return ${SUCCESS} || raise GenericError
}

toupper() {
  # Convert a string to uppercase.
  #
  # Parameters:
  #   str - an input string

  local str=$1

  echo ${str} | tr '[:lower:]' '[:upper:]' && return ${SUCCESS} || raise GenericError
}

tolower() {
  # Convert a string to lowercase.
  #
  # Parameters:
  #   str - an input string

  local str=$1

  echo ${str} | tr '[:upper:]' '[:lower:]' && return ${SUCCESS} || raise GenericError
}

capitalize() {
  # Converts the first character of an input string into uppercase while retaining
  # all other characters in lowercase.
  # NOTE: only current supports passing in a single word.
  #
  # Parameters:
  #   str - an input string

  local str=$1

  local firstChar=$(echo ${str:0:1} | tr '[:lower:]' '[:upper:]')
  local remainingChars=$(echo ${str:1:${#str}} | tr '[:upper:]' '[:lower:]')
  echo "${firstChar}${remainingChars}" && return ${SUCCESS} || raise GenericError
}

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

fuzzymatch() {
  # Pattern-matches a regex to a given string.
  # If a match is found, the provided string is returned, otherwise
  # an emptry string is returned.
  #
  # Parameters:
  #   pattern  - a regular expression
  #   query    - the query string

  local query=$1
  local pattern=$2

  [[ "${query}" =~ ${pattern} ]] && echo ${query} || raise NoMatchError "pattern not found"
}

exactmatch() {
  # Checks if two given string are exact matches.
  #
  # Parameters:
  #   str    - the reference string
  #   query  - the query string

  [[ "${str}" == "${query}" ]] && echo ${str} || raise NoMatchError "provided string does not match query string"
}
