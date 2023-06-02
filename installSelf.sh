#!/bin/bash

cd ~
mkdir Desktop
cd Desktop
touch mapsimgui.sh
chmod +x mapsimgui.sh
printf "#!/bin/bash\n\ncd ~/mapsimgui/\nsingularity run mapsimgui.sif\n" > mapsimgui.sh
cd ~
cd mapsimgui
mkdir output
mkdir .slurmfiles
mkdir mapsim
wget https://github.com/CJ5518/MapSimulation1/releases/download/Build-2023.6.2/LinuxHeadless-2023.6.2.tar
tar -xf LinuxHeadless-2023.6.2.tar -C mapsim
rm LinuxHeadless-2023.6.2.tar
wget https://github.com/CJ5518/MapSimulation1/releases/download/Build-2023.6.2/mapsimgui.sif
