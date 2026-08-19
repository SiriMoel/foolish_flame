local entity = GetUpdatedEntityID()
entity = EntityGetRootEntity(entity)
if entity ~= 0 then
    local comp = EntityGetFirstComponentIncludingDisabled(entity, "ProjectileComponent")
    if comp ~= nil then
        local damage_holy = ComponentObjectGetValue2(comp, "damage_by_type", "holy") or 0
        damage_holy = damage_holy + 0.4
        ComponentObjectSetValue2(comp, "damage_by_type", "holy", damage_holy)
    end
end