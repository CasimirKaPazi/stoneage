dofile(minetest.get_modpath("stoneage").."/ores.lua")
dofile(minetest.get_modpath("stoneage").."/overwrite.lua")

local torchdecay = true

minetest.register_craftitem("stoneage:silex", {
	description = "Silex",
	inventory_image = "stoneage_silex.png",
})

minetest.register_tool("stoneage:biface", {
	description = "Biface",
	inventory_image = "stoneage_biface.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3.20, [2]=1.20, [3]=0.60}, uses=20, maxlevel=1},
			fleshy={times={[2]=1.00, [3]=0.60}, uses=30, maxlevel=1},
			crumbly={times={[1]=1.70, [2]=0.70, [3]=0.50}, uses=10, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=2}
	},
})

--
-- fire striker
--
tinder = {
	"flowers:cotton",
	"default:paper",
	"default:coal_lump",
	"garden:cotton",
}

minetest.register_alias("stoneage:fire_striker", "stoneage:firestriker_steel")

local function strike_fire(user, pointed_thing)
			if pointed_thing.type == "node" then
				local n_pointed_above = minetest.env:get_node(pointed_thing.above)
				local n_pointed_under = minetest.env:get_node(pointed_thing.under)

				for _,tinder in ipairs(tinder) do
					if user:get_inventory():get_stack("main", user:get_wield_index()+1):get_name() == tinder then
						user:get_inventory():remove_item("main", tinder)
						if n_pointed_under.name == "stoneage:torch_unlit" then
							n_pointed_under.name = "default:torch"
							minetest.env:add_node(pointed_thing.under, n_pointed_under)
						elseif n_pointed_above.name == "air" then
							minetest.env:add_node(pointed_thing.above, {name="fire:basic_flame"})
						elseif n_pointed_above.name == "stoneage:bonfire_unlit" then
							minetest.env:add_node(pointed_thing.above, {name="stoneage:bonfire"})
						end
					end
				end				
			else
				return
			end
		end

minetest.register_tool("stoneage:firestriker_stone", {
	description = "Fire Striker",
	inventory_image = "stoneage_firestriker_stone.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
			strike_fire(user, pointed_thing)
			itemstack:add_wear(65535/16)
			return itemstack
		end
})

minetest.register_tool("stoneage:firestriker_steel", {
	description = "Fire Striker",
	inventory_image = "stoneage_firestriker_steel.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
			strike_fire(user, pointed_thing)
			itemstack:add_wear(65535/64)
			return itemstack
		end
})



--
-- torch
--

minetest.register_node("stoneage:torch_unlit", {
	description = "Torch",
	drawtype = "torchlike",
	tiles = {"stoneage_torch_unlit_on_floor.png", "stoneage_torch_unlit_on_ceiling.png", "stoneage_torch_unlit_on_wall.png"},
	inventory_image = "stoneage_torch_unlit_on_floor.png",
	wield_image = "stoneage_torch_unlit_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1},
	
	-- lighting a placed torch when hit by a buring one
	after_dig_node = function(pos, node, oldmetadata, puncher)
		local wield = puncher:get_wielded_item():get_name()
		if wield == "default:torch" then
			node.name = "default:torch"
			minetest.env:set_node(pos, node)
			local inv = puncher:get_inventory()
			inv:remove_item("main", "stoneage:torch_unlit")
		end
	end,
	
	-- lighting the torch in hand when hitting a buring one
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local n = minetest.env:get_node(pointed_thing.under)
			if minetest.get_item_group(n.name, "igniter") ~= 0 or n.name == "default:torch" or n.name == "default:furnace_active" then
				local torch_count = user:get_wielded_item():get_count()
				itemstack:replace("default:torch "..torch_count.."")
				return itemstack
			else
				minetest.env:punch_node(pointed_thing.under)
			end
		else
			return
		end
	end,
	
	sounds = default.node_sound_defaults(),
})

-- lighting the torch when a buring one is near by
minetest.register_abm({
	nodenames = {"stoneage:torch_unlit"},
	neighbors = {"group:igniter", "default:torch"},
	interval = 1,
	chance = 5,
	action = function(pos, node)		
		node.name = "default:torch"
		minetest.env:add_node(pos, node)
	end
})

-- torchdecay
-- burntime equals half a night
if torchdecay then
minetest.register_abm({
	nodenames = {"default:torch"},
	interval = 9,
	chance = 1,
	action = function(pos, node)
		local meta = minetest.env:get_meta(pos)
		local decay = meta:get_int("decay")
		if not decay then
			meta:set_int("decay", 1)
			return
		end
		if decay >= math.random(36, 44) then
			node.name = "stoneage:torch_unlit"
			minetest.env:add_node(pos, node)
			meta:set_int("decay", 0)
			return
		end
		decay = decay + 1
		meta:set_int("decay", decay)
	end
})
end



--
-- bonfire
--
-- in development

minetest.register_node("stoneage:bonfire_unlit", {
	description = "Bonfire",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"stoneage_bonfire_unlit.png"},
	inventory_image = "stoneage_bonfire_unlit.png",
	wield_image = "stoneage_bonfire_unlit.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drop = "default:coal_lump",
	groups = {snappy=3,flammable=2,attached_node=1},
	after_dig_node = function(pos, node, oldmetadata, puncher)
		local wield = puncher:get_wielded_item():get_name()
		if wield == "default:torch" then
			node.name = "stoneage:bonfire"
			minetest.env:set_node(pos, node)
			local inv = puncher:get_inventory()
			inv:remove_item("main", "default:coal_lump")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1/3, -1/2, -1/3, 1/3, 1/6, 1/3},
	},
})

minetest.register_node("stoneage:bonfire", {
	description = "Bonfire",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {
		{name="stoneage_bonfire_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	inventory_image = "stoneage_bonfire_unlit.png",
	wield_image = "stoneage_bonfire_unlit.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drop = "",
	damage_per_second = 1,
	light_source = LIGHT_MAX-1,
	groups = {dig_immediate=3,igniter=1,attached_node=1},
	after_place_node = function(pos, placer)
--		fire.on_flame_add_at(pos)
	end,
	after_dig_node = function(pos, node, oldmetadata, puncher)
		node.name = "stoneage:bonfire_unlit"
		minetest.env:set_node(pos, node)
--		fire.on_flame_remove_at(pos)
		puncher:set_hp(puncher:get_hp()-3)
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1/3, -1/2, -1/3, 1/3, 1/6, 1/3},
	},
})

for _,tinder in ipairs(tinder) do
	minetest.register_craft({
		output = 'stoneage:bonfire_unlit',
		recipe = {
			{'', 'default:stick', ''},
			{'default:stick', tinder, 'default:stick'},
		}
	})
end

if torchdecay then
minetest.register_abm({
	nodenames = {"stoneage:bonfire"},
	interval = 9,
	chance = 1,
	action = function(pos, node)
		local meta = minetest.env:get_meta(pos)
		local decay = meta:get_int("decay")
		if not decay then
			meta:set_int("decay", 1)
			return
		end
		if decay >= math.random(36, 44) then
			node.name = "stoneage:bonfire_unlit"
			minetest.env:add_node(pos, node)
			meta:set_int("decay", 0)
			return
		end
		decay = decay + 1
		meta:set_int("decay", decay)
	end
})
end

--
-- craft
--

-- craft stoneagetools
minetest.register_craft({
	type = 'shapeless',
	output = 'stoneage:firestriker_steel',
	recipe = {'stoneage:silex', 'default:steel_ingot'},
})

minetest.register_craft({
	type = 'shapeless',
	output = 'stoneage:firestriker_stone',
	recipe = {'stoneage:silex', 'group:stone'},
})

minetest.register_craft({
	output = 'stoneage:biface',
	recipe = {
		{'stoneage:silex'},
	}
})

-- craft torch
minetest.register_craft({
	output = 'stoneage:torch_unlit 4',
	recipe = {
		{'default:coal_lump'},
		{'default:stick'},
	}
})

minetest.register_craft({
	type = 'shapeless',
	output = 'default:torch 2',
	recipe = {'stoneage:torch_unlit', 'default:torch'},
})

minetest.register_craft({
	type = 'shapeless',
	output = 'stoneage:torch_unlit',
	recipe = {'default:torch'},
})

minetest.register_craft({
	type = 'cooking',
	output = 'default:torch',
	recipe = 'stoneage:torch_unlit',
	cooktime = 1,
})

-- craft furnace
minetest.register_craft({
	output = 'default:furnace',
	recipe = {
		{'group:stone','group:stone','group:stone'},
		{'group:stone','default:torch','group:stone'},
		{'group:stone','group:stone','group:stone'},
	}
})

minetest.register_craft({
	output = 'default:cobble 8',
	recipe = {
		{'group:stone','group:stone','group:stone'},
		{'group:stone','','group:stone'},
		{'group:stone','group:stone','group:stone'},
	}
})

-- craft default tools
minetest.register_craft({
	output = 'default:pick_stone',
	recipe = {
		{'stoneage:silex', 'stoneage:silex', 'stoneage:silex'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:shovel_stone',
	recipe = {
		{'stoneage:silex'},
		{'default:stick'},
		{'default:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'stoneage:silex', 'stoneage:silex'},
		{'stoneage:silex', 'default:stick'},
		{'', 'default:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_stone',
	recipe = {
		{'stoneage:silex'},
		{'stoneage:silex'},
		{'default:stick'},
	}
})

if (minetest.get_modpath("farming")) ~= nil then
	minetest.register_craft({
		output = 'farming:hoe_stone',
		recipe = {
			{'stoneage:silex', 'stoneage:silex'},
			{'', 'default:stick'},
			{'', 'default:stick'},
		}
	})
	
	minetest.register_craft({
		output = 'farming:hoe_stone',
		recipe = {
			{'stoneage:silex', 'stoneage:silex'},
			{'', 'default:stick'},
			{'', 'default:stick'},
		}
	})
end

-- craft more
minetest.register_craft({
	output = 'default:stick 6',
	recipe = {
		{'default:leaves'},
		{'default:leaves'},
		{'default:leaves'},
	}
})
