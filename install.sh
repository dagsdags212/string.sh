#!/usr/bin/env bash

TARGETDIR=~/.local/lib/bash
STRINGSH_PREFIX=${TARGETDIR}/string.sh
CONFIG_FILE=~/.zshrc

copy_project_dir() {
  mkdir -p ${STRINGSH_PREFIX}
  cp -r ./lib/ ${STRINGSH_PREFIX}
  cp ./string.sh ${STRINGSH_PREFIX}
}

append_to_config() {
  local export_line="export STRINGSH_PREFIX=${STRINGSH_PREFIX}"
  local source_line="source \${STRINGSH_PREFIX}/string.sh"
  grep -qxF "${export_line}" ${CONFIG_FILE} || echo ${export_line} >>${CONFIG_FILE}
  grep -qxF "${source_line}" ${CONFIG_FILE} || echo ${source_line} >>${CONFIG_FILE}
}

install() {
  # Assumes that script is executed within the project root
  copy_project_dir
  append_to_config
}

install
