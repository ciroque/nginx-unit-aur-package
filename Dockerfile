FROM manjarolinux/base:latest

ARG UNIT_VERSION=1.29.0

# By default commands run in Docker are executed as root.
# This is fine for the package installation...

RUN pacman --noconfirm -Syu base-devel go ruby php-embed nodejs npm


# But not for building pacakges; the following should run as a standard user...

RUN groupadd -g 393 appbuilder && \
    useradd -m -u 2112 -g appbuilder appbuilder

USER appbuilder

WORKDIR /home/appbuilder/

COPY PKGBUILD-$UNIT_VERSION PKGBUILD
COPY unit.service .

RUN makepkg

RUN ls -la

RUN tar -cvzf nginx-unit-$UNIT_VERSION-arch-packages.tar.gz *.zst
