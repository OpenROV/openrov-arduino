#!/bin/bash
set -e

mkdir -p output/opt/openrov/

cd output/opt/openrov

# Get the Arduino IDE
git clone https://github.com/arduino/Arduino.git arduino
cd arduino
git checkout 36c94191183600440676967d996abff8dbcd149d

# Remove IDE files, we just want the core files and libraries
rm -rf app/ arduino-core/ build/ .classpath .project README.md examples_formatter.conf format.every.sketch.sh lib_sync

# Remove the sam core files. We don't need these.
cd hardware/arduino
rm -rf sam
cd ..

# Get the OpenROV cores
git clone https://github.com/OpenROV/OROV-ArduinoCores.git openrov

# Setup arduino tools
cd tools

# Build CTAGS
git clone https://github.com/arduino/ctags.git
cd ctags
./configure
make -j8
cp ctags ../ctags2
cd ..
rm -rf ctags/
mv ctags2 ctags

# Build bossac
git clone https://github.com/spiderkeys/BOSSA.git
cd BOSSA
make
cp bin/bossac ..
cd ..
rm -rf BOSSA

# Build openocd
# TODO
  
# Download Atmel's CMSIS
wget http://downloads.arduino.cc/CMSIS-4.0.0.tar.bz2
tar xfj CMSIS-4.0.0.tar.bz2
rm CMSIS-4.0.0.tar.bz2



