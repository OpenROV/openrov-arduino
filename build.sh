#!/bin/bash
set -e

apt-get install libtool libusb-1.0-0-dev autoconf pkg-config

mkdir -p output/opt/openrov/
mkdir -p output/usr/local/

OPENOCD_DIR=${PWD}/output/usr/local

cd output/opt/openrov

# Get the OpenROV Arduino core files
git clone https://github.com/OpenROV/openrov-arduino-cores.git arduino --depth=1
cd arduino

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

# Download Atmel's CMSIS
wget http://downloads.arduino.cc/CMSIS-4.0.0.tar.bz2
tar xfj CMSIS-4.0.0.tar.bz2
rm CMSIS-4.0.0.tar.bz2



