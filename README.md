# nginx-unit-aur-package

Configuration for creating a NGINX Unit package for Arch Linux

Based on [the aur nginx-unitd](https://aur.archlinux.org/packages/nginx-unitd) package; updated to build 1.29.0 instead of 1.27.0.


# Usage

## Building Locally

If you are running Manjaro / Arch and would like to build the packages locally follow this section.

### Requirements

If you are running this locally in Manjaro / Arch use the following to ensure all required libraries are installed:

```
pacman --noconfirm -Syu base-devel go ruby php-embed nodejs npm
```

### Running the build

PKGBUILD files are  provided for a few versions of Unit. 

Select which version to build by symlinking the desired PKGBUILD-&lt;version&gt; as PKGBUILD:

```
ln -snf PKGBUILD-1.29.0 PKGBUILD
```

The default is 1.29.0, the current release.

```
git clone git@github.com:ciroque/nginx-unit-aur-package.git
cd nginx-unit-aur-package
makepkg
```

## Building with Docker

If you are not running on Manjaro / Arch, or would like to not have to install all the depenencies, a Dockerfile is provided.

PKGBUILD files are  provided for a few versions of Unit. 

Select which version to build by overriding the VERSION argument with `--build-arg UNIT_VERSION=<n.nn.n>`:


```
git clone https://github.com/ciroque/nginx-unit-aur-package.git
cd nginx-unit-aur-package
docker build --build-arg UNIT_VERSION=1.29.0 --rm -t nginx-unit-builder .
CID=$(docker create nginx-unit-builder:latest)
docker cp "$CID":/home/appbuilder/nginx-unit-<VERSION>-arch-packages.tar.gz .
docker rm "$CID"
```
