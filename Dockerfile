# ------------------------------------------------------------------------------
# Pull base image
FROM linuxserver/code-server
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV QLIBCVERS "2.4.8"
ENV QLIBCURL "https://github.com/wolkykim/qlibc/archive/refs/tags/v${QLIBCVERS}.tar.gz"

# ------------------------------------------------------------------------------
# Create a docker image suitable for development
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      bash-completion \
      build-essential \
      ca-certificates \
      cgdb \
      cmake \
      curl \
      doxygen \
      file \
      git \
      less \
      libcurl4-openssl-dev \
      libevent-dev \
      libgcrypt-dev \
      libhiredis-dev \
      libmicrohttpd-dev \
      libnet1-dbg \
      libnet1-dev \
      libpcap-dev \
      libsqlite3-dev \
      libssl-dev \
      libwebsockets-dev \
      libxml2-dev \
      libzmq3-dev \
      lsof \
      meson \
      nano \
      openssh-client \
      sshfs \
      tcpdump \
      tree \
      unzip \
      vim-tiny \
      xxd \
      xxhash \
      zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install qlibc
RUN cd /tmp && \
    curl -L ${QLIBCURL} -o qlibc-${QLIBCVERS}.tar.gz && \
    tar xf qlibc-${QLIBCVERS}.tar.gz && cd qlibc-${QLIBCVERS} && \
    ./configure --prefix=/usr --libdir=/usr/lib64 && make && make install && \
    cd src && doxygen doxygen.conf && mkdir /usr/share/doc/qlibc-${QLIBCVERS} && \
    cd /tmp && cp -r qlibc-${QLIBCVERS}/doc/html /usr/share/doc/qlibc-${QLIBCVERS}/ && \
    rm -rf qlibc-${QLIBCVERS} qlibc-${QLIBCVERS}.tar.gz

