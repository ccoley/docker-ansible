ARG ALPINE_VERSION=3
FROM alpine:${ALPINE_VERSION}

ARG ANSIBLE_VERSION=2
RUN apk add --update --no-cache \
    # Install latest version of these dependencies \
    bash openssh sshpass rsync \
    # Install a specific version of ansible-core with the latest compatible ansible \
    ansible ansible-core~=${ANSIBLE_VERSION}

WORKDIR /ansible

ENTRYPOINT []
CMD ["ansible", "--help"]

# vi: set ts=4 sw=4 et ft=dockerfile:
