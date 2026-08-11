function shot(proj)
    local this = GetUpdatedEntityID()
    local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lighter_state")
    if comp_state ~= nil then
        local state = ComponentGetValue2(comp_state, "value_bool")
        if state then
            EntityAddComponent2(proj, "HitEffectComponent", {
                effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
                value_string="mods/foolish_flame/files/entities/items/lighter/hit_entity.xml",
            })
        end
    end 
end