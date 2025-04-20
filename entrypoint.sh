#!/bin/sh
set -e

cp -R /tmp/.ssh /root/.ssh
chown -R root:root /root/.ssh

exec "$@"

# vi: set ts=4 sw=4 et ft=sh:
