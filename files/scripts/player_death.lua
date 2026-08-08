dofile_once("data/scripts/lib/utilities.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)
	
	local items = GameGetAllInventoryItems(entity) or {}
	for i,v in ipairs(items) do
		if EntityHasTag(v, "ff_willows_lighter") then
			AddFlagPersistent("ff_died_with_willows_lighter")
			break
		end
	end
end