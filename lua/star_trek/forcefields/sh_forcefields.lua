---------------------------------------
---------------------------------------
--         Star Trek Modules         --
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
--       Force Fields | Shared       --
---------------------------------------

-- Prevent Forcefields from being picked up by a Physgun
hook.Add("PhysgunPickup", "Star_Trek.ForceFields.PreventPickup", function(ply, ent)
	if ent:GetClass() ~= "force_field" then
		return
	end

	return false
end)

-- Prevent Forcefields from being modified by a Toolgun
hook.Add("CanTool", "Star_Trek.ForceFields.PreventCanTool", function(ply, tr, toolname, tool, button)
	local ent = tr.Entity
	if not IsValid(ent) then
		return
	end

	if ent:GetClass() ~= "force_field" then
		return
	end

	return false
end)