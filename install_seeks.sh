#!/bin/sh

mkdir dl
cd dl
wget http://curl.haxx.se/download/curl-7.20.1.tar.bz2
wget ftp://xmlsoft.org/libxml2/libxml2-2.7.7.tar.gz
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.20.tar.bz2
wget http://monkey.org/~provos/libevent-2.0.12-stable.tar.gz
wget http://protobuf.googlecode.com/files/protobuf-2.4.0a.tar.bz2
wget http://fallabs.com/tokyocabinet/tokyocabinet-1.4.47.tar.gz

cd ../
mkdir apps
cd apps
tar xvjf ../dl/curl-7.20.1.tar.bz2
tar xvzf ../dl/libxml2-2.7.7.tar.gz
tar xvjf ../dl/pcre-8.20.tar.bz2
tar xvzf ../dl/libevent-2.0.12-stable.tar.gz
tar xvjf ../dl/protobuf-2.4.0a.tar.bz2
tar xvzf ../dl/tokyocabinet-1.4.47.tar.gz
rm ../dl/curl-7.20.1.tar.bz2 ../dl/libxml2-2.7.7.tar.gz ../dl/pcre-8.20.tar.bz2 ../dl/libevent-2.0.12-stable.tar.gz ../dl/protobuf-2.4.0a.tar.bz2 ../dl/tokyocabinet-1.4.47.tar.gz

cd pcre-8.20
./configure --prefix=$HOME --enable-utf8
make && make install

cd ../curl-7.20.1
./configure --prefix=$HOME
make && make install

cd ../libxml2-2.7.7
./configure --prefix=$HOME
make && make install

cd ../libevent-2.0.12-stable
./configure --prefix=$HOME
make && make install

cd ../protobuf-2.4.0a
./configure --prefix=$HOME
make &&make install

cd ../tokyocabinet-1.4.47
./configure --prefix=$HOME
make && make install

cd ~/
mkdir seeks_project
cd seeks_project
git clone git://seeks.git.sourceforge.net/gitroot/seeks/seeks
cd seeks
git checkout --track -b experimental origin/experimental

./autogen.sh
source ~/.bash_profile
./configure --enable-httpserv-plugin --disable-opencv --with-libevent=$HOME CXXFLAGS="-O4 -I$HOME/include" LDFLAGS=-L$HOME/lib
make
