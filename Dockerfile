ARG ALPINE_VERSION=3
FROM alpine:${ALPINE_VERSION} AS base

# Define ANSIBLE_VERSION in this stage so it is inherited by later stages
ARG ANSIBLE_VERSION=2

# Add an entrypoint script that copies files from the /tmp/home directory into
# the actual home directory
RUN mkdir -p /tmp/home
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Add some useful aliases for instances where we want to log into the container
# and debug stuff
ENV ENV=/etc/profile
RUN echo "alias ll='ls -alFh'" >> /etc/profile.d/aliases.sh

# Set VIM as the default editor. Used by 'ansible-vault edit'
ENV EDITOR=/usr/bin/vim

WORKDIR /ansible
CMD ["ansible", "--help"]



# This stage is the base for only the legacy ansible-classic target, which
# This target is meant for building images containing "classic" Ansible versions
# such as 2.9 or 2.10, before ansible-core was split out as a separate package
FROM base AS ansible-classic
RUN apk add --update --no-cache \
    # Install latest version of these dependencies \
    bash openssh python3 rsync sshpass vim \
    # Install specific version of ansible-core and latest compatible ansible \
    ansible~=${ANSIBLE_VERSION}

# Symlink python to python3
RUN ln -s /usr/bin/python3 /usr/bin/python



# The default target that should be used for all modern versions of Ansible
FROM base AS default
RUN apk add --update --no-cache \
    # Install latest version of these dependencies \
    bash openssh python3 rsync sshpass vim \
    # Install specific version of ansible-core and latest compatible ansible \
    ansible ansible-core~=${ANSIBLE_VERSION}

# vi: set ts=4 sw=4 et ft=dockerfile:
