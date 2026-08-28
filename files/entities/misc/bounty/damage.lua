function shot(proj)
    local entity = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity)
    local mult = 1 + (y-20000)/48000
    local comps = EntityGetComponent(proj, "ProjectileComponent")
	if comps ~= nil then
    	for i,comp in ipairs(comps) do
            local damage = ComponentGetValue2(comp, "damage") or 0
            ComponentSetValue2(comp, "damage", damage * mult)
            local fire_damage = ComponentObjectGetValue2(comp, "damage_by_type", "fire") or 0
            ComponentObjectSetValue2(comp, "damage_by_type", "fire", fire_damage * mult)
            local holy_damage = ComponentObjectGetValue2(comp, "damage_by_type", "holy") or 0
            ComponentObjectSetValue2(comp, "damage_by_type", "holy", holy_damage * mult)
		end
	end
end