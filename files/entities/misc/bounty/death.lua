dofile_once("mods/foolish_flame/files/scripts/utils.lua")
dofile_once("mods/foolish_flame/files/scripts/bounty_rewards.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()
	local x, y = EntityGetTransform(this)

	if EntityHasTag(entity_thats_responsible, "ff_extra_bounty_reward") then
		SetRandomSeed(x + this, y)
		if Random(1, 2) == 1 then
			BountyReward(x - 6, y)
			BountyReward(x + 6, y)
		else
			BountyReward(x, y)
		end
	else
		BountyReward(x, y)
	end
end