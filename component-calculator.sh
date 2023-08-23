#!/bin/bash

print_usage() {
    echo "Usage: $0 <directory> [component1] [component2] [component3] ..."
    echo "Example: $0 ~/react-project Button Header Footer"
}

if [ $# -lt 2 ]; then
    echo "Error: Missing arguments."
    print_usage
    exit 1
fi

directory="$1"
shift 

if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

for component in "$@"; do
    count=$(grep -r -o -w -E "\<$component\>" "$directory" | wc -l)
    echo "$component - $count"
done

exit 0
