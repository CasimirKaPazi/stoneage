stoneage = {}

local torchdecay = true

tinder = {
	"flowers:cotton",
	"default:paper",
	"default:coal_lump",
	"garden:cotton",
}

dofile(minetest.get_modpath("stoneage").."/functions.lua")
dofile(minetest.get_modpath("stoneage").."/nodes.lua")
dofile(minetest.get_modpath("stoneage").."/tools.lua")
dofile(minetest.get_modpath("stoneage").."/crafting.lua")
dofile(minetest.get_modpath("stoneage").."/mapgen.lua")
dofile(minetest.get_modpath("stoneage").."/overwrite.lua")


minetest.register_alias("stoneage:fire_striker", "stoneage:firestriker_steel")
