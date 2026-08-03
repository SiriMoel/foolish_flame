dofile_once("data/scripts/lib/utilities.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity_id)

	SetRandomSeed(x, y)

	if Random(1, 10) <= 4 then
		local action = GetRandomAction(x, y, 10, 0)
		if Random(1, 100) <= 2 then
			action = "FF_LASER"
		end
		CreateItemActionEntity(action, x, y - 6)
	end

	for i=1,Random(3, 6) do
		EntityLoad("data/entities/items/pickup/goldnugget_200.xml", x - 9 + i * 3, y - 2)
	end
end