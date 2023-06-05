--Runs a job for the gui program

local walkieTalkie = require("walkieTalkie");

local module = {};



--Run command n times
function module.runJob(command, n)
	local filename = walkieTalkie.homeDir .. "/mapsimgui/.slurmfiles/OutbreakSim-" .. os.time() .. ".slurm";
	local fileText = string.format(
[[#!/bin/bash

#SBATCH -p tiny -a 1-%d

cd $SLURM_SUBMIT_DIR

%s
]], n,command);
	--Write out the slurm job
	local file = io.open(filename, "w");
	file:write(fileText);
	file:close();

	--Execute the slurm job 
	walkieTalkie.sendInput([[os.execute(string.format("sbatch %s", filename))]])
	
end

function module.printRunningJobs()
	filename = walkieTalkie.homeDir .. "/mapsimgui/deletSqueue.txt";
	walkieTalkie.sendInput(string.format([[os.execute("squeue --me > %s")]], filename));
	while not walkieTalkie.fileExists(filename) do
		os.execute("sleep 0.3");
	end
	os.execute("sleep 0.5");
	local file = io.open(filename, "r");
	for line in file:lines() do
		print(line);
	end
	file:close();
	os.executef("rm %s", filename);
end


return module;
