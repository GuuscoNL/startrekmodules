---------------------------------------
---------------------------------------
--        Star Trek Utilities        --
--                                   --
--            Created by             --
--       Jan 'Oninoni' Ziegler       --
--                                   --
-- This software can be used freely, --
--    but only distributed by me.    --
--                                   --
--    Copyright © 2022 Jan Ziegler   --
---------------------------------------
---------------------------------------

---------------------------------------
--           Alert | Server          --
---------------------------------------

-- Enable the given alert.
--
-- @param String alert
-- @return Boolean success
-- @return? String error
util.AddNetworkString("Star_Trek.Alert.Enable")
function Star_Trek.Alert:Enable(type)
	local alertType = self.AlertTypes[type]
	if not istable(alertType) then
		return false, "Invalid alert!"
	end

	if isstring(self.ActiveAlert) and self.ActiveAlert == type then
		return false, "Alert mode already active."
	end

	if self.ActiveAlertSound then
		self.ActiveAlertSound:Stop()
	end

	if isstring(alertType.Sound) then
		self.ActiveAlertSound = CreateSound(Entity(1), alertType.Sound)
		self.ActiveAlertSound:SetSoundLevel(0)
		self.ActiveAlertSound:Play()
	end

	local bridgeLights = ents.FindByName(Star_Trek.Alert.BridgeDimName)
	for _, ent in pairs(bridgeLights) do
		if alertType.BridgeDim then
			ent:Fire("turnOff")
		else
			ent:Fire("turnOn")
		end
	end

	net.Start("Star_Trek.Alert.Enable")
		net.WriteString(type)
	net.Broadcast()

	self.ActiveAlert = type

	return true
end

-- Sync Alert on Join.
hook.Add("PlayerInitialSpawn", "Star_Trek.Alert.Sync", function()
	if isstring(Star_Trek.Alert.ActiveAlert) then
		net.Start("Star_Trek.Alert.Enable")
			net.WriteString(Star_Trek.Alert.ActiveAlert)
		net.Broadcast()
	end
end)

-- Disable the current alert.
--
-- @return Boolean success
-- @return? String error
util.AddNetworkString("Star_Trek.Alert.Disable")
function Star_Trek.Alert:Disable()
	if not self.ActiveAlert then
		return false, "Alert already inactive."
	end

	if self.ActiveAlertSound then
		self.ActiveAlertSound:Stop()
	end

	local bridgeLights = ents.FindByName(Star_Trek.Alert.BridgeDimName)
	for _, ent in pairs(bridgeLights) do
		ent:Fire("turnOn")
	end

	net.Start("Star_Trek.Alert.Disable")
	net.Broadcast()

	self.ActiveAlert = nil

	return true
end

hook.Add("PostCleanupMap", "Star_Trek.Alert.Cleanup", function()
	Star_Trek.Alert:Disable()
end)