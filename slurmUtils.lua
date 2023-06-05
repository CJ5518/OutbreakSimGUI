--Runs a job for the gui program

local walkieTalkie = require("walkieTalkie");

local module = {};



--Run command n times
function module.runJob(command, n)
	local filename = walkieTalkie.homeDir .. "/mapsimgui/.slurmfiles/OutbreakSim-" .. os.time() .. ".slurm";
	local fileText = string.format(
[[#!/bin/bash

#SBATCH -p tiny

cd $SLURM_SUBMIT_DIR

%s
]], command);
	--Write out the slurm job
	local file = io.open(filename, "w");
	file:write(fileText);
	file:close();

	--Execute the slurm job 
	walkieTalkie.sendInput([[os.execute("touch HERERERERERE")]])
	--os.execute(string.format("sbatch -a 1-%d %s", n, filename));
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
