ARG ALPINE_VERSION=3
FROM alpine:${ALPINE_VERSION}

ARG ANSIBLE_VERSION=2
RUN apk add --update --no-cache \
    # Install latest version of these dependencies \
    bash openssh python3 rsync sshpass vim \
    # Install specific version of ansible-core and latest compatible ansible \
    ansible ansible-core~=${ANSIBLE_VERSION}

# Add an entrypoint script that copies files from the /tmp/home directory into
# the actual home directory
RUN mkdir -p /tmp/home
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Set VIM as the default editor. Used by 'ansible-vault edit'
ENV EDITOR=/usr/bin/vim

# Add some useful aliases for instances where we want to log into the container
# and debug stuff
ENV ENV=/etc/profile
RUN echo "alias ll='ls -alFh'" >> /etc/profile.d/aliases.sh

WORKDIR /ansible

CMD ["ansible", "--help"]

# vi: set ts=4 sw=4 et ft=dockerfile:
