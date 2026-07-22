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
		spawn_probability = "0.8,0.8,1.0,1.0,0.8",
		price = 100,
		mana = 20,
		ai_never_uses = true, -- souls precaution
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/flare/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 3
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees - 1.0
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/flare/hitfx.xml,"
		end,
	},
	{
		id = "HEAT_FLARE",
		name = "$action_ff_heat_flare",
		description = "$actiondesc_ff_heat_flare",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/heat_flare.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/heat_flare/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "4,5,6",
		spawn_probability = "0.7,0.8,0.8",
		price = 100,
		mana = 20,
		ai_never_uses = true, -- souls precaution
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/heat_flare/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 2
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees + 1.0
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/heat_flare/hitfx.xml,"
		end,
	},
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
			if heat > 0 or reflecting then
				c.damage_projectile_add = c.damage_projectile_add + 0.1 + heat / 140
				c.fire_rate_wait = c.fire_rate_wait + 2
				c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
				shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
				RemoveHeat(0.7)
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "BUNSEN",
		name = "$action_ff_bunsen",
		description = "$actiondesc_ff_bunsen",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/bunsen.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "4,5,6",
		spawn_probability = "0.6,0.7,0.8",
		price = 100,
		mana = 11,
		ai_never_uses = true, -- souls precaution
		action = function()
			c.fire_rate_wait = c.fire_rate_wait - 4
			c.spread_degrees = c.spread_degrees - 4.0
			local heat = GetHeat()
			if heat > 0 or reflecting then
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/bunsen/hitfx.xml,"
				RemoveHeat(0.8)
			end
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
		price = 240,
		mana = 63,
		ai_never_uses = true, -- souls precaution
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/axtinguisher/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/axtinguisher/hitfx.xml,"
		end,
	},
	{
		id = "LASER",
		name = "$action_ff_laser",
		description = "$actiondesc_ff_laser",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/laser.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/laser/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "6,10",
		spawn_probability = "0.1,0.2",
		price = 260,
		mana = 20,
		ai_never_uses = true, -- souls precaution
		custom_xml_file="mods/foolish_flame/files/entities/misc/card_laser.xml",
		action = function()
			if reflecting then add_projectile("mods/foolish_flame/files/entities/projectiles/laser/projectile.xml") return end -- is this needed?
			if not (GetHeat() > 0) then FF_Revs = 0 return end
			add_projectile("mods/foolish_flame/files/entities/projectiles/laser/projectile.xml")
			-- i think this Revs thing is from copith originally
			local caster = GetUpdatedEntityID()
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent")
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				FF_Revs = FF_Revs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire")
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire")
				if not shooting_now then
					FF_Revs = 0
				else
					if LastShootingStart ~= shooting_start then
						FF_Revs = 0
					else
						FF_Revs = FF_Revs + 1
					end
					c.fire_rate_wait = c.fire_rate_wait + 30 - math.min(4 * FF_Revs, 90)
					current_reload_time = current_reload_time - math.min(4 * FF_Revs, 40)
					c.spread_degrees = c.spread_degrees - math.min(0.5 * FF_Revs, 60)
					c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/laser/hitfx.xml,"
					RemoveHeat(0.2 + 0.1 * (math.min(FF_Revs, 20)/2))
				end
				LastShootingStart = shooting_start
			end
		end,
	},
}

for i,action in ipairs(new_actions) do
	action.id = "FF_" .. action.id
	table.insert(actions, action)
end