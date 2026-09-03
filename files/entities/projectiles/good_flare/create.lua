local this = GetUpdatedEntityID()

local comps = EntityGetComponent(this, "ProjectileComponent")
if comps ~= nil then
    for _,comp in ipairs(comps) do
        ComponentSetValue2(comp, "damage", 0)
        local damages = ComponentObjectGetMembers(comp, "damage_by_type")
        if damages ~= nil then
            for k,v in pairs(damages) do
                ComponentObjectSetValue2(comp, "damage_by_type", tostring(k), 0)
            end
        end
        ComponentObjectSetValue2(comp, "config_explosion", "damage", 0)
	end
end