FROM fedora:latest

RUN dnf upgrade \
    --refresh \
    --best \
    --allowerasing \
    -y

RUN dnf install \
    util-linux-user \
    which \
    -y
