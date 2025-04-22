#!/bin/sh
set -e

# Copy and chown files to the root user's home directory
rsync -rlp /tmp/home/ /root/

exec "$@"

# vi: set ts=4 sw=4 et ft=sh:
