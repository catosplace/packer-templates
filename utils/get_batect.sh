#!/usr/bin/env bash
#
# Author: Catosplace Engineering <engineering@catosplace.co.nz>
#
#/ Usage: SCRIPTNAME [OPTIONS]... [ARGUEMENTS]...
#/
#/
#/ OPTIONS
#/  -h, --help
#/              Print this help message
#/
#/ EXAMPLES
#/

#{{{ Bash settings
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# abort on errors within pipes
set -o pipefail
# set -o xtrace
#}}}

#{{{ Variables
# declare script_name
declare script_dir
# script_name=$(basename "${0}")
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
IFS=$'\t\n' # Split on newlines and tabs (but not on spaces)
BATECT_VERSION=0.79.1
#}}}

main() {
  # check_args "${@}"
  get_bactect
}

#{{{ Helper functions

get_bactect() {
  wget -O "${script_dir}"/../batect https://github.com/batect/batect/releases/download/$BATECT_VERSION/batect
  wget -O "${script_dir}"/../batect.cmd https://github.com/batect/batect/releases/download/$BATECT_VERSION/batect.cmd
}

#}}}

main "${@}"