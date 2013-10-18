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
	groups = {snappy=3,flammable=2,attached_node=1},
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
	after_dig_node = function(pos, node, oldmetadata, puncher)
		node.name = "stoneage:bonfire_unlit"
		minetest.env:set_node(pos, node)
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1/3, -1/2, -1/3, 1/3, 1/6, 1/3},
	},
})

--
-- ores
--

minetest.register_node("stoneage:grass_with_silex", {
	description = "Silex",
	tiles = {"default_grass.png^stoneage_silex_ore.png", "default_dirt.png^stoneage_silex_ore.png", "default_dirt.png^default_grass_side.png^stoneage_silex_ore.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1},
	drop = 'stoneage:silex',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node("stoneage:dirt_with_silex", {
	description = "Silex",
	tiles = {"default_dirt.png^stoneage_silex_ore.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1},
	drop = 'stoneage:silex',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node("stoneage:sand_with_silex", {
	description = "Silex",
	tiles = {"default_sand.png^stoneage_silex_ore.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1},
	drop = 'stoneage:silex',
	sounds = default.node_sound_sand_defaults(),
})
