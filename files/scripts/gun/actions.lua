dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local new_actions = {
	{
		id = "WIZARD_FLARE", -- "team fortress 2"
		name = "$action_ff_flare",
		description = "$actiondesc_ff_flare",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/flare.png",
		related_projectiles	= {"data/entities/projectiles/deck/light_bullet.xml"}, -- placeholder!!!
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 100,
		mana = 20,
		action = function()
			add_projectile("data/entities/projectiles/deck/light_bullet.xml") -- placeholder!!!

			c.fire_rate_wait = c.fire_rate_wait + 3
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees - 1.0
			--c.damage_critical_chance = c.damage_critical_chance + 2

			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/flare/hitfx.xml,"
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/misc/status_magic_fire/hitfx.xml,"
		end,
	},
}

for i,action in ipairs(new_actions) do
	action.id = "FF_" .. action.id
	table.insert(actions, action)
end