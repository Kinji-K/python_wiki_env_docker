#!/bin/sh

USER_ID=${UID:-9001}
GROUP_ID=${GID:-9001}

useradd -u $USER_ID -o -m user
groupmod -g $GROUP_ID user
export HOME=/home/user
chown -R user /opt/working
busybox crond -f -L /dev/stderr

exec gosu user:user bash
