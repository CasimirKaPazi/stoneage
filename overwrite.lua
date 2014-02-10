--
-- overwrite nodes and tools
--

minetest.override_item("default:axe_wood", {
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
		}
	}
})
	
minetest.override_item("default:pick_wood", {
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
		}
	}
})

local trees = {
	"default:tree",
	"default:jungletree",
	"moretrees:beech_trunk",
	"moretrees:apple_tree_trunk",
	"moretrees:oak_trunk",
	"moretrees:sequoia_trunk",
	"moretrees:birch_trunk",
	"moretrees:palm_trunk",
	"moretrees:spruce_trunk",
	"moretrees:pine_trunk",
	"moretrees:willow_trunk",
	"moretrees:rubber_tree_trunk",
	"moretrees:jungletree_trunk",
	"moretrees:fir_trunk",
	"conifers:trunk",
	"conifers:trunk_reversed",
}

for _,name in ipairs(trees) do
	if minetest.registered_items[name] then
		groups = {tree=1,choppy=2,flammable=2}
		minetest.override_item(name, {groups = groups})
	end
end
