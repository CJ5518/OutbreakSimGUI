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
wget https://github.com/CJ5518/MapSimulation1/releases/download/Build-2023.6.2/LinuxHeadless-2023.6.2.tar
tar -xf LinuxHeadless-2023.6.2.tar -C mapsim
rm LinuxHeadless-2023.6.2.tar
wget https://github.com/CJ5518/MapSimulation1/releases/download/Build-2023.6.2/mapsimgui.sif
