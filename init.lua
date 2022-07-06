local modname = "white_wine"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")
local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_craftitem("white_wine:green_grape", {
	description = S("Green Grapes"),
	inventory_image = "green_grape.png",
	on_use = minetest.item_eat(1),
	groups = {seed = 2, food_grapes = 1, flammable = 3},
})

minetest.override_item("farming:grapes_7", {
	drop = {
		items = {
			{items = {"farming:trellis"}, rarity = 1},
			{items = {"white_wine:green_grape 3"}, rarity = 1},
			{items = {"white_wine:green_grape 1"}, rarity = 2},
			{items = {"white_wine:green_grape 1"}, rarity = 3}
		}
	},
})

minetest.register_node("white_wine:glass_white_wine", {
		description = S("Glass of White Wine"),
		drawtype = "plantlike",
		visual_scale = 0.5,
		tiles = {"wine_white_wine_glass.png"},
		inventory_image = "wine_white_wine_glass.png",
		wield_image = "wine_white_wine_glass.png",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.15, -0.5, -0.15, 0.15, 0, 0.15}
		},
		groups = {
			vessel = 1, dig_immediate = 3,
			attached_node = 1, drink = 1, alcohol = 1
		},
		sounds = default.node_sound_glass_defaults(),
		on_use = function(itemstack, user, pointed_thing)

			if user then

				if thirsty_mod then
					thirsty.drink(user, 5)
				end

				return minetest.do_item_eat(2, nil,
						itemstack, user, pointed_thing)
			end
		end
	})
	
minetest.register_node("white_wine:bottle_white_wine", {
	description = S("Bottle of White Wine"),
	drawtype = "plantlike",
	visual_scale = 0.7,
	tiles = {"wine_white_wine_bottle.png"},
	inventory_image = "wine_white_wine_bottle.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.15, -0.5, -0.15, 0.15, 0.25, 0.15}
	},
	groups = {dig_immediate = 3, attached_node = 1, vessel = 1},
	sounds = default.node_sound_defaults(),
	})

minetest.register_craft({
	output = "white_wine:bottle_white_wine",
	recipe = {
		{"white_wine:glass_white_wine", "white_wine:glass_white_wine", "white_wine:glass_white_wine"},
		{"white_wine:glass_white_wine", "white_wine:glass_white_wine", "white_wine:glass_white_wine"},
		{"white_wine:glass_white_wine", "white_wine:glass_white_wine", "white_wine:glass_white_wine"}
	}
})

minetest.register_craft({
	output = "white_wine:glass_white_wine 9",
	recipe = {{"white_wine:bottle_white_wine"}}
})

--{"white_wine:green_grape", "white_wine:glass_white_wine"}

local list = {
	{[1]="white_wine:green_grape", [2]="white_wine:glass_white_wine",},
}

if minetest.get_modpath("wine") then
	wine:add_item(list)--not working ( attempt to get length of local 'list')
end
