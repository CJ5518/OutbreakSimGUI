--Define the stuff that main.lua needs to render and deal with
--Defines the simple stuff, more complex options are in main.lua maybe

local module = {};

local function makeEntry(name, argName, paramType, helpText)
	
end

makeEntry(
	"Output file folder",
	"-o",
	"directory",
	"The directory to put the output data files"
);

makeEntry(
	"Simulation Logfile path",
	"-simlog",
	"file",
	"Where to put the simulation verbose output file (this file is not made if this argument is not used)"
)

makeEntry(
	"Stop time",
	"--stop",
	"number",
	"The maximum amount of time the simulation will simulate, in units of hours"
);

makeEntry(
	"No output writing",
	"-nowrite",
	"boolean",
	"Don't write output data files"
);

makeEntry(
	"Output file postfix",
	"-opost",
	"string",
	"String of characters to append to the output filename - useful for differentiating runs"
);

makeEntry(
	"Deterministic",
	"-deterministic",
	"boolean",
	"Use the deterministic simulation model (default is stochastic)"
)

makeEntry(
	"Airports",
	"-airports",
	"boolean",
	"Use airports (default is no airports)"
)



module.params = {
	"id",
	"ir",
	"rs",
	"sv",
	"vs",
	"ei",
	"se"
}

module.paramNames = {
	"Infected",
	"Dead",
	"Recovered",
	"Susceptible",
	"Vaccinated",
	"Exposed"
}


return module;