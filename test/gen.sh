#!/bin/bash
# File to create 10 Dirs and 10 files in each Dirs
# Create directories
for i in {1..10}; do
    mkdir -p "directory$i"
done

# Generate random text files
for dir in directory*; do
    for i in {1..10}; do
        # Generate random data for text file
        random_data=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 100 | head -n 1)

        # Create text file with random data
        echo "$random_data" > "$dir/file$i.txt"
    done
done

echo "Directories and files created successfully."
