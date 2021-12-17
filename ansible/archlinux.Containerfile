FROM docker.io/archlinux:latest
LABEL maintainer="Ewen BARA"

RUN pacman -Sy --noconfirm openssh python

RUN systemctl set-default multi-user.target; \
    systemctl enable sshd

ENV container=docker
CMD ["/sbin/init"]
