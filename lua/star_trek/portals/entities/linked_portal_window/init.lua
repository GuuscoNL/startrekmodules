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
--   Linked Portal Window | Server   --
---------------------------------------

if not istable(ENT) then Star_Trek:LoadAllModules() return end

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

AccessorFunc( ENT, "partnername", "PartnerName" )

-- Collect properties
function ENT:KeyValue( key, value )
	if ( key == "partnername" ) then
		self:SetPartnerName( value )
		self:SetExit( ents.FindByName( value )[1] )
	elseif ( key == "width" ) then
		self:SetWidth( tonumber(value) * 2 )

	elseif ( key == "height" ) then
		self:SetHeight( tonumber(value) * 2 )

	elseif ( key == "DisappearDist" or key == "fademaxdist" ) then
		self:SetDisappearDist( tonumber(value) )

	elseif ( key == "angles" ) then
		local args = value:Split( " " )

		for k, arg in pairs( args ) do
			args[k] = tonumber(arg)
		end

		self:SetAngles( Angle( unpack(args) ) )
	elseif ( key == "scale" ) then
		self:SetScale(tonumber(value))
	end
end
