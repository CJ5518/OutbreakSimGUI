#!/bin/bash

cd ~
mkdir Desktop
cd Desktop
cp ~/mapsimgui/mapsimgui.sh ./mapsimgui.sh
chmod +x mapsimgui.sh
cd ~
cd mapsimgui
mkdir output
mkdir .slurmfiles
mkdir mapsim
wget https://github.com/CJ5518/MapSimulation1/releases/download/Linux-2023.6.28/LinuxHeadless-6.28.2023.tar
tar -xf LinuxHeadless-6.28.2023.tar -C mapsim
rm LinuxHeadless-6.28.2023.tar
# The sif file hasn't changed since this
wget https://github.com/CJ5518/MapSimulation1/releases/download/Build-2023.6.2/mapsimgui.sif
