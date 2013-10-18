function stoneage.strike_fire(user, pointed_thing)
			if pointed_thing.type == "node" then
				local n_pointed_above = minetest.env:get_node(pointed_thing.above)
				local n_pointed_under = minetest.env:get_node(pointed_thing.under)

				for _,tinder in ipairs(tinder) do
					if user:get_inventory():get_stack("main", user:get_wield_index()+1):get_name() == tinder then
						user:get_inventory():remove_item("main", tinder)
						if n_pointed_under.name == "stoneage:torch_unlit" then
							n_pointed_under.name = "default:torch"
							minetest.env:add_node(pointed_thing.under, n_pointed_under)
						elseif n_pointed_under.name == "stoneage:bonfire_unlit" then
							minetest.env:add_node(pointed_thing.under, {name="stoneage:bonfire"})
						elseif n_pointed_above.name == "air" then
							minetest.env:add_node(pointed_thing.above, {name="fire:basic_flame"})
						end
					end
				end				
			else
				return
			end
end

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

minetest.register_abm({
	nodenames = {"stoneage:bonfire"},
	interval = 18,
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
