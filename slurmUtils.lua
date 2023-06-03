--Runs a job for the gui program

local module = {};

local homeDirProgram = io.popen("echo $HOME", "r");
local homeDir = homeDirProgram:read("*a");
homeDirProgram:close();
homeDir = homeDir:gsub("\n","");
module.homeDir = homeDir;

--Run command n times
function module.runJob(command, n)
	local filename = homeDir .. "/mapsimgui/.slurmfiles/OutbreakSim-" .. os.time() .. ".slurm";
	local fileText = string.format(
[[#!/bin/bash

#SBATCH -p tiny

cd $SLURM_SUBMIT_DIR

%s
]], command);
	local file = io.open(filename, "w");
	file:write(fileText);
	file:close();
	os.execute(string.format("sbatch -a 1-%d %s", n, filename));
end

function module.printRunningJobs()
	os.execute("squeue --me > delet.txt");
	local file = io.open("delet.txt", "r");
	for line in file:lines() do
		print(line);
	end
	file:close();
	os.execute("rm delet.txt");
end


return module;
