#!/bin/sh

set -e

# Install all brew packages
brew bundle --global --file=~/.config/git/brewfile/Brewfile
