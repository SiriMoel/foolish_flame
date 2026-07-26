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
		spawn_probability = "0.8,0.9,1.0,1.0,0.8",
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
		spawn_level = "3,4,5,6",
		spawn_probability = "0.7,0.7,0.8,0.8",
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
		id = "AOE_FLARE",
		name = "$action_ff_aoe_flare",
		description = "$actiondesc_ff_aoe_flare",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/aoe_flare.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/aoe_flare/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.3,0.6,0.7,0.7",
		price = 110,
		mana = 30,
		ai_never_uses = true, -- souls precaution
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/aoe_flare/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 8
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees + 3.0
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/aoe_flare/hitfx.xml,"
		end,
	},
	{
		id = "BULLET_FLARE",
		name = "$action_ff_bullet_flare",
		description = "$actiondesc_ff_bullet_flare",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/bullet_flare.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/bullet_flare/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.3,0.6,0.7,0.7",
		price = 120,
		mana = 30,
		ai_never_uses = true, -- souls precaution
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/bullet_flare/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.spread_degrees = c.spread_degrees - 3.0
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/bullet_flare/hitfx.xml,"
		end,
	},
	{
		id = "THERMODYNAMICS",
		name = "$action_ff_thermodynamics",
		description = "$actiondesc_ff_thermodynamics",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/thermodynamics.png",
		type = ACTION_TYPE_PASSIVE,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.4,0.6,0.5,0.5",
		price = 120,
		mana = 0,
		ai_never_uses = true, -- souls precaution
		custom_xml_file="mods/foolish_flame/files/entities/misc/card_thermodynamics/card.xml",
		action = function()
			current_reload_time = current_reload_time + 2
			draw_actions(1, true)
		end,
	},
	{
		id = "HOT_IRON",
		name = "$action_ff_hot_iron",
		description = "$actiondesc_ff_hot_iron",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/hot_iron.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.6,0.8,0.8,0.9,0.8",
		price = 100,
		mana = 10,
		ai_never_uses = true, -- souls precaution
		action = function()
			local a, h = RemoveHeat2(0.5)
			if a or reflecting then
				c.damage_projectile_add = c.damage_projectile_add + 0.1 + h / 130
				c.fire_rate_wait = c.fire_rate_wait + 2
				c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"

			end
			draw_actions(1, true)
		end,
	},
	{
		id = "HEAT_SPEED",
		name = "$action_ff_heat_speed",
		description = "$actiondesc_ff_heat_speed",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/heat_speed.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.6,0.8,0.8,0.9,0.8",
		price = 100,
		mana = 8,
		ai_never_uses = true, -- souls precaution
		action = function()
			local a, h = RemoveHeat2(0.4)
			if a or reflecting then
				c.speed_multiplier = c.speed_multiplier * (1.5 + h / 60)
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "HOT_HAND",
		name = "$action_ff_hot_hand",
		description = "$actiondesc_ff_hot_hand",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/hot_hand.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "1,2,3,4,5",
		spawn_probability = "0.5,0.8,0.9,0.9,0.8",
		price = 110,
		mana = 4,
		ai_never_uses = true, -- souls precaution
		action = function()
			if GetHeat() > 0 or reflecting then
				c.damage_projectile_add = c.damage_projectile_add + 0.4
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "MELTDOWN",
		name = "$action_ff_meltdown",
		description = "$actiondesc_ff_meltdown",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/meltdown.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.4,0.5,0.2",
		price = 100,
		mana = 100,
		ai_never_uses = true, -- souls precaution
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			local heat = GetHeat()
			if heat > 0 then
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/meltdown/hitfx.xml,"
				c.damage_projectile_add = c.damage_projectile_add + heat * 0.01
				c.trail_material = c.trail_material .. "flame,"
				c.trail_material_amount = c.trail_material_amount + math.min(heat / 120, 30)
				RemoveHeat(heat)
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
			if RemoveHeat2(0.8) or reflecting then
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/bunsen/hitfx.xml,"
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
		spawn_level = "4,5,6,10",
		spawn_probability = "0.4,0.5,0.6,0.3",
		price = 240,
		mana = 63,
		ai_never_uses = true, -- souls precaution
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/axtinguisher/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
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
		spawn_level = "10",
		spawn_probability = "0.2",
		price = 260,
		mana = 20,
		ai_never_uses = true, -- souls precaution
		custom_xml_file="mods/foolish_flame/files/entities/misc/card_laser.xml",
		action = function()
			--[[
				why does add trigger break this?
			]]
			c.fire_rate_wait = c.fire_rate_wait + 40
			current_reload_time = current_reload_time + 3
			if reflecting then add_projectile("mods/foolish_flame/files/entities/projectiles/laser/projectile.xml") return end -- is this needed?
			if GetHeat() <= 0 then FF_Revs = 0 return end
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
					if RemoveHeat2(0.2 + 0.1 * (math.min(FF_Revs, 60))) then
						c.fire_rate_wait = c.fire_rate_wait - math.min(4 * FF_Revs, 120)
						current_reload_time = current_reload_time - math.min(3 * FF_Revs, 60)
						c.spread_degrees = c.spread_degrees - math.min(0.5 * FF_Revs, 60)
						c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/laser/hitfx.xml,"
					else
						current_reload_time = current_reload_time + math.min(3 * FF_Revs, 100) + 6
						FF_Revs = 0
					end
				end
				LastShootingStart = shooting_start
			end
		end,
	},
	{
		id = "WILLOW_WISP", -- "will-o'-the-wisp" / "will of the torch" / "ignis fatuus" / "foolish flame"
		name = "$action_ff_willow_wisp",
		description = "$actiondesc_ff_willow_wisp",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/willow_wisp.png",
		type = ACTION_TYPE_PASSIVE,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.1",
		price = 300,
		mana = 10,
		ai_never_uses = true, -- souls precaution
		custom_xml_file="mods/foolish_flame/files/entities/misc/willow_wisp/card.xml",
		action = function()
			current_reload_time = current_reload_time + 1
			draw_actions(1, true)
		end,
	},
}

for i,action in ipairs(new_actions) do
	action.id = "FF_" .. action.id
	table.insert(actions, action)
end