--Runs a job for the gui program

local module = {};

--Run command n times
function module.runJob(command, n)
	local filename = "~/mapsimgui/.slurmfiles/OutbreakSim-" .. os.time() .. ".slurm";
	os.execute(string.format("printf %s > %s","#!/bin/bash\n\n#SBATCH -p tiny\n\ncd $SLURM_SUBMIT_DIR\n\n%s", command, filename));
	os.execute(string.format("sbatch -a 1-%d %s", n, filename))
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