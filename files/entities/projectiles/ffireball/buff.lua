local entity = GetUpdatedEntityID()
entity = EntityGetRootEntity(entity)
if entity ~= 0 then
    local comp = EntityGetFirstComponentIncludingDisabled(entity, "ProjectileComponent")
    if comp ~= nil then
        local damage_fire = ComponentObjectGetValue2(comp, "damage_by_type", "fire") or 0
        damage_fire = damage_fire + 0.16
        ComponentObjectSetValue2(comp, "damage_by_type", "fire", damage_fire)
        local damage_holy = ComponentObjectGetValue2(comp, "damage_by_type", "holy") or 0
        damage_holy = damage_holy + 0.16
        ComponentObjectSetValue2(comp, "damage_by_type", "holy", damage_holy)
    end
    local comp_gaec = EntityGetFirstComponentIncludingDisabled(entity, "GameAreaEffectComponent")
    if comp_gaec ~= nil then
        local radius = ComponentGetValue2(comp_gaec, "radius") or 0
        radius = math.min(radius + 0.2, 30)
        ComponentSetValue2(comp_gaec, "radius", radius)
    end
    local comp_pec = EntityGetFirstComponentIncludingDisabled(entity, "ParticleEmitterComponent", "ffireball")
    if comp_pec ~= nil then
        local radius_min, radius_max = ComponentGetValue2(comp_pec, "area_circle_radius")
        radius_max = math.min(radius_max + 0.2, 30)
        ComponentSetValue2(comp_pec, "area_circle_radius", radius_min, radius_max)
        local count_min = ComponentGetValue2(comp_pec, "count_min")
        local count_max =  ComponentGetValue2(comp_pec, "count_max")
        count_min = count_min + radius_max * 11 - 40
        count_max = count_max + radius_max * 11 - 40
        ComponentSetValue2(comp_pec, "count_min", count_min)
		ComponentSetValue2(comp_pec, "count_max", count_max)
    end
end