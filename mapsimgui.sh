#!/bin/bash

#Use this (and only this) to run the GUI program

cd ~/mapsimgui/


bash -c "echo $$ > hostProgramPID; lua hostProgram.lua"

singularity run mapsimgui.sif


