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
--          Sections | Index         --
---------------------------------------

Star_Trek:RequireModules("util", "lcars")

Star_Trek.Sections = Star_Trek.Sections or {}

if SERVER then
	AddCSLuaFile("cl_net.lua")

	include("sv_sections.lua")
	include("sv_net.lua")
end

if CLIENT then
	include("cl_net.lua")
end