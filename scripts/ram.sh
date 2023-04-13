#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_ram_usage() {
  if is_linux; then
    function getRamUsage() {
        ramUsage=$(free -m | grep $memKeyword | awk '{printf "%.1f", $3/$2*100}' | tr ',' '.')
    }

    memKeyword="Mem"
    getRamUsage

    if [ -z "$ramUsage" ]; then
        memKeyword="Pam"
        getRamUsage
    fi
    echo "$ramUsage%"
  elif is_osx; then
    top -l 1 -s 0 | grep PhysMem | awk '{print $2}'
  fi
}

main() {
  print_ram_usage
}

main
