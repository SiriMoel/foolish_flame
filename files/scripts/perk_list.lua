dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local a = {
	{
		id = "HOTTER_FIRE",
		ui_name = "$perk_ff_hotter_fire",
		ui_description = "$perkdesc_ff_hotter_fire",
		ui_icon = "mods/foolish_flame/files/ui_gfx/perk_icons/hotter_fire.png",
		perk_icon = "mods/foolish_flame/files/items_gfx/perks/hotter_fire.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			if EntityHasTag(entity_who_picked, "player_unit") then
                EntityAddTag(entity_who_picked, "ff_hotter_fire")
            end
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "ff_hotter_fire")
		end
	},
	{
		id = "SLOW_HEAT_LOSS",
		ui_name = "$perk_ff_slow_heat_loss",
		ui_description = "$perkdesc_ff_slow_heat_loss",
		ui_icon = "mods/foolish_flame/files/ui_gfx/perk_icons/slow_heat_loss.png",
		perk_icon = "mods/foolish_flame/files/items_gfx/perks/slow_heat_loss.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			if EntityHasTag(entity_who_picked, "player_unit") then
                EntityAddTag(entity_who_picked, "ff_slow_heat_loss")
            end
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "ff_slow_heat_loss")
		end
	},
	{
		id = "EXTRA_BOUNTY_REWARD",
		ui_name = "$perk_ff_extra_bounty_reward",
		ui_description = "$perkdesc_ff_extra_bounty_reward",
		ui_icon = "mods/foolish_flame/files/ui_gfx/perk_icons/extra_bounty_reward.png",
		perk_icon = "mods/foolish_flame/files/items_gfx/perks/extra_bounty_reward.png",
		not_in_default_perk_pool = true,
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			if EntityHasTag(entity_who_picked, "player_unit") then
                EntityAddTag(entity_who_picked, "ff_extra_bounty_reward")
            end
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "ff_extra_bounty_reward")
		end
	},
}

for i,v in ipairs(a) do
    v.id = "FF_" .. v.id
    table.insert(perk_list, v)
end