FROM debian:jessie

RUN apt-get update && apt-get install -y \
    # Server
    autoconf\
    automake\
    bison\
    flex\
    g++\
    git\
    libboost-all-dev\
    libtool\
    make\
    pkg-config\
    ragel\
    libssl-dev\
    build-essential\
    # Tests
    bc\
    dnsutils\
    ldnsutils\
    bind9utils\
    validns\
    libnet-dns-perl\
    unbound-host\
    wget\
    libgcc-4.8-dev\
    mysql-client-5.5\
    default-jre\
    # API tests
    libsqlite3-dev\
    virtualenv\
    sqlite3\
  && apt-get clean

RUN mkdir -p /usr/local/jdnssec-tools\
    && cd /usr/local/jdnssec-tools\
    && wget -O jdnssec-tools-0.12.tar.gz 'https://www.verisignlabs.com/dnssec-tools/packages/jdnssec-tools-0.12.tar.gz'\
    && tar xf jdnssec-tools-0.12.tar.gz
 
RUN useradd pdns

RUN mkdir -p /usr/src/pdns
WORKDIR /usr/src/pdns