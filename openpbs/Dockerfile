FROM ubuntu:20.04


# Install system packages
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get -y install tzdata
RUN \
    apt-get update --quiet -y \
    && apt-get upgrade --quiet -y \
    && apt-get install --quiet -y \
    vim \
    wget \
    fish \
    unzip \
    gcc make libtool libhwloc-dev libx11-dev \
          libxt-dev libedit-dev libical-dev ncurses-dev perl \
          postgresql-server-dev-all postgresql-contrib python3-dev tcl-dev tk-dev swig \
          libexpat-dev libssl-dev libxext-dev libxft-dev autoconf \
          automake g++ \
    expat libedit2 postgresql python3 postgresql-contrib sendmail-bin \
          sudo tcl tk libical3 postgresql-server-dev-all \
    && apt-get clean


# OpenPBS
COPY ./install_openpbs.sh /home/developer/Downloads/install_openpbs.sh
RUN chmod +x /home/developer/Downloads/install_openpbs.sh \
    && /home/developer/Downloads/install_openpbs.sh

# User
WORKDIR /home/developer
USER root
RUN echo 'root:root' | chpasswd

# Shell
SHELL ["fish", "--command"]
RUN chsh -s /usr/bin/fish
ENV SHELL /usr/bin/fish
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

WORKDIR /home/developer
COPY ./entrypoint.sh /home/developer/entrypoint.sh
RUN chmod +x /home/developer/entrypoint.sh
ENTRYPOINT [ "/home/developer/entrypoint.sh" ]