#!/bin/bash

# Check if the current directory is a Git repository
git rev-parse --is-inside-work-tree > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Error: This is not a Git repository."
  exit 1
fi

# Get a list of all local branches
branches=$(git branch --format='%(refname:short)')

# Loop through each branch and get the latest commit details
for branch in $branches; do
  git log -1 --format="$branch | %ci | %cn | %s" $branch
done
