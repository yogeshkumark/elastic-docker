#!/usr/bin/env bash
#
# set -x
#

function check_containers() {
    # Show all containers with status = Exited
    echo "Exited Containers:"
    docker ps -a --format '{{ .Names }} {{ .Status }}' | sort -k4 -r | column -t | grep "Exited"
    RC=$?
    if [[ "${RC}" != 0 ]]; then
        echo "NONE"
    fi

    # Show all containers with strange names
    echo -e "\nSuspicious Container names:"
    docker ps -a --format '{{ .Names }}' | grep -v -E "(ls|esdb|hlog|sshd|rsyslog)"
    RC=$?
    if [[ "${RC}" != 0 ]]; then
        echo "NONE"
    fi
}

if [[ $1 == "batch" ]]; then
    check_containers
else
    for host in $(cat ~/scripts/hosts); do
    echo -e "\n##### ${host} #####\n"
    ssh -o "BatchMode yes" -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i ~/keys/docker_key docker@${host} '~/scripts/check_containers.sh batch || true' 2>/dev/null
    done
fi
 
