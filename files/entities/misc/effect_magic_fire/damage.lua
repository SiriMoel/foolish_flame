dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local comp_temp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "fire_temp")
if comp_temp ~= nil then
    local temp = ComponentGetValue2(comp_temp, "value_int")

    if temp > 0 then
        local x, y = EntityGetTransform(this)

        local p = EntityGetInRadiusWithTag(x, y, 140, "player_unit") or {}
        if #p > 0 then
            AddHeat(0.5 + temp * 0.25, p[1])
        end

        local holy_flames = EntityGetAllChildren(root, "ff_holy_flames") or {}
        if #holy_flames > 0 then
            local damage = 0
            damage = damage + 0.04 * #holy_flames * temp
            local dmc = EntityGetFirstComponent(root, "DamageModelComponent")
            if dmc ~= nil then
                local max_hp = ComponentGetValue2(dmc, "max_hp")
                damage = damage + math.min(max_hp, 10) * 0.002 * #holy_flames * temp * 0.5
            end
            EntityInflictDamage(root, damage, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 2, 2, 0, nil, nil, 20)
        end
    end
end