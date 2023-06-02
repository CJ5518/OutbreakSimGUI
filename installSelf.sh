#!/bin/bash

cd ~
mkdir Desktop
touch Desktop/mapsimgui.sh
echo "#!/bin/bash\n\ncd ~/mapsimgui/\nsingularity run mapsimgui.sif\n"

cd mapsimgui
mkdir output
mkdir mapsim
wget https://github.com/CJ5518/MapSimulation1/releases/download/Build-2023.6.2/LinuxHeadless-2023.6.2.tar
tar -xf LinuxHeadless-2023.6.2.tar -C mapsim
rm LinuxHeadless-2023.6.2.tar
wget https://github.com/CJ5518/MapSimulation1/releases/download/Build-2023.6.2/mapsimgui.sif