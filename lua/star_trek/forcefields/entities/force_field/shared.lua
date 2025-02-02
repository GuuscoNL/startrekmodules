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
--    Force Field Entity | Shared    --
---------------------------------------

if not istable(ENT) then Star_Trek:LoadAllModules() return end

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Force Field"
ENT.Author = "Oninoni"

ENT.Category = "Star Trek"

ENT.Spawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "AlwaysOn")
end