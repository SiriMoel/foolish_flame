local this = GetUpdatedEntityID()

local amt = 0

local comps = EntityGetComponent(this, "ProjectileComponent")
if comps ~= nil then
    for _,comp in ipairs(comps) do
        amt = amt + ComponentGetValue2(comp, "damage")
        ComponentSetValue2(comp, "damage", 0)

        local damages = ComponentObjectGetMembers(comp, "damage_by_type")
        if damages ~= nil then
            for k,v in pairs(damages) do
                amt = amt + (v or 0)
                ComponentObjectSetValue2(comp, "damage_by_type", tostring(k), 0)
            end
        end
        
        amt = amt + (ComponentObjectGetValue2(comp, "config_explosion", "damage") or 0)
        ComponentObjectSetValue2(comp, "config_explosion", "damage", 0)

        local crit_chance = ComponentObjectGetValue2(comp, "damage_critical", "chance") or 0
        local crit_mult = ComponentObjectGetValue2(comp, "damage_critical", "damage_multiplier") or 1
        amt = amt * (1 + (crit_chance/100) * crit_mult)
	end
end

-- wouldn't it be so cool if we had an on-hit callback?

if amt > 0 then
    local count = math.ceil(amt * 100) / 100
    local steps = {{1000000}, {400000}, {40000}, {4000}, {400}, {40}, {4}, {0.4,"04"}, {0.04,"004"}}
    for i=1,#steps do
        local step = steps[i]
        while count > step[1] do
            count = count - step[1]
            EntityAddComponent2(this, "HitEffectComponent", {
                effect_hit="LOAD_CHILD_ENTITY",
                value_string="mods/foolish_flame/files/entities/projectiles/flash_flare/flash_" .. (step[2] or step[1]) .. ".xml"
            })
        end
    end
end