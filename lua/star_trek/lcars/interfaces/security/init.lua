local securityUtil = include("util.lua")

function Star_Trek.LCARS:OpenSecurityMenu()
	local success, interfaceEnt = self:GetInterfaceEntity(TRIGGER_PLAYER, CALLER)
	if not success then
		Star_Trek:Message(interfaceEnt)
		return
	end

	if istable(self.ActiveInterfaces[interfaceEnt]) then
		return
	end

	local success2, menuWindow, actionWindow = securityUtil.CreateMenuWindow()
	if not success2 then
		Star_Trek:Message(menuWindow)
		return
	end

	local success3, mapWindow = securityUtil.CreateMapWindow(1)
	if not success3 then
		Star_Trek:Message(mapWindow)
		return
	end

	local success4, sectionWindow = Star_Trek.LCARS:CreateWindow(
		"category_list",
		Vector(-28, -5, -2),
		Angle(0, 0, 0),
		nil,
		500,
		700,
		function(windowData, interfaceData, categoryId, buttonId)
			if isnumber(buttonId) then
				local buttonData = windowData.Buttons[buttonId]

				mapWindow:SetSectionActive(buttonData.Data.Id, buttonData.Selected)
				mapWindow:Update()
			else
				mapWindow:SetDeck(categoryId)
				mapWindow:Update()
			end
		end,
		Star_Trek.LCARS:GetSectionCategories(),
		"SECTIONS",
		"SECTNS",
		false,
		true
	)
	if not success4 then
		Star_Trek:Message(menuWindow)
		return
	end

	local success5, error = self:OpenInterface(interfaceEnt, menuWindow, sectionWindow, mapWindow, actionWindow)
	if not success5 then
		Star_Trek:Message(error)
		return
	end
end