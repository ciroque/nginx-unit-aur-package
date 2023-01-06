FROM manjarolinux/base:latest

ARG VERSION=1.29.0

# This will run as root
RUN pacman --noconfirm -Syu base-devel go ruby php-embed nodejs npm


# The following should not run as root

RUN groupadd -g 393 appbuilder && \
    useradd -m -u 2112 -g appbuilder appbuilder

USER appbuilder

WORKDIR /home/appbuilder/

COPY PKGBUILD-$VERSION PKGBUILD
COPY unit.service .

RUN makepkg

RUN ls -la

RUN tar -cvzf nginx-unit-$VERSION-arch-packages.tar.gz *.zst
