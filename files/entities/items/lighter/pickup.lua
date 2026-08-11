function item_pickup(entity_item, entity_who_picked, item_name)
	local this = GetUpdatedEntityID()
    if this == entity_item and EntityHasTag(entity_who_picked, "player_unit") then
        local x, y = EntityGetTransform(entity_who_picked)
        local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lighter_state")
        if comp_state ~= nil then
            local state = ComponentGetValue2(comp_state, "value_bool")
            if state then
                GamePlaySound("data/audio/Desktop/animals.bank", "animals/shotgun_cock", x, y)
                GamePlaySound("data/audio/Desktop/materials.bank", "collision/lantern/joint_break", x, y)
                ComponentSetValue2(comp_state, "value_bool", false)
            end
        end
    end
end