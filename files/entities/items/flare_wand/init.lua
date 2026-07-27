dofile_once("mods/foolish_flame/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local wand = GetUpdatedEntityID()
local x, y = EntityGetTransform(wand)
SetRandomSeed(x, y + GameGetFrameNum())

local comp_ability = EntityGetFirstComponent(wand, "AbilityComponent")

local deck_capacity = Random(18, 25)
local actions_per_round = 3
local reload_time = Random(6, 26)
local fire_rate_wait = Random(1, 8)
local spread_degrees = Random(0, 4)
local speed_multiplier = 1.3
local mana_charge_speed = Random(550, 850)
local mana_max = Random(900, 1300)

ComponentObjectSetValue2(comp_ability, "gun_config", "reload_time", reload_time)
ComponentObjectSetValue2(comp_ability, "gunaction_config", "fire_rate_wait", fire_rate_wait)
ComponentSetValue2(comp_ability, "mana_charge_speed", mana_charge_speed)
ComponentObjectSetValue2(comp_ability, "gun_config", "actions_per_round", actions_per_round)
ComponentObjectSetValue2(comp_ability, "gun_config", "deck_capacity", deck_capacity)
ComponentObjectSetValue2(comp_ability, "gunaction_config", "spread_degrees", spread_degrees)
ComponentObjectSetValue2(comp_ability, "gunaction_config", "speed_multiplier", speed_multiplier)
ComponentSetValue2(comp_ability, "mana_max", mana_max)
ComponentSetValue2(comp_ability, "mana", mana_max)

AddGunActionPermanent(wand, "FF_MAGIC_FIRE")

local flare_options = {"WIZARD", "HEAT", "AOE", "BULLET"}
local flare = flare_options[Random(1, #flare_options)]

for i=1,3 do
	AddGunAction(wand, "FF_" .. flare .. "_FLARE")
end

ComponentSetValue2(comp_ability, "sprite_file", "mods/foolish_flame/files/entities/items/flare_wand/sprite_" .. flare .. ".xml")

local comp_sprite = EntityGetFirstComponent(wand, "SpriteComponent")

ComponentSetValue2(comp_sprite, "image_file", "mods/foolish_flame/files/entities/items/flare_wand/sprite_" .. flare .. ".xml")