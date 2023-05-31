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

local function main()
	local frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, 'OutbreakSim GUI');
	wx.wxLog.DontCreateOnDemand();
	
	local logWindow = wx.wxLogWindow(wx.NULL, "title", true);
	wx.wxLog.SetLogLevel(wx.wxLOG_Info);
	

	local button = wx.wxButton(frame, wx.wxID_ANY, "Text");
	button:SetSize(100,100);
	button:SetPosition(wx.wxPoint(100,100));
	local button2 = wx.wxButton(frame, 1001, "Text2");
	button2:SetSize(100,100);
	
	local textInput = wx.wxTextCtrl(frame, 1002, "text");
	textInput:SetSize(100, 30);
	textInput:SetPosition(wx.wxPoint(200,200));


	frame:Connect(1001, wx.wxEVT_BUTTON,
	function (event)
		print("ButtonClick");
	end )
	print("HERE");
	frame:Show();
end


main();
wx.wxGetApp():MainLoop()

