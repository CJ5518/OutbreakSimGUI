#!/bin/bash

#Use this (and only this) to run the GUI program

cd ~/mapsimgui/

lua hostProgram.lua &
LUAS_PID=$!

singularity run mapsimgui.sif

kill $LUAS_PID
