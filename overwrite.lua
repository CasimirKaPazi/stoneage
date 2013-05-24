--
-- overwrite default nodes and tools
--

-- stoneage = {}
local entity

-- registered
local registered = function(case,name)
	local params = {}
	local list
	if case == "item" then list = minetest.registered_items end
	if case == "node" then list = minetest.registered_nodes end
	if case == "craftitem" then list = minetest.registered_craftitems end
	if case == "tool" then list = minetest.registered_tools end
	if case == "entity" then list = minetest.registered_entities end
	if list then
		for k,v in pairs(list[name]) do
			params[k] = v
		end
	end
	return params
end

-- tree
entity = registered("node","default:tree")
entity.groups = {tree=1,choppy=2,flammable=2}
minetest.register_node(":default:tree", entity)

-- jungletree
entity = registered("node","default:jungletree")
entity.groups = {tree=1,choppy=2,flammable=2}
minetest.register_node(":default:jungletree", entity)

-- wooden axe
entity = registered("tool","default:axe_wood")
entity.tool_capabilities = {
			max_drop_level=0,
			groupcaps={
				choppy={times={[3]=0.80}, uses=10, maxlevel=1},
				fleshy={times={[2]=1.50, [3]=0.80}, uses=10, maxlevel=1},
			}
		}
minetest.register_tool(":default:axe_wood", entity)

-- wooden pickse
entity = registered("tool","default:pick_wood")
entity.tool_capabilities = {
			max_drop_level=0,
			groupcaps={
			}
		}
minetest.register_tool(":default:pick_wood", entity)
