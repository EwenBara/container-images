FROM docker.io/archlinux:latest
USER root
LABEL maintainer="Ewen BARA"

RUN echo $'\n\
    [personal]\n\
    SigLevel = Optional\n\
    Server = https://mirrors.ewen-bara.com/archlinux/$repo/os/$arch\n'\
    >> /etc/pacman.conf; \
    pacman --noconfirm -Syu base base-devel; \
    pacman --noconfirm -Scc; \
    useradd -m builder; \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/builder

USER builder
WORKDIR /home/builder
