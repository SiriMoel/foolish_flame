dofile_once("mods/foolish_flame/files/scripts/utils.lua")

function shot(proj)
    local heat = GetHeat()
    if heat > 0 then
        local mult = 1 + heat * 0.0025 -- 2x damage with 400 heat
        --local amt = heat * 0.003
        local comps = EntityGetComponent(proj, "ProjectileComponent")
	    if comps ~= nil then
    		for i,comp in ipairs(comps) do
                local damage = ComponentGetValue2(comp, "damage") or 0
                ComponentSetValue2(comp, "damage", damage * mult)
                --local fire_damage = ComponentObjectGetValue2(comp, "damage_by_type", "fire") or 0
                --ComponentObjectSetValue2(comp, "damage_by_type", "fire", fire_damage + amt)
		    end
	    end
    end
end