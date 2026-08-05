dofile_once("mods/foolish_flame/files/scripts/utils.lua")
dofile_once("mods/foolish_flame/files/scripts/bounty_rewards.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()
	local x, y = EntityGetTransform(this)

	BountyReward(x, y)
end