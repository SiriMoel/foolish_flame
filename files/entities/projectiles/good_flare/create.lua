local this = GetUpdatedEntityID()

local comps = EntityGetComponent(this, "ProjectileComponent")
if comps ~= nil then
    for i,comp in ipairs(comps) do
        ComponentSetValue2(comp, "damage", 0)
        ComponentObjectSetValue2(comp, "damage_by_type", "fire", 0)
        ComponentObjectSetValue2(comp, "damage_by_type", "electricity", 0)
        ComponentObjectSetValue2(comp, "damage_by_type", "holy", 0)
        ComponentObjectSetValue2(comp, "damage_by_type", "melee", 0)
        ComponentObjectSetValue2(comp, "damage_by_type", "slice", 0)
        ComponentObjectSetValue2(comp, "damage_by_type", "ice", 0)
        ComponentObjectSetValue2(comp, "damage_by_type", "drill", 0)
        ComponentObjectSetValue2(comp, "config_explosion", "damage", 0)
	end
end