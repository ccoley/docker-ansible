ARG ALPINE_VERSION=3
FROM alpine:${ALPINE_VERSION}

ARG ANSIBLE_VERSION=2
RUN apk add --update --no-cache \
    # Install latest version of these dependencies \
    bash openssh python3 rsync sshpass vim \
    # Install specific version of ansible-core and latest compatible ansible \
    ansible ansible-core~=${ANSIBLE_VERSION}

# Add entrypoint script
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Make sure the temporary SSH directory exists since we reference it in the
# entrypoint script
RUN mkdir /tmp/.ssh

WORKDIR /ansible

CMD ["ansible", "--help"]

# vi: set ts=4 sw=4 et ft=dockerfile:
