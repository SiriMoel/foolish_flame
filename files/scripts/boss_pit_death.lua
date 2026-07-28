dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity_id)
	
    EntityLoad("mods/foolish_flame/files/entities/gurbert/gurbert.xml", x, y)

	local flag_status = HasFlagPersistent("ff_gurbert_spells_unlocked")

	if not flag_status then
		CreateItemActionEntity("FF_REMEMBER", x - 32, y)
		CreateItemActionEntity("FF_RECALL", x + 32, y)
		CreateItemActionEntity("FF_REMEMBER_ONE", x - 48, y)
		CreateItemActionEntity("FF_FROGET", x + 48, y)
	end

	AddFlagPersistent("ff_gurbert_spells_unlocked")
end