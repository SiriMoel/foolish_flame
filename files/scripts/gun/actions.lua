dofile_once("mods/foolish_flame/files/scripts/utils.lua")

SOULS_PRECAUTION = true
-- gurbertbrain spells dont have 'ai_never_uses = SOULS_PRECAUTION' or 'ai_never_uses = true'

REFLECTING_HEAT_AMT = 150

local new_actions = {
	{
		id = "SPARKLE",
		name = "$action_ff_sparkle",
		description = "$actiondesc_ff_sparkle",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/sparkle.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/sparkle/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "0,1,2,3",
		spawn_probability = "0.7,0.8,0.7,0.7",
		price = 100,
		mana = 14,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.spread_degrees = c.spread_degrees + 4.0
			c.fire_rate_wait = c.fire_rate_wait - 2 --?
			add_projectile("mods/foolish_flame/files/entities/projectiles/sparkle/projectile.xml")
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/sparkle/hitfx.xml,"
		end,
	},
	{
		id = "WIZARD_FLARE", -- piggy from team fortress 2: Calm down everybody, we have Moldos from Noita.
		name = "$action_ff_flare",
		description = "$actiondesc_ff_flare",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/flare.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/flare/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "1,2,3,4,5",
		spawn_probability = "0.4,0.8,0.9,1.0,1.0",
		price = 100,
		mana = 25,
		ai_never_uses = SOULS_PRECAUTION,
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/flare/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 3
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees - 1.0
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/flare/hitfx.xml,"
		end,
	},
	{
		id = "FLARE_TRIGGER",
		name = "$action_ff_flare_trigger",
		description = "$actiondesc_ff_flare_trigger",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/flare_trigger.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/flare/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "2,3,4,5",
		spawn_probability = "0.5,0.5,0.6,0.6",
		price = 100,
		mana = 25,
		ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 3
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees - 1.0
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/flare/hitfx.xml,"
			add_projectile_trigger_hit_world("mods/foolish_flame/files/entities/projectiles/flare/projectile.xml", 1)
		end,
	},
	{
		id = "HEAT_FLARE",
		name = "$action_ff_heat_flare",
		description = "$actiondesc_ff_heat_flare",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/heat_flare.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/heat_flare/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "2,3,4,5",
		spawn_probability = "0.5,0.7,0.7,0.8",
		price = 100,
		mana = 20,
		ai_never_uses = SOULS_PRECAUTION,
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
		spawn_probability = "0.3,0.6,0.7,0.6",
		price = 110,
		mana = 60,
		ai_never_uses = SOULS_PRECAUTION,
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
		spawn_probability = "0.3,0.6,0.7,0.6",
		price = 120,
		mana = 30,
		ai_never_uses = SOULS_PRECAUTION,
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/bullet_flare/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.spread_degrees = c.spread_degrees - 3.0
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/bullet_flare/hitfx.xml,"
		end,
	},
	{
		id = "GOOD_FLARE",
		name = "$action_ff_good_flare",
		description = "$actiondesc_ff_good_flare",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/good_flare.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/good_flare/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "5,6",
		spawn_probability = "0.3,0.4",
		price = 160,
		mana = 21,
		ai_never_uses = SOULS_PRECAUTION,
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/good_flare/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.spread_degrees = c.spread_degrees - 3.0
			c.damage_projectile_add = c.damage_projectile_add - 0.15
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/good_flare/hitfx.xml,"
		end,
	},
	{
		id = "HOT_IRON",
		name = "$action_ff_hot_iron",
		description = "$actiondesc_ff_hot_iron",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/hot_iron.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.6,0.7,0.8,0.8,0.8",
		price = 100,
		mana = 12,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			local a, h = SpellRemoveHeat(0.8, GetUpdatedEntityID())
			if a or reflecting then
				if reflecting then h = REFLECTING_HEAT_AMT end
				c.damage_projectile_add = c.damage_projectile_add + 0.04 + h * 0.0024
				c.fire_rate_wait = c.fire_rate_wait + 6
				current_reload_time = current_reload_time - 3
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
		spawn_probability = "0.6,0.8,0.8,0.7,0.7",
		price = 90,
		mana = 8,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			local a, h = SpellRemoveHeat(0.8, GetUpdatedEntityID())
			if a or reflecting then
				if reflecting then h = REFLECTING_HEAT_AMT end
				c.speed_multiplier = c.speed_multiplier * (1 + h * 0.0125)
				if c.speed_multiplier >= 20 then
					c.speed_multiplier = math.min(c.speed_multiplier, 20)
				elseif c.speed_multiplier < 0 then
					c.speed_multiplier = 0
				end
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
		mana = 5,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			if SpellGetHeat(GetUpdatedEntityID()) > 0 or reflecting then
				c.damage_projectile_add = c.damage_projectile_add + 0.4
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "ENGINE",
		name = "$action_ff_engine",
		description = "$actiondesc_ff_engine",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/engine.png",
		type = ACTION_TYPE_MODIFIER, -- should it be utility like blood magic?
		spawn_level = "3,4,5,6",
		spawn_probability = "0.5,0.6,0.7,0.7",
		price = 250,
		mana = 0,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			if SpellRemoveHeat(1.2, GetUpdatedEntityID()) or reflecting then
				mana = mana + 60
				c.fire_rate_wait = c.fire_rate_wait - 18
				current_reload_time = current_reload_time - 28
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
		spawn_probability = "0.2,0.3,0.3,0.1",
		price = 280,
		mana = 190,
		--ai_never_uses = SOULS_PRECAUTION,
		custom_xml_file="mods/foolish_flame/files/entities/misc/card_meltdown.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			local caster = GetUpdatedEntityID()
			local heat = SpellGetHeat(caster)
			if heat > 10 or reflecting then
				if reflecting then heat = REFLECTING_HEAT_AMT end
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/meltdown/meltdown.xml,"
				local amt = heat * 0.027
				if reflecting then
					c.damage_projectile_add = c.damage_projectile_add + amt
				else
					local holy = amt * 0.5
					local holy_count = math.floor(holy / 0.4)
					for i=1,holy_count do
						c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/meltdown/add_holy_damage.xml,"
					end
					local proj = amt - holy_count * 0.4
					c.damage_projectile_add = c.damage_projectile_add + proj
				end
				current_reload_time = current_reload_time + 24 + math.ceil(0.19 * heat)
				--c.trail_material = c.trail_material .. "flame,"
				--c.trail_material_amount = c.trail_material_amount + math.min(heat * 0.005, 60)
				SpellRemoveHeat(heat * 0.2, caster)
			else
				current_reload_time = current_reload_time + 26
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "HOTTER_FLARES",
		name = "$action_ff_hotter_flares",
		description = "$actiondesc_ff_hotter_flares",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/hotter_flares.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "5,6",
		spawn_probability = "0.1,0.1",
		price = 160,
		mana = 110,
		ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 24
			current_reload_time = current_reload_time + 12
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/hotter_flares/hitfx.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "FIRE_DURATION",
		name = "$action_ff_fire_duration",
		description = "$actiondesc_ff_fire_duration",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/fire_duration.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "4,5,6",
		spawn_probability = "0.2,0.2,0.1",
		price = 140,
		mana = 12,
		ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 6
			current_reload_time = current_reload_time + 3
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/fire_duration/hitfx.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "BUNSEN",
		name = "$action_ff_bunsen",
		description = "$actiondesc_ff_bunsen",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/bunsen.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml",3},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.6,0.6,0.7,0.7,0.7",
		price = 130,
		mana = 16,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			if SpellRemoveHeat(0.8, GetUpdatedEntityID()) or reflecting then
				c.fire_rate_wait = c.fire_rate_wait - 8
				c.spread_degrees = c.spread_degrees - 4.0
				c.damage_critical_chance = c.damage_critical_chance + 10
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				add_projectile("mods/foolish_flame/files/entities/projectiles/bunsen/projectile.xml")
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/bunsen/hitfx.xml,"
			end
		end,
	},
	{
		id = "NEEDLE",
		name = "$action_ff_needle",
		description = "$actiondesc_ff_needle",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/needle.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/needle/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.6,0.6,0.7,0.7,0.7",
		price = 110,
		mana = 22,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.spread_degrees = c.spread_degrees + 3.0
			if SpellRemoveHeat(0.8, GetUpdatedEntityID()) or reflecting then
				current_reload_time = current_reload_time - 12
				c.damage_critical_chance = c.damage_critical_chance + 5
				add_projectile("mods/foolish_flame/files/entities/projectiles/needle/projectile.xml")
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/needle/hitfx.xml,"
				c.fire_rate_wait = -2
			end
		end,
	},
	{
		id = "BEAM",
		name = "$action_ff_beam",
		description = "$actiondesc_ff_beam",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/beam.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/beam/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.5,0.6,0.6,0.6",
		price = 150,
		mana = 34,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			if SpellRemoveHeat(1.2, GetUpdatedEntityID()) or reflecting then
				c.spread_degrees = c.spread_degrees - 12.0
				c.damage_critical_chance = c.damage_critical_chance + 2
				add_projectile("mods/foolish_flame/files/entities/projectiles/beam/projectile.xml")
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/beam/hitfx.xml,"
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
		spawn_level = "3,4,5,6",
		spawn_probability = "0.2,0.4,0.5,0.6",
		price = 240,
		mana = 53,
		ai_never_uses = SOULS_PRECAUTION,
		action = function()
			add_projectile("mods/foolish_flame/files/entities/projectiles/axtinguisher/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/axtinguisher/hitfx.xml,"
		end,
	},
	{
		id = "PHOENIX_FIELD",
		name = "$action_ff_phoenix_field",
		description = "$actiondesc_ff_phoenix_field",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/phoenix_field.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/phoenix_field/proj.xml"},
		type = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.3,0.3,0.4,0.3,0.4",
		price = 250,
		mana = 80,
		max_uses = 3,
		never_unlimited = true,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 20
			local caster = GetUpdatedEntityID()
			local heat = SpellGetHeat(caster)
			if heat > 20 or reflecting then
				if reflecting then heat = REFLECTING_HEAT_AMT end
				local amt = 20 + (heat - 20) * 0.16
				c.damage_healing_add = c.damage_healing_add - amt * 0.02
				SpellRemoveHeat(amt, caster)
				add_projectile("mods/foolish_flame/files/entities/projectiles/phoenix_field/proj.xml")
			end
		end,
	},
	{
		id = "RADIATOR",
		name = "$action_ff_radiator",
		description = "$actiondesc_ff_radiator",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/radiator.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "4,5,6",
		spawn_probability = "0.5,0.5,0.5",
		price = 200,
		mana = 500,
		max_uses = 40,
		--never_unlimited = true,
		ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 20
			if not reflecting then
				SpellAddHeat(20, GetUpdatedEntityID())
				--LoadGameEffectEntityTo(GetUpdatedEntityID(), "mods/foolish_flame/files/entities/misc/effect_reduce_heat_gain.xml") --?
			end
		end,
	},
	{
		id = "BLEEDING_HEAT",
		name = "$action_ff_bleeding_heat",
		description = "$actiondesc_ff_bleeding_heat",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/bleeding_heat.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "5,6,10",
		spawn_probability = "0.3,0.4,0.3",
		price = 150,
		mana = 7,
		ai_never_uses = true,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 18
			current_reload_time = current_reload_time + 12
			if reflecting then return end
			local caster = GetUpdatedEntityID()
			--if EntityHasTag(caster, "player_unit") then
				local comps = EntityGetComponent(caster, "DamageModelComponent") or {}
				if #comps > 0 then
					for _,comp in ipairs(comps) do
						local hp = ComponentGetValue2(comp, "hp")
						hp = math.max(hp - 0.28, 0.04)
						ComponentSetValue2(comp, "hp", hp)
					end
				end
				AddHeat(38, caster)
			--end
			draw_actions(1, true)
		end,
	},
	{
		id = "BURNING_UP", -- this one might be problematic for the mod's balance
		name = "$action_ff_burning_up",
		description = "$actiondesc_ff_burning_up",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/burning_up.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "5,6,10",
		spawn_probability = "0.1,0.1,0.1",
		price = 200,
		mana = 98,
		ai_never_uses = true,
		action = function(recursion_level, iteration)
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 24
			local iter = iteration or 1
			if iter > 1 then
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/burning_up/entity_reduced.xml,"
			else 
				c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/burning_up/entity.xml,"
			end
			draw_actions(1, true)
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
		mana = 12,
		--ai_never_uses = SOULS_PRECAUTION,
		custom_xml_file="mods/foolish_flame/files/entities/misc/card_thermodynamics/card.xml",
		action = function()
			current_reload_time = current_reload_time + 2
			draw_actions(1, true)
		end,
	},
	{
		id = "WILLOW_WISP", -- "will-o'-the-wisp" / "will of the torch" / "ignis fatuus" / "foolish flame"
		name = "$action_ff_willow_wisp",
		description = "$actiondesc_ff_willow_wisp",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/willow_wisp.png",
		type = ACTION_TYPE_PASSIVE,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.2",
		price = 300,
		mana = 10,
		--ai_never_uses = SOULS_PRECAUTION,
		custom_xml_file="mods/foolish_flame/files/entities/misc/willow_wisp/card.xml",
		action = function()
			current_reload_time = current_reload_time + 1
			draw_actions(1, true)
		end,
	},
	{
		id = "MAGIC_FIRE", -- only found on wand of magic fire as an always cast
		name = "$action_ff_magic_fire",
		description = "$actiondesc_ff_magic_fire",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/magic_fire.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "10",
		spawn_probability = "0.0",
		price = 100,
		mana = 0,
		--ai_never_uses = SOULS_PRECAUTION,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/foolish_flame/files/entities/projectiles/magic_fire/hitfx.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "LASER",
		name = "$action_ff_laser",
		description = "$actiondesc_ff_laser",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/laser.png",
		related_projectiles	= {"mods/foolish_flame/files/entities/projectiles/laser/projectile.xml"},
		spawn_requires_flag = "ff_laser_unlocked",
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "10",
		spawn_probability = "0.1",
		price = 300,
		mana = 30,
		--ai_never_uses = SOULS_PRECAUTION,
		custom_xml_file="mods/foolish_flame/files/entities/misc/card_laser.xml",
		action = function()
			-- why does add trigger break this?
			c.fire_rate_wait = c.fire_rate_wait + 40
			current_reload_time = current_reload_time + 3
			if reflecting then add_projectile("mods/foolish_flame/files/entities/projectiles/laser/projectile.xml") return end
			local caster = GetUpdatedEntityID()
			if SpellGetHeat(caster) <= 0 then FF_Revs = 0 return end
			add_projectile("mods/foolish_flame/files/entities/projectiles/laser/projectile.xml")
			-- i think this Revs thing is from copith originally
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
					if SpellRemoveHeat(0.1 + 0.1 * math.min(FF_Revs * 0.5, 30), caster) then
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
		id = "REMEMBER",
		name = "$action_ff_remember",
		description = "$actiondesc_ff_remember",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/remember.png",
		spawn_requires_flag = "ff_gurbert_spells_unlocked",
		type = ACTION_TYPE_OTHER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.5",
		price = 200,
		mana = 22,
		action = function()
			local data = {}
			local how_many = 1
			if #deck > 0 then
				data = deck[1]
			else
				data = nil
			end
			if data ~= nil then
				gurbertbrain = {}
				while (#deck >= how_many) and ((data.type == ACTION_TYPE_PROJECTILE) or (data.type == ACTION_TYPE_MODIFIER) or (data.type == ACTION_TYPE_STATIC_PROJECTILE) --[[or (data.type == ACTION_TYPE_DRAW_MANY)]] or (data.type == ACTION_TYPE_OTHER)) do
					table.insert(gurbertbrain, data)
					how_many = how_many + 1
					data = deck[how_many]
				end
				for i=1,how_many do
					data = deck[1]
					table.insert(discarded, data)
					table.remove(deck, 1)
				end
			end
		end,
	},
	{
		id = "RECALL",
		name = "$action_ff_recall",
		description = "$actiondesc_ff_recall",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/recall.png",
		spawn_requires_flag = "ff_gurbert_spells_unlocked",
		type = ACTION_TYPE_OTHER,
		recursive = true,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.5",
		price = 200,
		mana = 70,
		action = function(recursion_level, iteration)
			local data = {}
			local how_many = 1
			if #gurbertbrain > 0 then
				data = gurbertbrain[1]
			else
				data = nil
			end
			if data ~= nil then
				while (#gurbertbrain >= how_many) do
					local rec = check_recursion(data, recursion_level)
					if rec > -1 then
						data.action(rec)
					end
					how_many = how_many + 1
					data = gurbertbrain[how_many]
				end
			else
				GamePrint("No thoughts.")
			end

		end,
	},
	{
		id = "REMEMBER_ONE",
		name = "$action_ff_remember_one",
		description = "$actiondesc_ff_remember_one",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/remember_one.png",
		spawn_requires_flag = "ff_gurbert_spells_unlocked",
		type = ACTION_TYPE_OTHER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.5",
		price = 200,
		mana = 10,
		action = function()
			local data = {}			
			if #deck > 0 then
				data = deck[1]
			else
				data = nil
			end
			if data ~= nil then
				table.insert(gurbertbrain, data)
				table.insert(discarded, data)
				table.remove(deck, 1)
			end
		end,
	},
	{
		id = "FROGET",
		name = "$action_ff_forget",
		description = "$actiondesc_ff_forget",
		sprite = "mods/foolish_flame/files/ui_gfx/gun_actions/forget.png",
		spawn_requires_flag = "ff_gurbert_spells_unlocked",
		type = ACTION_TYPE_OTHER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.5",
		price = 200,
		mana = -30,
		action = function()
			gurbertbrain = {}
		end,
	},
}

for i,action in ipairs(new_actions) do
	action.id = "FF_" .. action.id
	table.insert(actions, action)
end