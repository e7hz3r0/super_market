#!/usr/bin/env sh

# Exit if any subcommand fails
set -e

# Set up Ruby dependencies via Bundler
bundle install

# Print instructions
echo
echo
cat README.md
