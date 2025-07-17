#!/bin/bash

set -x


# Copy build scripts

# mkdir -p ecapture/local
# cp Makefile ecapture/local
# cp -r scripts ecapture/local
# ls -R ecapture/local


## Configure git
git config --global user.name "obj-builder-ci"
git config --global user.email "obj-builder-ci@users.noreply.github.com"

# Configure origin
git remote -v
git remote set-url origin https://github.com/h0x0er/ecapture-objs.git
git remote -v

# Checkout to tag branch
git checkout -b "release/${{ inputs.release-tag }}"
git branch