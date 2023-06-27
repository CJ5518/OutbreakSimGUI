require("wx");
local homeDir = require("walkieTalkie").homeDir;

function print(s)
	wx.wxLogMessage(tostring(s));
end
function printf(s, ...)
	wx.wxLogMessage(string.format(s, ...));
end

local stuff = require("stuff")
local slurmUtilities = require("slurmUtils")

--takes ir and turn it into Infected -> Recovered
local function paramToLongName(param)
	local ret = "";
	for q = 1, 2 do
		if q == 2 then
			ret = ret .. " -> ";
		end
		for i, v in ipairs(stuff.paramNames) do
			if v:sub(1,1):lower() == param:sub(q,q) then
				ret = ret .. v;
				break;
			end
		end
	end
	return ret;
end

local rollingID = 1001;

local rollingYPos = 0;

local function addID()
	rollingID = rollingID + 1
end

local function addYPos(n)
	rollingYPos = rollingYPos + n;
end

local function addBoth(n)
	addID();
	addYPos(n);
end

--info stored like paramsControls[1] = {wxTextCtrl, "ir"}
local paramsControls = {};
--Info for both of these in the form {wxControl, "-stop"}
local textControls = {};
local boolControls = {};
local gravityModelCheckbox;
local gravityModelsParams = {};
local airportTextCtrl;
local outputFolderDirPicker;
local additionalArgsControl;
local outputCommandControl;

local function updateFullArgs()
	local argsString = homeDir .. "/mapsimgui/mapsim/MapSimulation1.x86_64 -o " .. outputFolderDirPicker:GetPath() .. "/";
	local paramString = "";
	for i,v in ipairs(paramsControls) do
		if v[1]:GetValue() ~= "" then
			--Already a param in the string, add a comma before this one
			if paramString ~= "" then
				paramString = paramString .. ",";
			end
			paramString = paramString .. v[2] .. "=" .. v[1]:GetValue();
		end
	end
	if paramString ~= "" then
		argsString = argsString .. " --params " .. paramString;
	end

	--Text controls
	for i,v in ipairs(textControls) do
		if v[1]:GetValue() ~= "" then
			argsString = argsString .. " " .. v[2] .. " " .. v[1]:GetValue();
			if v[2] == "-opost" then
				argsString = argsString .. "-$SLURM_ARRAY_TASK_ID";
			end
		end
	end
	--Boolean controls
	for i,v in ipairs(boolControls) do
		if v[1]:GetValue() then
			argsString = argsString .. " " .. v[2]
		end
	end
	--Gravity model stuff
	if gravityModelCheckbox:IsChecked() then
		local alpha = gravityModelsParams[1]:GetValue();
		local beta = gravityModelsParams[2]:GetValue();
		argsString = argsString .. string.format(" -gravity %s,%s", alpha == "" and "0" or alpha, beta == "" and "0" or beta);
	end

	argsString = argsString .. " " .. additionalArgsControl:GetValue();
	outputCommandControl:SetValue(argsString);
	return argsString;
end

local function createDefaultTextCtrlTextEvent()
	return updateFullArgs;
end
local function createDefaultCheckBoxEvent()
	return updateFullArgs;
end

local function main()
	local frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, 'OutbreakSim GUI', wx.wxDefaultPosition, wx.wxSize(800,600));
	wx.wxLog.DontCreateOnDemand();
	
	local logWindow = wx.wxLogWindow(wx.NULL, "title", true);
	wx.wxLog.SetLogLevel(wx.wxLOG_Info);
	
	
	local window = wx.wxScrolledWindow(frame, wx.wxID_ANY);
	window:SetScrollbars(1,1,1,1100);

	local function makeLabel(text)
		local ret = wx.wxStaticText(window, rollingID, text, wx.wxPoint(0, rollingYPos));
		addBoth(20);
		return ret;
	end

	--Output dir picker
	makeLabel("Output csv folder")
	outputFolderDirPicker = wx.wxDirPickerCtrl(window, rollingID, homeDir .. "/mapsimgui/output", "Folder to put the output csvs in",
		wx.wxPoint(0, rollingYPos), wx.wxSize(500,30),
		wx.wxDIRP_USE_TEXTCTRL)
	frame:Connect(rollingID, wx.wxEVT_DIRPICKER_CHANGED, updateFullArgs)
	addBoth(50);
	makeLabel("Output file postfix");
	--It is important that this stay as the exact string "-opost"
	textControls[#textControls + 1] = {wx.wxTextCtrl(window, rollingID, "-Run1", wx.wxPoint(0, rollingYPos), wx.wxSize(100,30)), "-opost"};
	frame:Connect(rollingID, wx.wxEVT_TEXT, createDefaultTextCtrlTextEvent());
	addBoth(40);

	--Parameters section
	local xSize = 200;
	local qOffset = 1;
	for q = 1, #stuff.params do
		wx.wxStaticText(window, rollingID, paramToLongName(stuff.params[q]), wx.wxPoint((q-qOffset)*xSize, rollingYPos));
		addID();
		paramsControls[q] = {wx.wxTextCtrl(window, rollingID, "", wx.wxPoint((q-qOffset)*xSize, rollingYPos+30)), stuff.params[q]};

		frame:Connect(rollingID, wx.wxEVT_TEXT, createDefaultTextCtrlTextEvent());

		addID();
		if q == 4 then addYPos(80); qOffset = 5; end
	end
	addYPos(80);

	--Airport text entry, can't be a combo box because too many elements caused it to crash
	local airportLabelText = "Airport starting location, e.g LAX, JFK, ATL, etc."
	local airportLabel = makeLabel(airportLabelText)
	airportTextCtrl = wx.wxTextCtrl(window, rollingID, "ATL", wx.wxPoint(0, rollingYPos), wx.wxSize(150,30))
	textControls[#textControls+1] = {airportTextCtrl, "-startat"};
	frame:Connect(rollingID, wx.wxEVT_TEXT, function()
		print(airportTextCtrl:GetLineText(0));
		local isValid = false;
		local text = airportTextCtrl:GetLineText(0);
		if text:len() == 3 then
			for i, v in pairs(stuff.airportCodes) do
				if v == text:upper() then
					isValid = true;
				end
			end
		end

		if not isValid then
			airportLabel:SetLabel(airportLabelText .. " - INVALID")
		else
			airportLabel:SetLabel(airportLabelText);
		end
		createDefaultTextCtrlTextEvent()();
	end);
	addBoth(40);

	gravityModelCheckbox = wx.wxCheckBox(window, rollingID, "Gravity model (vals of .35 for each param are sensible, larger values are crazy)", wx.wxPoint(0, rollingYPos), wx.wxSize(700,30));
	frame:Connect(rollingID, wx.wxEVT_CHECKBOX, createDefaultCheckBoxEvent());
	addBoth(40);
	wx.wxStaticText(window, rollingID, "alpha:", wx.wxPoint(150-150, rollingYPos + 5), wx.wxSize(50,30));
	addID();
	gravityModelsParams[1] = wx.wxTextCtrl(window, rollingID, "", wx.wxPoint(200-150, rollingYPos), wx.wxSize(100,30));
	frame:Connect(rollingID, wx.wxEVT_TEXT, createDefaultTextCtrlTextEvent());
	addID();
	wx.wxStaticText(window, rollingID, "beta:", wx.wxPoint(320-150, rollingYPos + 5), wx.wxSize(50,30));
	addID();
	gravityModelsParams[2] = wx.wxTextCtrl(window, rollingID, "", wx.wxPoint(370-150, rollingYPos), wx.wxSize(100,30));
	frame:Connect(rollingID, wx.wxEVT_TEXT, createDefaultTextCtrlTextEvent());
	addBoth(40);

	--Entries defined in stuff.lua
	for i,entry in ipairs(stuff.entries) do
		if entry[3] == "boolean" then
			boolControls[#boolControls + 1] = {wx.wxCheckBox(window, rollingID, entry[1], wx.wxPoint(0, rollingYPos), wx.wxSize(200,30)), entry[2]};
			frame:Connect(rollingID, wx.wxEVT_CHECKBOX, createDefaultCheckBoxEvent());
			addBoth(30);
		elseif entry[3] == "number" or entry[3] == "string" then
			makeLabel(entry[1]);
			textControls[#textControls+1] = {wx.wxTextCtrl(window, rollingID, "", wx.wxPoint(0, rollingYPos), wx.wxSize(200, 30)), entry[2]};
			frame:Connect(rollingID, wx.wxEVT_TEXT, createDefaultTextCtrlTextEvent());
			addBoth(30);
		end
	end

	--Additional args
	makeLabel("Additional arguments");
	additionalArgsControl = wx.wxTextCtrl(window, rollingID, "", wx.wxPoint(0, rollingYPos), wx.wxSize(500, 30));
	frame:Connect(rollingID, wx.wxEVT_TEXT, createDefaultTextCtrlTextEvent());
	addBoth(40);

	--Go button and go number
	makeLabel("# of simulations to run")
	local simNumberControl = wx.wxTextCtrl(window, rollingID, "", wx.wxPoint(0, rollingYPos), wx.wxSize(200, 30));
	addBoth(40);
	--Go button
	wx.wxButton(window, rollingID, "GO!", wx.wxPoint(0, rollingYPos), wx.wxSize(100,30));
	frame:Connect(rollingID, wx.wxEVT_BUTTON, function()
		slurmUtilities.runJob(updateFullArgs(), tonumber(simNumberControl:GetValue()));
	end)
	addID();
	--Jobs viewer button
	wx.wxButton(window, rollingID, "See Running", wx.wxPoint(100, rollingYPos), wx.wxSize(100,30));
	frame:Connect(rollingID, wx.wxEVT_BUTTON, function()
		slurmUtilities.printRunningJobs();
	end)
	addBoth(40);
	--Arg viewer
	makeLabel("Output command");
	outputCommandControl = wx.wxTextCtrl(window, rollingID, "", wx.wxPoint(0, rollingYPos), wx.wxSize(500, 90), bit32.bor(wx.wxTE_READONLY, wx.wxTE_NO_VSCROLL,wx.wxTE_MULTILINE));
	frame:Show();
end


main();
updateFullArgs();
wx.wxGetApp():MainLoop()

