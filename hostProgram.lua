local walkieTalkie = require("walkieTalkie");

--Host program inits the communication
walkieTalkie.init()

while true do
	walkieTalkie.waitForInput();
	dofile(walkieTalkie.getInpath());
	walkieTalkie.markInputConsumed();
	os.execute("sleep 1");
end