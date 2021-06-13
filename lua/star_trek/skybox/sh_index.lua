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
--           Skybox | Index          --
---------------------------------------

Star_Trek:RequireModules()

Star_Trek.Skybox = Star_Trek.Skybox or {}

if SERVER then
	AddCSLuaFile("cl_skybox.lua")
end

if CLIENT then
	include("cl_skybox.lua")
end