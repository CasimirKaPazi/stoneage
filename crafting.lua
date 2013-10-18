minetest.register_craft({
	output = 'default:stick 6',
	recipe = {
		{'default:leaves'},
		{'default:leaves'},
		{'default:leaves'},
	}
})

-- Stoneage tools
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

-- Torches
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

-- Furnace
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

-- Standard tools
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

for _,tinder in ipairs(tinder) do
	minetest.register_craft({
		output = 'stoneage:bonfire_unlit',
		recipe = {
			{'', 'default:stick', ''},
			{'default:stick', tinder, 'default:stick'},
		}
	})
end
