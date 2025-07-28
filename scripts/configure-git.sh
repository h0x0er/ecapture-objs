#!/bin/bash

set -x

repo="$GITHUB_REPOSITORY"

## Configure git
git config --global user.name "obj-builder-ci"
git config --global user.email "obj-builder-ci@users.noreply.github.com"

# Configure origin
git remote -v
git remote set-url origin "https://github.com/$repo.git"
git remote -v
