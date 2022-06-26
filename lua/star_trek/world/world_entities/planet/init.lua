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
--            World Entity           --
--          Planet | Server          --
---------------------------------------

if not istable(ENT) then Star_Trek:LoadAllModules() return end
local SELF = ENT

function SELF:Init(pos, ang, model, radius, spin)
	model = model or "models/planets/earth.mdl"

	local modelDiameter = Star_Trek.World:GetModelDiameter(model)
	print(modelDiameter, radius / (modelDiameter / 2))

	local models = {{Model = model, Scale = radius / (modelDiameter / 2)}}

	SELF.Base.Init(self, pos, ang, models, Vector(), Angle(0, spin, 0))
end

function SELF:SetSpin(spin)
	self:SetAngularVelocity(Angle(0, spin, 0))
end