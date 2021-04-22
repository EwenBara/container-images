FROM archlinux-builder
USER root
LABEL mainainer="Ewen BARA"

RUN pacman -Sy --noconfirm npm firefox
RUN npm install -g @angular/cli

USER builder
