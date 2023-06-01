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

local rollingID = 1001;

local paramsControls = {};

local function main()
	local frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, 'OutbreakSim GUI');
	wx.wxLog.DontCreateOnDemand();
	
	local logWindow = wx.wxLogWindow(wx.NULL, "title", true);
	wx.wxLog.SetLogLevel(wx.wxLOG_Info);
	
	
	local window = wx.wxScrolledWindow(frame, wx.wxID_ANY);
	--window:SetScrollbars(1,1,,1000);

	--Parameters section

	for q = 1, #stuff.params do
		--unfinished line
		--paramsControls[q] = wx.wxTextCtrl
	end
	

	

	local button = wx.wxButton(window, wx.wxID_ANY, "Text");
      button:SetSize(100,400);
      button:SetPosition(wx.wxPoint(100,100));


	frame:Connect(1001, wx.wxEVT_BUTTON,
	function (event)
		print("ButtonClick");
	end )
	print("HERE");
	frame:Show();
end


main();
wx.wxGetApp():MainLoop()

