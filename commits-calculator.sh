#!/bin/bash

print_usage() {
    echo "Usage: $0 <directory> [author1] [author2] ..."
    echo "Example: $0 ~/react-project \"Alex Max\" \"Mr. Bean\""
}

if [ $# -lt 1 ]; then
    echo "Error: Missing directory argument."
    print_usage
    exit 1
fi

directory="$1"
shift

if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

authors=("$@")

count_commits() {
    local author="$1"
    local commit_count=$(git -C "$directory" log --author="$author" --oneline 2>/dev/null | wc -l)
    echo "$author - $commit_count"
}

if [ ${#authors[@]} -gt 0 ]; then
    for author in "${authors[@]}"; do
        count_commits "$author"
    done
else

    all_authors=$(git -C "$directory" log --format="%aN" | sort -u)
    for author in $all_authors; do
        count_commits "$author"
    done
fi

exit 0
