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

minetest.register_tool("stoneage:firestriker_stone", {
	description = "Fire Striker",
	inventory_image = "stoneage_firestriker_stone.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
			stoneage.strike_fire(user, pointed_thing)
			itemstack:add_wear(65535/16)
			return itemstack
		end
})

minetest.register_tool("stoneage:firestriker_steel", {
	description = "Fire Striker",
	inventory_image = "stoneage_firestriker_steel.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
			stoneage.strike_fire(user, pointed_thing)
			itemstack:add_wear(65535/64)
			return itemstack
		end
})
