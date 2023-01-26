FROM localhost/archlinux-builder
USER root
LABEL maintainer="Ewen BARA"

RUN pacman -Sy --noconfirm git nodejs-lts-hydrogen npm firefox; \
    npm install -g @angular/cli

USER builder
