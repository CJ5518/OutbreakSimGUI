require("wx");

--[[
    control = wx.wxDirPickerCtrl(scrollWin, ID_DIRPICKERCTRL, wx.wxGetCwd(), "I'm the message parameter",
                                         wx.wxDefaultPosition, wx.wxDefaultSize,
                                         wx.wxDIRP_USE_TEXTCTRL)
    AddControl("wxDirPickerCtrl", control)

    -- -----------------------------------------------------------------------

    control = wx.wxFilePickerCtrl(scrollWin, ID_FILEPICKERCTRL, wx.wxGetCwd(), wx.wxFileSelectorPromptStr, wx.wxFileSelectorDefaultWildcardStr,
                                         wx.wxDefaultPosition, wx.wxDefaultSize,
                                         wx.wxFLP_USE_TEXTCTRL)
    AddControl("wxFilePickerCtrl", control)

]]


function print(s)
	wx.wxLogMessage(tostring(s));
end
function printf(s, ...)
	wx.wxLogMessage(string.format(s, ...));
end

local stuff = require("stuff")

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

local function createDefaultTextCtrlTextEvent(name)
	return function()
		print(name);
	end
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

local paramsControls = {};
local airportTextCtrl;

local function main()
	local frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, 'OutbreakSim GUI', wx.wxDefaultPosition, wx.wxSize(800,600));
	wx.wxLog.DontCreateOnDemand();
	
	local logWindow = wx.wxLogWindow(wx.NULL, "title", true);
	wx.wxLog.SetLogLevel(wx.wxLOG_Info);
	
	
	local window = wx.wxScrolledWindow(frame, wx.wxID_ANY);
	--window:SetScrollbars(1,1,,1000);

	local function makeLabel(text)
		local ret = wx.wxStaticText(window, rollingID, text, wx.wxPoint(0, rollingYPos));
		addBoth(20);
		return ret;
	end

	--Output dir picker
	makeLabel("Output csv folder")
	wx.wxDirPickerCtrl(window, rollingID, wx.wxGetCwd(), "I'm the message parameter",
		wx.wxPoint(0, rollingYPos), wx.wxSize(500,30),
		wx.wxDIRP_USE_TEXTCTRL)
	frame:Connect(rollingID, wx.wxEVT_DIRPICKER_CHANGED, function ()
		
	end)
	addBoth(50);
	makeLabel("Output file postfix");
	wx.wxTextCtrl(window, rollingID, "-Run1", wx.wxPoint(0, rollingYPos), wx.wxSize(100,30));
	addBoth(40);

	--Parameters section
	local xSize = 200;
	local qOffset = 1;
	for q = 1, #stuff.params do
		wx.wxStaticText(window, rollingID, paramToLongName(stuff.params[q]), wx.wxPoint((q-qOffset)*xSize, rollingYPos));
		addID();
		paramsControls[q] = wx.wxTextCtrl(window, rollingID, "", wx.wxPoint((q-qOffset)*xSize, rollingYPos+30));

		frame:Connect(rollingID, wx.wxEVT_TEXT, createDefaultTextCtrlTextEvent(q));

		addID();
		if q == 4 then addYPos(80); qOffset = 5; end
	end
	addYPos(80);

	--Airport text entry, can't be a combo box because too many elements caused it to crash
	local airportLabelText = "Airport starting location, e.g LAX, JFK, ATL, etc."
	local airportLabel = makeLabel(airportLabelText)
	airportTextCtrl = wx.wxTextCtrl(window, rollingID, "ATL", wx.wxPoint(0, rollingYPos), wx.wxSize(150,30))
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

	--Entries defined in stuff.lua
	for i,entry in ipairs(stuff.entries) do
		if entry[3] == "boolean" then
			makeLabel(entry[1]);
			--unfinished line
			--wx.wxCheckBox(window, rollingID, )
		end
	end


	frame:Show();
end


main();
wx.wxGetApp():MainLoop()

