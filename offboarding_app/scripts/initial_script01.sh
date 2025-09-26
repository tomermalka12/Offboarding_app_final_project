#!/bin/bash

###### Start Safe Header ######
#Developed by: Tomer Malka Pinto
#Purpose: Automate offboarding workflow - user directories deletion from multiple project paths
#date: 19/09/2025
#version: 0.1.1
set -o errexit
set -o pipefail
###### End Safe Header ########

read -r -p "Enter username:" USER

if [ -z "$USER" ]; then
    echo "No username entered. Exiting."
    exit 1
fi

deleted_count=0

# All base project paths
base_paths=(
    "/projects/architecture"
    "/projects/boxster"
    "/projects/chiron"
    "/projects/dolomites"
    "/projects/memories"
    "/projects/pliopsips"
    "/projects/roadster"
    "/projects/sandbox"
    "/projects/spider"
    "/projects/viper"
)

# Loop through each project path
for base in "${base_paths[@]}"; do
    if [ -d "$base" ]; then
        echo "Searching in $base ..."

        # Find all directories matching the username (recursive)
        function find_user_dirs {
            find "$1" -path '*/.*' -prune -o -type d -name "$USER" -print 2>/dev/null
        }
        function show_matches {
            if [ -n "$matches" ]; then
                echo "Matches found in $base:"
                echo "$matches"
            fi
        }
        matches=$(find_user_dirs "$base")
        show_matches

        function delete_dirs{
        if [ -n "$matches" ]; then
           while IFS= read -r dir; do
              if [ "$(basename "$dir")" = "$USER" ]; then
                read -r -p "Delete $dir ? [y/N]: " confirm
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    rm -rf "$dir"
                    echo "Deleted: $dir"
                    ((deleted_count++))
                else
                    echo "Skipped: $dir"
                fi
              fi
           done <<< "$matches"
        else
            echo "No matches found in $base"
        fi
    else
        echo "Path not found: $base"
    fi
    }
    delete_dirs
    echo "----------------------------------"
done
echo "=================================="
echo "Total deleted for user '$USER': $deleted_count"
echo "=================================="


