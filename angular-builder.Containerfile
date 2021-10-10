FROM localhost/archlinux-builder
USER root
LABEL mainainer="Ewen BARA"

RUN pacman -Sy --noconfirm git nodejs-lts-fermium npm6 firefox; \
    npm install -g @angular/cli

USER builder
