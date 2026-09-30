#!/bin/bash

show_help() {
    echo "Usage: $0 {system-info|check-host|check-port|help}"
}

case "$1" in
    system-info)
        echo "System Information"
        echo "Hostname: $(hostname)"
        echo "User: $(whoami)"
        echo "Kernel: $(uname -r)"
        ;;

    check-host)
        if [ -z "$2" ]; then
            echo "Error: host is required"
            exit 2
        fi

        if getent hosts "$2" >/dev/null 2>&1; then
            echo "Host $2 is reachable/resolvable"
            getent hosts "$2"
        else
            echo "Host $2 could not be resolved"
            exit 1
        fi
        ;;

    check-port)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Error: host and port are required"
            exit 2
        fi

        if ! [[ "$3" =~ ^[0-9]+$ ]]; then
            echo "Error: port must be numeric"
            exit 2
        fi

        if [ "$3" -lt 1 ] || [ "$3" -gt 65535 ]; then
            echo "Error: port must be between 1 and 65535"
            exit 2
        fi

        if timeout 5 bash -c "</dev/tcp/$2/$3" 2>/dev/null; then
            echo "Port $3 on $2 is open"
        else
            echo "Port $3 on $2 is closed or unreachable"
            exit 1
        fi
        ;;

    help)
        show_help
        ;;

    *)
        echo "Error: invalid command"
        show_help
        exit 2
        ;;
esac
