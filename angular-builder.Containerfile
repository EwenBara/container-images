FROM localhost/archlinux-builder
USER root
LABEL mainainer="Ewen BARA"

RUN pacman -Sy --noconfirm nodejs-lts-fermium npm6 firefox; \
    npm install -g @angular/cli

USER builder
