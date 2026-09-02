dofile_once("mods/foolish_flame/files/scripts/utils.lua")

function shot(proj)
    local heat = GetHeat()
    if heat > 0 then
        local setting_mult = tonumber(GlobalsGetValue("ff_heat_damage_mult", "1")) or 1
        local mult = 1 + heat * 0.0035 * setting_mult -- 1.7x with 200, 2.4x damage with 400
        local comps = EntityGetComponent(proj, "ProjectileComponent")
	    if comps ~= nil then
    		for i,comp in ipairs(comps) do
                local damage = ComponentGetValue2(comp, "damage") or 0
                ComponentSetValue2(comp, "damage", damage * mult)
		    end
	    end
    end
end