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




local function main()
	local frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, 'OutbreakSim GUI');

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
		--Doesn't print, look into: https://docs.wxwidgets.org/trunk/classwx_log_window.html
		print("ButtonClick");
		wx.wxMessageBox(textInput:GetValue(),
						"About wxLua",
						wx.wxOK + wx.wxICON_INFORMATION,
						frame)
	end )
	print("HERE");
	frame:Show();
end


main();
wx.wxGetApp():MainLoop()

