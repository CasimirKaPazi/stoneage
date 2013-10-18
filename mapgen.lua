minetest.register_ore({
	ore_type       = "scatter",
	ore            = "stoneage:grass_with_silex",
	wherein        = "default:dirt_with_grass",
	clust_scarcity = 19*19*19,
	clust_num_ores = 5,
	clust_size     = 3,
	height_min     = -8,
	height_max     = 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "stoneage:dirt_with_silex",
	wherein        = "default:dirt",
	clust_scarcity = 19*19*19,
	clust_num_ores = 5,
	clust_size     = 3,
	height_min     = -8,
	height_max     = 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "stoneage:sand_with_silex",
	wherein        = "default:sand",
	clust_scarcity = 17*17*17,
	clust_num_ores = 8,
	clust_size     = 4,
	height_min     = -63,
	height_max     = -16,
})
