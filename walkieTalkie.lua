--Communicate between a container and the host
--We do this by just writing to some files

local module = {}

function module.readFromProcess(proc)
	local program = io.popen(proc, "r");
	local text = program:read("*a");
	program:close();
	return text;
end

function os.executef(command, ...)
	os.execute(string.format(command, ...));
end

function module.fileExists(filename)
	local ret = module.readFromProcess(string.format("[ -e %s ]; echo $?", filename));
	return tonumber(ret) == 0;
end

module.homeDir = module.readFromProcess("printf $HOME");

local walkiefolder = module.homeDir .. "/.walkie";
local inpath = walkiefolder .. "/talkieinput";
local outpath = walkiefolder .. "/talkieoutput";
local insetpath = walkiefolder .. "/talkieinputset";
local outsetpath = walkiefolder .. "/talkieoutputset";

--Init the two files
function module.init()
	os.executef("mkdir %s", walkiefolder);
	os.executef("rm -f %s %s", inpath, outpath);
	os.executef("touch %s %s", inpath, outpath);
end

--Waits until the insetpath file exists
--Or rather, it waits until the file is changed in any way
function module.waitForInput()
	while not module.fileExists(insetpath) do
		os.execute("sleep 0.4");
	end
end

function module.getInpath()
	return inpath;
end

function module.writeOutput()

end

function module.markInputConsumed()
	os.executef("rm -f %s", insetpath);
end

function module.sendInput(message)
	if module.fileExists(insetpath) then
		return nil, "Previous input sent has not been consumed yet";
	end
	local infile, err = io.open(inpath, "w");
	if not infile then
		return infile, err;
	end
	infile:write(message);
	infile:flush();
	infile:close();
	os.executef("touch %s", insetpath);
end

return module;
