#!/bin/bash
#
# Bootstraps the automation that handles the provisioning of the Debian desktop.
#
# author: Kyle Walters (kyle@jorkle.com)
# copyright: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode.txt)

# Constant
readonly JORK_WORKING_DIR=$(mktemp -d)
export JORK_WORKING_DIR

err() {
	echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

debug() {
	if [ "$DEBUG" == "TRUE" ]; then
		echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
	else
		return 0
	fi
}

run_checks () {
	debug "Running various checks to ensure a functional environment. (run_checks)"
	check_root
	check_connectivity
}

check_root () {
	if [ "$EUID" -eq 0 ]; then
		debug "We are running as root (check_root)"
	else
		err "This script must be executed as root."
		exit 1
	fi
}

check_connectivity () {
	wget -q --spider http://google.com

	if [ $? -eq 0 ]; then
		debug "The internet connection appears to be functional (check_connectivity)"
	else
    		err "Internet connectivity test has failed. This script requires an internet connection."
		exit 1
	fi
}


install_deps

main () {
	run_checks
}

main
