dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 and not EntityHasTag(root, "player_unit") then

    local x, y = EntityGetTransform(root)

    local player = EntityGetWithTag("player_unit")[1]

    EntityLoad("mods/foolish_flame/files/entities/projectiles/flare/particles_entity.xml", x, y)

    local damage = 0.2

    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")
        damage = damage + 0.36 * temp

        local holy_flames = EntityGetAllChildren(root, "ff_holy_flames") or {}
        if #holy_flames > 0 then
            damage = damage + 4 * 0.04 * #holy_flames * temp
        end

        if temp >= 10 then
            damage = damage * 1.4
        end

        AddHeat(3 + temp * 3, player)
    end

    EntityInflictDamage(root, damage, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 4, 4, player, nil, nil, 40)

    MagicFireMakeItExpire(e[1], root)
end

EntityKill(this)