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
--    Copyright © 2021 Jan Ziegler   --
---------------------------------------
---------------------------------------

---------------------------------------
--       Alert Sounds | Shared       --
---------------------------------------

sound.Add({
	name = "star_trek.blue_alert",
	channel = CHAN_AUTO,
	volume = .8,
	level = 0,
	pitch = 100,
	sound = "oninoni/startrek/alert/voy_bluealert.wav",
})

sound.Add({
	name = "star_trek.red_alert",
	channel = CHAN_AUTO,
	volume = 1,
	level = 0,
	pitch = 100,
	sound = "oninoni/startrek/alert/voy_redalert.wav",
})