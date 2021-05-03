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
--    Copyright © 2020 Jan Ziegler   --
---------------------------------------
---------------------------------------

---------------------------------------
--           PADD | Client           --
---------------------------------------

hook.Add("Star_Trek.LCARS.OverrideEntity", "Star_Trek.PADD.OverrideEntity", function(ent)
	if ent:GetClass() ~= "padd_swep" then return end

	local owner = ent:GetOwner()
	if not IsValid(owner) or owner ~= LocalPlayer() then return end

	return owner:GetViewModel()
end)