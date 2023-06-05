local walkieTalkie = require("walkieTalkie");

--Host program inits the communication
walkieTalkie.init()

while true do
    walkieTalkie.waitForInput();
    dofile(walkieTalkie.getInpath());
end