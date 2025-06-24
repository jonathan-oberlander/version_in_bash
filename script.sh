#!/bin/bash

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git repository."
  exit 1
fi

commit_hash=$(git rev-parse --short HEAD)
commit_tag=$(git tag --points-at HEAD --list | head -n 1)
latest_tag=$(git tag --merged HEAD --sort=-creatordate | head -n 1)

if [ -n "$commit_tag" ]; then
  tag="$commit_tag"
else
  tag="$latest_tag"
fi

if [ -z "$tag" ]; then
  echo "No tags found in repository."
  exit 1
fi

tag_version=$(echo "$tag" | sed -E 's/^[^0-9]+//')
version="${tag_version}-${commit_hash}"

mkdir -p dist

echo $version > dist/version.txt
echo "[ version ] success dist/verison.txt" $(cat dist/version.txt)
