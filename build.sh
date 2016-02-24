#!/bin/bash
set -e

apt-get install libtool libusb-1.0-0-dev autoconf pkg-config

mkdir -p output/opt/openrov/
mkdir -p output/usr/local/

OPENOCD_DIR=${PWD}/output/usr/local

cd output/opt/openrov

# Get the OpenROV Arduino core files
git clone https://github.com/OpenROV/OROV-ArduinoCores.git arduino
cd arduino

rm -rf .git*

# Setup arduino tools
cd hardware/tools

# Build CTAGS
git clone https://github.com/arduino/ctags.git
cd ctags
rm -rf .git*
./configure
make -j8
cp ctags ../ctags2
cd ..
rm -rf ctags/
mv ctags2 ctags

# Build bossac
git clone https://github.com/spiderkeys/BOSSA.git
cd BOSSA
git checkout arduino
rm -rf .git*
make bossac
cp bin/bossac ..
cd ..
rm -rf BOSSA

# Build openocd
git clone https://github.com/ntfreak/openocd.git
cd openocd
./bootstrap
./configure --prefix=${OPENOCD_DIR} --enable-sysfsgpio
make -j8
make install
cd ..
rm -rf openocd

# Download Atmel's CMSIS
wget http://downloads.arduino.cc/CMSIS-4.0.0.tar.bz2
tar xfj CMSIS-4.0.0.tar.bz2
rm CMSIS-4.0.0.tar.bz2



