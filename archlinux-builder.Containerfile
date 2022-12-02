FROM docker.io/archlinux:latest
USER root
LABEL maintainer="Ewen BARA"

RUN echo $'\n\
    [aur]\n\
    SigLevel = Optional\n\
    Server = https://mirrors.ewen-bara.com/archlinux/$repo/os/$arch\n\
    \n\
    [personal]\n\
    SigLevel = Optional\n\
    Server = https://mirrors.ewen-bara.com/archlinux/$repo/os/$arch\n'\
    >> /etc/pacman.conf; \
    pacman --noconfirm --sync --refresh --upgrades --needed base base-devel; \
    pacman --noconfirm --sync --clean--clean; \
    useradd -m builder; \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/builder

USER builder
WORKDIR /home/builder
