# Ansible Image

This repo builds a Docker image containing Ansible and common dependencies for use as an isolated execution environment.

## Tags

Images are tagged with the version of `ansible-core` included in the image. There are also `python<version>` tags if you need to support managed nodes running specific versions of Python.

- `2.20`, `python3.9`, `latest`
- `2.18`, `python3.8`
- `2.16`, `python2.7`, `python3.6` EOL, but kept around for use with managed nodes that only support Python 2.7 or Python 3.6
- `2.10` EOL, but kept around for playbooks that only work with classic Ansible
- `2.9` EOL, but kept around for playbooks that only work with classic Ansible

## Usage

The working directory is `/ansible`, so mount your ansible playbooks and inventory files into that directory.

```bash
docker run --rm -it -v $(pwd):/ansible ccoley/ansible:latest ansible -m ping all
```

If you want to use any files/directories in your home directory from within the container, then you can mount them to `/tmp/home` in the container and they'll be copied to the container user's home directory. This is useful for SSH keys and known_hosts, auth configurations, etc.

```bash
docker run --rm -it -v $(pwd):/ansible -v ~/.ssh:/tmp/home/.ssh:ro ccoley/ansible:latest ansible -m ping all
```

## Building Images Locally

Build the standard image:

```bash
docker build .
```

Build an image that supports Python 3.8 on the managed node, which is the version of Python shipped with Ubuntu 20.04:

```bash
docker build --build-arg ALPINE_VERSION=3.22 --build-arg ANSIBLE_VERSION=2.18 .
```

Build an image that supports Python 2.7/3.6 on the managed node:

```bash
docker build --build-arg ALPINE_VERSION=3.19 --build-arg ANSIBLE_VERSION=2.16 .
```



[_modeline]: # ( vi: set ts=4 sw=4 et wrap ft=markdown: )
