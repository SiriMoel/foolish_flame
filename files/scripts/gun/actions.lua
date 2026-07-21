dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local new_actions = {
	{
		id = "WIZARD_FLARE", -- "team fortress 2"
		name = "$action_ff_flare",
		description = "$actiondesc_ff_flare",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/flare.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/flare/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.8,0.8,0.8,0.8,0.8",
		price = 100,
		mana = 16,
		ai_never_uses = true, -- souls precaution
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/flare/projectile.xml")

			c.fire_rate_wait = c.fire_rate_wait + 3
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees - 1.0

			--AddHeat(50) -- testing!

			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/flare/hitfx.xml,"
		end,
	},
	--[[{
		id = "FLAMETHROWER",
		name = "$action_ff_flamethrower",
		description = "$actiondesc_ff_flamethrower",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/flamethrower.png",
		related_projectiles	= {"data/entities/projectiles/deck/light_bullet.xml"}, -- placeholder!!!
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 100,
		mana = 4,
		ai_never_uses = true, -- souls precaution
		action = function()
			--if reflecting then return end
			local heat = GetHeat()
			if heat > 0.6 then
				RemoveHeat(0.6)
				c.fire_rate_wait = c.fire_rate_wait - 8
				c.spread_degrees = c.spread_degrees + 3.0
				c.damage_critical_chance = c.damage_critical_chance + 4
				add_projectile("data/entities/projectiles/deck/light_bullet.xml") -- placeholder!!!
			end
		end,
	},]]
	{
		id = "HOT_IRON",
		name = "$action_ff_hot_iron",
		description = "$actiondesc_ff_hot_iron",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/hot_iron.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.6,0.8,0.8,0.9,0.8",
		price = 100,
		mana = 8,
		ai_never_uses = true, -- souls precaution
		action = function()
			local heat = GetHeat()
			if heat > 0 then
				c.damage_projectile_add = c.damage_projectile_add + 0.1 + heat / 140
				c.fire_rate_wait = c.fire_rate_wait + 2
				c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
				shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
				RemoveHeat(0.6)
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "AXTINGUISHER", 
		name = "$action_ff_axtinguisher",
		description = "$actiondesc_ff_axtinguisher",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/axtinguisher.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/axtinguisher/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "5,6,10",
		spawn_probability = "0.1,0.2,0.3",
		price = 100,
		mana = 43,
		ai_never_uses = true, -- souls precaution
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/axtinguisher/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/axtinguisher/hitfx.xml,"
		end,
	},
}

for i,action in ipairs(new_actions) do
	action.id = "FF_" .. action.id
	table.insert(actions, action)
end